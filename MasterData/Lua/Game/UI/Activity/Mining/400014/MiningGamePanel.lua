local MiningGamePanel = class("MiningGamePanel", BasePanel)
MiningGamePanel._bIsMainPanel = true
MiningGamePanel._bAddToBackHistory = true
MiningGamePanel._sUIResRootPath = "UI_Activity/"
MiningGamePanel._tbDefine = {
  {
    sPrefabPath = "_400014/MiningGamePanel.prefab",
    sCtrlName = "Game.UI.Activity.Mining.MiningGameCtrl"
  }
}

function MiningGamePanel:Awake()
  self.nGuidePanelId = PanelId.MiningGameGuidePanel_400014
end

function MiningGamePanel:OnEnable()
end

function MiningGamePanel:OnAfterEnter()
end

function MiningGamePanel:OnDisable()
end

function MiningGamePanel:OnDestroy()
end

function MiningGamePanel:OnRelease()
end

return MiningGamePanel
