_class("BuffLogicChangeSecondaryParam", BuffLogicBase)
BuffLogicChangeSecondaryParam = BuffLogicChangeSecondaryParam

function BuffLogicChangeSecondaryParam:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._sameElementAddValue = logicParam.sameElementAddValue
end

function BuffLogicChangeSecondaryParam:DoLogic()
  local e = self._buffInstance:Entity()
  if e:Element():GetPrimaryType() == e:Element():GetSecondaryType() and self._sameElementAddValue then
    self._buffLogicService:ChangeAllAttackParam(e, self._buffInstance:BuffSeq(), self._sameElementAddValue)
    return
  end
  self._buffLogicService:ChangeSecondaryAttackParam(e, self._buffInstance:BuffSeq(), self._addValue)
end

_class("BuffLogicRemoveSecondaryParam", BuffLogicBase)
BuffLogicRemoveSecondaryParam = BuffLogicRemoveSecondaryParam

function BuffLogicRemoveSecondaryParam:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSecondaryParam:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveSecondaryAttackParam(e, self._buffInstance:BuffSeq())
end
