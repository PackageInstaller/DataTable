require("buff_logic_base")
_class("BuffLogicSetGridDefPercentage", BuffLogicBase)
BuffLogicSetGridDefPercentage = BuffLogicSetGridDefPercentage

function BuffLogicSetGridDefPercentage:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate
  self._pos = logicParam.pos
end

function BuffLogicSetGridDefPercentage:DoLogic()
  local cBuff = self:GetBuffComponent()
  cBuff:SetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_RATE", self._rate)
  cBuff:SetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_ARRAY", self._pos)
end

_class("BuffLogicRevertGridDefPercentage", BuffLogicBase)
BuffLogicRevertGridDefPercentage = BuffLogicRevertGridDefPercentage

function BuffLogicRevertGridDefPercentage:DoLogic()
  local cBuff = self:GetBuffComponent()
  cBuff:SetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_RATE", nil)
  cBuff:SetBuffValue("DEFENDER_DIRECTIONAL_DEF_POS_ARRAY", nil)
end
