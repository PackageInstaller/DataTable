local HudPanel = class("HudPanel", BasePanel)
HudPanel._bAddToBackHistory = false
HudPanel._bIsMainPanel = false
HudPanel._sSortingLayerName = AllEnum.SortingLayerName.HUD
HudPanel._tbDefine = {
  {
    sPrefabPath = "HUD/HUDROOT.prefab",
    sCtrlName = "Game.UI.Hud.HudMainCtrl"
  }
}
return HudPanel
