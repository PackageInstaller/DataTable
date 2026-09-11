local LevelUpView = class("LevelUpView", (import("game.views.pop.PopFramingBaseView")))

function LevelUpView:UIName()
	return "Widget/Common/Pop/PlayerlvlpopUI"
end

function LevelUpView:UIParent()
	return manager.ui.uiPop.transform
end

function LevelUpView:Init()
	self:InitUI()
	self:AddListeners()
end

function LevelUpView:InitUI()
	self:BindCfgUI()

	self.animatorList_ = {
		self.animator_1
	}
end

function LevelUpView:OnEnter()
	self:RefreshUI()

	self.timer_ = FrameTimer.New(function()
		self:Update()
	end, 1, -1)

	self.timer_:Start()

	self.callBack_ = self.params_.callback
end

function LevelUpView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.callBack_ then
		self.callBack_()
	end
end

function LevelUpView:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back(true)
	end)
end

function LevelUpView:RemoveListeners()
	return
end

function LevelUpView:OnSubscribe()
	self:RefreshUI()
end

function LevelUpView:RefreshUI()
	local var_12_0 = 0

	for iter_12_0 = self.params_.levelUpInfoList[1].fromLevel + 1, self.params_.levelUpInfoList[#self.params_.levelUpInfoList].toLevel do
		var_12_0 = var_12_0 + GameLevelSetting[iter_12_0].fatigue_upgrade_reward
	end

	self.fromLevelText_.text = tostring(self.params_.levelUpInfoList[1].fromLevel)
	self.toLevelText_.text = tostring(self.params_.levelUpInfoList[#self.params_.levelUpInfoList].toLevel)
	self.getFatigueText_.text = string.format("+%d", var_12_0)
	self.fatigueUpLimitText_.text = string.format("%d(+%d)", GameLevelSetting[self.params_.levelUpInfoList[#self.params_.levelUpInfoList].toLevel].fatigue_max, GameLevelSetting[self.params_.levelUpInfoList[#self.params_.levelUpInfoList].toLevel].fatigue_max - GameLevelSetting[self.params_.levelUpInfoList[1].fromLevel].fatigue_max)
end

function LevelUpView:Update()
	return
end

function LevelUpView:Dispose()
	LevelUpView.super.Dispose(self)
end

return LevelUpView
