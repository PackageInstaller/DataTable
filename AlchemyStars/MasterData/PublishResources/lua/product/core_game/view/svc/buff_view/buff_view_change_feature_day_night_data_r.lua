_class("BuffViewChangeFeatureDayNightData", BuffViewBase)
BuffViewChangeFeatureDayNightData = BuffViewChangeFeatureDayNightData

function BuffViewChangeFeatureDayNightData:PlayView(TT)
  local result = self:GetBuffResult()
  local oldState = result:GetOldState()
  local newState = result:GetNewState()
  local restRound = result:GetRestRound()
  local featureSvc = self._world:GetService("FeatureRender")
  featureSvc:ModifyDayNightData(TT, oldState, newState, restRound)
end
