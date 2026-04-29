_class("BuffLogicSetFeatureSkillPower", BuffLogicBase)
BuffLogicSetFeatureSkillPower = BuffLogicSetFeatureSkillPower

function BuffLogicSetFeatureSkillPower:Constructor(buffInstance, logicParam)
  self._power = logicParam.power or 0
  self._ready = logicParam.ready or 1
  self._featureType = logicParam.featureType
end

function BuffLogicSetFeatureSkillPower:DoLogic()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature then
    lsvcFeature:SetFeatureSkillCurPower(self._featureType, self._power, self._ready)
    local data = FeatureSkillCommonPowerData:New()
    data.power = self._power
    data.ready = self._ready
    data.featureType = self._featureType
    local buffResult = BuffResultSetFeatureSkillPower:New(data)
    return buffResult
  end
end
