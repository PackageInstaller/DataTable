local var_0_0 = class("SingleRoleOnAnimatedCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1]
	local var_1_1 = CaptureGameMgr:GetCurRoleId()
	local var_1_2 = CaptureGameMgr:GetEntityMgr():GetEntity(var_1_1)

	if not var_1_2 then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if var_1_2:IsInAnim(iter_1_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetConditionRecoomendAnim(arg_2_0, arg_2_1)
	return arg_2_1[1] or {}
end

return var_0_0
