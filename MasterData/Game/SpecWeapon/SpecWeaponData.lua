local SpecWeaponData = class("SpecWeaponData")

function SpecWeaponData:InitSpecWeapon(weaponId, step, level)
  self._weaponId = weaponId
  self._baseCfg = ConfigData.spec_weapon_basic_config[weaponId]
  self._stepListCfg = ConfigData.spec_weapon_step[weaponId]
  self._levelListCfg = ConfigData.spec_weapon_level[weaponId]
  self._maxStep = ConfigData.spec_weapon_step.stepDic[weaponId]
  self._maxLevel = ConfigData.spec_weapon_level.levelDic[weaponId]
  self:RefreshSpecWeapon(step, level)
end

function SpecWeaponData:RefreshSpecWeapon(step, level)
  if level > self._maxLevel then
    level = self._maxLevel
  end
  if step > self._maxStep then
    step = self._maxStep
  end
  self._step = step
  self._level = level
  local levelCfg = self._levelListCfg[self._level]
  local stepCfg = self._stepListCfg[self._step]
  if levelCfg ~= nil then
    self._attrAddLevelDic = levelCfg.level_attribute
  else
    self._attrAddLevelDic = table.emptytable
  end
  if stepCfg ~= nil then
    self._attrAddStepDic = stepCfg.step_attribute
    self._reolaceSkillDic = stepCfg.replaceSkillDic
  else
    self._reolaceSkillDic = nil
    self._attrAddStepDic = table.emptytable
  end
end

function SpecWeaponData:GetSpecWeaponId()
  return self._weaponId
end

function SpecWeaponData:GetSpecWeaponHeroId()
  return self._baseCfg.hero_id
end

function SpecWeaponData:GetSpecWeaponCurStep()
  return self._step
end

function SpecWeaponData:GetSpecWeaponCurLevel()
  return self._level
end

function SpecWeaponData:GetSpecWeaponMaxStep()
  return self._maxStep
end

function SpecWeaponData:GetSpecWeaponMaxLevel()
  return self._maxLevel
end

function SpecWeaponData:IsSpecWeaponFullStep()
  return self._step >= self._maxStep
end

function SpecWeaponData:IsSpecWeaponFullLevel()
  return self._level >= self._maxLevel
end

function SpecWeaponData:GetSpecWeaponStepLevel(step)
  if step == nil then
    step = self._step
  end
  local stepCfg = self._stepListCfg[step]
  if stepCfg ~= nil then
    return stepCfg.max_level
  end
  return 0
end

function SpecWeaponData:IsSpecWeaponContinueLevel()
  if self:IsSpecWeaponFullLevel() then
    return false
  end
  return self._level < self:GetSpecWeaponStepLevel()
end

function SpecWeaponData:IsSpecWeaponContinueStep()
  if self:IsSpecWeaponFullStep() then
    return false
  end
  return self._level >= self:GetSpecWeaponStepLevel()
end

function SpecWeaponData:GetSpecWeaponUprageCost()
  local costIds, costNums
  local hasNext = false
  if self:IsSpecWeaponContinueStep() then
    local nextStep = self._stepListCfg[self._step + 1]
    costIds = nextStep.cost_ids
    costNums = nextStep.cost_nums
    hasNext = true
  elseif self:IsSpecWeaponContinueLevel() then
    local nextLevel = self._levelListCfg[self._level]
    costIds = nextLevel.cost_ids
    costNums = nextLevel.cost_nums
    hasNext = true
  end
  return costIds, costNums, hasNext
end

function SpecWeaponData:IsSpecWeaponCouldUprage()
  if self._step == 0 and not self:IsSpecWeaponCouldUnlock() then
    return false
  end
  local costIds, costNums, hasNext = self:GetSpecWeaponUprageCost()
  if not hasNext then
    return false
  end
  for i, costId in ipairs(costIds) do
    if PlayerDataCenter:GetItemCount(costId) < costNums[i] then
      return false
    end
  end
  return true
