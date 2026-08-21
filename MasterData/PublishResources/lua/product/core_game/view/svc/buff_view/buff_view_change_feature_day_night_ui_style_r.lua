_class("BuffViewChangeFeatureDayNightUiStyle", BuffViewBase)
BuffViewChangeFeatureDayNightUiStyle = BuffViewChangeFeatureDayNightUiStyle

function BuffViewChangeFeatureDayNightUiStyle:PlayView(TT)
  local result = self:GetBuffResult()
  local uiStyle = result:GetUiStyle()
  local featureSvc = self._world:GetService("FeatureRender")
  featureSvc:NotifyDayNightUIStyleChange(uiStyle)
end
