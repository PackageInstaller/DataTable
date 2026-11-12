local CharPotentialTrialPanel = class("CharPotentialTrialPanel", BasePanel)
CharPotentialTrialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoTrial/CharPotentialTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharPotentialTrialCtrl"
  }
}

function CharPotentialTrialPanel:Awake()
end

function CharPotentialTrialPanel:OnEnable()
end

function CharPotentialTrialPanel:OnDisable()
end

function CharPotentialTrialPanel:OnDestroy()
end

return CharPotentialTrialPanel
