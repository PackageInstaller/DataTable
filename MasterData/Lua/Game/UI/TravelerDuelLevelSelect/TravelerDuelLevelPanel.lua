local TravelerDuelLevelPanel = class("TravelerDuelLevelPanel", BasePanel)
TravelerDuelLevelPanel._tbDefine = {
  {
    sPrefabPath = "TravelerDuelLevelSelect/TravelerDuelLevelPanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelLevelSelectCtrl"
  }
}

function TravelerDuelLevelPanel:Awake()
end

function TravelerDuelLevelPanel:OnEnable()
end

function TravelerDuelLevelPanel:OnDisable()
end

function TravelerDuelLevelPanel:OnDestroy()
end

function TravelerDuelLevelPanel:OnRelease()
end

return TravelerDuelLevelPanel
