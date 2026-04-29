require("skill_effect_result_base")
_class("SkillDamageEffectResult", SkillEffectResultBase)
SkillDamageEffectResult = SkillDamageEffectResult

function SkillDamageEffectResult:Constructor(gridPos, targetid, damage, damageArray, damageStageIndex)
  self._attackGridDataDict = {}
  self._gridPos = gridPos
  self._targetID = targetid
  self._totalDamage = damage
  self._multiDamageInfo = damageArray
  self._damageStageIndex = damageStageIndex or 1
  self._used = false
  self._buffLayerCountForDamage = 0
  self._isClearBuffLayer = false
  self._damageIndex = nil
end

function SkillDamageEffectResult:GetEffectType()
  return SkillEffectType.Damage
end

function SkillDamageEffectResult:GetTargetID()
  return self._targetID
end

function SkillDamageEffectResult:GetTotalDamage()
  return self._totalDamage
end

function SkillDamageEffectResult:SetTotalDamage(val)
  self._totalDamage = math.floor(val)
  if self._totalDamage < 1 then
    self._totalDamage = 1
  end
end

function SkillDamageEffectResult:GetGridPos()
  return self._gridPos
end

function SkillDamageEffectResult:GetDamageInfoArray()
  return self._multiDamageInfo
end

function SkillDamageEffectResult:GetDamageInfo(index)
  if self._multiDamageInfo then
    return self._multiDamageInfo[index]
  end
  return nil
end

function SkillDamageEffectResult:SetDamageInfo(index, damageInfo)
  self._multiDamageInfo[index] = damageInfo
  self._totalDamage = self._totalDamage + damageInfo:GetDamageValue()
end

function SkillDamageEffectResult:GetDamageStageIndex()
  return self._damageStageIndex
end

function SkillDamageEffectResult:SetDamageStageIndex(damageStageIndex)
  self._damageStageIndex = damageStageIndex
end

function SkillDamageEffectResult:SetUsed()
  self._used = true
end

function SkillDamageEffectResult:IsUsed()
  return self._used
end

function SkillDamageEffectResult:IsSame(otherResult)
  if self._targetID ~= otherResult._targetID then
    return false
  end
  if self._gridPos ~= otherResult._gridPos then
    return false
  end
  return true
end

function SkillDamageEffectResult:SetSpecialScopeResultList(specialScopeResultList)
  self._specialScopeResultList = specialScopeResultList
end

function SkillDamageEffectResult:GetSpecialScopeResultList()
  return self._specialScopeResultList
end

function SkillDamageEffectResult:SetCasterID(casterID)
  self._casterID = casterID
end

function SkillDamageEffectResult:GetCasterID()
  return self._casterID
end

function SkillDamageEffectResult:SetBuffLayerCountForDamage(layerCount)
  self._buffLayerCountForDamage = layerCount
end

function SkillDamageEffectResult:GetBuffLayerCountForDamage()
  return self._buffLayerCountForDamage
end

function SkillDamageEffectResult:SetDamageIndex(index)
  self._damageIndex = index
end

function SkillDamageEffectResult:GetDamageIndex()
  return self._damageIndex
end

function SkillDamageEffectResult:SetNormalAttackDouble(normalAttackDouble)
  self._normalAttackDouble = normalAttackDouble
end

function SkillDamageEffectResult:GetNormalAttackDouble()
  return self._normalAttackDouble
end

function SkillDamageEffectResult:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function SkillDamageEffectResult:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end
