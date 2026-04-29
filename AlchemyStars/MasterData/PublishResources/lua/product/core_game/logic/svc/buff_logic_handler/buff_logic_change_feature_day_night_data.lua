_class("BuffLogicChangeFeatureDayNightData", BuffLogicBase)
BuffLogicChangeFeatureDayNightData = BuffLogicChangeFeatureDayNightData

function BuffLogicChangeFeatureDayNightData:Constructor(buffInstance, logicParam)
  self._toState = logicParam.toState
  self._restRound = logicParam.restRound
end

function BuffLogicChangeFeatureDayNightData:DoLogic()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local oldState, newState, restRound = lsvcFeature:ModifyDayNightData(self._toState, self._restRound)
  local buffResult = BuffResultChangeFeatureDayData:New(oldState, newState, restRound)
  return buffResult
end
