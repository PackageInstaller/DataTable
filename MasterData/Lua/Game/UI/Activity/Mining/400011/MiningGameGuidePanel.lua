local MiningGameGuidePanel = class("MiningGameGuidePanel", BasePanel)
MiningGameGuidePanel._sUIResRootPath = "UI_Activity/"
MiningGameGuidePanel._tbDefine = {
  {
    sPrefabPath = "_400011/MiningGameGuidePanel.prefab",
    sCtrlName = "Game.UI.Activity.Mining.MiningGameGuideCtrl"
  }
}

function MiningGameGuidePanel:Awake()
end

function MiningGameGuidePanel:OnEnable()
end

function MiningGameGuidePanel:OnAfterEnter()
end

function MiningGameGuidePanel:OnDisable()
end

function MiningGameGuidePanel:OnDestroy()
end

function MiningGameGuidePanel:OnRelease()
end

return MiningGameGuidePanel
