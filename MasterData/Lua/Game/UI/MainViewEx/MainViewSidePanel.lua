local MainViewSidePanel = class("MainViewSidePanel", BasePanel)
MainViewSidePanel._nSnapshotPrePanel = 3
MainViewSidePanel._tbDefine = {
  {
    sPrefabPath = "MainViewEx/MainViewSidePanel.prefab",
    sCtrlName = "Game.UI.MainViewEx.MainViewSideCtrl"
  }
}

function MainViewSidePanel:Awake()
end

function MainViewSidePanel:OnEnable()
end

function MainViewSidePanel:OnDisable()
end

function MainViewSidePanel:OnDestroy()
end

return MainViewSidePanel
