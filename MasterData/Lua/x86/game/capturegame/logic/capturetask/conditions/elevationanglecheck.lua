local ElevationAngleCheck = class("ElevationAngleCheck", CaptureConditionBase)

function ElevationAngleCheck:CheckCondition(arg_1_1)
	if (arg_1_1[1] or 0.2) > CaptureGameMgr:GetCameraMgr():GetSingleCamAxisValue(2) then
		return true
	end

	return false
end

return ElevationAngleCheck
