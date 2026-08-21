require("buff_logic_base")
_class("BuffLogicSetGridDamageFinalBeHitReduction", BuffLogicBase)
BuffLogicSetGridDamageFinalBeHitReduction = BuffLogicSetGridDamageFinalBeHitReduction

function BuffLogicSetGridDamageFinalBeHitReduction:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate
  self._pos = logicParam.pos
end

function BuffLogicSetGridDamageFinalBeHitReduction:DoLogic()
  local cBuff = self:GetBuffComponent()
  cBuff:SetBuffValue("DEFENDER_FINAL_BE_HIT_POS_RATE", self._rate)
  cBuff:SetBuffValue("DEFENDER_FINAL_BE_HIT_POS_ARRAY", self._pos)
end

_class("BuffLogicResetGridDamageFinalBeHitReduction", BuffLogicBase)
BuffLogicResetGridDamageFinalBeHitReduction = BuffLogicResetGridDamageFinalBeHitReduction

function BuffLogicResetGridDamageFinalBeHitReduction:DoLogic()
  local cBuff = self:GetBuffComponent()
  cBuff:SetBuffValue("DEFENDER_FINAL_BE_HIT_POS_RATE", nil)
  cBuff:SetBuffValue("DEFENDER_FINAL_BE_HIT_POS_ARRAY", nil)
end
