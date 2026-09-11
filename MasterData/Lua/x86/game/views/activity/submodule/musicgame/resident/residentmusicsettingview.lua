local ResidentMusicSettingView = class("ResidentMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0
local var_0_9 = 0
local var_0_10 = 1

function ResidentMusicSettingView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicSetUI"
end

function ResidentMusicSettingView:UIParent()
	return manager.ui.uiMain.transform
end

function ResidentMusicSettingView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitMusicSet()

	self.trackPathType = MusicData:GetTrackPathType()
	self.spectralType = MusicData:GetSpectralType()

	self:SetMusicCamera()

	self.speedNum = 0
	self.judgeNum = 0
	self.screanNum = 0
	self.showMovie = true
	self.test = true
end

function ResidentMusicSettingView:InitMusicSet()
	if self.musicSetGo then
		return
	end

	self.musicSetGo = Object.Instantiate((Asset.Load("Music/V210MusicSet")))
	self.musicSetController = self.musicSetGo:GetComponent("MusicSetController")
end

function ResidentMusicSettingView:InitUI()
	self:BindCfgUI()
	self:InitKeySetUI()

	self.m_speedSlider.minValue = var_0_2
	self.m_speedSlider.maxValue = var_0_1
	self.m_judgeSlider.minValue = var_0_4
	self.m_judgeSlider.maxValue = var_0_3
	self.m_screanSlider.minValue = var_0_6
	self.m_screanSlider.maxValue = var_0_5
	self.m_volumeSlider.minValue = var_0_8
	self.m_volumeSlider.maxValue = var_0_7
	self.m_mixSlider.minValue = var_0_9
	self.m_mixSlider.maxValue = var_0_10
	self.ratingController = ControllerUtil.GetController(self.transform_, "rating")
	self.testController = ControllerUtil.GetController(self.transform_, "test")
	self.pathController = ControllerUtil.GetController(self.transform_, "path")
	self.spectralController = ControllerUtil.GetController(self.transform_, "spectral")
	self.showStateController = ControllerUtil.GetController(self.transform_, "showState")
	self.keyPosController = ControllerUtil.GetController(self.transform_, "Keyposition")
end

function ResidentMusicSettingView:AddUIListener()
	self:AddBtnListener(self.keySetBtn_, nil, function()
		self.showStateController:SetSelectedState("keySet")
	end)
	self.m_speedSlider.onValueChanged:AddListener(function()
		self.speedNum = tonumber((string.format("%.1f", self.m_speedSlider.value)))
		self.m_speedLab.text = self.speedNum

		self:ChangeSpeed()
	end)
	self:AddPressingByTimeListener(self.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.speedNum < var_0_1 then
			self.speedNum = self.speedNum + 0.1
			self.speedNum = math.min(self.speedNum, var_0_1)
			self.m_speedSlider.value = self.speedNum
			self.m_speedLab.text = self.speedNum

			self:ChangeSpeed()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.m_speedDelBtn.gameObject, 3, 0.5, 0.2, function()
		if self.speedNum > var_0_2 then
			self.speedNum = self.speedNum - 0.1
			self.speedNum = math.max(self.speedNum, var_0_2)
			self.m_speedSlider.value = self.speedNum
			self.m_speedLab.text = self.speedNum

			self:ChangeSpeed()

			return true
		end

		return false
	end)
	self.m_judgeSlider.onValueChanged:AddListener(function()
		self.judgeNum = tonumber((string.format("%.0f", self.m_judgeSlider.value)))
		self.m_judgeLab.text = self.judgeNum

		self:ChangeJudge()
	end)
	self:AddPressingByTimeListener(self.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.judgeNum < var_0_3 then
			self.judgeNum = self.judgeNum + 1
			self.judgeNum = math.min(self.judgeNum, var_0_3)
			self.m_judgeSlider.value = self.judgeNum
			self.m_judgeLab.text = self.judgeNum

			self:ChangeJudge()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.m_judgeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if self.judgeNum > var_0_4 then
			self.judgeNum = self.judgeNum - 1
			self.judgeNum = math.max(self.judgeNum, var_0_4)
			self.m_judgeSlider.value = self.judgeNum
			self.m_judgeLab.text = self.judgeNum

			self:ChangeJudge()

			return true
		end

		return false
	end)
	self.m_screanSlider.onValueChanged:AddListener(function()
		self.screanNum = tonumber((string.format("%.0f", self.m_screanSlider.value)))
		self.m_screanLab.text = self.screanNum

		self:ChangeScreen()
	end)
	self:AddPressingByTimeListener(self.m_screanAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.screanNum < var_0_5 then
			self.screanNum = self.screanNum + 1
			self.screanNum = math.min(self.screanNum, var_0_5)
			self.m_screanSlider.value = self.screanNum
			self.m_screanLab.text = self.screanNum

			self:ChangeScreen()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.m_screanDelBtn.gameObject, 3, 0.5, 0.2, function()
		if self.screanNum > var_0_6 then
			self.screanNum = self.screanNum - 1
			self.screanNum = math.max(self.screanNum, var_0_6)
			self.m_screanSlider.value = self.screanNum
			self.m_screanLab.text = self.screanNum

			self:ChangeScreen()

			return true
		end

		return false
	end)
	self.m_volumeSlider.onValueChanged:AddListener(function()
		self.volumeNum = tonumber((string.format("%.0f", self.m_volumeSlider.value)))
		self.m_volumeLab.text = self.volumeNum

		self:ChangeVolume()
	end)
	self:AddPressingByTimeListener(self.m_volumeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.volumeNum < var_0_7 then
			self.volumeNum = self.volumeNum + 1
			self.volumeNum = math.min(self.volumeNum, var_0_7)
			self.m_volumeSlider.value = self.volumeNum
			self.m_volumeLab.text = self.volumeNum

			self:ChangeVolume()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.m_volumeDelBtn.gameObject, 3, 0.5, 0.2, function()
		if self.volumeNum > var_0_8 then
			self.volumeNum = self.volumeNum - 1
			self.volumeNum = math.max(self.volumeNum, var_0_8)
			self.m_volumeSlider.value = self.volumeNum
			self.m_volumeLab.text = self.volumeNum

			self:ChangeVolume()

			return true
		end

		return false
	end)
	self.m_mixSlider.onValueChanged:AddListener(function()
		self.mixNum = tonumber((string.format("%.1f", self.m_mixSlider.value)))
		self.m_mixValueLab.text = self.mixNum

		self:ChangeMixValue()
	end)
	self:AddPressingByTimeListener(self.m_mixAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.mixNum < var_0_10 then
			self.mixNum = self.mixNum + 0.1
			self.mixNum = math.min(self.mixNum, var_0_10)
			self.m_mixSlider.value = self.mixNum
			self.m_mixValueLab.text = self.mixNum

			self:ChangeMixValue()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.m_mixMinusBtn.gameObject, 3, 0.5, 0.2, function()
		if self.mixNum > var_0_9 then
			self.mixNum = self.mixNum - 0.1
			self.mixNum = math.max(self.mixNum, var_0_9)
			self.m_mixSlider.value = self.mixNum
			self.m_mixValueLab.text = self.mixNum

			self:ChangeMixValue()

			return true
		end

		return false
	end)
	self:AddBtnListener(self.m_testOn, nil, function()
		self:ChangeTestBool(true)
	end)
	self:AddBtnListener(self.m_testOff, nil, function()
		self:ChangeTestBool(false)
	end)
	self:AddBtnListener(self.m_slopeOn, nil, function()
		self:ChangeTrackPath(MusicConst.MusicTrackType.Slope)
	end)
	self:AddBtnListener(self.m_verticalOn, nil, function()
		self:ChangeTrackPath(MusicConst.MusicTrackType.Vertical)
	end)
	self:AddBtnListener(self.m_evenSlopeOn, nil, function()
		self:ChangeTrackPath(MusicConst.MusicTrackType.Constant_Slope)
	end)
	self:AddBtnListener(self.m_mirrorOn, nil, function()
		self:ChangeSpectralType(MusicConst.MusicSpectralType.Mirror)
	end)
	self:AddBtnListener(self.m_mirrorOff, nil, function()
		self:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
	self:AddBtnListener(self.m_RandomOn, nil, function()
		self:ChangeSpectralType(MusicConst.MusicSpectralType.Random)
	end)
	self:AddBtnListener(self.m_RandomOff, nil, function()
		self:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
end

function ResidentMusicSettingView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function ResidentMusicSettingView:OnEnter()
	SetActive(self.musicSetGo, true)

	self.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	self.musicSetController:Begain()
	self:InitMusicSet()
	self:SetMusicCamera()
	self.ratingController:SetSelectedIndex(0)
	self:InitBackScene()

	self.trackPathType = MusicData:GetTrackPathType()
	self.spectralType = MusicData:GetSpectralType()
	self.speedNum = MusicData:GetSpeedValue(self.trackPathType)
	self.m_speedSlider.value = self.speedNum
	self.m_speedLab.text = self.speedNum

	self:ChangeSpeed()

	self.judgeNum = MusicData:GetJudgeValue()
	self.m_judgeSlider.value = self.judgeNum
	self.m_judgeLab.text = self.judgeNum

	self:ChangeJudge()

	self.screanNum = MusicData:GetScreanValue()
	self.m_screanSlider.value = self.screanNum
	self.m_screanLab.text = self.screanNum

	self:ChangeScreen()

	self.volumeNum = MusicData:GetVolumeValue()
	self.m_volumeSlider.value = self.volumeNum
	self.m_volumeLab.text = self.volumeNum

	self:ChangeVolume()

	self.mixNum = MusicData:GetMixValue()
	self.m_mixSlider.value = self.mixNum
	self.m_mixValueLab.text = self.mixNum

	self:ChangeMixValue()
	self:ChangeTrackPath(self.trackPathType, true)
	self:ChangeSpectralType(self.spectralType)

	self.test = self.musicSetController.autoClick

	self.testController:SetSelectedIndex(self.test and 1 or 0)
end

function ResidentMusicSettingView:OnExit()
	manager.windowBar:HideBar()

	if self.raycaster then
		Object.Destroy(self.raycaster_)
	end

	self.musicSetController:End()
	SetActive(self.musicSetGo, false)
	MusicData:SetSpeedValue(self.speedNum, self.trackPathType)
	MusicData:SetJudgeValue(self.judgeNum)
	MusicData:SetScreanValue(self.screanNum)
	MusicData:SetVolumeValue(self.volumeNum)
	MusicData:SetShoMovie(self.showMovie)
	MusicData:SetTrackPathType(self.trackPathType)
	MusicData:SetSpectralType(self.spectralType)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(self.speedNum),
		time = tostring(self.judgeNum),
		other_data = MusicData:GetSpectralAndVercialSDKKey()
	})

	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end

	if self.sceneSetting_ then
		self.sceneSetting_.enabled = true
	end
end

function ResidentMusicSettingView:GetIsVertical()
	return self.trackPathType == MusicConst.MusicTrackType.Vertical
end

function ResidentMusicSettingView:SetMusicCamera()
	local var_36_0 = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Constant_Slope

	if self.trackPathType == MusicConst.MusicTrackType.Constant_Slope then
		manager.ui:SetMainCamera("musicSetConstant")
	elseif self.trackPathType == MusicConst.MusicTrackType.Vertical then
		manager.ui:SetMainCamera("musicSetVertical")
	else
		manager.ui:SetMainCamera("musicSet")
	end

	if self.AdaptiveTimer then
		self.AdaptiveTimer:Stop()

		self.AdaptiveTimer = nil
	end

	self.AdaptiveTimer = FrameTimer.New(function()
		self:AdaptiveSetGo()
	end, 1, 1)

	self.AdaptiveTimer:Start()
end

function ResidentMusicSettingView:AdaptiveSetGo()
	return
end

function ResidentMusicSettingView:ChangeSpeed()
	self.musicSetController.stayTime = 45.833333333333336 * self.speedNum * self.speedNum - 562.5 * self.speedNum + 2016.6666666666667

	if self.trackPathType == MusicConst.MusicTrackType.Constant_Slope then
		self.musicSetController.constantStayTime = self.speedNum * 10
	end
end

function ResidentMusicSettingView:ChangeJudge()
	local var_40_0 = math.abs(self.judgeNum) / 50 * 300

	if self.judgeNum < 0 then
		var_40_0 = -1 * var_40_0
	end

	MusicGame.MusicSetController.latency = var_40_0 - 42
end

function ResidentMusicSettingView:ChangeScreen()
	local var_41_0 = math.abs(self.screanNum) / 50 * 300

	if self.screanNum < 0 then
		var_41_0 = -1 * var_41_0
	end

	MusicGame.MusicSetController.judgeLatency = var_41_0
end

function ResidentMusicSettingView:ChangeVolume()
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", math.abs(self.volumeNum) / 100)
end

function ResidentMusicSettingView:ChangeMixValue()
	MusicData:SetMixValue(self.mixNum)

	MusicGame.MusicSetController.mixRange = self.mixNum
end

function ResidentMusicSettingView:ChangeTestBool(arg_44_1)
	if self.test == arg_44_1 then
		return
	end

	self.test = arg_44_1

	self.testController:SetSelectedIndex(self.test and 1 or 0)

	self.musicSetController.autoClick = arg_44_1
end

function ResidentMusicSettingView:ChangeSpectralType(arg_45_1)
	self.spectralType = arg_45_1

	local var_45_0

	if arg_45_1 == MusicConst.MusicSpectralType.None then
		var_45_0 = 0
	elseif arg_45_1 == MusicConst.MusicSpectralType.Mirror then
		var_45_0 = 1
	elseif arg_45_1 == MusicConst.MusicSpectralType.Random then
		var_45_0 = 2
	end

	if var_45_0 then
		self.spectralController:SetSelectedIndex(var_45_0)
	end
end

function ResidentMusicSettingView:ChangeTrackPath(arg_46_1, arg_46_2)
	if not arg_46_2 and arg_46_1 == self.trackPathType then
		return
	end

	MusicData:SetSpeedValue(self.speedNum, self.trackPathType)

	self.trackPathType = arg_46_1
	self.speedNum = MusicData:GetSpeedValue(self.trackPathType)
	self.m_speedSlider.value = self.speedNum
	self.m_speedLab.text = self.speedNum

	self.pathController:SetSelectedIndex(self.trackPathType - 1)
	self.musicSetController:SetTrackType(self.trackPathType)
	self:SetMusicCamera()
	self:ChangeSpeed()
end

function ResidentMusicSettingView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(11, 11, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = self.bgImg_.sprite
end

function ResidentMusicSettingView:OnMusicSetNodeHit(arg_48_1, arg_48_2)
	SetActive(self.m_effect, false)
	SetActive(self.m_effect, true)

	if arg_48_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_48_2 or MusicConst.MusicNodeHitType.Long == arg_48_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_48_1 then
		self.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_48_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_48_1 then
		self.ratingController:SetSelectedIndex(2)
	else
		self.ratingController:SetSelectedIndex(1)
	end
end

function ResidentMusicSettingView:Dispose()
	self:DisposeSet()
	ResidentMusicSettingView.super.Dispose(self)
end

return ResidentMusicSettingView
