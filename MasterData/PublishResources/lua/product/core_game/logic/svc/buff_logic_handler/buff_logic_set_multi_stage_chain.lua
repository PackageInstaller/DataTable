_class("BuffLogicSetMultiStageChain", BuffLogicBase)
BuffLogicSetMultiStageChain = BuffLogicSetMultiStageChain

function BuffLogicSetMultiStageChain:Constructor(buffInstance, logicParam)
  self._active = logicParam.active
end

function BuffLogicSetMultiStageChain:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("MultiStageChain", self._active)
end
