_class("SkillAutoBeadAttackData", Object)
SkillAutoBeadAttackData = SkillAutoBeadAttackData

function SkillAutoBeadAttackData:Constructor(autoBeadID, skillID, skillIndex, skillTurnIndex, skillBeadIndex, skillExtraIndex, skillRepeatIndex)
  self._autoBeadID = autoBeadID
  self._autoBeadSkillID = skillID
  self._autoBeadSkillIndex = skillIndex
  self._autoBeadSkillTurnIndex = skillTurnIndex
  self._autoBeadSkillBeadIndex = skillBeadIndex
  self._autoBeadSkillExtraIndex = skillExtraIndex
  self._autoBeadSkillRepeatIndex = skillRepeatIndex
  self._resultContainer = nil
end

function SkillAutoBeadAttackData:GetResultContainer()
  return self._resultContainer
end

function SkillAutoBeadAttackData:SetResultContainer(rc)
  self._resultContainer = rc
end

function SkillAutoBeadAttackData:GetAutoBeadID()
  return self._autoBeadID
end

function SkillAutoBeadAttackData:GetAutoBeadAttackDataSkillID()
  return self._autoBeadSkillID
end

function SkillAutoBeadAttackData:GetAutoBeadSkillIndex()
  return self._autoBeadSkillIndex
end

function SkillAutoBeadAttackData:GetAutoBeadSkillTurnIndex()
  return self._autoBeadSkillTurnIndex
end

function SkillAutoBeadAttackData:GetAutoBeadSkillBeadIndex()
  return self._autoBeadSkillBeadIndex
end

function SkillAutoBeadAttackData:GetAutoBeadSkillExtraIndex()
  return self._autoBeadSkillExtraIndex
end

function SkillAutoBeadAttackData:GetAutoBeadSkillRepeatIndex()
  return self.skillRepeatIndex
end

function SkillAutoBeadAttackData:HasDamage()
  if self._resultContainer and self._resultContainer:GetEffectResultByArray(SkillEffectType.Damage) then
    return true
  end
  return false
end

function SkillAutoBeadAttackData:SetFinalAttack(isFinalAttack)
  self._isFinalAttack = isFinalAttack
end

function SkillAutoBeadAttackData:IsFinalAttack()
  return self._isFinalAttack
end
