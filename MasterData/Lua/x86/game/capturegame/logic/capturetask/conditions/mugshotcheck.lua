local MugShotCheck = class("MugShotCheck", CaptureConditionBase)

function MugShotCheck:CheckCondition(arg_1_1)
	local var_1_0 = arg_1_1[1] or 10
	local var_1_1 = arg_1_1[2] or 20
	local var_1_2 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

	if not var_1_2 then
		return false
	end

	if Vector3.Dot(var_1_2.context.transform.forward, UnityEngine.Camera.main.transform.forward) > 0 then
		return false
	end

	local var_1_3 = CaptureGameMgr:GetCameraMgr():GetFov()

	if var_1_0 <= var_1_3 and var_1_3 <= var_1_1 then
		return true
	end

	return false
end

return MugShotCheck
