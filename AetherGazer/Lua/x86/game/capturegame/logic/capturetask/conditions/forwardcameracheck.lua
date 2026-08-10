local var_0_0 = class("ForwardCameraCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	if CaptureGameMgr:IsSingleMode() then
		local var_1_0 = CaptureGameMgr:GetCurRoleId()
		local var_1_1 = CaptureGameMgr:GetEntityMgr():GetEntity(var_1_0)

		if not var_1_1 then
			return false
		end

		if Vector3.Dot(var_1_1.context.transform.forward, UnityEngine.Camera.main.transform.forward) <= 0 then
			return true
		end

		return false
	else
		return true
	end
end

return var_0_0
