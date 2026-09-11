local EnternalMusicSettingView = class("EnternalMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50
local var_0_5 = 50
local var_0_6 = -50
local var_0_7 = 100
local var_0_8 = 0

function EnternalMusicSettingView:UIName()
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicSetUI"
end

function EnternalMusicSettingView:UIParent()
	return manager.ui.uiMain.transform
end

function EnternalMusicSettingView:Init()
	self:InitUI()
	self:AddUIListener()

	self.musicSetGo = Object.Instantiate((Asset.Load("Music/MusicSet")))
	self.musicSetController = self.musicSetGo:GetComponent("MusicSetController")

	manager.ui:SetMainCamera("musicSet")

	self.speedNum = 0
	self.judgeNum = 0
	self.screanNum = 0
	self.showMovie = true
	self.test = true
	self.ratingController = ControllerUtil.GetController(self.transform_, "rating")
end

function EnternalMusicSettingView:InitUI()
	self:BindCfgUI()

	self.m_speedSlider.minValue = var_0_2
	self.m_speedSlider.maxValue = var_0_1
	self.m_judgeSlider.minValue = var_0_4
	self.m_judgeSlider.maxValue = var_0_3
	self.m_screanSlider.minValue = var_0_6
	self.m_screanSlider.maxValue = var_0_5
	self.m_volumeSlider.minValue = var_0_8
	self.m_volumeSlider.maxValue = var_0_7
	self.testController = ControllerUtil.GetController(self.transform_, "test")
	self.vedioController = ControllerUtil.GetController(self.transform_, "vedio")
end

function EnternalMusicSettingView:AddUIListener()
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
	self:AddBtnListener(self.m_vedioOn, nil, function()
		self:ChangeVedioBool(true)
	end)
	self:AddBtnListener(self.m_vedioOff, nil, function()
		self:ChangeVedioBool(false)
	end)
end

function EnternalMusicSettingView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function EnternalMusicSettingView:OnEnter()
	manager.ui:SetMainCamera("musicSet")
	self.ratingController:SetSelectedIndex(0)
	self:InitBackScene()

	self.speedNum = MusicData:GetSpeedValue()
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

	self.showMovie = MusicData:GetShowMovie()

	self.vedioController:SetSelectedIndex(self.showMovie and 1 or 0)

	self.test = self.musicSetController.autoClick

	self.testController:SetSelectedIndex(self.test and 1 or 0)
	SetActive(self.musicSetGo, true)

	self.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	self.musicSetController:Begain()
end

function EnternalMusicSettingView:OnExit()
	manager.windowBar:HideBar()

	if self.raycaster then
		Object.Destroy(self.raycaster_)
	end

	self.musicSetController:End()
	SetActive(self.musicSetGo, false)
	MusicData:SetSpeedValue(self.speedNum)
	MusicData:SetJudgeValue(self.judgeNum)
	MusicData:SetScreanValue(self.screanNum)
	MusicData:SetVolumeValue(self.volumeNum)
	MusicData:SetShoMovie(self.showMovie)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(self.speedNum),
		time = tostring(self.judgeNum)
	})

	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end
end

function EnternalMusicSettingView:ChangeSpeed()
	self.musicSetController.stayTime = 350 + (5 - self.speedNum) * (1500 - 350) / 4
end

function EnternalMusicSettingView:ChangeJudge()
	local var_26_0 = math.abs(self.judgeNum) / 50 * 300

	if self.judgeNum < 0 then
		var_26_0 = -1 * var_26_0
	end

	MusicGame.MusicSetController.latency = var_26_0
end

function EnternalMusicSettingView:ChangeScreen()
	local var_27_0 = math.abs(self.screanNum) / 50 * 300

	if self.screanNum < 0 then
		var_27_0 = -1 * var_27_0
	end

	MusicGame.MusicSetController.judgeLatency = var_27_0
end

function EnternalMusicSettingView:ChangeVolume()
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", math.abs(self.volumeNum) / 100)
end

function EnternalMusicSettingView:ChangeTestBool(arg_29_1)
	if self.test == arg_29_1 then
		return
	end

	self.test = arg_29_1

	self.testController:SetSelectedIndex(self.test and 1 or 0)

	self.musicSetController.autoClick = arg_29_1
end

function EnternalMusicSettingView:ChangeVedioBool(arg_30_1)
	if arg_30_1 == self.showMovie then
		return
	end

	self.showMovie = arg_30_1

	self.vedioController:SetSelectedIndex(self.showMovie and 1 or 0)
end

function EnternalMusicSettingView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(11, 11, 1)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/XuHeng1st_bg_00122")
end

function EnternalMusicSettingView:OnMusicSetNodeHit(arg_32_1, arg_32_2)
	SetActive(self.m_effect, false)
	SetActive(self.m_effect, true)

	if arg_32_1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == arg_32_2 or MusicConst.MusicNodeHitType.Long == arg_32_2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == arg_32_1 then
		self.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == arg_32_1 then
		self.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == arg_32_1 then
		self.ratingController:SetSelectedIndex(2)
	else
		self.ratingController:SetSelectedIndex(1)
	end
end

return EnternalMusicSettingView
