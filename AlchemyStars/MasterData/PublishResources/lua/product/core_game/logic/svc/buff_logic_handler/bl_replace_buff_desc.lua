require("buff_logic_base")
_class("BuffLogicReplaceBuffDesc", BuffLogicBase)
BuffLogicReplaceBuffDesc = BuffLogicReplaceBuffDesc

function BuffLogicReplaceBuffDesc:Constructor(_, logicParam)
  self._replaceTable = logicParam.replaceTable
  self._replaceNameTable = logicParam.replaceNameTable
  self._replaceIconTable = logicParam.replaceIconTable
end

function BuffLogicReplaceBuffDesc:DoLogic(_)
  local e = self:GetEntity()
  local buffCmpt = e:BuffComponent()
  buffCmpt:SetBuffValue("ReplaceBuffDescReplaceTable", self._replaceTable)
  buffCmpt:SetBuffValue("ReplaceBuffNameReplaceTable", self._replaceNameTable)
  buffCmpt:SetBuffValue("ReplaceBuffIconReplaceTable", self._replaceIconTable)
end
