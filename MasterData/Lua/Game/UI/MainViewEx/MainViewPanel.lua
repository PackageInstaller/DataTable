local MainViewPanel = class("MainViewPanel", BasePanel)
MainViewPanel._nFadeInType = 0
MainViewPanel._tbDefine = {
  {
    sPrefabPath = "MainViewEx/MainViewPanel.prefab",
    sCtrlName = "Game.UI.MainViewEx.MainViewCtrl"
  }
}

function MainViewPanel:OnAfterEnter()
end

return MainViewPanel
