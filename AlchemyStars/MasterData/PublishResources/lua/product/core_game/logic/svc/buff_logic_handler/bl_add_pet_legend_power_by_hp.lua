_class("BuffLogicAddPetLegendPowerByHP", BuffLogicBase)
BuffLogicAddPetLegendPowerByHP = BuffLogicAddPetLegendPowerByHP

function BuffLogicAddPetLegendPowerByHP:Constructor(buffInstance, logicParam)
  self._hpLimit = logicParam.hpLimit
  self._unitPowerVal = logicParam.unitPowerVal
end

function BuffLogicAddPetLegendPowerByHP:DoLogic()
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  local battleService = self._world:GetService("Battle")
  local hp, maxHP = battleService:GetCasterHP(petEntity)
  local costHPPercent = (maxHP - hp) / maxHP
  local count = math.floor(costHPPercent // self._hpLimit)
  if count <= 0 then
    return
  end
  local val = math.floor(count * self._unitPowerVal + 0.5)
  local curAttributeCmpt = petEntity:Attributes()
  local curLegendPower = curAttributeCmpt:GetAttribute("LegendPower")
  local newPower = curLegendPower + val
  if newPower > BattleConst.LegendPowerMax then
    newPower = BattleConst.LegendPowerMax
  end
  curAttributeCmpt:Modify("LegendPower", newPower)
  local ready = false
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local blsvc = self._world:GetService("BuffLogic")
  blsvc:ChangePetActiveSkillReady(petEntity, ready)
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
  local previouslyReady = curLegendPower >= skillConfigData:GetSkillTriggerParam()
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local result = BuffResultAddPetLegendPowerByHP:New(petPstID, newPower, ready, previouslyReady)
  if requireNTPowerReady then
    result:RequireNTPowerReady(petEntity:GetID())
  end
  return result
end
