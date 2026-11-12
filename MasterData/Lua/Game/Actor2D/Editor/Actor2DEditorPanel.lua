local Actor2DEditorPanel = class("Actor2DEditorPanel", BasePanel)
Actor2DEditorPanel._tbDefine = {
  {
    sPrefabPath = "Actor2DEditor/Actor2DEditor.prefab",
    sCtrlName = "Game.Actor2D.Editor.Actor2DEditorCtrl"
  }
}
return Actor2DEditorPanel
