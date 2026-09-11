ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local SpringFestivalMainView = class("SpringFestivalMainView", ActivityMainBaseView)

function SpringFestivalMainView:UIName()
	return "UI/EmptyDream/NewyearMainUI"
end

function SpringFestivalMainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		SpringFestivalGreetingSubmoduleItem.New(self.springFestivalGreetingGo_, ActivityConst.SPRING_FESTIVAL_GREETING),
		ActivitySubmoduleWithSpineItem.New(self.paperCutGo_, ActivityConst.PAPER_CUT_GAME),
		ActivitySubmoduleWithSpineItem.New(self.btn2_, ActivityConst.SPRING_ANTITHETICAL_COUPLET),
		ActivitySubmoduleWithSpineItem.New(self.riddleGo_, ActivityConst.SPRING_FESTIVAL_RIDDLE),
		ActivitySubmoduleWithSpineItem.New(self.canteenGo_, ActivityConst.SPRING_CANTEEN, function()
			if GameSetting.activity_festival_canteen_plot.value[1] and not manager.story:IsStoryPlayed(GameSetting.activity_festival_canteen_plot.value[1]) then
				manager.story:StartStoryById(GameSetting.activity_festival_canteen_plot.value[1], function(arg_4_0)
					DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
					ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
				end)
			else
				DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
				ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
			end
		end),
		ActivitySubmoduleWithSpineItem.New(self.btn5_, ActivityConst.FIRE_WORK, function()
			if not manager.story:IsStoryPlayed(GameSetting.activity_firework_unlock_pre_story.value[1]) then
				ShowTips(string.format(GetTips("FIRE_WORK_LOCK_STORY"), StoryCfg[GameSetting.activity_firework_unlock_pre_story.value[1]].name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.FIRE_WORK)
		end),
		ActivitySubmoduleWithSpineItem.New(self.btn4_, ActivityConst.NIEN_WORLD_BOSS, function()
			if not manager.story:IsStoryPlayed(GameSetting.activity_firework_story.value[1]) then
				ShowTips(string.format(GetTips("ACTIVITY_WORLD_BOSS_LOCK_STORY"), StoryCfg[GameSetting.activity_firework_story.value[1]].name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.NIEN_WORLD_BOSS)
		end)
	}
end

function SpringFestivalMainView:GetActivityID()
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY
end

function SpringFestivalMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function SpringFestivalMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function SpringFestivalMainView:OnEnter()
	SpringFestivalMainView.super.OnEnter(self)
	self:BindRedPoint()
	self:AddTimer()
	TimeTools.StartAfterSeconds(0.033, function()
		if manager.guide:IsPlaying() then
			self.scrollContent_.localPosition.x = -400
			self.scrollContent_.localPosition = self.scrollContent_.localPosition
		end
	end, {})
end

function SpringFestivalMainView:OnExit()
	SpringFestivalMainView.super.OnExit(self)
	self:UnbindRedPoint()
	self:StopTimer()
end

function SpringFestivalMainView:RefreshUI()
	return
end

function SpringFestivalMainView:AddListeners()
	return
end

function SpringFestivalMainView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData((self:GetActivityID())).stopTime

	self:StopTimer()

	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function SpringFestivalMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SpringFestivalMainView