end

function SpecWeaponData:IsSpecWeaponCouldMultipleUprage(count)
  return self._level + count <= self:GetSpecWeaponMultipleUprageTargetLevel()
end

function SpecWeaponData:GetSpecWeaponMultipleUprageCost(count)
  local costDic = {}
  for i = self._level, self._level + count - 1 do
    local nextLevel = self._levelListCfg[i]
    for i, v in ipairs(nextLevel.cost_ids) do
      local num = costDic[v] or 0
      num = num + nextLevel.cost_nums[i]
      costDic[v] = num
    end
  end
  return costDic
end

function SpecWeaponData:GetSpecWeaponMultipleUprageTargetLevel()
  local remainDic = {}
  local maxLevel = self:GetSpecWeaponStepLevel()
  local curLevel = self._level
  local isStop = false
  while maxLevel > curLevel do
    local nextLevel = self._levelListCfg[curLevel]
    for i, v in ipairs(nextLevel.cost_ids) do
      local itemCount = remainDic[v] or PlayerDataCenter:GetItemCount(v)
      itemCount = itemCount - nextLevel.cost_nums[i]
      if itemCount < 0 then
        isStop = true
        break
      end
      remainDic[v] = itemCount
    end
    if isStop then
      break
    end
    curLevel = curLevel + 1
  end
  return curLevel
end

function SpecWeaponData:IsSpecWeaponCouldUnlock()
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SpecWeapon) and CheckCondition.CheckLua(self._baseCfg.pre_condition, self._baseCfg.pre_para1, self._baseCfg.pre_para2)
end

function SpecWeaponData:GetSpecWeaponLevelCfg(level)
  if level == nil then
    level = self._level
  end
  return self._levelListCfg[level]
end

function SpecWeaponData:GetSpecWeaponStepCfg(step)
  if step == nil then
    step = self._step
  end
  return self._stepListCfg[step]
end

function SpecWeaponData:GetSpecWeaponBasicCfg()
  return self._baseCfg
end

function SpecWeaponData:GetSpecWeaponAttriAddtion()
  local temp = {}
  for k, v in pairs(self._attrAddLevelDic) do
    temp[k] = v
  end
  for k, v in pairs(self._attrAddStepDic) do
    temp[k] = (temp[k] or 0) + v
  end
  return temp
end

function SpecWeaponData:GetSpecWeaponAttriAddtionById(attriId)
  return (self._attrAddLevelDic[attriId] or 0) + (self._attrAddStepDic[attriId] or 0)
end

function SpecWeaponData:GetSpecWeaponReplaceSkillDic()
  return self._reolaceSkillDic
end

function SpecWeaponData:GetSpecWeaponHeroFragCount()
  local total = self._baseCfg.fragTotal
  if self._level > 0 then
    local levelCfg = self._levelListCfg[self._level - 1]
    total = total - levelCfg.fragTotal2Level
  end
  if 0 < self._step then
    local stepCfg = self._stepListCfg[self._step]
    total = total - stepCfg.fragTotal2Step
  end
  return total
end

function SpecWeaponData:GetSpecWeaponFrontRoot(step, level)
  if level ~= nil then
    if level <= 1 then
      return 1, level
    end
    local targetStep = 1
    for i = self._maxStep, 1, -1 do
      local stepMaxLevel = self:GetSpecWeaponStepLevel(i)
      if level > stepMaxLevel then
        targetStep = i + 1
        break
      end
    end
    return targetStep, level - 1
  end
  if step ~= nil then
    if step <= 1 then
      return step, 0
    end
    step = step - 1
    local befrontStepLevel = self:GetSpecWeaponStepLevel(step)
    return step, befrontStepLevel
  end
  if isGameDev then
    error("输入不能全空")
  end
  return 0, 0
end

return SpecWeaponData
