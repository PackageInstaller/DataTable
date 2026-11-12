local SkillSucBarPanel = class("SkillSucBarPanel", BasePanel)
SkillSucBarPanel._bIsMainPanel = false
SkillSucBarPanel._tbDefine = {
  {
    sPrefabPath = "SuccessBarEx/SkillSucBarPanel.prefab",
    sCtrlName = "Game.UI.SuccessBarEx.SkillSucBarCtrl"
  }
}

function SkillSucBarPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapData = tbParam[1]
    self.callback = tbParam[2]
  end
end

function SkillSucBarPanel:OnEnable()
end

function SkillSucBarPanel:OnDisable()
end

function SkillSucBarPanel:OnDestroy()
end

return SkillSucBarPanel
