_class("BuffLogicPSPAddEnergyOnceMoreProb", BuffLogicBase)
BuffLogicPSPAddEnergyOnceMoreProb = BuffLogicPSPAddEnergyOnceMoreProb

function BuffLogicPSPAddEnergyOnceMoreProb:Constructor(buffInstance, logicParam)
  self._baseValue = logicParam.baseValue
  self._modifyType = logicParam.modifyType
end

function BuffLogicPSPAddEnergyOnceMoreProb:DoLogic()
  local popSarProSvc = self._world:GetService("PopStarProLogic")
  local count = popSarProSvc:GetCountByModifyType(self._modifyType)
  local addValue = self._baseValue * count
  local buffComponent = self._entity:BuffComponent()
  if not buffComponent then
    return
  end
  buffComponent:SetBuffValue(PopStarConst.BVK_AddEnergyOnceMore, addValue)
end
