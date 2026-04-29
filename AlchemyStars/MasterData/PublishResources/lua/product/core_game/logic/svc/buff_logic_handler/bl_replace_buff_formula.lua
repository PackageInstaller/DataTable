require("buff_logic_base")
_class("BuffLogicReplaceBuffFormula", BuffLogicBase)
BuffLogicReplaceBuffFormula = BuffLogicReplaceBuffFormula

function BuffLogicReplaceBuffFormula:Constructor(_, logicParam)
  self._replaceBuffFormulaTable = logicParam.replaceBuffFormulaTable
end

function BuffLogicReplaceBuffFormula:DoLogic(_)
  local e = self:GetEntity()
  local buffCmpt = e:BuffComponent()
  buffCmpt:SetBuffValue("ReplaceBuffFormulaTable", self._replaceBuffFormulaTable)
end
