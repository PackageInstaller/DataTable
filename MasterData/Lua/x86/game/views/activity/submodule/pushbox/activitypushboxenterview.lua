ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityPushBoxEnterView = class("ActivityPushBoxEnterView", ActivityMainBasePanel)

function ActivityPushBoxEnterView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryMainUI"
end

function ActivityPushBoxEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxEnterView:InitUI()
	self:BindCfgUI()
end

function ActivityPushBoxEnterView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		if "ACTIVITY_PUSH_BOX_DESC" ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips("ACTIVITY_PUSH_BOX_DESC"),
				key = "ACTIVITY_PUSH_BOX_DESC"
			})
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.activityData_:IsActivitying() then
			JumpTools.OpenPageByJump("/activityPushBoxMain", {
				activityID = self.activityID_
			})
		end
	end)
end

function ActivityPushBoxEnterView:OnEnter()
	self:RefreshUI()
	self:BindRedPointUI()
end

function ActivityPushBoxEnterView:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
end

function ActivityPushBoxEnterView:RefreshData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPushBoxEnterView:RefreshTime()
	self:StopTimer()

	local var_10_0 = manager.time:GetServerTime()

	if var_10_0 < self.startTime_ then
		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if self.startTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_10_0 < self.stopTime_ then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		self.timer_ = Timer.New(function()
			if self.stopTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")
	end
end

function ActivityPushBoxEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPushBoxEnterView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. self.activityID_)
end

function ActivityPushBoxEnterView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. self.activityID_)
end

function ActivityPushBoxEnterView:OnExit()
	self:StopTimer()
	self:UnbindRedPointUI()
	self:RemoveAllEventListener()
end

function ActivityPushBoxEnterView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityPushBoxEnterView
