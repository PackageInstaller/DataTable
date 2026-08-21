_class("UIFightSkillActiveVarPoint", UICustomWidget)
UIFightSkillActiveVarPoint = UIFightSkillActiveVarPoint

function UIFightSkillActiveVarPoint:Constructor()
end

function UIFightSkillActiveVarPoint:OnShow(uiParams)
  self._off = self:GetGameObject("off")
  self._on = self:GetGameObject("on")
end

function UIFightSkillActiveVarPoint:SetData(idx, curIdx)
  self._off:SetActive(idx ~= curIdx)
  self._on:SetActive(idx == curIdx)
end
