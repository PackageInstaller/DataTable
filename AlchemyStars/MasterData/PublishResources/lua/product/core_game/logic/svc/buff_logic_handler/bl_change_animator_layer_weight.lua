_class("BuffLogicChangeAnimatorLayerWeight", BuffLogicBase)
BuffLogicChangeAnimatorLayerWeight = BuffLogicChangeAnimatorLayerWeight

function BuffLogicChangeAnimatorLayerWeight:Constructor(buffInstance, logicParam)
  self._layerWeightTable = {}
  if logicParam.layerWeightTable then
    for key, value in pairs(logicParam.layerWeightTable) do
      self._layerWeightTable[key] = tonumber(value)
    end
  end
end

function BuffLogicChangeAnimatorLayerWeight:DoLogic(notify)
  return BuffResultChangeAnimatorLayerWeight:New(self._layerWeightTable)
end
