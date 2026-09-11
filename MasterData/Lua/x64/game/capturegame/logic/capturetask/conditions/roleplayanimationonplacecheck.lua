local RolePlayAnimationOnPlaceCheck = class("RolePlayAnimationOnPlaceCheck", CaptureConditionBase)

function RolePlayAnimationOnPlaceCheck:CheckCondition(arg_1_1)
	local var_1_0 = arg_1_1[3] or {}
	local var_1_1 = CaptureGameMgr:GetPlaceHolderMgr():GetEntity(arg_1_1[2][1])

	if not var_1_1 then
		return false
	end

	local var_1_2 = var_1_1:GetSkinEntityId()

	if var_1_2 ~= -1 then
		local var_1_3 = CaptureGameMgr:GetEntityMgr():GetEntity(var_1_2)

		if var_1_3:GetRoleId() == arg_1_1[1][1] then
			for iter_1_0, iter_1_1 in ipairs(var_1_0) do
				if var_1_3:IsInAnim(iter_1_1) then
					return true
				end
			end
		end
	end

	return false
end

function RolePlayAnimationOnPlaceCheck:GetConditionRecoomendAnim(arg_2_1)
	return arg_2_1[3] or {}
end

return RolePlayAnimationOnPlaceCheck
