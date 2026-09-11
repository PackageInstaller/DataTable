ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local HodurActivityMainView = class("HodurActivityMainView", ActivityMainBasePanel)

function HodurActivityMainView:GetUIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_MainUI"
end

function HodurActivityMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HodurActivityMainView:InitUI()
	self:BindCfgUI()
end

function HodurActivityMainView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_5_0 = {
			content = GetTips("ACTIVITY_HODUR_INFO_TIP")
		}

		var_5_0.key = "ACTIVITY_HODUR_INFO_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		HodurTools.GotoMainlineView()
	end)
end

function HodurActivityMainView:OnEnter()
	HodurActivityMainView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.HODUR_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_HODUR_MAIN)
	self:UpdatePreview()
	self:RefreshLimitTime()
end

function HodurActivityMainView:RefreshLimitTime()
	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
		SetActive(self.limitRewardBtn_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	else
		SetActive(self.limitRewardBtn_.gameObject, false)
	end

	self:LimitStopTimer()

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

				SetActive(self.limitRewardBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function HodurActivityMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HodurActivityMainView:OnTop()
	self:UpdateBar()
end

function HodurActivityMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function HodurActivityMainView:OnExit()
	self:LimitStopTimer()
	manager.redPoint:unbindUIandKey(self.rewardRedRoot_.transform)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform)
	HodurActivityMainView.super.OnExit(self)
end

function HodurActivityMainView:Dispose()
	self:LimitStopTimer()
	self:RemoveAllListeners()
	HodurActivityMainView.super.Dispose(self)
end

return HodurActivityMainView
