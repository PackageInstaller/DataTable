local OnYouLeftCheck = class("OnYouLeftCheck", CaptureConditionBase)

function OnYouLeftCheck:CheckCondition(arg_1_1)
	local var_1_0 = CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(arg_1_1[1][1])
	local var_1_1 = CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(arg_1_1[2][1])

	if var_1_0 == -1 or var_1_1 == -1 then
		return false
	else
		return CaptureGameMgr:GetPlaceHolderMgr():GetHolderPhysicsIdx(var_1_0) < CaptureGameMgr:GetPlaceHolderMgr():GetHolderPhysicsIdx(var_1_1)
	end

	return false
end

return OnYouLeftCheck
