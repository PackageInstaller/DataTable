_class("BuffLogicBeCrazy", BuffLogicBase)
BuffLogicBeCrazy = BuffLogicBeCrazy

function BuffLogicBeCrazy:Constructor(buffInstance, logicParam)
end

function BuffLogicBeCrazy:DoLogic()
  self._entity:ReplaceCrazyMode()
end
