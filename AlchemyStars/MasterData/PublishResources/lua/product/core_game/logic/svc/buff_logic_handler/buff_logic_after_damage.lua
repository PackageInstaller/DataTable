require("buff_logic_base")
_class("BuffLogicAddAfterDamage", BuffLogicBase)
BuffLogicAddAfterDamage = BuffLogicAddAfterDamage

function BuffLogicAddAfterDamage:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddAfterDamage:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  attrCmpt:Modify("AfterDamage", self._addValue, self._buffInstance:BuffSeq())
end

function BuffLogicAddAfterDamage:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicResetAfterDamage", BuffLogicBase)
BuffLogicResetAfterDamage = BuffLogicResetAfterDamage

function BuffLogicResetAfterDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicResetAfterDamage:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  attrCmpt:RemoveModify("AfterDamage", self._buffInstance:BuffSeq())
end

function BuffLogicResetAfterDamage:DoOverlap(logicParam)
end
