local ForwardCameraCheck = class("ForwardCameraCheck", CaptureConditionBase)

function ForwardCameraCheck:CheckCondition(arg_1_1)
	if CaptureGameMgr:IsSingleMode() then
		local var_1_0 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

		if not var_1_0 then
			return false
		end

		if Vector3.Dot(var_1_0.context.transform.forward, UnityEngine.Camera.main.transform.forward) <= 0 then
			return true
		end

		return false
	else
		return true
	end
end

return ForwardCameraCheck
