require("skill_effect_param_base")
_class("SkillSerialKillerEffectParam", SkillEffectParamBase)
SkillSerialKillerEffectParam = SkillSerialKillerEffectParam

function SkillSerialKillerEffectParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._killCount = t.count
  self._serialScopeType = t.serialScopeType
  self._radius = t.radius
  self._pieceType = t.pieceType
  self._onePieceAddAttackCount = t.onePieceAddAttackCount
  self._pureDamage = t.pureDamage or 0
  self._multiple = t.multiple or 1
end

function SkillSerialKillerEffectParam:GetSerialScopeType()
  return self._serialScopeType
end

function SkillSerialKillerEffectParam:GetRadius()
  return self._radius
end

function SkillSerialKillerEffectParam:GetPieceType()
  return self._pieceType
end

function SkillSerialKillerEffectParam:GetOnePieceAddAttackCount()
  return self._onePieceAddAttackCount
end

function SkillSerialKillerEffectParam:GetEffectType()
  return SkillEffectType.SerialKiller
end

function SkillSerialKillerEffectParam:GetPercent()
  return self._percent
end

function SkillSerialKillerEffectParam:GetFormulaID()
  return self._formulaID
end

function SkillSerialKillerEffectParam:GetKillCount()
  return self._killCount
end

function SkillSerialKillerEffectParam:GetPureDamage()
  return self._pureDamage
end

function SkillSerialKillerEffectParam:GetMultiple()
  return self._multiple
end
