require("action_cast_skill_base")
_class("ActionCastSelectedSkill", ActionCastSkillBase)
ActionCastSelectedSkill = ActionCastSelectedSkill

function ActionCastSelectedSkill:Constructor()
end

function ActionCastSelectedSkill:GetWorkSkillID()
  local nSkillID = self:GetLogicData(1)
  return nSkillID
end
