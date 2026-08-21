_class("BuffLogicChangeEliteDefenceByHPPercent", BuffLogicBase)
BuffLogicChangeEliteDefenceByHPPercent = BuffLogicChangeEliteDefenceByHPPercent

function BuffLogicChangeEliteDefenceByHPPercent:Constructor(_buffIns, logicParam)
  self._defArgument = tonumber(logicParam.defArgument)
  self._hpPercentFix = tonumber(logicParam.hpPercentFix)
  assert(self._defArgument, "ChangeEliteDefenceByHPPercent: parameter[defArgument] is required. ")
  assert(self._hpPercentFix, "ChangeEliteDefenceByHPPercent: parameter[hpPercentFix] is required. ")
end

function BuffLogicChangeEliteDefenceByHPPercent:DoLogic()
  self:GetBuffLogicService():RemoveBaseDefence(self:GetEntity(), self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix)
  local cAttr = self:GetEntity():Attributes()
  local currentDef = cAttr:GetDefence()
  local battleSvc = self._world:GetService("Battle")
  local hp, maxHP = battleSvc:GetCasterHP(self:GetEntity())
  local newDef = currentDef * self._defArgument * (self._hpPercentFix - hp / maxHP)
  local def = newDef - currentDef
  self:GetBuffLogicService():ChangeBaseDefence(self:GetEntity(), self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix, def)
  return true
end

function BuffLogicChangeEliteDefenceByHPPercent:DoOverlap(logicParam, context)
  return self:DoLogic()
end

_class("BuffLogicRevertEliteDefenceByHPPercent", BuffLogicBase)
BuffLogicRevertEliteDefenceByHPPercent = BuffLogicRevertEliteDefenceByHPPercent

function BuffLogicRevertEliteDefenceByHPPercent:DoLogic()
  self:GetBuffLogicService():RemoveBaseDefence(self:GetEntity(), self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix)
  return true
end
