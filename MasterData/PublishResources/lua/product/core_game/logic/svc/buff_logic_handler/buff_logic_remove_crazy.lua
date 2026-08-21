_class("BuffLogicRemoveCrazy", BuffLogicBase)
BuffLogicRemoveCrazy = BuffLogicRemoveCrazy

function BuffLogicRemoveCrazy:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveCrazy:DoLogic()
  self._entity:RemoveCrazyMode()
end
