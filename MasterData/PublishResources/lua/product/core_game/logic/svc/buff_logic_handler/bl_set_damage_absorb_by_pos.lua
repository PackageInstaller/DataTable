require("buff_logic_base")
_class("BuffLogicSetDamageAbsorbByPos", BuffLogicBase)
BuffLogicSetDamageAbsorbByPos = BuffLogicSetDamageAbsorbByPos

function BuffLogicSetDamageAbsorbByPos:Constructor(buffInstance, logicParam)
  self._rate = logicParam.rate
  self._posIndex = logicParam.posIndex
  self._absorbType = logicParam.absorbType
end

function BuffLogicSetDamageAbsorbByPos:DoLogic()
  local cBuff = self:GetBuffComponent()
  if self._absorbType == MonsterSkillAbsorbType.NormalSkill then
    cBuff:SetBuffValue("defender_normal_absorb_rate", self._rate)
    cBuff:SetBuffValue("defender_normal_absorb_rate_array", self._posIndex)
  elseif self._absorbType == MonsterSkillAbsorbType.ChainSkill then
    cBuff:SetBuffValue("defender_chain_absorb_rate", self._rate)
    cBuff:SetBuffValue("defender_chain_absorb_rate_array", self._posIndex)
  elseif self._absorbType == MonsterSkillAbsorbType.ActiveSkill then
    cBuff:SetBuffValue("defender_active_absorb_rate", self._rate)
    cBuff:SetBuffValue("defender_active_absorb_rate_array", self._posIndex)
  end
end
