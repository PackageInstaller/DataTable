ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("SpringFestivalMainView", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/NewyearMainUI"
end

function var_0_0.InitSubmoduleButton(arg_2_0)
	arg_2_0.submoduleBtnList_ = {
		SpringFestivalGreetingSubmoduleItem.New(arg_2_0.springFestivalGreetingGo_, ActivityConst.SPRING_FESTIVAL_GREETING),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.paperCutGo_, ActivityConst.PAPER_CUT_GAME),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.btn2_, ActivityConst.SPRING_ANTITHETICAL_COUPLET),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.riddleGo_, ActivityConst.SPRING_FESTIVAL_RIDDLE),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.canteenGo_, ActivityConst.SPRING_CANTEEN, function()
			local var_3_0 = GameSetting.activity_festival_canteen_plot.value[1]

			if var_3_0 and not manager.story:IsStoryPlayed(var_3_0) then
				manager.story:StartStoryById(var_3_0, function(arg_4_0)
					DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
					ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
				end)
			else
				DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
				ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
			end
		end),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.btn5_, ActivityConst.FIRE_WORK, function()
			local var_5_0 = GameSetting.activity_firework_unlock_pre_story.value[1]

			if not manager.story:IsStoryPlayed(var_5_0) then
				local var_5_1 = StoryCfg[var_5_0]

				ShowTips(string.format(GetTips("FIRE_WORK_LOCK_STORY"), var_5_1.name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.FIRE_WORK)
		end),
		ActivitySubmoduleWithSpineItem.New(arg_2_0.btn4_, ActivityConst.NIEN_WORLD_BOSS, function()
			local var_6_0 = GameSetting.activity_firework_story.value[1]

			if not manager.story:IsStoryPlayed(var_6_0) then
				local var_6_1 = StoryCfg[var_6_0]

				ShowTips(string.format(GetTips("ACTIVITY_WORLD_BOSS_LOCK_STORY"), var_6_1.name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.NIEN_WORLD_BOSS)
		end)
	}
end

function var_0_0.GetActivityID(arg_7_0)
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function var_0_0.UnbindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function var_0_0.OnEnter(arg_10_0)
	var_0_0.super.OnEnter(arg_10_0)
	arg_10_0:BindRedPoint()
	arg_10_0:AddTimer()
	TimeTools.StartAfterSeconds(0.033, function()
		if manager.guide:IsPlaying() then
			local var_11_0 = arg_10_0.scrollContent_.localPosition

			var_11_0.x = -400
			arg_10_0.scrollContent_.localPosition = var_11_0
		end
	end, {})
end

function var_0_0.OnExit(arg_12_0)
	var_0_0.super.OnExit(arg_12_0)
	arg_12_0:UnbindRedPoint()
	arg_12_0:StopTimer()
end

function var_0_0.RefreshUI(arg_13_0)
	return
end

function var_0_0.AddListeners(arg_14_0)
	return
end

function var_0_0.AddTimer(arg_15_0)
	local var_15_0 = arg_15_0:GetActivityID()

	arg_15_0.stopTime_ = ActivityData:GetActivityData(var_15_0).stopTime

	arg_15_0:StopTimer()

	if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
		arg_15_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_15_0.textTime_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
	arg_15_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
			arg_15_0:StopTimer()

			arg_15_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_15_0.textTime_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

return var_0_0
