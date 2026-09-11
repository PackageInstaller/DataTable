local RoleOnHolderCondition = class("RoleOnHolderCondition", CaptureConditionBase)

function RoleOnHolderCondition:CheckCondition(arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1[2]) do
		local var_1_0 = CaptureGameMgr:GetPlaceHolderMgr():GetEntity(iter_1_1)

		if not var_1_0 then
			return false
		end

		local var_1_1 = var_1_0:GetSkinEntityId()

		if var_1_1 ~= -1 then
			if CaptureGameMgr:GetEntityMgr():GetEntity(var_1_1):GetRoleId() == arg_1_1[1][1] then
				return true
			end
		end
	end

	return false
end

return RoleOnHolderCondition
