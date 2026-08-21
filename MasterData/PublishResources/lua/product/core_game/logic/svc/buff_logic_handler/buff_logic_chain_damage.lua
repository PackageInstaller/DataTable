_class("BuffLogicChainDamage", BuffLogicBase)
BuffLogicChainDamage = BuffLogicChainDamage

function BuffLogicChainDamage:Constructor(buffInstance, logicParam)
  self._formulaID = logicParam.formulaID or 141
  self._playDamageText = logicParam.dontPlayDamageText or 1
end

function BuffLogicChainDamage:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  local entityID = entity:GetID()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local casterEntity = context.casterEntity
  if not casterEntity then
    return
  end
  local logicChainDamage = entity:LogicChainDamage()
  if not logicChainDamage then
    return
  end
  if not notify.GetChangeHP or not notify.GetDamageInfo then
    return
  end
  local damageType = notify:GetDamageType()
  local originalAttackID = notify:GetDamageSrcEntityID()
  local attackerID = notify:GetDamageSrcEntityID()
  local notifyDamageInfo = notify:GetDamageInfo()
  local hpAndShieldChangeValue = notifyDamageInfo:GetHpAndShieldChangeValue()
  if hpAndShieldChangeValue == 0 then
    return
  end
  if damageType == DamageType.Miss or damageType == DamageType.Guard then
    return
  end
  local transerID = self._entity:GetID()
  local attacker = self._world:GetEntityByID(attackerID)
  if attacker then
    if attacker:HasPetPstID() then
      attacker = attacker:Pet():GetOwnerTeamEntity()
      attackerID = attacker:GetID()
    end
  else
    attacker = entity
    attackerID = attacker:GetID()
  end
  local defenderIDs = {}
  local percents = {}
  local chainList = {}
  if damageType == DamageType.Recover or damageType == DamageType.RecoverTransmit then
    chainList = logicChainDamage:GetChainRecoverList()
  else
    chainList = logicChainDamage:GetChainDamageList()
  end
  if table.count(chainList) == 0 then
    return
  end
  for chainEntityID, percent in pairs(chainList) do
    local isTransmit = damageType == DamageType.RealTransmit or damageType == DamageType.RecoverTransmit
    if chainEntityID ~= attackerID or not isTransmit then
      local chainEntity = self._world:GetEntityByID(chainEntityID)
      if chainEntity and (not chainEntity or not chainEntity:HasDeadMark()) then
        table.insert(defenderIDs, chainEntityID)
        table.insert(percents, percent)
      end
    end
  end
  local blsvc = self._world:GetService("BuffLogic")
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfos = {}
  for i, ID in pairs(defenderIDs) do
    local defender = self._world:GetEntityByID(ID)
    if defender:HasPetPstID() then
      defender = defender:Pet():GetOwnerTeamEntity()
    end
    local percent = percents[i]
    local damageInfo
    if damageType == DamageType.Recover or damageType == DamageType.RecoverTransmit then
      local attrCmpt = defender:Attributes()
      local max_hp = attrCmpt:CalcMaxHp()
      local cur_hp = attrCmpt:GetCurrentHP()
      local add_value = math.floor(hpAndShieldChangeValue * percent)
      if max_hp < add_value + cur_hp then
        add_value = max_hp - cur_hp
      end
      damageInfo = DamageInfo:New(add_value, DamageType.RecoverTransmit)
      damageInfo:SetAttackerEntityID(entity:GetID())
      calcDamage:AddTargetHP(defender:GetID(), damageInfo)
    else
      damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), entity, defender, {
        percent = percent,
        formulaID = self._formulaID,
        changeHp = hpAndShieldChangeValue,
        attackPos = notify:GetAttackPos(),
        damageStatisticsAttackerEntityID = originalAttackID
      })
    end
    if damageInfo then
      table.insert(damageInfos, damageInfo)
    end
  end
  if table.count(damageInfos) == 0 then
    return
  end
  local buffResult = BuffResultChainDamage:New(originalAttackID, entityID, defenderIDs, damageInfos)
  buffResult:SetAttackPos(notify:GetAttackPos())
  buffResult:SetNotifyHp(notify:GetChangeHP())
  buffResult:SetPlayDamageText(self._playDamageText)
  return buffResult
end
