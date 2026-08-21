_class("BuffLogicChangePetPowerForOverdraw", BuffLogicBase)
BuffLogicChangePetPowerForOverdraw = BuffLogicChangePetPowerForOverdraw

function BuffLogicChangePetPowerForOverdraw:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._checkSkillIDList = logicParam.checkSkillIDList or {}
end

function BuffLogicChangePetPowerForOverdraw:DoLogic()
  local petPowerStateList = {}
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  self:_OnChangePetPowerForOverdraw(petEntity, petPowerStateList)
  if next(petPowerStateList) then
    local buffResult = BuffResultChangePetPowerForOverdraw:New(petPowerStateList)
    return buffResult
  end
end

function BuffLogicChangePetPowerForOverdraw:_OnChangePetPowerForOverdraw(petEntity, petPowerStateList)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = petEntity:Attributes()
  local curPower = curAttributeCmpt:GetAttribute("Power")
  local curReady = curAttributeCmpt:GetAttribute("Ready")
  local newPower = curPower - self._addValue
  local notRefreshView = false
  local ready = false
  local cancelReady = false
  local blsvc = self._world:GetService("BuffLogic")
  local requireNTPowerReady = false
  local curRoundHadCastTargetSkill = false
  local battleStatComponent = self._world:BattleStat()
  local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
  if lastDoActiveSkillRound and lastDoActiveSkillRound == curRound then
    curRoundHadCastTargetSkill = true
  end
  local curRoundDoActiveSkillTimes = battleStatComponent:GetCurRoundDoActiveSkillTimes(petPstID)
  if curRoundHadCastTargetSkill and 2 <= curRoundDoActiveSkillTimes then
    notRefreshView = true
  end
  if curAttributeCmpt:GetAttribute("Ready") == 1 and 0 < newPower then
    blsvc:ChangePetActiveSkillReady(petEntity, 0)
    cancelReady = true
  end
  if newPower < 0 then
    newPower = 0
  end
  self._world:GetSyncLogger():Trace({
    key = "BuffLogicChangePetPowerForOverdraw",
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
  petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
  self:PrintBuffLogicLog("ChangePetPowerForOverdraw() pet entity=", petEntity:GetID(), " power=", newPower)
  curAttributeCmpt:Modify("Power", newPower)
  if notRefreshView == true then
    petPowerStateList[petPstID] = nil
  end
  return true
end
