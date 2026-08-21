_class("RandomCountDamageSameHalfCalculator", Object)
RandomCountDamageSameHalfCalculator = RandomCountDamageSameHalfCalculator

function RandomCountDamageSameHalfCalculator:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function RandomCountDamageSameHalfCalculator:Calculate(casterEntity, skillEffectCalcParam, finalScopeFilterParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
  if not targetIDs or table.count(targetIDs) == 0 then
    return
  end
  local results = {}
  local damageDampList = {}
  local percents = skillEffectCalcParam:GetDamagePercent()
  local damageFormulaID = skillEffectCalcParam:GetDamageFormulaID()
  local dampPer = skillEffectCalcParam:GetDampPercent()
  local percentAddParam = skillEffectCalcParam:GetPercentAdd()
  local isSelTargetLoop = skillEffectCalcParam:GetIsSelTargetLoop()
  local randomSvc = self._world:GetService("RandomLogic")
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local curDamageIndex = 1
  local lastIndex = 0
  local damageRandomCount = skillEffectCalcParam:GetDamageRandomCount()
  local randomSvc = self._world:GetService("RandomLogic")
  local damageCount = randomSvc:LogicRand(damageRandomCount[1], damageRandomCount[2])
  while damageCount > #results do
    local index
    if isSelTargetLoop then
      index = lastIndex + 1
      if index > #targetIDs then
        index = 1
      end
      lastIndex = index
    else
      index = randomSvc:LogicRand(1, #targetIDs)
    end
    local targetID = targetIDs[index]
    if not damageDampList[targetID] then
      damageDampList[targetID] = 1
    end
    local multiDamageInfo = {}
    local totalDamage = 0
    local target = self._world:GetEntityByID(targetID)
    local targetPos = target:GridLocation():GetGridPos()
    for _, percent in ipairs(percents) do
      self._skillEffectService:NotifyDamageBegin(casterEntity, target, casterEntity:GetGridPosition(), targetPos, skillID, nil, nil, curDamageIndex)
      local damageInfo = svcCalcDamage:DoCalcDamage(casterEntity, target, {
        percent = (percent + percentAddParam) * damageDampList[targetID],
        skillID = skillID,
        formulaID = damageFormulaID,
        critProb = skillEffectCalcParam.critProb,
        crit = skillEffectCalcParam.crit
      })
      damageInfo:SetRandHalfDamageIndex(curDamageIndex)
      curDamageIndex = curDamageIndex + 1
      damageDampList[targetID] = damageDampList[targetID] * dampPer
      totalDamage = totalDamage + damageInfo:GetDamageValue()
      table.insert(multiDamageInfo, damageInfo)
      self._skillEffectService:NotifyDamageEnd(casterEntity, target, casterEntity:GetGridPosition(), targetPos, skillID, damageInfo)
    end
    local skillResult = SkillDamageEffectResult:New(targetPos, targetID, totalDamage, multiDamageInfo)
    results[#results + 1] = skillResult
  end
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  for _, v in ipairs(results) do
    skillEffectResultContainer:AddEffectResult(v)
  end
  return results
end
