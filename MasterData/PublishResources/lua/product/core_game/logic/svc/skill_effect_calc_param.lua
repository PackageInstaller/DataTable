_class("SkillEffectCalcParam", Object)
SkillEffectCalcParam = SkillEffectCalcParam

function SkillEffectCalcParam:Constructor(casterEntityID, targetEntityIDs, skillEffectParam, skillID, skillRange, attackPos, gridPos, centerPos, wholeRange)
  self.casterEntityID = casterEntityID
  self.targetEntityIDs = targetEntityIDs
  self.skillID = skillID
  self.attackPos = attackPos
  self.gridPos = gridPos
  self.centerPos = centerPos
  self.skillRange = skillRange
  self.skillEffectParam = skillEffectParam or {}
  self.wholeRange = wholeRange
end

function SkillEffectCalcParam:GetCasterEntityID()
  return self.casterEntityID
end

function SkillEffectCalcParam:GetTargetEntityIDs()
  return self.targetEntityIDs
end

function SkillEffectCalcParam:SetTargetEntityIDs(targetEntityIDs)
  self.targetEntityIDs = targetEntityIDs
end

function SkillEffectCalcParam:GetSkillID()
  return self.skillID
end

function SkillEffectCalcParam:GetSkillEffectParam()
  return self.skillEffectParam
end

function SkillEffectCalcParam:GetAttackPos()
  return self.attackPos
end

function SkillEffectCalcParam:GetGridPos()
  return self.gridPos
end

function SkillEffectCalcParam:GetSkillRange()
  return self.skillRange
end

function SkillEffectCalcParam:SetSkillEffectParam(t)
  self.skillEffectParam = t
end

function SkillEffectCalcParam:SetSkillRange(t)
  self.skillRange = t
end

function SkillEffectCalcParam:SetGridPos(gridPos)
  self.gridPos = gridPos
end

function SkillEffectCalcParam:GetCenterPos()
  return self.centerPos
end

function SkillEffectCalcParam:SetSpecialScopeResult(specialScopeResult)
  self._specialScopeResult = specialScopeResult
end

function SkillEffectCalcParam:GetSpecialScopeResult()
  return self._specialScopeResult
end

function SkillEffectCalcParam:GetWholeRange()
  return self.wholeRange
end

function SkillEffectCalcParam:SetTotalTargetCount(cnt)
  self.totalTargetCount = cnt
end

function SkillEffectCalcParam:GetTotalTargetCount()
  return self.totalTargetCount or 0
end

function SkillEffectCalcParam:SetDamageGridPos(v2)
  self._damageGridPos = v2
end

function SkillEffectCalcParam:GetDamageGridPos()
  return self._damageGridPos
end

function SkillEffectCalcParam:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function SkillEffectCalcParam:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end
