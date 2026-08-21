require("skill_effect_result_base")
_class("SkillEffectResultControlMonsterMove", SkillEffectResultBase)
SkillEffectResultControlMonsterMove = SkillEffectResultControlMonsterMove

function SkillEffectResultControlMonsterMove:Constructor(entityID, posStart, posMiddle, posEnd, dir)
  self._entityID = entityID
  self._posStart = posStart
  self._posMiddle = posMiddle
  self._posEnd = posEnd
  self._dir = dir
end

function SkillEffectResultControlMonsterMove:GetEffectType()
  return SkillEffectType.ControlMonsterMove
end

function SkillEffectResultControlMonsterMove:GetCasterEntityID()
  return self._entityID
end

function SkillEffectResultControlMonsterMove:GetPosStart()
  return self._posStart
end

function SkillEffectResultControlMonsterMove:GetPosMiddle()
  return self._posMiddle
end

function SkillEffectResultControlMonsterMove:GetPosEnd()
  return self._posEnd
end

function SkillEffectResultControlMonsterMove:GetDir()
  return self._dir
end
