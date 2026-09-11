ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local OsirisPlayGameMainView = class("OsirisPlayGameMainView", ActivityMainBasePanel)

function OsirisPlayGameMainView:GetUIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_MainUI"
end

function OsirisPlayGameMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function OsirisPlayGameMainView:InitUI()
	self:BindCfgUI()
end

function OsirisPlayGameMainView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_5_0 = {
			content = GetTips("ACTIVITY_GENERALITY_DESC")
		}

		var_5_0.key = "ACTIVITY_GENERALITY_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameLimitRewardView", {
			activityID = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameEnterView", {
			activityID_ = self.activityID_
		})
	end)
end

function OsirisPlayGameMainView:OnEnter()
	OsirisPlayGameMainView.super.OnEnter(self)
	self:UpdatePreview()
	self:RefreshLimitTime()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)
	end

	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_MAIN .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME)
end

function OsirisPlayGameMainView:RefreshLimitTime()
	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK) then
		SetActive(self.limitRewardBtn_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	else
		SetActive(self.limitRewardBtn_.gameObject, false)
	end

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
			else
				if manager.time:GetServerTime() < var_9_0.startTime then
					self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_9_0.startTime))
				elseif manager.time:GetServerTime() > var_9_0.stopTime then
					self.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(self.limitRewardBtn_, false)
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function OsirisPlayGameMainView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function OsirisPlayGameMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function OsirisPlayGameMainView:OnTop()
	self:UpdateBar()
end

function OsirisPlayGameMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function OsirisPlayGameMainView:OnExit()
	self:LimitStopTimer()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)
	end

	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_MAIN .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME)
	OsirisPlayGameMainView.super.OnExit(self)
end

function OsirisPlayGameMainView:Dispose()
	self:RemoveAllListeners()
	OsirisPlayGameMainView.super.Dispose(self)
end

return OsirisPlayGameMainView
