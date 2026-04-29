_class("BuffLogicPSPAddRelicCounter", BuffLogicBase)
BuffLogicPSPAddRelicCounter = BuffLogicPSPAddRelicCounter

function BuffLogicPSPAddRelicCounter:Constructor(buffInstance, logicParam)
  self._relicID = logicParam.relicID or 0
end

function BuffLogicPSPAddRelicCounter:DoLogic()
  local svc = self._world:GetService("PopStarProLogic")
  svc:AddRelicCounter(self._relicID)
end
