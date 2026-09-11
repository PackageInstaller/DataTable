local ForwardTargetCheck = class("ForwardTargetCheck", CaptureConditionBase)

function ForwardTargetCheck:CheckCondition(arg_1_1)
	local var_1_0 = arg_1_1[1] or ""

	if not var_1_0 or var_1_0 == "" then
		return false
	end

	local var_1_1 = CaptureGameMgr:GetEntityMgr():QueryDecorator(var_1_0)

	if var_1_1 then
		local var_1_2 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

		if not var_1_2 then
			return false
		end

		if Vector3.Dot(var_1_1.context.transform.forward, var_1_2.context.transform.forward) <= 0 then
			return true
		end
	end

	return false
end

return ForwardTargetCheck
