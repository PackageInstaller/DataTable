require("skill_effect_result_base")
_class("SkillEffectDestroyTrapResult", SkillEffectResultBase)
SkillEffectDestroyTrapResult = SkillEffectDestroyTrapResult

function SkillEffectDestroyTrapResult:Constructor(entityID, trapID, trapPos, stageIndex)
  self._entityID = entityID
  self._trapID = trapID
  self._trapPos = trapPos
  self._stageIndex = stageIndex or 1
end

function SkillEffectDestroyTrapResult:GetEffectType()
  return SkillEffectType.DestroyTrap
end

function SkillEffectDestroyTrapResult:GetEntityID()
  return self._entityID
end

function SkillEffectDestroyTrapResult:GetTrapID()
  return self._trapID
end

function SkillEffectDestroyTrapResult:SetTrapPos(pos)
  self._trapPos = pos
end

function SkillEffectDestroyTrapResult:GetTrapPos()
  return self._trapPos
end

function SkillEffectDestroyTrapResult:GetDamageStageIndex()
  return self._stageIndex
end
