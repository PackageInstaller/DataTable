local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivityWuluoVehicleEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_MainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/activityWuluoVehicleMainView")
	end)
	arg_4_0:AddBtnListener(arg_4_0.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityWuluoVehicleLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "MERGE_BALL_ENTRANCE_DESC",
			content = GetTips("MERGE_BALL_ENTRANCE_DESC")
		})
	end)
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0.super.OnEnter(arg_8_0)
	arg_8_0:RefreshRewardTime()
	arg_8_0:BindRedPoint()
end

function var_0_1.OnTop(arg_9_0)
	return
end

function var_0_1.OnExit(arg_10_0)
	arg_10_0:LimitStopTimer()
	arg_10_0:UnBindRedPoint()
	var_0_1.super.OnExit(arg_10_0)
end

function var_0_1.Dispose(arg_11_0)
	arg_11_0.super.Dispose(arg_11_0)
end

function var_0_1.RefreshRewardTime(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)

	arg_12_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

	SetActive(arg_12_0.limitRewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK))

	if arg_12_0.limittimer_ == nil then
		arg_12_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK) then
				arg_12_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				SetActive(arg_12_0.limitRewardBtn_.gameObject, false)
				arg_12_0:LimitStopTimer()
			end
		end, 1, -1)
	end

	arg_12_0.limittimer_:Start()
end

function var_0_1.LimitStopTimer(arg_14_0)
	if arg_14_0.limittimer_ then
		arg_14_0.limittimer_:Stop()

		arg_14_0.limittimer_ = nil
	end
end

function var_0_1.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.goBtn_.transform, ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
	manager.redPoint:bindUIandKey(arg_15_0.limitRewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
end

function var_0_1.UnBindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.goBtn_.transform, ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN)
	manager.redPoint:unbindUIandKey(arg_16_0.limitRewardBtn_.transform, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK)
end

return var_0_1
