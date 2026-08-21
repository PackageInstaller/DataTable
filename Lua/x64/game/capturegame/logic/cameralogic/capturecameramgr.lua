local var_0_0 = class("CaptureCameraMgr", CaptureLogicMgrBase)

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.context = {}
	arg_2_0.userInfoBinder = {}
end

function var_0_0.SetController(arg_3_0, arg_3_1)
	arg_3_0.context.controller = arg_3_1
	arg_3_0.context.eventRectTrans = arg_3_0.context.controller.gameObject:GetComponent("RectTransform")
	arg_3_0.context.lensImgComp = arg_3_0.context.controller.transform:Find("Lens").gameObject:GetComponent(typeof(Image))
	arg_3_0.context.mainCam = UnityEngine.Camera.main
	arg_3_0.userInfoBinder.gameObject = arg_3_0.context.controller.transform:Find("UserInfo").gameObject

	ComponentBinder.GetInstance():BindCfgUI(arg_3_0.userInfoBinder, arg_3_0.userInfoBinder.gameObject)
	arg_3_0:InitUserControl()
	arg_3_0:AddListener()

	if not GameToSDK.IsEditorOrPcPlatform() then
		arg_3_0:SetCameraParams(1000, 1000, 0.03)
	elseif GameToSDK.IsPCPlatform() then
		arg_3_0:SetCameraParams(1, 1, 0.1)
	else
		arg_3_0:SetCameraParams(1, 1, 1)
	end
end

