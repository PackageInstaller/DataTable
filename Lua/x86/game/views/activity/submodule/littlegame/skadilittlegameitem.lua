local var_0_0 = class("SkadiLittleGameItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2
	arg_1_0.activityID_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.starController_ = ControllerUtil.GetController(arg_1_0.starsGo_.transform, "name")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.name1Text_.text = GetI18NText(ActivityCrossWaveCfg[arg_2_0.chapterID_].name)
	arg_2_0.name2Text_.text = GetI18NText(ActivityCrossWaveCfg[arg_2_0.chapterID_].name)

	arg_2_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, arg_2_0.activityID_))
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, arg_3_0.activityID_))
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBtn_, nil, function()
		if manager.time:GetServerTime() < arg_5_0:GetOpenTimestamp() then
			local var_6_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_0, manager.time:GetLostTimeStr(arg_5_0:GetOpenTimestamp())))

			return
		end

		local var_6_1 = ActivityCrossWaveCfg[arg_5_0.chapterID_].stage_id

		arg_5_0:Go("skadiSectionInfo", {
			activityID = arg_5_0.activityID_,
			chapterID = arg_5_0.chapterID_,
			section = var_6_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKADI_GAME
		})
	end)
end

function var_0_0.GetOpenTimestamp(arg_7_0)
	return ActivityData:GetActivityData(arg_7_0.chapterID_).startTime or 0
end

function var_0_0.GetStopTimestamp(arg_8_0)
	return ActivityData:GetActivityData(arg_8_0.chapterID_).stop_time
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:RefreshState()

	local var_9_0 = manager.time:GetServerTime() - arg_9_0:GetOpenTimestamp()

	if var_9_0 >= 0 then
		return
	end

	local var_9_1 = manager.time:GetLostTimeStr(arg_9_0:GetOpenTimestamp())

	arg_9_0.countdownText_.text = string.format(GetTips("OPEN_TIME"), var_9_1)

	arg_9_0:StopTimer()

	arg_9_0.timer_ = Timer.New(function()
		var_9_0 = manager.time:GetServerTime() - arg_9_0:GetOpenTimestamp()

		arg_9_0:RefreshState()

		local var_10_0 = manager.time:GetLostTimeStr(arg_9_0:GetOpenTimestamp())

		arg_9_0.countdownText_.text = string.format(GetTips("OPEN_TIME"), var_10_0)

		if var_9_0 >= 0 then
			arg_9_0:StopTimer()
		end
	end, 1, -1)

	arg_9_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.RefreshState(arg_12_0)
	if manager.time:GetServerTime() < arg_12_0:GetOpenTimestamp() then
		arg_12_0.controller_:SetSelectedState("close")

		return
	end

	local var_12_0 = table.length(SummerLittleGameData:GetSkadiStars(arg_12_0.chapterID_))

	arg_12_0.starController_:SetSelectedState(var_12_0)

	if manager.time:GetServerTime() >= arg_12_0:GetOpenTimestamp() then
		arg_12_0.controller_:SetSelectedState("normal")

		return
	end
end

function var_0_0.IsOpen(arg_13_0)
	if manager.time:GetServerTime() >= arg_13_0:GetOpenTimestamp() then
		return true
	end

	return false
end

return var_0_0
