local var_0_0 = class("RoleOnHolderCondition", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1][1]
	local var_1_1 = arg_1_1[2]

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = CaptureGameMgr:GetPlaceHolderMgr():GetEntity(iter_1_1)

		if not var_1_2 then
			return false
		end

		local var_1_3 = var_1_2:GetSkinEntityId()

		if var_1_3 ~= -1 and CaptureGameMgr:GetEntityMgr():GetEntity(var_1_3):GetRoleId() == var_1_0 then
			return true
		end
	end

	return false
end

return var_0_0
