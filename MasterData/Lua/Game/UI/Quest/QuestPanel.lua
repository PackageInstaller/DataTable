local QuestPanel = class("QuestPanel", BasePanel)
QuestPanel._tbDefine = {
  {
    sPrefabPath = "Quest/QuestPanel.prefab",
    sCtrlName = "Game.UI.Quest.QuestCtrl"
  }
}

function QuestPanel:Awake()
  self.nCurTab = nil
end

function QuestPanel:OnEnable()
end

function QuestPanel:OnDisable()
end

function QuestPanel:OnDestroy()
end

function QuestPanel:OnRelease()
end

return QuestPanel
