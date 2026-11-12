local QuestNewbiePanel = class("QuestNewbiePanel", BasePanel)
QuestNewbiePanel._tbDefine = {
  {
    sPrefabPath = "QuestNewbie/QuestNewbiePanel.prefab",
    sCtrlName = "Game.UI.QuestNewbie.QuestNewbieCtrl"
  }
}

function QuestNewbiePanel:Awake()
  self.nCurTab = nil
end

function QuestNewbiePanel:OnEnable()
end

function QuestNewbiePanel:OnDisable()
end

function QuestNewbiePanel:OnDestroy()
end

function QuestNewbiePanel:OnRelease()
end

return QuestNewbiePanel
