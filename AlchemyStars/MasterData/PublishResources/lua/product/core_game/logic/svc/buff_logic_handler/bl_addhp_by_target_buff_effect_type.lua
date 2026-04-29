_class("BuffLogicAddHPByTargetBuffEffectType", BuffLogicBase)
BuffLogicAddHPByTargetBuffEffectType = BuffLogicAddHPByTargetBuffEffectType

function BuffLogicAddHPByTargetBuffEffectType:Constructor(buffInstance, logicParam)
  self._baseType = 2
  if logicParam.baseType then
    self._baseType = logicParam.baseType
  end
  self._buffEffectType = logicParam.buffEffectType
  self._mulValue = logicParam.mulValue
  self._mulValueHigh = logicParam.mulValueHigh
end

function BuffLogicAddHPByTargetBuffEffectType:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local buffSvc = self._world:GetService("BuffLogic")
  local battleService = self._world:GetService("Battle")
  local calcPercentHp, calcPercentMaxHp = battleService:GetCasterHP(e)
  local calcValueMaxHP = calcPercentMaxHp
  if self._entity:PetPstID() and self._baseType == 2 then
    local pstId = self._entity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    calcValueMaxHP = petData:GetPetHealth()
  end
  local hpPercent = 1
  if calcPercentMaxHp and 0 < calcPercentMaxHp and calcPercentHp then
    hpPercent = calcPercentHp / calcPercentMaxHp
  end
  local teamEntity
  if e:HasTeam() then
    teamEntity = e
  elseif e:HasPetPstID() then
    teamEntity = e:Pet():GetOwnerTeamEntity()
  end
  if teamEntity and teamEntity:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local recoverHp = 0
  local targetEntityList = notify:GetDefenderEntityIDList()
  local entityList = {}
  
  local function isContainEntityFunc(list, entity)
    local entityId = entity:GetID()
    for _, v in ipairs(list) do
      if v:GetID() == entityId then
        return true
      end
    end
    return false
  end
  
  for _, entityid in ipairs(targetEntityList) do
    local entity = self._world:GetEntityByID(entityid)
    if not isContainEntityFunc(entityList, entity) and not entity:Trap() then
      entityList[#entityList + 1] = entity
    end
  end
  local addHPRateByTargetHP = e:BuffComponent():GetBuffValue("AddHPRateByTargetHP") or 1
  for _, targetEntity in ipairs(entityList) do
    local layer = buffSvc:GetBuffLayer(targetEntity, self._buffEffectType)
    if layer and 0 < layer then
      local targetHp = targetEntity:Attributes():GetCurrentHP()
      local targetMaxHp = targetEntity:Attributes():CalcMaxHp()
      local p = targetHp / targetMaxHp
      local mulValue = self._mulValue
      if hpPercent < p then
        mulValue = mulValue * addHPRateByTargetHP
      end
      recoverHp = recoverHp + calcValueMaxHP * mulValue * layer
    end
  end
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  if e:PetPstID() then
    e = teamEntity
  end
  if e:Attributes():GetCurrentHP() == 0 then
    return
  end
  recoverHp = recoverHp * (1 + rate)
  recoverHp = math.ceil(recoverHp)
  local svc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(recoverHp, DamageType.Recover)
  svc:AddTargetHP(e:GetID(), damageInfo)
  local result = BuffResultAddHPByTargetBuffEffectType:New(recoverHp, damageInfo)
  return result
end
