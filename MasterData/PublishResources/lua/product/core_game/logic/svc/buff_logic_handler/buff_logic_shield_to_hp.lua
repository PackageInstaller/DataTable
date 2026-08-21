_class("BuffLogicShieldToHP", BuffLogicBase)
BuffLogicShieldToHP = BuffLogicShieldToHP

function BuffLogicShieldToHP:Constructor(buffInstance, logicParam)
  self._recoverPersent = logicParam.recoverPersent
  self._clearShield = logicParam.clearShield
  self._lessThanLostHp = logicParam.lessThanLostHp or false
  self._lessThanPetMaxHp = logicParam.lessThanPetMaxHp or false
end

function BuffLogicShieldToHP:DoLogic()
  local e = self._buffInstance:Entity()
  local recoverEntity = e
  if e:PetPstID() then
    recoverEntity = e:Pet():GetOwnerTeamEntity()
  end
  local buffCmpt = recoverEntity:BuffComponent()
  if buffCmpt == nil then
    return
  end
  local curShieldValue = buffCmpt:GetBuffValue("HPShield") or 0
  if curShieldValue == 0 then
    return
  end
  local addHp = curShieldValue * self._recoverPersent
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  addHp = math.floor(addHp * (1 + rate))
  local shieldToHpVal = addHp
  if self._lessThanPetMaxHp and self._lessThanLostHp then
    local lostHp = self:CalcLostHp(recoverEntity)
    local ownerMaxHp = self:GetBuffOwnerMaxHp(e)
    local maxShieldToHp = math.min(ownerMaxHp, lostHp)
    shieldToHpVal = math.min(addHp, maxShieldToHp)
  end
  local curShield = 0
  if self._clearShield then
    buffCmpt:SetBuffValue("HPShield", curShield)
  else
    curShield = curShieldValue - shieldToHpVal
    if curShield < 0 then
      curShield = 0
    end
    buffCmpt:SetBuffValue("HPShield", curShield)
  end
  if recoverEntity:Attributes():GetAttribute("BuffForbidCure") then
    Log.notice("BuffForbidCure , 諾爾無法回血")
    return
  end
  local calcDamageSvc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(shieldToHpVal, DamageType.Recover)
  calcDamageSvc:AddTargetHP(recoverEntity:GetID(), damageInfo)
  addHp = damageInfo:GetDamageValue()
  local result = BuffResultShieldToHP:New(addHp, damageInfo, curShield)
  return result
end

function BuffLogicShieldToHP:CalcLostHp(recoverEntity)
  local currentHp = recoverEntity:Attributes():GetCurrentHP()
  local maxHp = recoverEntity:Attributes():CalcMaxHp()
  local lostHp = maxHp - currentHp
  return lostHp
end

function BuffLogicShieldToHP:GetBuffOwnerMaxHp(e)
  local ownerMaxHp = 0
  if e:HasPetPstID() then
    local pstid = e:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstid)
    ownerMaxHp = petData:GetPetHealth()
  elseif e:HasMonsterID() then
    local configService = self._world:GetService("Config")
    local monsterConfigData = configService:GetMonsterConfigData()
    local monsterid = e:MonsterID():GetMonsterID()
    local maxhp = configService:GetMonsterHealth(e)
    ownerMaxHp = maxhp
  end
  return ownerMaxHp
end
