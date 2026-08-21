ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityReforgeMainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_REFORGE_GAMEHELPKEY"

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeMainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeChapterView", {
			ActivityID = arg_4_0.activityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_0_1),
			key = var_0_1
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
	arg_7_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_8_0)
	return
end

function var_0_0.UnBindRedPoint(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshTime()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.RefreshTime(arg_12_0)
	arg_12_0.stopTime_ = ActivityData:GetActivityData(arg_12_0.activityID_).stopTime

	if manager.time:GetServerTime() < arg_12_0.stopTime_ then
		arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_12_0.stopTime_)
	else
		arg_12_0:StopTimer()

		arg_12_0.timeText_.text = GetTips("TIME_OVER")
	end

	arg_12_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < arg_12_0.stopTime_ then
			arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_12_0.stopTime_)
		else
			arg_12_0:StopTimer()

			arg_12_0.timeText_.text = GetTips("TIME_OVER")
		end
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.Show(arg_14_0, arg_14_1)
	var_0_0.super.Show(arg_14_0, arg_14_1)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:StopTimer()
	arg_15_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopTimer()
	arg_16_0:RemoveAllListeners()
	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
