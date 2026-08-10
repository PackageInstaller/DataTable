ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityHeroLetterEnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return ActivityHeroLetterTools.GetEnterUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityHeroLetter", {
			isEnter = true,
			activityID = arg_4_0.activityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.tipBtn_, nil, function()
		local var_6_0 = ActivityHeroLetterTools.GetHelpKey(arg_4_0.activityID_)

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

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
	arg_7_0:BindRedPointUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshTime()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.activityData_ = ActivityData:GetActivityData(arg_9_0.activityID_)
	arg_9_0.startTime_ = arg_9_0.activityData_.startTime
	arg_9_0.stopTime_ = arg_9_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_10_0.stopTime_)
	arg_10_0.timer_ = Timer.New(function()
		arg_10_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_10_0.stopTime_)
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. arg_13_0.activityID_)
end

function var_0_0.UnbindRedPointUI(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. arg_14_0.activityID_)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:StopTimer()
	arg_15_0:UnbindRedPointUI()
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
