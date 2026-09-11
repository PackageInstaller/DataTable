local CaptureCameraMgr = class("CaptureCameraMgr", CaptureLogicMgrBase)

function CaptureCameraMgr:Ctor()
	self:Init()
end

function CaptureCameraMgr:Init()
	self.context = {}
	self.userInfoBinder = {}
end

function CaptureCameraMgr:SetController(arg_3_1)
	self.context.controller = arg_3_1
	self.context.eventRectTrans = self.context.controller.gameObject:GetComponent("RectTransform")
	self.context.lensImgComp = self.context.controller.transform:Find("Lens").gameObject:GetComponent(typeof(Image))
	self.context.mainCam = UnityEngine.Camera.main
	self.userInfoBinder.gameObject = self.context.controller.transform:Find("UserInfo").gameObject

	ComponentBinder.GetInstance():BindCfgUI(self.userInfoBinder, self.userInfoBinder.gameObject)
	self:InitUserControl()
	self:AddListener()

	if not GameToSDK.IsEditorOrPcPlatform() then
		self:SetCameraParams(1000, 1000, 0.03)
	elseif GameToSDK.IsPCPlatform() then
		self:SetCameraParams(1, 1, 0.1)
	else
		self:SetCameraParams(1, 1, 1)
	end
end

function CaptureCameraMgr:SetCameraParams(arg_4_1, arg_4_2, arg_4_3)
	self.context.controller.speed = 1 * arg_4_1
	self.context.controller.speedY = 1 * arg_4_1
	self.context.controller.multiSpeed = 0.02 * arg_4_2
	self.context.controller.multiSpeedY = 0.02 * arg_4_2
	self.context.controller.multiFovSpeed = 5 * arg_4_3
end

function CaptureCameraMgr:GetControllerRectTransform()
	return self.context.eventRectTrans
end

function CaptureCameraMgr:GetFov()
	return self.context.mainCam.fieldOfView
end

function CaptureCameraMgr:GetMainCam()
	return self.context.mainCam
end

function CaptureCameraMgr:PreStartInit()
	if not CaptureGameMgr:IsSingleMode() then
		self.context.initY = CaptureGameMgr:GetGameContext().multiCaptureCamera.transform.position.y
	end
end

function CaptureCameraMgr:GetInitY()
	return self.context.initY or 0
end

function CaptureCameraMgr:GetFovRatio()
	local var_10_0 = self:GetFov()
	local var_10_1 = 0
	local var_10_2 = 0

	if CaptureGameMgr:IsSingleMode() then
		var_10_2 = self.context.controller.singleCameraMaxFov
		var_10_1 = self.context.controller.singleCameraMinFov
	else
		var_10_2 = self.context.controller.multiCameraMaxFov
		var_10_1 = self.context.controller.multiCameraMinFov
	end

	return (var_10_2 - var_10_0) / (var_10_2 - var_10_1)
end

function CaptureCameraMgr:ChangeFovRatio(arg_11_1)
	if CaptureGameMgr:IsSingleMode() then
		self.context.controller:ChangeSingleCameraFov(self.context.controller.singleCameraMaxFov - (self.context.controller.singleCameraMaxFov - self.context.controller.singleCameraMinFov) * arg_11_1)
	else
		self.context.controller:ChangeMultiCameraFov(self.context.controller.multiCameraMaxFov - (self.context.controller.multiCameraMaxFov - self.context.controller.multiCameraMinFov) * arg_11_1)
	end
end

function CaptureCameraMgr:GetVirtualFovRatio()
	local var_12_0 = self:GetVirtualCameraFov()
	local var_12_1 = 0
	local var_12_2 = 0

	if CaptureGameMgr:IsSingleMode() then
		var_12_2 = self.context.controller.singleCameraMaxFov
		var_12_1 = self.context.controller.singleCameraMinFov
	else
		var_12_2 = self.context.controller.multiCameraMaxFov
		var_12_1 = self.context.controller.multiCameraMinFov
	end

	return (var_12_2 - var_12_0) / (var_12_2 - var_12_1)
end

function CaptureCameraMgr:GetVirtualCameraFov()
	if self.context.controller then
		return self.context.controller:GetVirtualCameraFov()
	end

	return 0
end

function CaptureCameraMgr:GetSingleCamAxisValue(arg_14_1)
	if self.context.controller then
		return self.context.controller:GetVirtualCameraAxisValue(arg_14_1)
	end

	return 0
end

function CaptureCameraMgr:AddListener()
	function self.context.controller.onPointerClick(arg_16_0, arg_16_1)
		manager.notify:Invoke(CAPTURE_GAME_CAMERA_CLICK)
	end
end

function CaptureCameraMgr:PauseMainCamera(arg_17_1)
	self.context.controller.pauseCameraLogic = arg_17_1
end

function CaptureCameraMgr:SwitchLens(arg_18_1)
	if arg_18_1 == -1 then
		self.context.lensImgComp.gameObject:SetActive(false)
	else
		self.context.lensImgComp.gameObject:SetActive(true)

		self.context.lensImgComp.sprite = pureGetSpriteWithoutAtlas(CaptureGameTools:GetLensPath(arg_18_1))
	end
end

function CaptureCameraMgr:InitUserControl()
	self.userInfoBinder.logoParent_ = {
		[0] = self.userInfoBinder.ltLogo_,
		self.userInfoBinder.lbLogo_,
		self.userInfoBinder.rtLogo_,
		self.userInfoBinder.rbLogo_
	}
	self.userInfoBinder.cardParent_ = {
		[0] = self.userInfoBinder.ltCard_,
		self.userInfoBinder.lbCard_,
		self.userInfoBinder.rtCard_,
		self.userInfoBinder.rbCard_
	}
end

function CaptureCameraMgr:ShowUserPanel(arg_20_1)
	if arg_20_1 then
		self.userInfoBinder.gameObject:SetActive(true)

		local var_20_0 = CaptureGameSettingData:CheckNeedPlayerName()

		SetActive(self.userInfoBinder.goCardPanel_, var_20_0)
		self.userInfoBinder.transformLogo_:SetParent(self.userInfoBinder.logoParent_[CaptureGameSettingData:GetLogoPos()], false)

		if var_20_0 then
			self.userInfoBinder.transformCard_:SetParent(self.userInfoBinder.cardParent_[CaptureGameSettingData:GetCardPos()], false)

			local var_20_1 = PlayerData:GetPlayerInfo()

			self.userInfoBinder.textNick_.text = GetI18NText(var_20_1.nick)
			self.userInfoBinder.textLv_.text = CaptureGameSettingData:CheckNeedLevel() and GetTips("LEVEL") .. var_20_1.userLevel or GetTips("LEVEL") .. "**"
			self.userInfoBinder.textUID_.text = CaptureGameSettingData:CheckNeedUid() and "UID：" .. USER_ID or "UID：************"
		end
	else
		self.userInfoBinder.gameObject:SetActive(false)
	end
end

function CaptureCameraMgr:Dispose()
	self.context.controller.onPointerClick = nil
	self.context.controller = nil
	self.context.eventRectTrans = nil
	self.context.mainCam = nil
	self.context.lensImgComp = nil

	for iter_21_0, iter_21_1 in pairs(self.userInfoBinder) do
		self.userInfoBinder[iter_21_0] = nil
	end

	self.userInfoBinder = nil
end

return CaptureCameraMgr
