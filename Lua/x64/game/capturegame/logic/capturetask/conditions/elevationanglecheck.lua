local var_0_0 = class("ElevationAngleCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	if (arg_1_1[1] or 0.2) > CaptureGameMgr:GetCameraMgr():GetSingleCamAxisValue(2) then
		return true
	end

	return false
end

return var_0_0
