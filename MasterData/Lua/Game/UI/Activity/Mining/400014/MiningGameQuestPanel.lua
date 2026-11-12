local MiningGameQuestPanel = class("MiningGamePanel", BasePanel)
MiningGameQuestPanel._bIsMainPanel = false
MiningGameQuestPanel._sUIResRootPath = "UI_Activity/"
MiningGameQuestPanel._tbDefine = {
  {
    sPrefabPath = "_400014/MiningGameQuest.prefab",
    sCtrlName = "Game.UI.Activity.Mining.MiningGameQuestCtrl"
  }
}

function MiningGameQuestPanel:Awake()
end

function MiningGameQuestPanel:OnEnable()
end

function MiningGameQuestPanel:OnAfterEnter()
end

function MiningGameQuestPanel:OnDisable()
end

function MiningGameQuestPanel:OnDestroy()
end

function MiningGameQuestPanel:OnRelease()
end

return MiningGameQuestPanel
