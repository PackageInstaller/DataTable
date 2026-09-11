local DepressionAngleCheck = class("DepressionAngleCheck", CaptureConditionBase)

function DepressionAngleCheck:CheckCondition(arg_1_1)
	if (arg_1_1[1] or 0.6) < CaptureGameMgr:GetCameraMgr():GetSingleCamAxisValue(2) then
		return true
	end

	return false
end

return DepressionAngleCheck
