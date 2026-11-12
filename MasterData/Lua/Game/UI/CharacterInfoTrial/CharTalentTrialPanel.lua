local CharTalentTrialPanel = class("CharTalentTrialPanel", BasePanel)
CharTalentTrialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoTrial/CharTalentTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharTalentTrialCtrl"
  }
}

function CharTalentTrialPanel:Awake()
end

function CharTalentTrialPanel:OnEnable()
end

function CharTalentTrialPanel:OnDisable()
end

function CharTalentTrialPanel:OnDestroy()
end

return CharTalentTrialPanel
