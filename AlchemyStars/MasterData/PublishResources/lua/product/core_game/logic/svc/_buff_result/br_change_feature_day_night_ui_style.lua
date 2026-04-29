require("_buff_result_base")
_class("BuffResultChangeFeatureDayNightUiStyle", BuffResultBase)
BuffResultChangeFeatureDayNightUiStyle = BuffResultChangeFeatureDayNightUiStyle

function BuffResultChangeFeatureDayNightUiStyle:Constructor(uiStyle)
  self._uiStyle = uiStyle
end

function BuffResultChangeFeatureDayNightUiStyle:GetUiStyle()
  return self._uiStyle
end
