local StarTowerQuestPanel = class("StarTowerQuestPanel", BasePanel)
StarTowerQuestPanel._bAddToBackHistory = false
StarTowerQuestPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerQuest/StarTowerQuestPanel.prefab",
    sCtrlName = "Game.UI.StarTowerQuest.StarTowerQuestCtrl"
  }
}

function StarTowerQuestPanel:Awake()
end

function StarTowerQuestPanel:OnEnable()
end

function StarTowerQuestPanel:OnAfterEnter()
end

function StarTowerQuestPanel:OnDisable()
end

function StarTowerQuestPanel:OnDestroy()
end

function StarTowerQuestPanel:OnRelease()
end

return StarTowerQuestPanel
