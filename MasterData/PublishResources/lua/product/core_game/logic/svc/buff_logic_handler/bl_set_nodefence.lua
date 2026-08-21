require("buff_logic_base")
_class("BuffLogicSetNoDefence", BuffLogicBase)
BuffLogicSetNoDefence = BuffLogicSetNoDefence

function BuffLogicSetNoDefence:Constructor(buffInstance, logicParam)
  self._defPercent = tonumber(logicParam.defPercent) or 1
end

function BuffLogicSetNoDefence:DoLogic()
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  attributeCmpt:SetSimpleAttribute("NoDefence", self._defPercent)
end

function BuffLogicSetNoDefence:DoOverlap(logicParam)
  local newParam = tonumber(logicParam.defPercent) or 1
  self._defPercent = self._defPercent + newParam
end

_class("BuffLogicResetNoDefence", BuffLogicBase)
BuffLogicResetNoDefence = BuffLogicResetNoDefence

function BuffLogicResetNoDefence:Constructor(buffInstance, logicParam)
end

function BuffLogicResetNoDefence:DoLogic()
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  attributeCmpt:SetSimpleAttribute("NoDefence", 0)
end
