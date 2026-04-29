_class("BuffLogicChangeFeatureDayNightUiStyle", BuffLogicBase)
BuffLogicChangeFeatureDayNightUiStyle = BuffLogicChangeFeatureDayNightUiStyle

function BuffLogicChangeFeatureDayNightUiStyle:Constructor(buffInstance, logicParam)
  self._uiStyle = logicParam.uiStyle or UIFeatureDayNightStyle.Normal
end

function BuffLogicChangeFeatureDayNightUiStyle:DoLogic()
  local buffResult = BuffResultChangeFeatureDayNightUiStyle:New(self._uiStyle)
  return buffResult
end
