local UseAnyLensCheck = class("UseAnyLensCheck", CaptureConditionBase)

function UseAnyLensCheck:CheckCondition(arg_1_1)
	return CaptureGameSettingData:GetLens() ~= -1
end

return UseAnyLensCheck
