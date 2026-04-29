require("skill_effect_param_base")
_class("SkillEffectParamSpliceBoard", SkillEffectParamBase)
SkillEffectParamSpliceBoard = SkillEffectParamSpliceBoard

function SkillEffectParamSpliceBoard:Constructor(t)
  self._distance = t.distance or 0
  self._direction = t.direction or {0, 0}
  self._notifyTrapList = t.notifyTrapList or {}
end

function SkillEffectParamSpliceBoard:GetEffectType()
  return SkillEffectType.SpliceBoard
end

function SkillEffectParamSpliceBoard:GetDistance()
  return self._distance
end

function SkillEffectParamSpliceBoard:GetDirection()
  return self._direction
end

function SkillEffectParamSpliceBoard:GetNotifyTrapList()
  return self._notifyTrapList
end
