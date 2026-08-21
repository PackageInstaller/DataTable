local var_0_0 = class("SummerChessBoardBaseBtn", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityID_ = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.stateController_ = arg_2_0.controllerEx_:GetController("state")
	arg_2_0.lockController_ = arg_2_0.controllerEx_:GetController("lock")
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		local var_5_0, var_5_1 = arg_4_0:IsUnlockActivity()

		if not var_5_0 then
			local var_5_2, var_5_3 = SummerChessBoardData:CallFun("GetUnlockTips", arg_4_0.activityID_)

			ShowTips(var_5_2)

			if var_5_3 == 2 then
				manager.notify:CallUpdateFunc(SUMMER_CHESS_BOARD_CLICK_LOCK_ACTIVITY)
			end

			return
		end

		if var_5_0 and var_5_1 ~= 0 and ActivityUnlockStateData:GetUnlockState(var_5_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
			ActivityUnlockStateAction.UpdateState(var_5_1, ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT, 1)
			manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_4_0.activityID_), 0, RedPointStyle.SHOW_NEW_TAG)
			arg_4_0.stateController_:SetSelectedState("normal")
		end

		SummerChessBoardData:CallFun("GotoGameWindow", arg_4_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshUI()
	arg_6_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_6_0.transform_, SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_6_0.activityID_))

	if arg_6_0.activityID_ == ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY and manager.redPoint:getTipValue(RedPointConst.MONSTER_COSPLAY_SKILL) > 0 then
		SetActive(arg_6_0.redGo_, true)
	end
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_7_0.transform_, SummerChessBoardData:CallFun("GetEntryRedPointKey", arg_7_0.activityID_))
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = ActivityData:GetActivityData(arg_8_0.activityID_)
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0.startTime then
		arg_8_0:RefreshTimeText(var_8_0.startTime)
	else
		arg_8_0:RefreshTimeText(var_8_0.stopTime)
	end

	if var_8_1 >= var_8_0.stopTime then
		arg_8_0:Show(false)

		return
	end

	arg_8_0:Show(true)

	arg_8_0.timer_ = Timer.New(function()
		local var_9_0 = ActivityData:GetActivityData(arg_8_0.activityID_)
		local var_9_1 = manager.time:GetServerTime()

		if var_9_1 < var_9_0.startTime then
			arg_8_0:RefreshTimeText(var_9_0.startTime)
		else
			arg_8_0:RefreshTimeText(var_9_0.stopTime)
		end

		if var_9_1 >= var_9_0.stopTime then
			arg_8_0:Show(false)
			arg_8_0:StopTimer()
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ActivityCfg[arg_11_0.activityID_]

	if var_11_0 == nil then
		return
	end

	arg_11_0.nameText_.text = var_11_0.remark
end

function var_0_0.IsUnlockActivity(arg_12_0)
	return SummerChessBoardData:CallFun("CurrentUnlockStageID", arg_12_0.activityID_)
end

function var_0_0.Show(arg_13_0, arg_13_1)
	if arg_13_1 then
		local var_13_0, var_13_1 = arg_13_0:IsUnlockActivity()

		if var_13_0 and var_13_1 ~= 0 then
			if ActivityUnlockStateData:GetUnlockState(var_13_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
				arg_13_0.stateController_:SetSelectedState("new")
			else
				arg_13_0.stateController_:SetSelectedState("normal")
			end

			arg_13_0.lockController_:SetSelectedState("false")
		else
			local var_13_2 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_13_0.activityID_] or {}

			if #var_13_2 <= 0 then
				arg_13_0.stateController_:SetSelectedState("normal")
			else
				arg_13_0.stateController_:SetSelectedState("lock")
			end

			if var_13_0 and #var_13_2 <= 0 then
				arg_13_0.lockController_:SetSelectedState("false")
			elseif ActivityTools.GetActivityStatus(arg_13_0.activityID_) == ActivityConst.ACTIVITY_STATE.ACTIVING then
				arg_13_0.lockController_:SetSelectedState("true")
			else
				arg_13_0.lockController_:SetSelectedState("timeLock")
			end
		end
	end

	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.RefreshTimeText(arg_14_0, arg_14_1)
	if arg_14_0.timeText_ then
		arg_14_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_14_1)
	end
end

return var_0_0
