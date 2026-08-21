local AddHpByLayerMarkFromType = {MaxHP = 1, LostHP = 2}
_enum("AddHpByLayerMarkFromType", AddHpByLayerMarkFromType)
_class("BuffLogicAddHPByLayerMark", BuffLogicBase)
BuffLogicAddHPByLayerMark = BuffLogicAddHPByLayerMark

function BuffLogicAddHPByLayerMark:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._oneLayerValue = logicParam.oneLayerValue or 0
  self._fromType = logicParam.fromType or AddHpByLayerMarkFromType.MaxHP
end

function BuffLogicAddHPByLayerMark:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local context = self._buffInstance:Context()
  if context then
    casterEntity = context.casterEntity
  end
  local e = casterEntity
  local rate = e:Attributes():GetAttribute("AddBloodRate") or 0
  if casterEntity:PetPstID() then
    e = casterEntity:Pet():GetOwnerTeamEntity()
  end
  if e:Attributes():GetCurrentHP() == 0 then
    return
  end
  if e:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local attrCmpt = casterEntity:Attributes()
  local baseParam = 0
  if self._fromType == AddHpByLayerMarkFromType.MaxHP then
    local max_hp = attrCmpt:CalcMaxHp()
    if casterEntity:PetPstID() then
      local pstId = casterEntity:PetPstID():GetPstID()
      local petData = self._world:GetPetData(pstId)
      max_hp = petData:GetPetHealth()
    end
    baseParam = max_hp
  elseif self._fromType == AddHpByLayerMarkFromType.LostHP then
    local lostHP = 0
    local maxHP = attrCmpt:CalcMaxHp()
    local curHP = attrCmpt:GetCurrentHP()
    lostHP = maxHP - curHP
    baseParam = lostHP
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:GetBuffLayer(self._entity, self._layerType)
  local add_value = 0
  add_value = baseParam * self._oneLayerValue * curMarkLayer
  local damageType = DamageType.Recover
  add_value = add_value * (1 + rate)
  local svc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, damageType)
  svc:AddTargetHP(e:GetID(), damageInfo)
  local res = BuffResultAddHPByLayerMark:New(damageInfo, e:GetID())
  return res
end
