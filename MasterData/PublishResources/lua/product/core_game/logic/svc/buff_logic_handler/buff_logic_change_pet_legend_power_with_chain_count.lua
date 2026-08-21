_class("BuffLogicChangePetLegendPowerWithChainCount", BuffLogicBase)
BuffLogicChangePetLegendPowerWithChainCount = BuffLogicChangePetLegendPowerWithChainCount

function BuffLogicChangePetLegendPowerWithChainCount:Constructor(buffInstance, logicParam)
  self._addOneValueNeedChainCount = logicParam.addOneValueNeedChainCount or 1
  self._maxValue = logicParam.maxValue or 0
end

function BuffLogicChangePetLegendPowerWithChainCount:DoLogic(notify)
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  local petPowerStateList = {}
  self:_OnChangePetPower(notify, petEntity, petPowerStateList)
  local buffResult = BuffResultChangePetLegendPowerWithChainCount:New(petPowerStateList)
  return buffResult
end

function BuffLogicChangePetLegendPowerWithChainCount:_OnChangePetPower(notify, petEntity, petPowerStateList)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = petEntity:Attributes()
  local curLegendPower = curAttributeCmpt:GetAttribute("LegendPower")
  local addValue = math.floor(notify:GetChainCount() / self._addOneValueNeedChainCount)
  local newPower = curLegendPower + addValue
  if newPower < 0 then
    newPower = 0
  end
  if self._maxValue ~= 0 and newPower > self._maxValue then
    newPower = self._maxValue
  end
  local ready = false
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local blsvc = self._world:GetService("BuffLogic")
  local requireNTPowerReady = false
  if newPower >= skillConfigData:GetSkillTriggerParam() then
    blsvc:ChangePetActiveSkillReady(petEntity, 1)
    ready = true
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  else
    blsvc:ChangePetActiveSkillReady(petEntity, 0)
    ready = false
  end
  if newPower > BattleConst.LegendPowerMax then
    newPower = BattleConst.LegendPowerMax
  end
  curAttributeCmpt:Modify("LegendPower", newPower)
  local previouslyReady = curLegendPower >= skillConfigData:GetSkillTriggerParam()
  if not petPowerStateList[petPstID] then
    petPowerStateList[petPstID] = {}
  end
  petPowerStateList[petPstID].petEntityID = petEntity:GetID()
  petPowerStateList[petPstID].petPstID = petPstID
  petPowerStateList[petPstID].power = newPower
  petPowerStateList[petPstID].ready = ready
  petPowerStateList[petPstID].previouslyReady = previouslyReady
  petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
  Log.debug("BuffLogicChangePetLegendPowerWithChainCount pet entity=", petEntity:GetID(), " power=", newPower, " ready=", ready)
  return true
end
