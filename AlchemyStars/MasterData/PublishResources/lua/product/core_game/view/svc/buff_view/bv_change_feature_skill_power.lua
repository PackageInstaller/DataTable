_class("BuffViewChangeFeatureSkillPower", BuffViewBase)
BuffViewChangeFeatureSkillPower = BuffViewChangeFeatureSkillPower

function BuffViewChangeFeatureSkillPower:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    local dataList = result:GetFeatureSkillPowerDataList()
    for _, data in ipairs(dataList) do
      local powerData = data
      featureSvcRender:NotifyFeatureSkillPowerChange(powerData.featureType, powerData.power, powerData.ready)
    end
  end
end
