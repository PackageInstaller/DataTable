local CreatePlayerPanel = class("CreatePlayerPanel", BasePanel)
CreatePlayerPanel._bAddToBackHistory = false
CreatePlayerPanel._tbDefine = {
  {
    sPrefabPath = "CreatePlayer/CreatePlayerUI.prefab",
    sCtrlName = "Game.UI.CreatePlayer.CreatePlayerCtrl"
  }
}
return CreatePlayerPanel
