_class("BuffLogicChangeAnimatorByElement", BuffLogicBase)
BuffLogicChangeAnimatorByElement = BuffLogicChangeAnimatorByElement

function BuffLogicChangeAnimatorByElement:Constructor(buffInstance, logicParam)
  self._animator = logicParam.animator
end

function BuffLogicChangeAnimatorByElement:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  local element = entity:Element():GetPrimaryType()
  local changeAnimator = self._animator[element]
  Log.error(changeAnimator)
  entity:BuffComponent():SetBuffValue("ChangeAnimator", changeAnimator)
end
