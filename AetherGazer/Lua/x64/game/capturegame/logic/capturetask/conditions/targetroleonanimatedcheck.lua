local var_0_0 = class("TargetRoleOnAnimatedCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1][1]
	local var_1_1 = arg_1_1[2]

	if CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(var_1_0) ~= -1 then
		local var_1_2 = CaptureGameMgr:GetEntityMgr():QueryRole(var_1_0)

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if var_1_2:IsInAnim(iter_1_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetConditionRecoomendAnim(arg_2_0, arg_2_1)
	return arg_2_1[2] or {}
end

return var_0_0
