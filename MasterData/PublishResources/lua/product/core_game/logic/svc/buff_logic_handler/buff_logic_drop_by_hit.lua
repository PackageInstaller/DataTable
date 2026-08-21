_class("BuffLogicDropByHit", BuffLogicBase)
BuffLogicDropByHit = BuffLogicDropByHit

function BuffLogicDropByHit:Constructor(buffInstance, logicParam)
  self._hitCount = logicParam.hitCount
  self._hitEffectID = logicParam.hitEffectID
  self._dropList = logicParam.dropList
end

function BuffLogicDropByHit:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("DropHitCount", self._hitCount)
  e:BuffComponent():SetBuffValue("DropByCountEffectID", self._hitEffectID)
  e:BuffComponent():SetBuffValue("DropListByHit", self._dropList)
end
