_class("BuffLogicChangePetPowerAndWatch", BuffLogicBase)
BuffLogicChangePetPowerAndWatch = BuffLogicChangePetPowerAndWatch

function BuffLogicChangePetPowerAndWatch:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicChangePetPowerAndWatch:DoLogic()
  local petPowerStateList = {}
  local world = self._buffInstance:World()
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  self:_OnChangePetPower(petEntity, petPowerStateList)
  if next(petPowerStateList) then
    local buffResult = BuffResultChangePetPowerAndWatch:New(petPowerStateList)
    return buffResult
  end
end

function BuffLogicChangePetPowerAndWatch:_OnChangePetPower(petEntity, petPowerStateList)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = petEntity:Attributes()
  local curPower = curAttributeCmpt:GetAttribute("Power")
  if curPower <= 0 then
    return false
  end
  local newPower = curPower - self._addValue
  local ready = false
  local requireNTPowerReady = false
  local blsvc = self._world:GetService("BuffLogic")
  local battleStatComponent = self._world:BattleStat()
  local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
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
    local buffComponent = self._entity:BuffComponent()
    local keyStr = "HadSaveSkillGrayWatch" .. "_Round_" .. tostring(curRound) .. "_Skill_" .. tostring(activeSkillID)
    local hadSaveSkillGrayWatch = buffComponent:GetBuffValue(keyStr)
    if hadSaveSkillGrayWatch == nil then
      newPower = curPower - (self._addValue - 1)
      buffComponent:SetBuffValue(keyStr, true)
      battleStatComponent:SetLastDoActiveSkillRound(petPstID, nil)
    end
  end
  if newPower <= 0 then
    newPower = 0
    blsvc:ChangePetActiveSkillReady(petEntity, 1)
    ready = true
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  end
  self._world:GetSyncLogger():Trace({
    key = "BuffLogicChangePetPowerAndWatch",
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
  petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
  self:PrintBuffLogicLog("ChangePetPower() pet entity=", petEntity:GetID(), " power=", newPower)
  curAttributeCmpt:Modify("Power", newPower)
  return true
end
