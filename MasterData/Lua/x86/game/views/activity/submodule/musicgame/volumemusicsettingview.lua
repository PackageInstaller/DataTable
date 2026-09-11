local VolumeMusicSettingView = class("VolumeMusicSettingView", ReduxView)
local var_0_1 = 5
local var_0_2 = 1
local var_0_3 = 50
local var_0_4 = -50

function VolumeMusicSettingView:UIName()
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettingUI"
end

function VolumeMusicSettingView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeMusicSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicSettingView:InitUI()
	self:BindCfgUI()

	self.m_speedSlider.minValue = var_0_2
	self.m_speedSlider.maxValue = var_0_1
	self.m_judgeSlider.minValue = var_0_4
	self.m_judgeSlider.maxValue = var_0_3
	self.movieController = ControllerUtil.GetController(self.m_movieBtn.transform, "select")
	self.soundController = ControllerUtil.GetController(self.m_soundBtn.transform, "select")
end

function VolumeMusicSettingView:AddUIListener()
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_confirmBtn, nil, function()
		MusicData:SetSpeedValue(self.speedNum)
		MusicData:SetJudgeValue(self.judgeNum)
		MusicData:SetShoMovie(self.showMovie)
		MusicData:SetPlayKeyEffectSound(self.playSound)
		SDKTools.SendMessageToSDK("activity_music_setting", {
			activity_id = ActivityConst.VOLUME_MUSIC,
			speed = tostring(self.speedNum),
			time = tostring(self.judgeNum)
		})
		self:Back()
	end)
	self.m_speedSlider.onValueChanged:AddListener(function()
		self.speedNum = tonumber((string.format("%.1f", self.m_speedSlider.value)))
		self.m_speedLab.text = self.speedNum
	end)
	self:AddPressingByTimeListener(self.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.speedNum < var_0_1 then
			self.speedNum = self.speedNum + 0.1
			self.speedNum = math.min(self.speedNum, var_0_1)
			self.m_speedSlider.value = self.speedNum
			self.m_speedLab.text = self.speedNum

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

			return true
		end

		return false
	end)
	self.m_judgeSlider.onValueChanged:AddListener(function()
		self.judgeNum = tonumber((string.format("%.0f", self.m_judgeSlider.value)))
		self.m_judgeLab.text = self.judgeNum
	end)
	self:AddPressingByTimeListener(self.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function()
		if self.judgeNum < var_0_3 then
			self.judgeNum = self.judgeNum + 1
			self.judgeNum = math.min(self.judgeNum, var_0_3)
			self.m_judgeSlider.value = self.judgeNum
			self.m_judgeLab.text = self.judgeNum

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

			return true
		end

		return false
	end)
	self:AddBtnListener(self.m_movieBtn, nil, function()
		self.showMovie = not self.showMovie

		self.movieController:SetSelectedIndex(self.showMovie and 1 or 0)
	end)
	self:AddBtnListener(self.m_soundBtn, nil, function()
		self.playSound = not self.playSound

		self.soundController:SetSelectedIndex(self.playSound and 1 or 0)
	end)
end

function VolumeMusicSettingView:OnTop()
	manager.windowBar:SwitchBar({})
end

function VolumeMusicSettingView:OnEnter()
	self.speedNum = MusicData:GetSpeedValue()
	self.m_speedSlider.value = self.speedNum
	self.m_speedLab.text = self.speedNum
	self.judgeNum = MusicData:GetJudgeValue()
	self.m_judgeSlider.value = self.judgeNum
	self.m_judgeLab.text = self.judgeNum
	self.showMovie = MusicData:GetShowMovie()

	self.movieController:SetSelectedIndex(self.showMovie and 1 or 0)

	self.playSound = MusicData:GetPlayKeyEffectSound()

	self.soundController:SetSelectedIndex(self.playSound and 1 or 0)
end

function VolumeMusicSettingView:OnExit()
	manager.windowBar:HideBar()
end

function VolumeMusicSettingView:Dispose()
	VolumeMusicSettingView.super.Dispose(self)
end

return VolumeMusicSettingView
