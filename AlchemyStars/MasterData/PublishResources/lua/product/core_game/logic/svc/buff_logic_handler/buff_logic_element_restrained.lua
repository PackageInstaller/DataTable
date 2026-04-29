_class("BuffLogicAddElementRestrained", BuffLogicBase)
BuffLogicAddElementRestrained = BuffLogicAddElementRestrained

function BuffLogicAddElementRestrained:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue
end

function BuffLogicAddElementRestrained:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:ChangeExElementParam(e, self._buffInstance:BuffSeq(), self._mulValue)
end

_class("BuffLogicRemoveElementRestrained", BuffLogicBase)
BuffLogicRemoveElementRestrained = BuffLogicRemoveElementRestrained

function BuffLogicRemoveElementRestrained:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveElementRestrained:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveExElementParam(e, self._buffInstance:BuffSeq())
end
