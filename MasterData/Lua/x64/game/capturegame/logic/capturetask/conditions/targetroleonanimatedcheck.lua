local TargetRoleOnAnimatedCheck = class("TargetRoleOnAnimatedCheck", CaptureConditionBase)

function TargetRoleOnAnimatedCheck:CheckCondition(arg_1_1)
	if CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(arg_1_1[1][1]) ~= -1 then
		local var_1_0 = CaptureGameMgr:GetEntityMgr():QueryRole(arg_1_1[1][1])

		for iter_1_0, iter_1_1 in ipairs(arg_1_1[2]) do
			if var_1_0:IsInAnim(iter_1_1) then
				return true
			end
		end
	end

	return false
end

function TargetRoleOnAnimatedCheck:GetConditionRecoomendAnim(arg_2_1)
	return arg_2_1[2] or {}
end

return TargetRoleOnAnimatedCheck
