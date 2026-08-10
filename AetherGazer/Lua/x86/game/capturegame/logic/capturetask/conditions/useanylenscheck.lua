local var_0_0 = class("UseAnyLensCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	return CaptureGameSettingData:GetLens() ~= -1
end

return var_0_0
