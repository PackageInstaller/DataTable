local V210MusicSettingView = class("V210MusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0

function V210MusicSettingView:UIName()
	local var_1_0 = MusicData:GetNowMusicUINameList()

	if var_1_0 and var_1_0.settingView then
		return var_1_0.settingView
	else
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicSetUI"
	end
end

function V210MusicSettingView:UIParent()
	return manager.ui.uiMain.transform
end

function V210MusicSettingView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitMusicSet()

	self.isVertical = MusicData:GetVerical()
	self.spectralType = MusicData:GetSpectralType()

	self:SetMusicCamera()

	self.speedNum = 0
	self.judgeNum = 0
	self.screanNum = 0
	self.showMovie = true
	self.test = true
end

function V210MusicSettingView:InitMusicSet()
	if self.musicSetGo then
		return
	end

	self.musicSetGo = Object.Instantiate((Asset.Load("Music/V210MusicSet")))
	self.musicSetController = self.musicSetGo:GetComponent("MusicSetController")
end

function V210MusicSettingView:InitUI()
	self:BindCfgUI()

	self.m_speedSlider.minValue = var_0_2
	self.m_speedSlider.maxValue = var_0_1
	self.m_judgeSlider.minValue = var_0_4
	self.m_judgeSlider.maxValue = var_0_3
	self.m_screanSlider.minValue = var_0_6
	self.m_screanSlider.maxValue = var_0_5
	self.m_volumeSlider.minValue = var_0_8
	self.m_volumeSlider.maxValue = var_0_7
	self.ratingController = ControllerUtil.GetController(self.transform_, "rating")
	self.testController = ControllerUtil.GetController(self.transform_, "test")
	self.pathController = ControllerUtil.GetController(self.transform_, "path")
	self.spectralController = ControllerUtil.GetController(self.transform_, "spectral")
end

function V210MusicSettingView:AddUIListener()
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
	self:AddBtnListener(self.m_testOn, nil, function()
		self:ChangeTestBool(true)
	end)
	self:AddBtnListener(self.m_testOff, nil, function()
		self:ChangeTestBool(false)
	end)
	self:AddBtnListener(self.m_pathOn, nil, function()
		self:ChangeVericalBool(false)
	end)
	self:AddBtnListener(self.m_pathOff, nil, function()
		self:ChangeVericalBool(true)
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

function V210MusicSettingView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function V210MusicSettingView:OnEnter()
	self:InitMusicSet()
	self:SetMusicCamera()
	self.ratingController:SetSelectedIndex(0)
	self:InitBackScene()

	self.isVertical = MusicData:GetVerical()
	self.spectralType = MusicData:GetSpectralType()
	self.speedNum = MusicData:GetSpeedValue(self.isVertical)
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
	self:ChangeVericalBool(self.isVertical, true)
	self:ChangeSpectralType(self.spectralType)

	self.test = self.musicSetController.autoClick

	self.testController:SetSelectedIndex(self.test and 1 or 0)
	SetActive(self.musicSetGo, true)

	self.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	self.musicSetController:Begain()
end

function V210MusicSettingView:OnExit()
	manager.windowBar:HideBar()

	if self.raycaster then
		Object.Destroy(self.raycaster_)
	end

	self.musicSetController:End()

	if manager.windowBar:GetWhereTag() == "qworld" then
		QWorldMgr:EnableCamera(QWorldCameraFlag.Player)

		if self.musicSetGo then
			Asset.Unload("Music/V210MusicSet")
			Object.Destroy(self.musicSetGo)

			self.musicSetGo = nil
		end
	end

	MusicData:SetSpeedValue(self.speedNum, self.isVertical)
	MusicData:SetJudgeValue(self.judgeNum)
	MusicData:SetScreanValue(self.screanNum)
	MusicData:SetVolumeValue(self.volumeNum)
	MusicData:SetShoMovie(self.showMovie)
	MusicData:SetVerical(self.isVertical)
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

function V210MusicSettingView:SetMusicCamera()
	if self.isVertical then
		if manager.windowBar:GetWhereTag() == "qworld" then
			QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, "musicVerticalCamera")
		else
			manager.ui:SetMainCamera("musicSetVertical")
		end
	elseif manager.windowBar:GetWhereTag() == "qworld" then
		QWorldMgr:EnableCamera(QWorldCameraFlag.CustomCamera, "musicCamera")
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

function V210MusicSettingView:AdaptiveSetGo()
	local var_32_0 = UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, self.setPosTrs_.position)

	self.musicSetGo.transform.position = Vector3(manager.ui.mainCameraCom_:ScreenToWorldPoint(Vector3(var_32_0.x, var_32_0.y, 50)).x + (self.isVertical and 0 or 3), 0, 0)
