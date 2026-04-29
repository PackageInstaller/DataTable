_class("SkillEffectCalcRandDamageSameHalf", Object)
SkillEffectCalcRandDamageSameHalf = SkillEffectCalcRandDamageSameHalf

function SkillEffectCalcRandDamageSameHalf:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalcRandDamageSameHalf:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local percents = skillDamageParam:GetDamagePercent()
  local damageFormulaID = skillDamageParam:GetDamageFormulaID()
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local damageDampList = {}
  local damageCount = skillDamageParam:GetDamageCount()
  local dampPer = skillDamageParam:GetDampPercent()
  local percentAddParam = skillDamageParam:GetPercentAdd()
  local isSelTargetLoop = skillDamageParam:GetIsSelTargetLoop()
  local isKeepDamageList = skillDamageParam:IsKeepDampList()
  local isFakeRandom = skillDamageParam:GetIsFakeRandom()
  if isFakeRandom then
    local randomSeed = skillDamageParam:GetFakeRandomSeed()
    self:_InitFakeRandomGenerator(randomSeed)
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local curDamageIndex = 1
  local lastIndex = 0
  if isKeepDamageList then
    local super = attacker
    if attacker:HasSuperEntity() then
      super = attacker:GetSuperEntity() or attacker
    end
    if super:SkillContext() then
      damageDampList = super:SkillContext():GetDamageDampList()
    end
  end
  local damageRandomCount = skillDamageParam:GetDamageRandomCount()
  if damageRandomCount and type(damageRandomCount) == "table" then
    local randomSvc = self._world:GetService("RandomLogic")
    local randomCount = randomSvc:LogicRand(damageRandomCount[1], damageRandomCount[2])
    damageCount = randomCount
  end
  local preCalTargetPer = self:_CalcPreRepeatTargetDmgPer(skillDamageParam, targets, damageCount)
  while damageCount > #results do
    local index
    if isSelTargetLoop then
      index = lastIndex + 1
      if index > #targets then
        index = 1
      end
      lastIndex = index
    elseif isFakeRandom then
      index = self:_CalcFakeRandomIndex(targets, damageDampList)
    else
      index = randomSvc:LogicRand(1, #targets)
    end
    local targetID = targets[index]
    if not damageDampList[targetID] then
      damageDampList[targetID] = 1
    end
    if preCalTargetPer and preCalTargetPer[targetID] then
      damageDampList[targetID] = preCalTargetPer[targetID]
    end
    local multiDamageInfo = {}
    local totalDamage = 0
    local target = self._world:GetEntityByID(targetID)
    if target then
      local targetPos = target:GridLocation():GetGridPos()
      for _, percent in ipairs(percents) do
        self._skillEffectService:NotifyDamageBegin(attacker, target, attacker:GetGridPosition(), targetPos, skillEffectCalcParam.skillID, nil, nil, curDamageIndex)
        local damageInfo = svcCalcDamage:DoCalcDamage(attacker, target, {
          percent = (percent + percentAddParam) * damageDampList[targetID],
          skillID = skillEffectCalcParam.skillID,
          formulaID = damageFormulaID
        })
        damageInfo:SetRandHalfDamageIndex(curDamageIndex)
        curDamageIndex = curDamageIndex + 1
        damageDampList[targetID] = damageDampList[targetID] * dampPer
        totalDamage = totalDamage + damageInfo:GetDamageValue()
        table.insert(multiDamageInfo, damageInfo)
        self._skillEffectService:NotifyDamageEnd(attacker, target, skillEffectCalcParam.attackPos, targetPos, skillEffectCalcParam.skillID, damageInfo)
      end
      local skillResult = SkillDamageEffectResult:New(targetPos, targetID, totalDamage, multiDamageInfo)
      results[#results + 1] = skillResult
    end
  end
  return results
end

function SkillEffectCalcRandDamageSameHalf:_CalcPreRepeatTargetDmgPer(skillDamageParam, targets, damageCount)
  local dampPer = skillDamageParam:GetDampPercent()
  local isSelTargetLoop = skillDamageParam:GetIsSelTargetLoop()
  local isRepeatAllSameHalf = skillDamageParam:IsRepeatAllSameHalf()
  if isRepeatAllSameHalf and isSelTargetLoop then
    local attackTargetArray = {}
    local index = 0
    for i = 1, damageCount do
      index = index + 1
      if index > #targets then
        index = 1
      end
      local targetID = targets[index]
      table.insert(attackTargetArray, targetID)
    end
    local targetCountDic = {}
    for _, targetID in ipairs(attackTargetArray) do
      if targetCountDic[targetID] then
        targetCountDic[targetID] = targetCountDic[targetID] + 1
      else
        targetCountDic[targetID] = 1
      end
    end
    local preCalTargetPer = {}
    for _, targetID in ipairs(targets) do
      if targetCountDic[targetID] and 1 < targetCountDic[targetID] then
        preCalTargetPer[targetID] = dampPer
      end
    end
    return preCalTargetPer
  end
end

function SkillEffectCalcRandDamageSameHalf:_InitFakeRandomGenerator(randomSeed)
  self._randomGenerator = lcg(randomSeed)
  if EDITOR then
    Log.debug("RandDamageSameHalf:_CalcFakeRandomIndex, initSeed=", randomSeed)
  end
end

function SkillEffectCalcRandDamageSameHalf:_CalcFakeRandomIndex(targets, damageDampList)
  if self._randomGenerator then
    local targetInfos = {}
    for index, targetID in ipairs(targets) do
      local targetInfo = {id = targetID, oriIndex = index}
      table.insert(targetInfos, targetInfo)
    end
    local aliveTargetInfos = {}
    for index, targetInfo in ipairs(targetInfos) do
      local targetID = targetInfo.id
      local targetEntity = self._world:GetEntityByID(targetID)
      if targetEntity then
        local currentHP = targetEntity:Attributes():GetCurrentHP()
        if 0 < currentHP then
          table.insert(aliveTargetInfos, targetInfo)
        end
      end
    end
    if #aliveTargetInfos == 0 then
      aliveTargetInfos = targetInfos
    end
    local firstLevelTargetInfos = {}
    for index, targetInfo in ipairs(aliveTargetInfos) do
      local targetID = targetInfo.id
      if not damageDampList[targetID] then
        table.insert(firstLevelTargetInfos, targetInfo)
      end
    end
    if #firstLevelTargetInfos == 0 then
      firstLevelTargetInfos = aliveTargetInfos
    end
    local validIndex = self:LocalLogicRand(1, #firstLevelTargetInfos)
    if validIndex < 0 then
      return 1
    end
    local index = firstLevelTargetInfos[validIndex].oriIndex
    if EDITOR then
      local targetCount = #targets
      Log.debug("RandDamageSameHalf:_CalcFakeRandomIndex,targetCount=", targetCount, " index:", index)
    end
    return index
  else
    return 1
  end
end

function SkillEffectCalcRandDamageSameHalf:LocalLogicRand(m, n)
  if not self._randomGenerator then
    return -1
  end
  local randomNum = -1
  if m == nil and n == nil then
    randomNum = self._randomGenerator:random()
  else
    randomNum = self:Rounding(self._randomGenerator:random(m, n))
  end
  return randomNum
end

function SkillEffectCalcRandDamageSameHalf:Rounding(value)
  local f = math.floor(value)
  if f == value then
    return f
  else
    return math.floor(value + 0.5)
  end
end
