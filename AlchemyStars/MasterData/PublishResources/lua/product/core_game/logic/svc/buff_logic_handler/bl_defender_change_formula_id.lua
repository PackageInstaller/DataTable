require("buff_logic_base")
_class("BuffLogicDefenderChangeFormulaID", BuffLogicBase)
BuffLogicDefenderChangeFormulaID = BuffLogicDefenderChangeFormulaID

function BuffLogicDefenderChangeFormulaID:Constructor(buffInstance, logicParam)
  self._replaceDic = logicParam.replaceDic
  self._isRevert = logicParam.isRevert or 0
end

function BuffLogicDefenderChangeFormulaID:GetBuffValueKey()
  return "DefenderChangeFormulaIDDic"
end

function BuffLogicDefenderChangeFormulaID:DoLogic(notify)
  local cBuff = self._entity:BuffComponent()
  local bvk = self:GetBuffValueKey()
  local savedDic = {}
  if not cBuff:GetBuffValue(bvk) then
    cBuff:SetBuffValue(bvk, savedDic)
  else
    savedDic = table.cloneconf(cBuff:GetBuffValue(bvk))
  end
  if self._replaceDic then
    for key, value in pairs(self._replaceDic) do
      if self._isRevert and self._isRevert == 1 then
        savedDic[key] = nil
      else
        savedDic[key] = value
      end
    end
  end
  cBuff:SetBuffValue(bvk, savedDic)
end
