require("ai_node_new")
_class("ActionCastSpecifiedSkill", ActionCastSkillBase)
ActionCastSpecifiedSkill = ActionCastSpecifiedSkill

function ActionCastSpecifiedSkill:Constructor()
end

function ActionCastSpecifiedSkill:GetWorkSkillID()
  local skillIndexX, skillIndexY = self:GetLogicData(-1), self:GetLogicData(-2)
  local nSkillID = self:GetConfigSkillID(skillIndexX, skillIndexY)
  self:PrintDebugLog("释放技能：", nSkillID)
  return nSkillID
end
