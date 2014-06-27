
class AEkeyFrameExporter {

  XML xml;
  XML objs;
  XML scn;
  XML kf;
  long initialFrame;

  AEkeyFrameExporter(int _fRate, int _sceneWidth, int _sceneHeight) {

    initialFrame=frameCount;

    xml = new XML("xml");

    XML gnrl = xml.addChild("general");
    scn = gnrl.addChild("scene");
    scn.setInt("width", _sceneWidth);
    scn.setInt("height", _sceneHeight);
    scn.setFloat("framerate", fRate);

    objs = xml.addChild("objects");
    
  }

  void addObject(int _id, color _color) {

    XML obj = objs.addChild("object");
    obj.setInt("id", _id);
    
    //COLORS
    int red   = (_color >> 16) & 0xFF;
    int green = (_color >> 8)  & 0xFF;
    int blue  =  _color        & 0xFF;
  
    obj.setInt("color_R", red);
    obj.setInt("color_G", green);
    obj.setInt("color_B", blue);
    
    kf = obj.addChild("keyframes");
  }

  void writeObjectData(int _id, PVector _pos, int _sW, int _sH) {
    
    XML[] children = objs.getChildren("object");
    

  for (int i = 0; i < children.length; i++) {
    String id = children[i].getString("id");
    if(int(id)==int(_id)){
    
    XML frame = children[i].getChildren("keyframes")[0].addChild("frame");
    frame.setInt("number",frameCount);
    XML anchorP = frame.addChild("anchor_point");
    anchorP.setInt("x", 0);
    anchorP.setInt("y", 0);
    XML position = frame.addChild("position");
    position.setInt("x", int(_pos.x));
    position.setInt("y", int(_pos.y));
    XML size = frame.addChild("size");
    size.setInt("sizeW", _sW);
    size.setInt("sizeH", _sH);
    XML scale = frame.addChild("scale");
    scale.setInt("x_perc", 100);
    scale.setInt("y_perc", 100);
    }
  }
}


  void saveOutput() {

     scn.setInt("frame_duration", int(frameCount-initialFrame));

    saveXML(xml, "data/objectsInfo.xml");
  }
}
