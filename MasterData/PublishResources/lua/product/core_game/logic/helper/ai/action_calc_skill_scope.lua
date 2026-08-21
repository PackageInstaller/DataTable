require("ai_node_new")
_class("ActionCalcSkillScope", AINewNode)
ActionCalcSkillScope = ActionCalcSkillScope

function ActionCalcSkillScope:Constructor()
end

function ActionCalcSkillScope:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local addRoundCount = self:GetLogicData(-1)
  local skillIndexX, skillIndexY = self:GetLogicData(-2), self:GetLogicData(-3)
  local nSkillID = self:GetConfigSkillID(skillIndexX, skillIndexY)
  aiCmpt:SetCurSkillScopeResult(addRoundCount, nSkillID)
  return AINewNodeStatus.Success
end
