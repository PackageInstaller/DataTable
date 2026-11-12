local ReengagementMallPopupPanel = class("ReengagementMallPopupPanel", BasePanel)
ReengagementMallPopupPanel._bIsMainPanel = false
ReengagementMallPopupPanel._tbDefine = {
  {
    sPrefabPath = "Mall/MallPopupPanel.prefab",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementMallPopupCtrl"
  }
}
return ReengagementMallPopupPanel
