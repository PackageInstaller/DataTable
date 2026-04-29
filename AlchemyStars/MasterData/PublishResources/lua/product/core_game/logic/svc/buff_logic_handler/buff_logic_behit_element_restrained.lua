_class("BuffLogicAddBeHitElementRestrained", BuffLogicBase)
BuffLogicAddBeHitElementRestrained = BuffLogicAddBeHitElementRestrained

function BuffLogicAddBeHitElementRestrained:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue
end

function BuffLogicAddBeHitElementRestrained:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:ChangeExBeHitElementParam(e, self._buffInstance:BuffSeq(), self._mulValue)
end

_class("BuffLogicRemoveBeHitElementRestrained", BuffLogicBase)
BuffLogicRemoveBeHitElementRestrained = BuffLogicRemoveBeHitElementRestrained

function BuffLogicRemoveBeHitElementRestrained:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveBeHitElementRestrained:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveExBeHitElementParam(e, self._buffInstance:BuffSeq())
end
