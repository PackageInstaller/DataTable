local DepotPanel = class("DepotPanel", BasePanel)
DepotPanel._bAddToBackHistory = true
DepotPanel._tbDefine = {
  {
    sPrefabPath = "DepotEx/DepotPanel.prefab",
    sCtrlName = "Game.UI.DepotEx.DepotCtrl"
  }
}
return DepotPanel
