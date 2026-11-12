local DormQuestPanel = class("DormQuestPanel", BasePanel)
DormQuestPanel._bIsMainPanel = false
DormQuestPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormQuestPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormQuest.DormQuestCtrl"
  }
}

function DormQuestPanel:Awake()
end

function DormQuestPanel:OnEnable()
end

function DormQuestPanel:OnAfterEnter()
end

function DormQuestPanel:OnDisable()
end

function DormQuestPanel:OnDestroy()
end

function DormQuestPanel:OnRelease()
end

return DormQuestPanel
