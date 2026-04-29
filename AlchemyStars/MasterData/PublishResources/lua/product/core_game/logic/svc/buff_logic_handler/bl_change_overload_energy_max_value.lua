_class("BuffLogicChangeMaxAUOEValue", BuffLogicBase)
BuffLogicChangeMaxAUOEValue = BuffLogicChangeMaxAUOEValue

function BuffLogicChangeMaxAUOEValue:Constructor(buffInstance, logicParam)
  self._maxValue = logicParam.maxValue
end

function BuffLogicChangeMaxAUOEValue:DoLogic(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  featureSvc:SetMaxAUOEValue(self._maxValue)
  return true
end
