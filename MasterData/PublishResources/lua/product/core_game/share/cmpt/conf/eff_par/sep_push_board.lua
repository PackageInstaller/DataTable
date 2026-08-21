require("skill_effect_param_base")
_class("SkillEffectPushBoardParam", SkillEffectParamBase)
SkillEffectPushBoardParam = SkillEffectPushBoardParam

function SkillEffectPushBoardParam:Constructor(t)
  self._targetIndex = t.targetIndex or 0
  self._dir = Vector2(0, 1)
  if t.dir then
    self._dir = Vector2(t.dir[1], t.dir[2])
  end
  self._pushStep = t.pushStep or 1
  self._disFromBoardEdge = t.disFromBoardEdge
end

function SkillEffectPushBoardParam:GetEffectType()
  return SkillEffectType.PushBoard
end

function SkillEffectPushBoardParam:GetTargetIndex()
  return self._targetIndex
end

function SkillEffectPushBoardParam:GetDir()
  return self._dir
end

function SkillEffectPushBoardParam:GetPushStep()
  return self._pushStep
end

function SkillEffectPushBoardParam:GetDisFromBoardEdge()
  return self._disFromBoardEdge
end
