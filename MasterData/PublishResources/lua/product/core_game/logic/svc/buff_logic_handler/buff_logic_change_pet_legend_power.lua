_class("BuffLogicChangePetLegendPower", BuffLogicBase)
BuffLogicChangePetLegendPower = BuffLogicChangePetLegendPower

function BuffLogicChangePetLegendPower:Constructor(buffInstance, logicParam)
  self._enable = logicParam.enable or 1
  self._addValue = logicParam.addValue or 0
  self._maxValue = logicParam.maxValue or 0
  self._addPercent = logicParam.addPercent
  self._addPercentMinAbsValue = logicParam.addPercentMinAbsValue
  self._checkExtraSkillID = logicParam.checkExtraSkillID
  self._autoCheckExtra = logicParam.autoCheckExtra or 1
end

function BuffLogicChangePetLegendPower:DoLogic(notify)
  if self._enable ~= 1 then
    return
  end
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  local petPowerStateList = {}
  self:_OnChangePetPower(petEntity, petPowerStateList)
  local buffResult = BuffResultChangePetLegendPower:New(petPowerStateList)
  if notify then
    if notify.GetAttackPos and notify.GetTargetPos then
      buffResult.attackPos = notify:GetAttackPos()
      buffResult.targetPos = notify:GetTargetPos()
    end
    if notify.GetNormalAttackIndex then
      buffResult.normalAttackIndex = notify:GetNormalAttackIndex()
    end
  end
  return buffResult
end

function BuffLogicChangePetLegendPower:_OnChangePetPower(petEntity, petPowerStateList)
  local petPstIDComponent = petEntity:PetPstID()
  if not petPstIDComponent then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  if self._checkExtraSkillID and self._checkExtraSkillID ~= 0 then
    activeSkillID = self._checkExtraSkillID
    local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(petEntity, activeSkillID)
    if not isExtraSkill then
      return
    end
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local skillTriggerType = skillConfigData:GetSkillTriggerType()
  if skillTriggerType ~= SkillTriggerType.LegendEnergy then
    return
  end
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = petEntity:Attributes()
  local curLegendPower = curAttributeCmpt:GetAttribute("LegendPower")
  local addValue = self:_CalcModifyValue(curLegendPower)
  local newPower = curLegendPower + addValue
  if newPower < 0 then
    newPower = 0
  end
  if self._maxValue ~= 0 and newPower > self._maxValue then
    newPower = self._maxValue
  end
  local ready = false
  local blsvc = self._buffLogicService
  local requireNTPowerReady = false
  local minCost = blsvc:CalcMinCostByExtraParam(petEntity, activeSkillID)
  if newPower >= minCost then
    blsvc:ChangePetActiveSkillReady(petEntity, 1, activeSkillID)
    ready = true
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  else
    blsvc:ChangePetActiveSkillReady(petEntity, 0, activeSkillID)
    ready = false
  end
  if newPower > BattleConst.LegendPowerMax then
    newPower = BattleConst.LegendPowerMax
  end
  local previouslyReady = curLegendPower >= minCost
  curAttributeCmpt:Modify("LegendPower", newPower)
  if not petPowerStateList[petPstID] then
    petPowerStateList[petPstID] = {}
  end
  petPowerStateList[petPstID].petEntityID = petEntity:GetID()
  petPowerStateList[petPstID].petPstID = petPstID
  petPowerStateList[petPstID].power = newPower
  petPowerStateList[petPstID].ready = ready
  petPowerStateList[petPstID].previouslyReady = previouslyReady
  petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
  petPowerStateList[petPstID].maxValue = self._maxValue ~= 0 and self._maxValue
  petPowerStateList[petPstID].extraSkillID = self._checkExtraSkillID
  Log.debug("BuffLogicChangePetLegendPower pet entity=", petEntity:GetID(), " power=", newPower, " ready=", ready)
  if self._checkExtraSkillID and self._checkExtraSkillID ~= 0 then
  elseif self._autoCheckExtra and self._autoCheckExtra == 1 then
    local extraSkillIDList = petEntity:SkillInfo():GetExtraActiveSkillIDList()
    local skillInfoCmpt = petEntity:SkillInfo()
    if extraSkillIDList and 0 < #extraSkillIDList then
      for index, extraSkillID in ipairs(extraSkillIDList) do
        local skillConfigData = configService:GetSkillConfigData(extraSkillID, petEntity)
        if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
          local extraRequireNTPowerReady = false
          local extraMinCost = blsvc:CalcMinCostByExtraParam(petEntity, extraSkillID)
          local extrPreviousReady = curLegendPower >= extraMinCost
          local extraReady = false
          if newPower >= extraMinCost then
            blsvc:ChangePetActiveSkillReady(petEntity, 1, extraSkillID)
            extraReady = true
            local notify = NTPowerReady:New(petEntity)
            self._world:GetService("Trigger"):Notify(notify)
            extraRequireNTPowerReady = true
          else
            blsvc:ChangePetActiveSkillReady(petEntity, 0, extraSkillID)
            extraReady = false
          end
          local indexKey = petPstID + index
          if not petPowerStateList[indexKey] then
            petPowerStateList[indexKey] = {}
          end
          petPowerStateList[indexKey].petEntityID = petEntity:GetID()
          petPowerStateList[indexKey].petPstID = petPstID
          petPowerStateList[indexKey].power = newPower
          petPowerStateList[indexKey].ready = extraReady
          petPowerStateList[indexKey].previouslyReady = extrPreviousReady
          petPowerStateList[indexKey].requireNTPowerReady = extraRequireNTPowerReady
          petPowerStateList[indexKey].maxValue = self._maxValue ~= 0 and self._maxValue
          petPowerStateList[indexKey].extraSkillID = extraSkillID
        end
      end
    end
  end
  return true
end

function BuffLogicChangePetLegendPower:_CalcModifyValue(curLegendPower)
  local addValue = self._addValue
  if self._addPercent then
    local oriModifyVal = curLegendPower * self._addPercent
    local absModifyVal = math.abs(oriModifyVal)
    absModifyVal = math.floor(absModifyVal)
    if self._addPercentMinAbsValue and absModifyVal < self._addPercentMinAbsValue then
      absModifyVal = self._addPercentMinAbsValue
    end
    if oriModifyVal < 0 then
      addValue = -1 * absModifyVal
    else
      addValue = absModifyVal
    end
  end
  return addValue
end
