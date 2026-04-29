_class("SkillEffectResultContainer", Object)
SkillEffectResultContainer = SkillEffectResultContainer
require("skill_effect_type")
SkillEffectResultTypeOverride = {
  [SkillEffectType.SummonMultipleTrap] = SkillEffectType.SummonTrap,
  [SkillEffectType.EnhanceOccupiedGrid] = SkillEffectType.SummonTrap
}
_enum("SkillEffectResultTypeOverride", SkillEffectResultTypeOverride)

function SkillEffectResultContainer:Constructor()
  self._isFinalAttack = false
  self._finalAttackEntityID = nil
  self._scopeResult = nil
  self._effectResultDic = {}
  self.m_nSkillID = 0
  self._isNormalAttack = false
  self._isLastNormalAttackAtOneGrid = true
  self._isInvalidated = false
end

function SkillEffectResultContainer:Clear()
  self._isFinalAttack = false
  self._finalAttackEntityID = nil
  self._scopeResult = nil
  self._effectResultDic = {}
  self.m_nSkillID = 0
  self._isNormalAttack = false
  self._isLastNormalAttackAtOneGrid = true
  self._isInvalidated = false
end

function SkillEffectResultContainer:SetScopeResult(result)
  self._scopeResult = result
end

function SkillEffectResultContainer:GetScopeResult()
  return self._scopeResult
end

function SkillEffectResultContainer:AddEffectResult(result, bReplace)
  if result == nil then
    Log.error("SkillEffectResultContainer:AddEffectResult result is nil")
    return
  end
  local effect_type = result:GetEffectType()
  if self._effectResultDic[effect_type] == nil then
    self._effectResultDic[effect_type] = {}
  end
  local results = self._effectResultDic[effect_type]
  if not results.array then
    results.array = {}
  end
  local bAddSuccess = false
  if bReplace then
    for k, v in ipairs(results.array) do
      if result:IsSame(v) then
        bAddSuccess = true
        results.array[k] = result
        break
      end
    end
  end
  if false == bAddSuccess then
    results.array[#results.array + 1] = result
  end
  if not results.pos then
    results.pos = {}
  end
  local posGrid = result:GetGridPos()
  if posGrid then
    results.pos[Vector2.Pos2Index(posGrid)] = result
  end
  if not results.target then
    results.target = {}
  end
  if result:GetTargetID() then
    results.target[result:GetTargetID()] = result
  end
end

function SkillEffectResultContainer:GetEffectResultByArray(type, index)
  local res = self._effectResultDic[type]
  if res then
    if index == nil then
      index = 1
    end
    return res.array[index]
  end
end

function SkillEffectResultContainer:GetEffectResultByArrayAll(type)
  local res = self._effectResultDic[type]
  if res then
    return res.array
  end
end

function SkillEffectResultContainer:GetEffectResultByPos(type, pos)
  local res = self._effectResultDic[type]
  if nil == res then
    return nil
  end
  return res.pos[Vector2.Pos2Index(pos)]
end

function SkillEffectResultContainer:GetEffectResultByTargetID(type, targetid)
  local res = self._effectResultDic[type]
  if res then
    return res.target[targetid]
  end
end

function SkillEffectResultContainer:GetEffectResultsAsPosDic(type)
  if not self._effectResultDic[type] then
    return
  end
  return self._effectResultDic[type].pos
end

function SkillEffectResultContainer:GetEffectResultsAsTargetIdDic(type)
  if not self._effectResultDic[type] then
    return
  end
  return self._effectResultDic[type].target
end

function SkillEffectResultContainer:GetEffectResultsAsArray(type, damageStageIndex)
  if not self._effectResultDic[type] then
    return
  end
  local effectResultDic = self:_FilterByStage(self._effectResultDic[type].array, damageStageIndex)
  return effectResultDic
end

function SkillEffectResultContainer:_FilterByStage(damageResultArrayAllStage, damageStageIndex)
  if damageStageIndex then
    local effectResultDic = {}
    for _, damageResult in ipairs(damageResultArrayAllStage) do
      if damageResult:GetDamageStageIndex() == damageStageIndex then
        table.insert(effectResultDic, damageResult)
      end
    end
    return effectResultDic
  end
  return damageResultArrayAllStage
end

function SkillEffectResultContainer:GetEffectResultsStageCount(type)
  if not self._effectResultDic[type] then
    return
  end
  local stageCount = 0
  local effectResultDic = self._effectResultDic[type].array
  for _, effectResult in ipairs(effectResultDic) do
    local stageIndex = effectResult:GetDamageStageIndex()
    if stageCount < stageIndex then
      stageCount = stageIndex
    end
  end
  return stageCount
end

function SkillEffectResultContainer:GetEffectResultDict()
  return self._effectResultDic
end

function SkillEffectResultContainer:SetEffectResultDict(results)
  self._effectResultDic = results
end

function SkillEffectResultContainer:SetFinalAttack(isFinalAttack)
  self._isFinalAttack = isFinalAttack
end

function SkillEffectResultContainer:SetFinalAttackEntityID(entityID)
  self._finalAttackEntityID = entityID
end

function SkillEffectResultContainer:GetFinalAttackEntityID()
  return self._finalAttackEntityID
end

function SkillEffectResultContainer:IsFinalAttack()
  return self._isFinalAttack
end

function SkillEffectResultContainer:IsFinalDamageResult(res)
  for i, r in ipairs(self._effectResultDic[SkillEffectType.Damage].array) do
    if r ~= res and not r:IsUsed() then
      return false
    end
  end
  return true
end

function SkillEffectResultContainer:SetSkillID(nSkillID)
  self.m_nSkillID = nSkillID
end

function SkillEffectResultContainer:GetSkillID()
  return self.m_nSkillID
end

function SkillEffectResultContainer:SetChainEffectResultTimeIndex(idx)
  self._chainTimeIndex = idx
end

function SkillEffectResultContainer:GetChainEffectResultTimeIndex()
  return self._chainTimeIndex
end

function SkillEffectResultContainer:SetChainEffectResultStageIndex(idx)
  self.chainStageIndex = idx
end

function SkillEffectResultContainer:GetChainEffectResultStageIndex()
  return self.chainStageIndex or 1
end

function SkillEffectResultContainer:SetNormalAttack(isNormalAttack)
  self._isNormalAttack = isNormalAttack
end

function SkillEffectResultContainer:IsNormalAttack()
  return self._isNormalAttack
end

function SkillEffectResultContainer:SetLastNormalAttackAtOnGrid(isLastNormalAttackAtOneGrid)
  self._isLastNormalAttackAtOneGrid = isLastNormalAttackAtOneGrid
end

function SkillEffectResultContainer:IsLastNormalAttackAtOnGrid()
  return self._isLastNormalAttackAtOneGrid
end

function SkillEffectResultContainer:GetEffectResultsByType(type)
  return self._effectResultDic[type]
end

function SkillEffectResultContainer:SetNormalAttackBeAttackOriPos(pos)
  self._normalAttackBeAttackOriPos = pos
end

function SkillEffectResultContainer:GetNormalAttackBeAttackOriPos()
  return self._normalAttackBeAttackOriPos
end

function SkillEffectResultContainer:SetAutoBeadResultSkillIndex(idx)
  self._autoBeadSkillIndex = idx
end

function SkillEffectResultContainer:GetAutoBeadResultSkillIndex()
  return self._autoBeadSkillIndex
end

function SkillEffectResultContainer:SetIsInvalidated(invalidated)
  self._isInvalidated = invalidated
end

function SkillEffectResultContainer:GetIsInvalidated()
  return self._isInvalidated
end
