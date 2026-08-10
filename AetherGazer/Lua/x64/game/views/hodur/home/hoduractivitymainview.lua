ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("HodurActivityMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_MainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		local var_5_0 = "ACTIVITY_HODUR_INFO_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.limitRewardBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		HodurTools.GotoMainlineView()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.HODUR_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_HODUR_MAIN)
	arg_8_0:UpdatePreview()
	arg_8_0:RefreshLimitTime()
end

function var_0_0.RefreshLimitTime(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
		SetActive(arg_9_0.limitRewardBtn_.gameObject, true)

		arg_9_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	else
		SetActive(arg_9_0.limitRewardBtn_.gameObject, false)
	end

	arg_9_0:LimitStopTimer()

	if arg_9_0.limittimer_ == nil then
		arg_9_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_9_0.activityID_) then
				arg_9_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
			else
				if manager.time:GetServerTime() < var_9_0.startTime then
					arg_9_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_9_0.startTime))
				elseif manager.time:GetServerTime() > var_9_0.stopTime then
					arg_9_0.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(arg_9_0.limitRewardBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	arg_9_0.limittimer_:Start()
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.LimitStopTimer(arg_13_0)
	if arg_13_0.limittimer_ then
		arg_13_0.limittimer_:Stop()

		arg_13_0.limittimer_ = nil
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:LimitStopTimer()
	manager.redPoint:unbindUIandKey(arg_14_0.rewardRedRoot_.transform)
	manager.redPoint:unbindUIandKey(arg_14_0.goBtn_.transform)
	var_0_0.super.OnExit(arg_14_0)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:LimitStopTimer()
	arg_15_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
