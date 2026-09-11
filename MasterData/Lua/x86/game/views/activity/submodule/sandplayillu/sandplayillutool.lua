local var_0_0 = {}
local var_0_1 = "IlluCamera"

function var_0_0.EnterSandPlayIllu(arg_1_0)
	QWorldLuaBridge.StopControl(true)
	QWorldMgr:StartBlackFade(0.5, 0.5, 0, function()
		JumpTools.GoToSystem("/sandPlayIlluView", {
			itemID = arg_1_0
		})
	end)
end

function var_0_0.OnEnterSandPlayIllu()
	QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, var_0_1, QWorldCameraLayer.Illu)
end

function var_0_0.ExitSandPlayIllu()
	QWorldMgr:ExitCustomCamera(var_0_1)
end

function var_0_0.IsIlluUnlock()
	if SandplayIlluData:GetGroupNum() < 1 then
		return false
	end

	return true
end

return var_0_0
