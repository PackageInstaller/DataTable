_class("BuffLogicAddHPByLayer", BuffLogicBase)
BuffLogicAddHPByLayer = BuffLogicAddHPByLayer

function BuffLogicAddHPByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._costLayer = logicParam.costLayer
  self._perLayer = logicParam.perLayer
  self._attrType = logicParam.attrType
end

function BuffLogicAddHPByLayer:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local e = casterEntity
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  local defenderRate = 0
  Log.info("BuffLogicAddHPByLayer:DoLogic CasterRate = ", rate)
  if casterEntity:PetPstID() then
    e = casterEntity:Pet():GetOwnerTeamEntity()
    defenderRate = e:Attributes():GetAttribute("AddBloodRate") or 0
    Log.info("BuffLogicAddHPByLayer:DoLogic TeamEntity = ", rate)
    rate = rate + defenderRate
  end
  local battleSvc = self._world:GetService("Battle")
  local curHP, maxHP = battleSvc:GetCasterHP(casterEntity)
  if curHP <= 0 then
    return
  end
  if e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local attrCmpt = casterEntity:Attributes()
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:GetBuffLayer(self._entity, self._layerType)
  local add_value = 0
  local value
  local count = 0
  local sourceLayer = curMarkLayer
  while curMarkLayer >= self._costLayer and curHP < maxHP do
    value = self:_CalcAddBlood(casterEntity, self._attrType, self._perLayer, 0)
    curHP = curHP + value
    add_value = add_value + value
    curMarkLayer = curMarkLayer - self._costLayer
    count = count + 1
  end
  local damageType = DamageType.Recover
  Log.info("BuffLogicAddHPByLayer:DoLogic FinalRage = ", rate, "SourceValue = ", add_value, "FinalValue = ", add_value * (1 + rate))
  local final_value = add_value * (1 + rate)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(final_value, damageType)
  calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
  Log.fatal("AddHPByLayer addValue:", final_value, "NewLayer:", curMarkLayer)
  local tmp, buffinst = svc:SetBuffLayer(self._entity, self._layerType, curMarkLayer)
  local layerName = svc:GetBuffLayerName(self._layerType)
  local totalLayerCount = svc:GetBuffTotalLayer(self._entity, layerName)
  local res = BuffResultAddHPByLayer:New(damageInfo, e:GetID(), curMarkLayer, totalLayerCount, buffinst:BuffSeq())
  res:SetLayerName(layerName)
  return res
end

function BuffLogicAddHPByLayer:_CalcAddBlood(casterEntity, nByAttribute, nAddPercent, nConfigData)
  local nByAttributeVal = 0
  if casterEntity then
    if nByAttribute == AddBlood_Attribute.Attack then
      nByAttributeVal = casterEntity:Attributes():GetAttack() or 0
    elseif nByAttribute == AddBlood_Attribute.Defense then
      nByAttributeVal = casterEntity:Attributes():GetDefence() or 0
    elseif nByAttribute == AddBlood_Attribute.MaxHP then
      nByAttributeVal = casterEntity:Attributes():CalcMaxHp() or 0
    end
  end
  local nAddData = nConfigData + nByAttributeVal * nAddPercent
  return nAddData
end
