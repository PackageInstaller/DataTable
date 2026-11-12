local CharSkillTrialPanel = class("CharSkillTrialPanel", BasePanel)
CharSkillTrialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoTrial/CharSkillTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharSkillTrialCtrl"
  }
}

function CharSkillTrialPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
  end
end

return CharSkillTrialPanel
