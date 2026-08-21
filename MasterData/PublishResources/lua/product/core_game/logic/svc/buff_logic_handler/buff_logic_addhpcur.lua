require("buff_logic_base")
_class("BuffLogicAddHPCur", BuffLogicBase)
BuffLogicAddHPCur = BuffLogicAddHPCur

function BuffLogicAddHPCur:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddHPCur:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasPetPstID() then
    e = e:Pet():GetOwnerTeamEntity()
  end
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local cur_hp = e:Attributes():GetCurrentHP()
  if cur_hp <= 0 then
    return
  end
  local add_value = cur_hp * self._mulValue + self._addValue
  add_value = math.floor(add_value)
  cur_hp = cur_hp + add_value
  if cur_hp < 0 then
    cur_hp = 0
  end
  if max_hp < cur_hp then
    add_value = max_hp - cur_hp
    cur_hp = max_hp
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(add_value, DamageType.Recover)
  calcDamage:AddTargetHP(e:GetID(), damageInfo)
  local result = BuffResultAddHP:New(damageInfo)
  return result
end
