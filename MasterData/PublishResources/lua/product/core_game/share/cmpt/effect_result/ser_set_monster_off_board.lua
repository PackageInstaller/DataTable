_class("SkillEffectResultSetMonsterOffBoard", SkillEffectResultBase)
SkillEffectResultSetMonsterOffBoard = SkillEffectResultSetMonsterOffBoard

function SkillEffectResultSetMonsterOffBoard:Constructor(bSetOff)
  self._bSetOff = bSetOff
end

function SkillEffectResultSetMonsterOffBoard:GetEffectType()
  return SkillEffectType.SetMonsterOffBoard
end

function SkillEffectResultSetMonsterOffBoard:SetTargetEntityID(targetEntityID)
  self._targetEntityID = targetEntityID
end

function SkillEffectResultSetMonsterOffBoard:GetTargetEntityID()
  return self._targetEntityID
end

function SkillEffectResultSetMonsterOffBoard:SetIsSetOff(bSetOff)
  self._bSetOff = bSetOff
end

function SkillEffectResultSetMonsterOffBoard:GetIsSetOff()
  return self._bSetOff
end
