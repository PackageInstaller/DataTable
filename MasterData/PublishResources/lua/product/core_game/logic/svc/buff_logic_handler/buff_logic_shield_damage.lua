BuffLogicAddDamageShield_ShieldLimitType = {LowerThanOwnerHP = 0, BuffOwnerAttackPercent = 1}
_enum("BuffLogicAddDamageShield_ShieldLimitType", BuffLogicAddDamageShield_ShieldLimitType)
_class("BuffLogicAddDamageShield", BuffLogicBase)
BuffLogicAddDamageShield = BuffLogicAddDamageShield

function BuffLogicAddDamageShield:Constructor(buffInstance, logicParam)
  self._shieldPercent = logicParam.shieldPercent
  self._maxPercent = logicParam.maxPercent
  self._minPercent = logicParam.minPercent
  self._shieldLimitType = logicParam.shieldLimitType or BuffLogicAddDamageShield_ShieldLimitType.LowerThanOwnerHP
end

function BuffLogicAddDamageShield:DoLogic(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCom = teamEntity:BuffComponent()
  if not buffCom then
    return
  end
  local damage = notify:GetDamage()
  if damage <= 0 then
    return
  end
  local addShield = self._shieldPercent * damage
  addShield = math.floor(addShield)
  Log.info(table.concat({
    "BuffLogicAddDamageShield: ",
    "shieldPercent=",
    tostring(self._shieldPercent),
    "damage=",
    tostring(damage),
    "round val=",
    addShield
  }, " "))
  addShield = self:LimitShieldMinMax(addShield)
  local shield = self._buffLogicService:AddHPShield(teamEntity, addShield)
  return BuffResultAddDamageShield:New(shield)
end

function BuffLogicAddDamageShield:LimitShieldMinMax(val)
  if self._shieldLimitType == BuffLogicAddDamageShield_ShieldLimitType.LowerThanOwnerHP then
    local pstId = self._entity:PetPstID():GetPstID()
    local petData = self._world:GetPetData(pstId)
    local hp = petData:GetPetHealth()
    local addShield = val
    local maxHp = math.floor(hp * self._maxPercent)
    if addShield > maxHp then
      addShield = maxHp
    end
    return addShield
  elseif self._shieldLimitType == BuffLogicAddDamageShield_ShieldLimitType.BuffOwnerAttackPercent then
    local eOwner = self._entity
    local cAttributes = eOwner:Attributes()
    if not cAttributes then
      Log.fatal("BuffLogicAddDamageShield: shieldLimitType=", self._shieldLimitType, " owner has no AttributesComponent. ")
      return val
    end
    local baseAttack = cAttributes:GetAttack()
    local min, max
    if self._minPercent then
      min = baseAttack * self._minPercent
    end
    if self._maxPercent then
      max = baseAttack * self._maxPercent
    end
    local finalVal = val
    if min and val < min then
      finalVal = min
    end
    if max and val > max then
      finalVal = max
    end
    Log.info(table.concat({
      "BuffLogicAddDamageShield: shieldLimitType =",
      self._shieldLimitType,
      "damageShieldVal =",
      val,
      "baseAttack =",
      baseAttack,
      "limitMinPercent =",
      tostring(self._minPercent),
      "maxPercent =",
      tostring(self._maxPercent),
      "min =",
      tostring(min),
      "max =",
      tostring(max),
      "finalVal =",
      finalVal,
      "floor =",
      math.floor(finalVal)
    }, " "))
    return math.floor(finalVal)
  end
  return val
end

_class("BuffLogicRemoveDamageShield", BuffLogicBase)
BuffLogicRemoveDamageShield = BuffLogicRemoveDamageShield

function BuffLogicRemoveDamageShield:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveDamageShield:DoLogic()
  local player = self._world:Player():GetCurrentTeamEntity()
  if not player:BuffComponent():HasBuffEffect(BuffEffectType.ShieldToHP) then
    player:BuffComponent():SetBuffValue("HPShield", 0)
  end
  return true
end
