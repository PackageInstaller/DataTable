require("skill_effect_result_base")
_class("SkillEffectResultDamageBySelectPieceCount", SkillEffectResultBase)
SkillEffectResultDamageBySelectPieceCount = SkillEffectResultDamageBySelectPieceCount

function SkillEffectResultDamageBySelectPieceCount:Constructor(entityID, posStart, posMiddle, posEnd, dir)
  self._entityID = entityID
  self._posStart = posStart
  self._posMiddle = posMiddle
  self._posEnd = posEnd
  self._dir = dir
end

function SkillEffectResultDamageBySelectPieceCount:GetEffectType()
  return SkillEffectType.DamageBySelectPieceCount
end

function SkillEffectResultDamageBySelectPieceCount:GetCasterEntityID()
  return self._entityID
end

function SkillEffectResultDamageBySelectPieceCount:GetPosStart()
  return self._posStart
end

function SkillEffectResultDamageBySelectPieceCount:GetPosMiddle()
  return self._posMiddle
end

function SkillEffectResultDamageBySelectPieceCount:GetPosEnd()
  return self._posEnd
end

function SkillEffectResultDamageBySelectPieceCount:GetDir()
  return self._dir
end
