require("buff_logic_base")
_class("BuffLogicAddLegendPowerByMonsterDead", BuffLogicBase)
BuffLogicAddLegendPowerByMonsterDead = BuffLogicAddLegendPowerByMonsterDead

function BuffLogicAddLegendPowerByMonsterDead:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddLegendPowerByMonsterDead:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local addLayer = 0
  local casterEntity = notify:GetAttackerEntity()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArray or #damageResultArray == 0 then
    return
  end
  local targetEntityList = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity and targetEntity:HasMonsterID() and not table.intable(targetEntityList, targetEntity) then
      table.insert(targetEntityList, targetEntity)
    end
  end
  for _, entity in ipairs(targetEntityList) do
    if entity:Attributes():GetCurrentHP() == 0 then
      addLayer = addLayer + 1
    end
  end
  if addLayer == 0 then
    return
  end
  local petPstIDComponent = casterEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local curAttributeCmpt = casterEntity:Attributes()
  local curLegendPower = curAttributeCmpt:GetAttribute("LegendPower")
  local newPower = curLegendPower + self._addValue * addLayer
  if newPower < 0 then
    newPower = 0
  end
  local ready = false
  local activeSkillID = casterEntity:SkillInfo():GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local blsvc = self._world:GetService("BuffLogic")
  local requireNTPowerReady = false
  if newPower >= skillConfigData:GetSkillTriggerParam() then
    blsvc:ChangePetActiveSkillReady(casterEntity, 1)
    ready = true
    local notify = NTPowerReady:New(casterEntity)
    self._world:GetService("Trigger"):Notify(notify)
    requireNTPowerReady = true
  else
    blsvc:ChangePetActiveSkillReady(casterEntity, 0)
    ready = false
  end
  if newPower > BattleConst.LegendPowerMax then
    newPower = BattleConst.LegendPowerMax
  end
  curAttributeCmpt:Modify("LegendPower", newPower)
  local buffResult = BuffResultAddLegendPowerByMonsterDead:New(petPstID, newPower, ready)
  if requireNTPowerReady then
    buffResult:RequireNTPowerReady(casterEntity:GetID())
  end
  return buffResult
end