function var_0_0.SetCameraParams(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0.context.controller

	var_4_0.speed = 1 * arg_4_1
	var_4_0.speedY = 1 * arg_4_1
	var_4_0.multiSpeed = 0.02 * arg_4_2
	var_4_0.multiSpeedY = 0.02 * arg_4_2
	var_4_0.multiFovSpeed = 5 * arg_4_3
end

function var_0_0.GetControllerRectTransform(arg_5_0)
	return arg_5_0.context.eventRectTrans
end

function var_0_0.GetFov(arg_6_0)
	return arg_6_0.context.mainCam.fieldOfView
end

function var_0_0.GetMainCam(arg_7_0)
	return arg_7_0.context.mainCam
end

function var_0_0.PreStartInit(arg_8_0)
	if not CaptureGameMgr:IsSingleMode() then
		arg_8_0.context.initY = CaptureGameMgr:GetGameContext().multiCaptureCamera.transform.position.y
	end
end

function var_0_0.GetInitY(arg_9_0)
	return arg_9_0.context.initY or 0
end

function var_0_0.GetFovRatio(arg_10_0)
	local var_10_0 = arg_10_0.context.controller
	local var_10_1 = arg_10_0:GetFov()
	local var_10_2 = 0
	local var_10_3 = 0

	if CaptureGameMgr:IsSingleMode() then
		var_10_2, var_10_3 = var_10_0.singleCameraMinFov, var_10_0.singleCameraMaxFov
	else
		var_10_2, var_10_3 = var_10_0.multiCameraMinFov, var_10_0.multiCameraMaxFov
	end

	return (var_10_3 - var_10_1) / (var_10_3 - var_10_2)
end

function var_0_0.ChangeFovRatio(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.context.controller

	if CaptureGameMgr:IsSingleMode() then
		local var_11_1 = var_11_0.singleCameraMinFov
		local var_11_2 = var_11_0.singleCameraMaxFov
		local var_11_3 = var_11_2 - (var_11_2 - var_11_1) * arg_11_1

		var_11_0:ChangeSingleCameraFov(var_11_3)
	else
		local var_11_4 = var_11_0.multiCameraMinFov
		local var_11_5 = var_11_0.multiCameraMaxFov
		local var_11_6 = var_11_5 - (var_11_5 - var_11_4) * arg_11_1

		var_11_0:ChangeMultiCameraFov(var_11_6)
	end
end

function var_0_0.GetVirtualFovRatio(arg_12_0)
	local var_12_0 = arg_12_0.context.controller
	local var_12_1 = arg_12_0:GetVirtualCameraFov()
	local var_12_2 = 0
	local var_12_3 = 0

	if CaptureGameMgr:IsSingleMode() then
		var_12_2, var_12_3 = var_12_0.singleCameraMinFov, var_12_0.singleCameraMaxFov
	else
		var_12_2, var_12_3 = var_12_0.multiCameraMinFov, var_12_0.multiCameraMaxFov
	end

	return (var_12_3 - var_12_1) / (var_12_3 - var_12_2)
end

function var_0_0.GetVirtualCameraFov(arg_13_0)
	if arg_13_0.context.controller then
		return arg_13_0.context.controller:GetVirtualCameraFov()
	end

	return 0
end

function var_0_0.GetSingleCamAxisValue(arg_14_0, arg_14_1)
	if arg_14_0.context.controller then
		return arg_14_0.context.controller:GetVirtualCameraAxisValue(arg_14_1)
	end

	return 0
end

function var_0_0.AddListener(arg_15_0)
	function arg_15_0.context.controller.onPointerClick(arg_16_0, arg_16_1)
		manager.notify:Invoke(CAPTURE_GAME_CAMERA_CLICK)
	end
end

function var_0_0.PauseMainCamera(arg_17_0, arg_17_1)
	arg_17_0.context.controller.pauseCameraLogic = arg_17_1
end

function var_0_0.SwitchLens(arg_18_0, arg_18_1)
	if arg_18_1 == -1 then
		arg_18_0.context.lensImgComp.gameObject:SetActive(false)
	else
		arg_18_0.context.lensImgComp.gameObject:SetActive(true)

		arg_18_0.context.lensImgComp.sprite = pureGetSpriteWithoutAtlas(CaptureGameTools:GetLensPath(arg_18_1))
	end
end

function var_0_0.InitUserControl(arg_19_0)
	arg_19_0.userInfoBinder.logoParent_ = {
		[0] = arg_19_0.userInfoBinder.ltLogo_,
		arg_19_0.userInfoBinder.lbLogo_,
		arg_19_0.userInfoBinder.rtLogo_,
		arg_19_0.userInfoBinder.rbLogo_
	}
	arg_19_0.userInfoBinder.cardParent_ = {
		[0] = arg_19_0.userInfoBinder.ltCard_,
		arg_19_0.userInfoBinder.lbCard_,
		arg_19_0.userInfoBinder.rtCard_,
		arg_19_0.userInfoBinder.rbCard_
	}
end

function var_0_0.ShowUserPanel(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.userInfoBinder

	if arg_20_1 then
		var_20_0.gameObject:SetActive(true)

		local var_20_1 = CaptureGameSettingData:CheckNeedPlayerName()

		SetActive(var_20_0.goCardPanel_, var_20_1)
		var_20_0.transformLogo_:SetParent(var_20_0.logoParent_[CaptureGameSettingData:GetLogoPos()], false)

		if var_20_1 then
			var_20_0.transformCard_:SetParent(var_20_0.cardParent_[CaptureGameSettingData:GetCardPos()], false)

			local var_20_2 = PlayerData:GetPlayerInfo()

			var_20_0.textNick_.text = GetI18NText(var_20_2.nick)

			if CaptureGameSettingData:CheckNeedLevel() then
				var_20_0.textLv_.text = GetTips("LEVEL") .. var_20_2.userLevel
			else
				var_20_0.textLv_.text = GetTips("LEVEL") .. "**"
			end

			if CaptureGameSettingData:CheckNeedUid() then
				var_20_0.textUID_.text = "UID：" .. USER_ID
			else
				var_20_0.textUID_.text = "UID：************"
			end
		end
	else
		var_20_0.gameObject:SetActive(false)
	end
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.context.controller.onPointerClick = nil
	arg_21_0.context.controller = nil
	arg_21_0.context.eventRectTrans = nil
	arg_21_0.context.mainCam = nil
	arg_21_0.context.lensImgComp = nil

	for iter_21_0, iter_21_1 in pairs(arg_21_0.userInfoBinder) do
		arg_21_0.userInfoBinder[iter_21_0] = nil
	end

	arg_21_0.userInfoBinder = nil
end

return var_0_0
