ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityReforgeMainView = class("ActivityReforgeMainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_REFORGE_GAMEHELPKEY"

function ActivityReforgeMainView:GetUIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeMainUI"
end

function ActivityReforgeMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeMainView:InitUI()
	self:BindCfgUI()
end

function ActivityReforgeMainView:AddUIListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeChapterView", {
			ActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
end

function ActivityReforgeMainView:OnEnter()
	self:RefreshUI()
	self:BindRedPoint()
end

function ActivityReforgeMainView:BindRedPoint()
	return
end

function ActivityReforgeMainView:UnBindRedPoint()
	return
end

function ActivityReforgeMainView:RefreshUI()
	self:RefreshTime()
end

function ActivityReforgeMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityReforgeMainView:RefreshTime()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	else
		self:StopTimer()

		self.timeText_.text = GetTips("TIME_OVER")
	end

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < self.stopTime_ then
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		else
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityReforgeMainView:Show(arg_14_1)
	ActivityReforgeMainView.super.Show(self, arg_14_1)
end

function ActivityReforgeMainView:OnExit()
	self:StopTimer()
	self:UnBindRedPoint()
end

function ActivityReforgeMainView:Dispose()
	self:StopTimer()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityReforgeMainView
