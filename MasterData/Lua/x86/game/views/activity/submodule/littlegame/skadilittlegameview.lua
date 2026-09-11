local SkadiLittleGameView = class("SkadiLittleGameView", ReduxView)

function SkadiLittleGameView:UIName()
	return "UI/VersionUI/SummerUI/SummerSkadiGameUI"
end

function SkadiLittleGameView:UIParent()
	return manager.ui.uiMain.transform
end

function SkadiLittleGameView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function SkadiLittleGameView:AddUIListener()
	self:AddBtnListener(self.buttonBtn_, nil, function()
		JumpTools.OpenPageByJump("skadiGameReward")
	end)
end

function SkadiLittleGameView:InitBtns()
	if not self.itemView_ then
		self.itemView_ = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
			self.itemView_[iter_6_1] = SkadiLittleGameItem.New(self[string.format("item%dGo_", iter_6_0)], iter_6_1, self.activityID_)
		end
	end
end

function SkadiLittleGameView:OnTop()
	local var_7_0 = ActivityTools.GetGameHelpKey(self.activityID_)

	if var_7_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_7_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function SkadiLittleGameView:OnEnter()
	self.activityID_ = ActivityConst.SIKADI_GAME

	self:InitBtns()

	for iter_8_0, iter_8_1 in pairs(self.itemView_) do
		iter_8_1:OnEnter()
	end

	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.detailText_.text = GetTips("ACTIVITY__CROSSWAVE_CONTENT")

	self:AddTimer()
	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(self.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function SkadiLittleGameView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs(self.itemView_) do
		iter_9_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function SkadiLittleGameView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.itemView_) do
		iter_10_1:Dispose()
	end

	self.itemView_ = nil

	SkadiLittleGameView.super.Dispose(self)
end

function SkadiLittleGameView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 0.5, -1)

	self.timer_:Start()
end

function SkadiLittleGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SkadiLittleGameView
