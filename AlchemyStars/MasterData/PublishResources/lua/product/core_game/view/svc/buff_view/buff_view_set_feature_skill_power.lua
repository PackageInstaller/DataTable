_class("BuffViewSetFeatureSkillPower", BuffViewBase)
BuffViewSetFeatureSkillPower = BuffViewSetFeatureSkillPower

function BuffViewSetFeatureSkillPower:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    local powerData = result:GetFeatureSkillCommonPowerData()
    featureSvcRender:NotifyFeatureSkillPowerChange(powerData.featureType, powerData.power, powerData.ready)
  end
end
