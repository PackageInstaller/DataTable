EnumChangePetPower = {
  Random = 1,
  Self = 2,
  AllPet = 3,
  PrioritySmall = 4,
  PriorityBig = 5,
  MaxCD = 6
}
_enum("EnumChangePetPower", EnumChangePetPower)
_class("BuffLogicChangePetPower", BuffLogicBase)
BuffLogicChangePetPower = BuffLogicChangePetPower

function BuffLogicChangePetPower:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._logicType = logicParam.logicType or EnumChangePetPower.AllPet
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
  self._setByMaxPower = logicParam.setByMaxPower or 0
  self._force = logicParam.force or 0
  self._delayToRoundEnter = logicParam.delayToRoundEnter
  self._readyNoRemind = logicParam.readyNoRemind
end

function BuffLogicChangePetPower:DoLogic()
  local petPowerStateList = {}
  local world = self._buffInstance:World()
  local teamEntity = world:Player():GetLocalTeamEntity()
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPet() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  if self._logicType == EnumChangePetPower.Random then
    local cdNotEnougthPetList = {}
    for _, petEntity in ipairs(petEntities) do
      if not petEntity:HasPetDeadMark() then
        local matchPet = petEntity:MatchPet():GetMatchPet()
        if table.icontains(self._jobs, matchPet:GetJob()) then
          local attributeCmpt = petEntity:Attributes()
          local power = attributeCmpt:GetAttribute("Power")
          if 0 < power then
            table.insert(cdNotEnougthPetList, petEntity)
          end
        end
      end
    end
    if #cdNotEnougthPetList == 0 then
      return
    end
    local randomSvc = self._world:GetService("RandomLogic")
    local randomIndex = randomSvc:LogicRand(1, #cdNotEnougthPetList)
    local curPet = cdNotEnougthPetList[randomIndex]
    self:_OnChangePetPower(curPet, petPowerStateList)
  elseif self._logicType == EnumChangePetPower.Self then
    local petEntity = self._buffInstance:Entity()
    if not petEntity then
      return
    end
    self:_OnChangePetPower(petEntity, petPowerStateList)
  elseif self._logicType == EnumChangePetPower.AllPet then
    local petEntity = self._buffInstance:Entity()
    if not petEntity then
      return
    end
    local cdNotEnougthPetList = {}
    for _, petEntity in ipairs(petEntities) do
      local attributeCmpt = petEntity:Attributes()
      local power = attributeCmpt:GetAttribute("Power")
      if 0 < power then
        self:_OnChangePetPower(petEntity, petPowerStateList)
      end
    end
  elseif self._logicType == EnumChangePetPower.PrioritySmall then
    local petEntityList = {}
    local cdNotEnougthPetList = {}
    for _, petEntity in ipairs(petEntities) do
      table.insert(petEntityList, petEntity)
    end
    table.sort(petEntityList, function(e1, e2)
      local power1 = e1:Attributes():GetAttribute("Power")
      local power2 = e2:Attributes():GetAttribute("Power")
      return power1 < power2
    end)
    local chengeTimes = math.min(table.count(petEntityList), self._logicParameter)
    for i = 1, chengeTimes do
      local petEntity = petEntityList[i]
      self:_OnChangePetPower(petEntity, petPowerStateList)
      petEntity:BuffComponent():SetBuffValue("AddPetPower", 1)
    end
  elseif self._logicType == EnumChangePetPower.PriorityBig then
    local petEntityList = self:_SortPetPowerBig2Small(petEntities)
    local changeTimes = math.min(table.count(petEntityList), self._logicParameter)
    for i = 1, changeTimes do
      local petEntity = petEntityList[i]
      self:_OnChangePetPower(petEntity, petPowerStateList)
      petEntity:BuffComponent():SetBuffValue("AddPetPower", 1)
    end
  elseif self._logicType == EnumChangePetPower.MaxCD then
    local maxCD = -1
    local selectPetEntity
    local utilCalcServiceShare = self._world:GetService("UtilCalc")
    for _, petEntity in ipairs(petEntities) do
      local attributeCmpt = petEntity:Attributes()
      local power = attributeCmpt:GetAttribute("Power")
      if (power ~= 0 or utilCalcServiceShare:IsPetCurRoundCastActiveSkill(petEntity)) and maxCD < power then
        selectPetEntity = petEntity
        maxCD = power
      end
    end
    if selectPetEntity then
      self:_OnChangePetPower(selectPetEntity, petPowerStateList)
    end
  end
  if next(petPowerStateList) then
    local buffResult = BuffResultChangePetPower:New(petPowerStateList, self._notifyView)
    return buffResult
  end
end

function BuffLogicChangePetPower:_OnChangePetPower(petEntity, petPowerStateList)
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  if not activeSkillID then
    local petData = self._world:GetPetData(petPstID)
    activeSkillID = petData:GetPetActiveSkill()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy or skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    return
  end
  local curAttributeCmpt = petEntity:Attributes()
  local curPower = curAttributeCmpt:GetAttribute("Power")
  local curReady = curAttributeCmpt:GetAttribute("Ready")
  if self._skipFull and curPower <= 0 and curReady == 1 then
    return false
  end
  local newPower = curPower - self._addValue
  if self._setValue ~= 0 then
    newPower = self._setValue
  end
  if self._setByMaxPower ~= 0 then
    local utilData = self._world:GetService("UtilData")
    local maxPower = utilData:GetPetMaxPowerAttr(petEntity, activeSkillID)
    newPower = maxPower
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
    blsvc:ChangePetActiveSkillReady(petEntity, 1)
    ready = true
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  else
    local battleStatComponent = self._world:BattleStat()
    local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
    local curRound = battleStatComponent:GetLevelTotalRoundCount()
    if lastDoActiveSkillRound == curRound and curPower > newPower and self._force == 0 then
      return false
    end
    if not self:_CanCurRoundChangePower(curPower, newPower, petEntity) then
      return false
    end
    if self._force == 2 then
      local curRoundHadCastTargetSkill = false
      local extraSkillIDList = petEntity:SkillInfo():GetExtraActiveSkillIDList()
      if extraSkillIDList and 0 < #extraSkillIDList then
        local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
        local curRoundHadCastSkillList = battleStatComponent:GetPetDoActiveSkillRecord(petPstID, curRound)
        if curRoundHadCastSkillList and 0 < table.count(curRoundHadCastSkillList) and table.icontains(curRoundHadCastSkillList, activeSkillID) then
          curRoundHadCastTargetSkill = true
        end
      else
        curRoundHadCastTargetSkill = false
        local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
        local curRound = battleStatComponent:GetLevelTotalRoundCount()
        if lastDoActiveSkillRound and lastDoActiveSkillRound == curRound then
          curRoundHadCastTargetSkill = true
        end
      end
      if curRoundHadCastTargetSkill then
        local buffComponent = petEntity:BuffComponent()
        local keyStr = "HadSaveSkillGrayWatch" .. "_Round_" .. tostring(curRound) .. "_Skill_" .. tostring(activeSkillID)
        local hadSaveSkillGrayWatch = buffComponent:GetBuffValue(keyStr)
        if hadSaveSkillGrayWatch == nil then
          newPower = curPower - (self._addValue - 1)
          buffComponent:SetBuffValue(keyStr, true)
          battleStatComponent:SetLastDoActiveSkillRound(petPstID, nil)
        end
      end
    end
    if newPower <= 0 then
      blsvc:ChangePetActiveSkillReady(petEntity, 1)
      ready = true
      local notify = NTPowerReady:New(petEntity)
      self._world:GetService("Trigger"):Notify(notify)
      requireNTPowerReady = true
    end
    if curAttributeCmpt:GetAttribute("Ready") == 1 and 0 < newPower then
      blsvc:ChangePetActiveSkillReady(petEntity, 0)
      cancelReady = true
    end
  end
  if newPower < 0 then
    newPower = 0
  end
  self._world:GetSyncLogger():Trace({
    key = "BuffLogicChangePetPower",
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
  self:PrintBuffLogicLog("ChangePetPower() pet entity=", petEntity:GetID(), " power=", newPower, "notifyView=", self._notifyView)
  curAttributeCmpt:Modify("Power", newPower)
  return true
end

function BuffLogicChangePetPower:_CanCurRoundChangePower(curPower, newPower, petEntity)
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

function BuffLogicChangePetPower:_SortPetPowerBig2Small(petEntities)
  local bsComponent = self._world:BattleStat()
  local curRound = bsComponent:GetLevelTotalRoundCount()
  local petEntityList = {}
  for _, petEntity in ipairs(petEntities) do
    if self:_CheckCanChangePower(petEntity) then
      table.insert(petEntityList, petEntity)
    end
  end
  table.sort(petEntityList, function(e1, e2)
    local power1 = e1:Attributes():GetAttribute("Power")
    if bsComponent:GetPetDoActiveSkillRecord(e1, curRound) then
      power1 = power1 + 1
    end
    local power2 = e2:Attributes():GetAttribute("Power")
    if bsComponent:GetPetDoActiveSkillRecord(e2, curRound) then
      power2 = power2 + 1
    end
    return power1 > power2
  end)
  return petEntityList
end

function BuffLogicChangePetPower:_CheckCanChangePower(petEntity)
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  if not activeSkillID then
    local petData = self._world:GetPetData(petPstID)
    activeSkillID = petData:GetPetActiveSkill()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.Energy then
    return true
  end
  return false
end
