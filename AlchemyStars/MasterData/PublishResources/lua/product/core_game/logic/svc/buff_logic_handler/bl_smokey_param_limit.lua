require("buff_logic_base")
_class("BuffLogicSetSmokeyParamLimit", BuffLogicBase)
BuffLogicSetSmokeyParamLimit = BuffLogicSetSmokeyParamLimit

function BuffLogicSetSmokeyParamLimit:Constructor(buffInstance, logicParam)
  self._limit = logicParam.limit
end

function BuffLogicSetSmokeyParamLimit:DoLogic(notify)
  local cBuff = self._entity:BuffComponent()
  cBuff:SetBuffValue("SmokeyParamLimit", self._limit)
end

_class("BuffLogicRevertSmokeyParamLimit", BuffLogicBase)
BuffLogicRevertSmokeyParamLimit = BuffLogicRevertSmokeyParamLimit

function BuffLogicRevertSmokeyParamLimit:Constructor(buffInstance, logicParam)
end

function BuffLogicRevertSmokeyParamLimit:DoLogic(notify)
  local cBuff = self._entity:BuffComponent()
  cBuff:SetBuffValue("SmokeyParamLimit", nil)
end
