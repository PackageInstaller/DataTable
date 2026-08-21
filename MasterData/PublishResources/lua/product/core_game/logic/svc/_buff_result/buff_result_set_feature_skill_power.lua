require("_buff_result_base")
_class("BuffResultSetFeatureSkillPower", BuffResultBase)
BuffResultSetFeatureSkillPower = BuffResultSetFeatureSkillPower

function BuffResultSetFeatureSkillPower:Constructor(commonPowerData)
  self._commonPowerData = commonPowerData
end

function BuffResultSetFeatureSkillPower:GetFeatureSkillCommonPowerData()
  return self._commonPowerData
end
