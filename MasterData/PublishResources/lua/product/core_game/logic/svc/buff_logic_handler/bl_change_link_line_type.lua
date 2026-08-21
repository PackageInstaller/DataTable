require("buff_logic_base")
_class("BuffLogicChangeLinkLineType", BuffLogicBase)
BuffLogicChangeLinkLineType = BuffLogicChangeLinkLineType

function BuffLogicChangeLinkLineType:Constructor(buffinstance, logicParam)
  self._linkLineType = logicParam.LinkLineType
end

function BuffLogicChangeLinkLineType:DoLogic(notify)
  self._world:ChangeLinkLineType(self._linkLineType)
end
