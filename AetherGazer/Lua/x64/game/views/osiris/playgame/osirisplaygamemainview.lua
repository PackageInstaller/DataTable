ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("OsirisPlayGameMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_MainUI"
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
		local var_5_0 = "ACTIVITY_GENERALITY_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameLimitRewardView", {
			activityID = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameEnterView", {
			activityID_ = arg_4_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)
	arg_8_0:UpdatePreview()
	arg_8_0:RefreshLimitTime()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		local var_8_0 = RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK

		manager.redPoint:bindUIandKey(arg_8_0.limitRewardBtn_.transform, var_8_0)
	end

	local var_8_1 = RedPointConst.OSIRIS_PLAY_GAME_MAIN .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME

	manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, var_8_1)
end

function var_0_0.RefreshLimitTime(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK) then
		SetActive(arg_9_0.limitRewardBtn_.gameObject, true)

		arg_9_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	else
		SetActive(arg_9_0.limitRewardBtn_.gameObject, false)
	end

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

				SetActive(arg_9_0.limitRewardBtn_, false)
			end
		end, 1, -1)
	end

	arg_9_0.limittimer_:Start()
end

function var_0_0.RefreshTimeText(arg_11_0)
	if arg_11_0.timeText_ then
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_11_0.stopTime_, true)
	end
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.LimitStopTimer(arg_14_0)
	if arg_14_0.limittimer_ then
		arg_14_0.limittimer_:Stop()

		arg_14_0.limittimer_ = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:LimitStopTimer()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		local var_15_0 = RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK

		manager.redPoint:unbindUIandKey(arg_15_0.limitRewardBtn_.transform, var_15_0)
	end

	local var_15_1 = RedPointConst.OSIRIS_PLAY_GAME_MAIN .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME

	manager.redPoint:unbindUIandKey(arg_15_0.goBtn_.transform, var_15_1)
	var_0_0.super.OnExit(arg_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
