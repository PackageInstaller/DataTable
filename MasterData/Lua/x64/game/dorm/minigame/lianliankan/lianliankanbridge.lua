local var_0_0 = {}

function var_0_0.Enter(arg_1_0)
	manager.ui:SetMainCamera("lianliankan")
	manager.windowBar:SetWhereTag("lianliankan")

	local var_1_0 = DormLinkGameData:GetCurLevelID()

	LianLianKanGameManager.GetInstance():Init(var_1_0)

	if var_1_0 then
		DormLinkGameData:InitCustomerInfo()
		gameContext:Go("/dormLinkGamePlayView")
	end

	var_0_0:UpSetCameraFOV()
end

function var_0_0.UpSetCameraFOV(arg_2_0)
	manager.ui.mainCameraCom_.fieldOfView = math.max(1.7777777777777777 / (Screen.width / Screen.height) * CameraCfg.lianliankan.fieldOfView, CameraCfg.lianliankan.fieldOfView)
end

function var_0_0.Exit(arg_3_0)
	LianLianKanGameManager.GetInstance():Reset()
	DormLinkGameData:DisposeRunGameInfo()
end

return var_0_0
