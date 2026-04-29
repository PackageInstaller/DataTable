_class("BuffLogicRecordPetPowerAndWatch", BuffLogicBase)
BuffLogicRecordPetPowerAndWatch = BuffLogicRecordPetPowerAndWatch

function BuffLogicRecordPetPowerAndWatch:Constructor(buffInstance, logicParam)
  self._record = logicParam.record
  self._apply = logicParam.apply
end

function BuffLogicRecordPetPowerAndWatch:DoLogic()
  local petPowerStateList = {}
  local world = self._buffInstance:World()
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = petEntity:Attributes()
  local buffComponent = self._entity:BuffComponent()
  local recordKey = "BuffLogicRecordPetPowerAndWatch"
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local utilDataSvc = world:GetService("UtilData")
  local curReady = utilDataSvc:GetPetSkillReadyAttr(petEntity, activeSkillID)
  local curPower = curAttributeCmpt:GetAttribute("Power")
  if self._record == 1 then
    local grayWatch = false
    local battleStatComponent = world:BattleStat()
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
      grayWatch = true
      local keyStr = "HadSaveSkillGrayWatch" .. "_Round_" .. tostring(curRound) .. "_Skill_" .. tostring(activeSkillID)
      local hadSaveSkillGrayWatch = buffComponent:GetBuffValue(keyStr)
      if hadSaveSkillGrayWatch then
        grayWatch = false
      end
    end
    local recordPetPowerAndWatchData = {
      power = curPower,
      grayWatch = grayWatch,
      ready = curReady
    }
    buffComponent:SetBuffValue(recordKey, recordPetPowerAndWatchData)
    return
  elseif self._apply == 1 then
    local recordPetPowerAndWatchData = buffComponent:GetBuffValue(recordKey)
    if not recordPetPowerAndWatchData then
      return
    end
    local recordPower = recordPetPowerAndWatchData.power
    local recordGrayWatch = recordPetPowerAndWatchData.grayWatch
    local recordReady = recordPetPowerAndWatchData.ready == 1
    curAttributeCmpt:Modify("Power", recordPower)
    local blsvc = world:GetService("BuffLogic")
    blsvc:ChangePetActiveSkillReady(petEntity, recordReady)
    local notifyView = false
    if curReady == 0 and recordReady == true then
      local notify = NTPowerReady:New(petEntity)
      world:GetService("Trigger"):Notify(notify)
      notifyView = true
    end
    buffComponent:SetBuffValue(recordKey, nil)
    if recordGrayWatch == false then
      local battleStatComponent = world:BattleStat()
      battleStatComponent:SetLastDoActiveSkillRound(petPstID, nil)
    end
    local buffResult = BuffResultRecordPetPowerAndWatch:New(petEntity:GetID(), petPstID, recordPower, recordReady, recordGrayWatch, notifyView)
    return buffResult
  end
end
