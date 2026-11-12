local MallPopupPanel = class("MallPopupPanel", BasePanel)
MallPopupPanel._bIsMainPanel = false
MallPopupPanel._tbDefine = {
  {
    sPrefabPath = "Mall/MallPopupPanel.prefab",
    sCtrlName = "Game.UI.Mall.MallPopupCtrl"
  }
}

function MallPopupPanel:Awake()
end

function MallPopupPanel:OnEnable()
end

function MallPopupPanel:OnDisable()
end

function MallPopupPanel:OnDestroy()
end

return MallPopupPanel
