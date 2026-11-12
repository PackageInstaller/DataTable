local TalentPanel = class("TalentPanel", BasePanel)
TalentPanel._tbDefine = {
  {
    sPrefabPath = "CharSkill/CharSkillPanel.prefab",
    sCtrlName = "Game.UI.CharSkill.CharSkillCtrl"
  }
}

function TalentPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
  end
end

return TalentPanel
