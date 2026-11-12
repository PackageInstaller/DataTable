local TravelerDuelQuestPanel = class("TravelerDuelQuestPanel", BasePanel)
TravelerDuelQuestPanel._tbDefine = {
  {
    sPrefabPath = "TravelerDuelLevelSelect/TravelerDuelLevelQuestPanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelQuest.TravelerDuelQuestCtrl"
  }
}

function TravelerDuelQuestPanel:Awake()
end

function TravelerDuelQuestPanel:OnEnable()
end

function TravelerDuelQuestPanel:OnDisable()
end

function TravelerDuelQuestPanel:OnDestroy()
end

function TravelerDuelQuestPanel:OnRelease()
end

return TravelerDuelQuestPanel
