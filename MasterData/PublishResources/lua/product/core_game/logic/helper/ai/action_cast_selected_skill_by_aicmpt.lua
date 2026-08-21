require("action_cast_skill_base")
_class("ActionCastSelectedSkillByAiCmpt", ActionCastSkillBase)
ActionCastSelectedSkillByAiCmpt = ActionCastSelectedSkillByAiCmpt

function ActionCastSelectedSkillByAiCmpt:Constructor()
end

function ActionCastSelectedSkillByAiCmpt:GetWorkSkillID()
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  local nSelectedSkillID = aiComponent:GetSelectSkillID()
  if nSelectedSkillID == 0 then
    return self:GetLogicData(1)
  end
  return nSelectedSkillID
end
