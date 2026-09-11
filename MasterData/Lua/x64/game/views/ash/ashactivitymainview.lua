ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local AshActivityMainView = class("AshActivityMainView", ActivityMainBasePanel)

function AshActivityMainView:GetUIName()
	return "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_MainUI"
end

function AshActivityMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshActivityMainView:InitUI()
	self:BindCfgUI()
end

function AshActivityMainView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_5_0 = {
			content = GetTips("ASH_ENTRANCE_TIP")
		}

		var_5_0.key = "ASH_ENTRANCE_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/cowBoyHomeView")
	end)
end

function AshActivityMainView:OnEnter()
	AshActivityMainView.super.OnEnter(self)
	self:UpdatePreview()
	self:RefreshLimitTime()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ASH_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_ASH_MAIN)
	manager.redPoint:bindUIandKey(self.rewardRedRoot_.transform, RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
end

function AshActivityMainView:RefreshLimitTime()
	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
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

function AshActivityMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AshActivityMainView:OnTop()
	self:UpdateBar()
end

function AshActivityMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AshActivityMainView:OnExit()
	self:LimitStopTimer()
	manager.redPoint:unbindUIandKey(self.rewardRedRoot_.transform)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform)
	AshActivityMainView.super.OnExit(self)
end

function AshActivityMainView:Dispose()
	self:LimitStopTimer()
	self:RemoveAllListeners()
	AshActivityMainView.super.Dispose(self)
end

return AshActivityMainView
