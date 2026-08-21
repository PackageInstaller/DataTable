local var_0_0 = class("OnYouLeftCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1][1]
	local var_1_1 = arg_1_1[2][1]
	local var_1_2 = CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(var_1_0)
	local var_1_3 = CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(var_1_1)

	if var_1_2 == -1 or var_1_3 == -1 then
		return false
	else
		return CaptureGameMgr:GetPlaceHolderMgr():GetHolderPhysicsIdx(var_1_2) < CaptureGameMgr:GetPlaceHolderMgr():GetHolderPhysicsIdx(var_1_3)
	end

	return false
end

return var_0_0
