ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityHeroLetterEnterView = class("ActivityHeroLetterEnterView", ActivityMainBasePanel)

function ActivityHeroLetterEnterView:GetUIName()
	return ActivityHeroLetterTools.GetEnterUIName(self.activityID_)
end

function ActivityHeroLetterEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityHeroLetterEnterView:InitUI()
	self:BindCfgUI()
end

function ActivityHeroLetterEnterView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityHeroLetter", {
			isEnter = true,
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.tipBtn_, nil, function()
		local var_6_0 = ActivityHeroLetterTools.GetHelpKey(self.activityID_)

		if var_6_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_6_0),
				key = var_6_0
			})
		end
	end)
end

function ActivityHeroLetterEnterView:OnEnter()
	self:RefreshUI()
	self:BindRedPointUI()
end

function ActivityHeroLetterEnterView:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
end

function ActivityHeroLetterEnterView:RefreshData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityHeroLetterEnterView:RefreshTime()
	self:StopTimer()

	self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	self.timer_ = Timer.New(function()
		self.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityHeroLetterEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityHeroLetterEnterView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. self.activityID_)
end

function ActivityHeroLetterEnterView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. self.activityID_)
end

function ActivityHeroLetterEnterView:OnExit()
	self:StopTimer()
	self:UnbindRedPointUI()
	self:RemoveAllEventListener()
end

function ActivityHeroLetterEnterView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityHeroLetterEnterView
