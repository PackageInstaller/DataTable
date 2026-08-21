require("buff_logic_base")
_class("BuffLogicSaveRevertHP", BuffLogicBase)
BuffLogicSaveRevertHP = BuffLogicSaveRevertHP

function BuffLogicSaveRevertHP:DoLogic(notify)
  local currentHP = self:GetEntity():Attributes():GetCurrentHP()
  self:GetBuffComponent():SetBuffValue("SaveRevertHP", currentHP)
  return BuffResultSaveRevertHP:New(currentHP)
end

_class("BuffLogicDoRevertHP", BuffLogicBase)
BuffLogicDoRevertHP = BuffLogicDoRevertHP

function BuffLogicDoRevertHP:DoLogic(notify)
  local savedHP = self:GetBuffComponent():GetBuffValue("SaveRevertHP")
  if not savedHP then
    Log.error(self._className, "Run SaveRevertHP before this! ")
    return
  end
  local currentHP = self:GetEntity():Attributes():GetCurrentHP()
  local dmgsvc = self._world:GetService("CalcDamage")
  local damageInfo
  if savedHP > currentHP then
    damageInfo = self:_LogicRecover(savedHP, currentHP)
  else
    damageInfo = self:_LogicDamage(savedHP, currentHP)
  end
  local calcDamage = self._world:GetService("CalcDamage")
  return BuffResultDoRevertHP:New(damageInfo)
end

function BuffLogicDoRevertHP:_LogicRecover(savedHP, currentHP)
  local damageInfo = DamageInfo:New(savedHP - currentHP, DamageType.Recover)
  local dmgsvc = self._world:GetService("CalcDamage")
  dmgsvc:AddTargetHP(self:GetEntity():GetID(), damageInfo)
  return damageInfo
end

function BuffLogicDoRevertHP:_LogicDamage(savedHP, currentHP)
  local damageInfo = DamageInfo:New(currentHP - savedHP, DamageType.Real)
  local dmgsvc = self._world:GetService("CalcDamage")
  dmgsvc:_DoDamageModifyHP(self:GetEntity(), self:GetEntity(), damageInfo)
  return damageInfo
end
