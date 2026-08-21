local var_0_0 = class("RolePlayAnimationOnPlaceCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1][1]
	local var_1_1 = arg_1_1[2][1]
	local var_1_2 = arg_1_1[3] or {}
	local var_1_3 = CaptureGameMgr:GetPlaceHolderMgr():GetEntity(var_1_1)

	if not var_1_3 then
		return false
	end

	local var_1_4 = var_1_3:GetSkinEntityId()

	if var_1_4 ~= -1 then
		local var_1_5 = CaptureGameMgr:GetEntityMgr():GetEntity(var_1_4)

		if var_1_5:GetRoleId() == var_1_0 then
			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				if var_1_5:IsInAnim(iter_1_1) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.GetConditionRecoomendAnim(arg_2_0, arg_2_1)
	return arg_2_1[3] or {}
end

return var_0_0
