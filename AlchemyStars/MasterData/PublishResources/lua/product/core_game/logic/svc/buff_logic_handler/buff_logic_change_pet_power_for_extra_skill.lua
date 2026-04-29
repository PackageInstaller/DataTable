_class("BuffLogicChangePetPowerForExtraSkill", BuffLogicBase)
BuffLogicChangePetPowerForExtraSkill = BuffLogicChangePetPowerForExtraSkill

function BuffLogicChangePetPowerForExtraSkill:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._logicType = logicParam.logicType or EnumChangePetPower.Self
  self._logicParameter = logicParam.logicParameter
  self._complete = logicParam.complete or false
  self._skipFull = logicParam.skipFull
  self._jobs = logicParam.jobs or {
    PetProfType.PetProf_Attack,
    PetProfType.PetProf_Blood,
    PetProfType.PetProf_Color,
    PetProfType.PetProf_Function
  }
  self._notifyView = logicParam.notifyView or 1
  self._addCdAnimation = logicParam.addCdAnimation or 1
  self._setValue = logicParam.setValue or 0
  self._force = logicParam.force or 0
  self._delayToRoundEnter = logicParam.delayToRoundEnter
  self._readyNoRemind = logicParam.readyNoRemind
  self._extraSkillIndex = logicParam.extraSkillIndex or 1
end

function BuffLogicChangePetPowerForExtraSkill:DoLogic()
  local petPowerStateList = {}
  local world = self._buffInstance:World()
  local teamEntity = world:Player():GetLocalTeamEntity()
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  if self._logicType == EnumChangePetPower.Self then
    local petEntity = self._buffInstance:Entity()
    if not petEntity then
      return
    end
    self:_OnChangePetPower(petEntity, petPowerStateList)
  elseif self._logicType == EnumChangePetPower.AllPet then
    for _, petEntity in ipairs(petEntities) do
      local attributeCmpt = petEntity:Attributes()
      local power = attributeCmpt:GetAttribute("Power")
      if 0 < power then
        self:_OnChangePetPower(petEntity, petPowerStateList)
      end
    end
  end
  if next(petPowerStateList) then
    local buffResult = BuffResultChangePetPowerForExtraSkill:New(petPowerStateList, self._notifyView)
    return buffResult
  end
end

function BuffLogicChangePetPowerForExtraSkill:_OnChangePetPower(petEntity, petPowerStateList)
  local utilData = self._world:GetService("UtilData")
  local skillIndex = self._extraSkillIndex + 1
  local skillInfoCmpt = petEntity:SkillInfo()
  local activeSkillID = skillInfoCmpt:GetSkillIDByIndex(skillIndex)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  if not activeSkillID or activeSkillID == 0 then
    local petData = self._world:GetPetData(petPstID)
    local extraSkillList = petData:GetPetExtraActiveSkill()
    if extraSkillList then
      activeSkillID = extraSkillList[self._extraSkillIndex]
    end
  end
  if not activeSkillID or activeSkillID == 0 then
    return
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy or skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    return
  end
  local curPower = utilData:GetPetPowerAttr(petEntity, activeSkillID)
  local curReady = utilData:GetPetSkillReadyAttr(petEntity, activeSkillID)
  if self._skipFull and curPower <= 0 and curReady == 1 then
    return false
  end
  local newPower = curPower - self._addValue
  if self._setValue ~= 0 then
    newPower = self._setValue
  end
  local ready = false
  local cancelReady = false
  local blsvc = self._world:GetService("BuffLogic")
  local requireNTPowerReady = false
  if self._complete then
    if not self:_CanCurRoundChangePower(curPower, newPower, petEntity) then
      return false
    end
    newPower = 0
    blsvc:ChangePetActiveSkillReady(petEntity, 1, activeSkillID)
    ready = true
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  else
    local battleStatComponent = self._world:BattleStat()
    local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID, self._extraSkillIndex)
    local curRound = battleStatComponent:GetLevelTotalRoundCount()
    if lastDoActiveSkillRound == curRound and curPower > newPower and self._force == 0 then
      return false
    end
    if not self:_CanCurRoundChangePower(curPower, newPower, petEntity) then
      return false
    end
    if lastDoActiveSkillRound == curRound and self._force == 2 then
      local buffComponent = petEntity:BuffComponent()
      local keyStr = "SkillWatchIsGray" .. tostring(self._extraSkillIndex)
      local skillWatchIsGray = buffComponent:GetBuffValue(keyStr) or true
      if self._setValue == 0 then
        local curAddValue = self._addValue
        if skillWatchIsGray then
          curAddValue = curAddValue - 1
        end
        newPower = curPower - curAddValue
      end
      if skillWatchIsGray then
        buffComponent:SetBuffValue(keyStr, false)
        battleStatComponent:SetLastDoActiveSkillRound(petPstID, nil, self._extraSkillIndex)
      end
    end
    if newPower <= 0 then
      blsvc:ChangePetActiveSkillReady(petEntity, 1, activeSkillID)
      ready = true
      local notify = NTPowerReady:New(petEntity)
      self._world:GetService("Trigger"):Notify(notify)
      requireNTPowerReady = true
    end
    local readyAttr = utilData:GetPetSkillReadyAttr(petEntity, activeSkillID)
    if readyAttr == 1 and 0 < newPower then
      blsvc:ChangePetActiveSkillReady(petEntity, 0, activeSkillID)
      cancelReady = true
    end
  end
  if newPower < 0 then
    newPower = 0
  end
  self._world:GetSyncLogger():Trace({
    key = "BuffLogicChangePetPowerForExtraSkill",
    petEntityID = petEntity:GetID(),
    newPower = newPower
  })
  if not petPowerStateList[petPstID] then
    petPowerStateList[petPstID] = {}
  end
  petPowerStateList[petPstID].petEntityID = petEntity:GetID()
  petPowerStateList[petPstID].petPstID = petPstID
  petPowerStateList[petPstID].power = newPower
  petPowerStateList[petPstID].ready = ready
  petPowerStateList[petPstID].cancelReady = cancelReady
  petPowerStateList[petPstID].addCdAnimation = self._addCdAnimation
  petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
  petPowerStateList[petPstID].readyNoRemind = self._readyNoRemind
  petPowerStateList[petPstID].skillID = activeSkillID
  self:PrintBuffLogicLog("ChangePetPowerForExtraSkill() pet entity=", petEntity:GetID(), " skillID=", activeSkillID, " power=", newPower, "notifyView=", self._notifyView)
  utilData:SetPetPowerAttr(petEntity, newPower, activeSkillID)
  return true
end

function BuffLogicChangePetPowerForExtraSkill:_CanCurRoundChangePower(curPower, newPower, petEntity)
  if self._delayToRoundEnter then
    local changePower = newPower - curPower
    local curChangePower = petEntity:BuffComponent():GetBuffValue("DelayChangePowerValue")
    if not curChangePower then
      petEntity:BuffComponent():SetBuffValue("DelayChangePowerValue", 0)
      curChangePower = 0
    end
    petEntity:BuffComponent():SetBuffValue("DelayChangePowerValue", curChangePower + changePower)
    return false
  end
  return true
end
