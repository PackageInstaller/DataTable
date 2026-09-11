local MoonBoResultView = class("MoonBoResultView", ReduxView)

function MoonBoResultView:UIName()
	return "UI/VolumeIIIUI/VolumeBocakeResultUI"
end

function MoonBoResultView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonBoResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function MoonBoResultView:InitUI()
	self:BindCfgUI()

	self.longController_ = ControllerUtil.GetController(self.gameObject_.transform, "IsShowLong")
	self.shortController_ = ControllerUtil.GetController(self.gameObject_.transform, "IsShowShort")
	self.discControllers_ = {}
	self.discControllers_[1] = ControllerUtil.GetController(self.diceTrans1_, "num")
	self.discControllers_[2] = ControllerUtil.GetController(self.diceTrans2_, "num")
	self.discControllers_[3] = ControllerUtil.GetController(self.diceTrans3_, "num")
	self.discControllers_[4] = ControllerUtil.GetController(self.diceTrans4_, "num")
	self.discControllers_[5] = ControllerUtil.GetController(self.diceTrans5_, "num")
	self.discControllers_[6] = ControllerUtil.GetController(self.diceTrans6_, "num")
	self.isPlaying = false
	self.curFrame_ = 0
end

function MoonBoResultView:OnEnter()
	self:RefreshUI()

	self.settingData_ = SettingData:GetPicSettingData()

	local var_5_1 = self.settingData_.frame + 1 == 1 and 30 or 60

	self.timer_ = FrameTimer.New(function()
		self.curFrame_ = self.curFrame_ + 1

		if self.curFrame_ > var_5_1 * 2 then
			self.isPlaying = false
		end
	end, 1, (self.settingData_.frame + 1 == 1 and 30 or 60) * 2 + 10)

	self.timer_:Start()
end

function MoonBoResultView:RefreshUI()
	SetActive(self.liziGo1_, false)
	SetActive(self.liziGo2_, false)
	SetActive(self.liziGo3_, false)
	SetActive(self.liziGo4_, false)
	SetActive(self.liziGo5_, false)
	SetActive(self.liziGo6_, false)

	local var_7_0 = MoonBoData:GetCurDices()

	for iter_7_0 = 1, 6 do
		self.discControllers_[iter_7_0]:SetSelectedState(string.format("%s", var_7_0[iter_7_0]))
		SetActive(self.discControllers_[iter_7_0].gameObject, false)
	end

	if MoonBoData:GetCurLevel() == 0 then
		self.shortController_:SetSelectedState("false")
		self.longController_:SetSelectedState("false")
		self.noflashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		self.curDir_ = self.noflashDir_
		self.isPlaying = true
		self.curFrame_ = 0
	else
		self.shortController_:SetSelectedState("true")

		self.levelText_.color = Color.New(self.levelText_.color.r, self.levelText_.color.g, self.levelText_.color.b, 0)

		local var_7_1 = MoonBoData:LevelNumToLanguage(MoonBoData:GetCurLevel())

		self.levelText_.text = var_7_1

		if MoonBoData:GetIsShowText() then
			self.longController_:SetSelectedState("true")

			self.resultText_.color = Color.New(self.resultText_.color.r, self.resultText_.color.g, self.resultText_.color.b, 0)
			self.resultText_.text = string.format(GetTips("ACTIVITY_MOONCAKE_GAMBLING_REWARD_NONE"), var_7_1, var_7_1)
		else
			self.longController_:SetSelectedState("false")
		end

		self.flashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		self.curDir_ = self.flashDir_
		self.isPlaying = true
		self.curFrame_ = 0
	end
end

function MoonBoResultView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.isPlaying then
			self.isPlaying = false
			self.curDir_.time = 2

			manager.audio:StopEffect()
		else
			MoonBoData:SetIsShowReward(true)
			self:Back()
		end
	end)
end

function MoonBoResultView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MoonBoResultView:Dispose()
	MoonBoResultView.super.Dispose(self)
end

return MoonBoResultView
