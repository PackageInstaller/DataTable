local var_0_0 = class("ForwardTargetCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[1] or ""

	if not var_1_0 or var_1_0 == "" then
		return false
	end

	local var_1_1 = CaptureGameMgr:GetEntityMgr():QueryDecorator(var_1_0)

	if var_1_1 then
		local var_1_2 = CaptureGameMgr:GetCurRoleId()
		local var_1_3 = CaptureGameMgr:GetEntityMgr():GetEntity(var_1_2)

		if not var_1_3 then
			return false
		end

		if Vector3.Dot(var_1_1.context.transform.forward, var_1_3.context.transform.forward) <= 0 then
			return true
		end
	end

	return false
end

return var_0_0