end

function V210MusicSettingView:ChangeSpeed()
	self.musicSetController.stayTime = 350 + (5 - self.speedNum) * (1500 - 350) / 4
end

function V210MusicSettingView:ChangeJudge()
	local var_34_0 = math.abs(self.judgeNum) / 50 * 300

	if self.judgeNum < 0 then
		var_34_0 = -1 * var_34_0
	end

	MusicGame.MusicSetController.latency = var_34_0 - 42
end

function V210MusicSettingView:ChangeScreen()
	local var_35_0 = math.abs(self.screanNum) / 50 * 300

	if self.screanNum < 0 then
		var_35_0 = -1 * var_35_0
	end

	MusicGame.MusicSetController.judgeLatency = var_35_0
end

function V210MusicSettingView:ChangeVolume()
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", math.abs(self.volumeNum) / 100)
end

function V210MusicSettingView:ChangeTestBool(arg_37_1)
	if self.test == arg_37_1 then
		return
	end

	self.test = arg_37_1

	self.testController:SetSelectedIndex(self.test and 1 or 0)

	self.musicSetController.autoClick = arg_37_1
end

function V210MusicSettingView:ChangeSpectralType(arg_38_1)
	self.spectralType = arg_38_1

	local var_38_0

	if arg_38_1 == MusicConst.MusicSpectralType.None then
		var_38_0 = 0
	elseif arg_38_1 == MusicConst.MusicSpectralType.Mirror then
		var_38_0 = 1
	elseif arg_38_1 == MusicConst.MusicSpectralType.Random then
		var_38_0 = 2
	end

	if var_38_0 then
		self.spectralController:SetSelectedIndex(var_38_0)
	end
end

function V210MusicSettingView:ChangeVericalBool(arg_39_1, arg_39_2)
	if not arg_39_2 and arg_39_1 == self.isVertical then
		return
	end

	MusicData:SetSpeedValue(self.speedNum, self.isVertical)

	self.isVertical = arg_39_1
	self.speedNum = MusicData:GetSpeedValue(self.isVertical)
	self.m_speedSlider.value = self.speedNum
	self.m_speedLab.text = self.speedNum

	self.pathController:SetSelectedIndex(self.isVertical and 0 or 1)

	MusicGame.MusicSetController.isVertical = arg_39_1

	self:ChangeSpeed()
	self:SetMusicCamera()
end

function V210MusicSettingView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(11, 11, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = self.bgImg_.sprite
	self.sceneSetting_ = manager.ui:GetSceneSettingBySceneName((QWorldData:GetCurSceneName()))
	self.sceneSetting_.enabled = false
end

function V210MusicSettingView:OnMusicSetNodeHit(arg_41_1, arg_41_2)
	SetActive(self.m_effect, false)
	SetActive(self.m_effect, true)

	if arg_41_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_41_2 or MusicConst.MusicNodeHitType.Long == arg_41_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_41_1 then
		self.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_41_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_41_1 then
		self.ratingController:SetSelectedIndex(2)
	else
		self.ratingController:SetSelectedIndex(1)
	end
end

function V210MusicSettingView:Dispose()
	V210MusicSettingView.super.Dispose(self)
end

return V210MusicSettingView
