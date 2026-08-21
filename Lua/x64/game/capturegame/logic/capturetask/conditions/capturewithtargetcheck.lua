local var_0_0 = class("CaptureWithTargetCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1] or ""

	if not var_1_0 or var_1_0 == "" then
		return true
	end

	local var_1_1 = CaptureGameMgr:GetEntityMgr():QueryDecorator(var_1_0)

	if var_1_1 then
		return not var_1_1:IsOcculuded()
	end

	return false
end

return var_0_0
