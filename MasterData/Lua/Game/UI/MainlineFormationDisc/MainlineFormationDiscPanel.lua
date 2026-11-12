local MainlineFormationDiscPanel = class("MainlineFormationDiscPanel", BasePanel)
MainlineFormationDiscPanel._tbDefine = {
  {
    sPrefabPath = "MainlineFormationDisc/MainlineFormationDiscPanelEx.prefab",
    sCtrlName = "Game.UI.MainlineFormationDiscEx.MainlineFormationDiscCtrl"
  }
}

function MainlineFormationDiscPanel:Awake()
  self.curRoguelikeId = nil
  self.nTeamIndex = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.curRoguelikeId = tbParam[1]
    self.nTeamIndex = tbParam[2]
    self.bSweep = tbParam[3]
    self.nPreselectionId = tbParam[4]
  end
end

function MainlineFormationDiscPanel:OnEnable()
end

function MainlineFormationDiscPanel:OnDisable()
end

function MainlineFormationDiscPanel:OnDestroy()
end

return MainlineFormationDiscPanel
