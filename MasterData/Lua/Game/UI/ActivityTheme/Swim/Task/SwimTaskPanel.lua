local SwimTaskPanel = class("SwimTaskPanel", BasePanel)
SwimTaskPanel._sUIResRootPath = "UI_Activity/"
SwimTaskPanel._tbDefine = {
  {
    sPrefabPath = "Swim/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.Swim.Task.SwimTaskCtrl"
  }
}
return SwimTaskPanel
