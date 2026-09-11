local ActivityWuluoVehicleEnterView = class("ActivityWuluoVehicleEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivityWuluoVehicleEnterView:GetUIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_MainUI"
end

function ActivityWuluoVehicleEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivityWuluoVehicleEnterView:InitUI()
	self:BindCfgUI()
end

function ActivityWuluoVehicleEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/activityWuluoVehicleMainView")
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "MERGE_BALL_ENTRANCE_DESC",
			content = GetTips("MERGE_BALL_ENTRANCE_DESC")
		})
	end)
end

function ActivityWuluoVehicleEnterView:OnEnter()
	self.super.OnEnter(self)
	self:RefreshRewardTime()
	self:BindRedPoint()
end

function ActivityWuluoVehicleEnterView:OnTop()
	return
end

function ActivityWuluoVehicleEnterView:OnExit()
	self:LimitStopTimer()
	self:UnBindRedPoint()
	ActivityWuluoVehicleEnterView.super.OnExit(self)
end

function ActivityWuluoVehicleEnterView:Dispose()
	self.super.Dispose(self)
end

function ActivityWuluoVehicleEnterView:RefreshRewardTime()
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)

	self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

	SetActive(self.limitRewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				SetActive(self.limitRewardBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function ActivityWuluoVehicleEnterView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function ActivityWuluoVehicleEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
	manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
end

function ActivityWuluoVehicleEnterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
	manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
end

return ActivityWuluoVehicleEnterView
