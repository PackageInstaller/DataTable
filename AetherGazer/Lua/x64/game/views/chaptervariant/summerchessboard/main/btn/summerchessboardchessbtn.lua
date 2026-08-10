SummerChessBoardBaseBtn = import(".SummerChessBoardBaseBtn")

local var_0_0 = class("SummerChessBoardChessBtn", SummerChessBoardBaseBtn)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("explore")
	arg_1_0.finishController_ = arg_1_0.controllerEx_:GetController("finish")
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	local var_2_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	if ChessBoardLevelCfg[var_2_0] and ChessBoardLevelCfg[var_2_0].activity == arg_2_0.activityID_ then
		arg_2_0.selectController_:SetSelectedState("true")
	else
		arg_2_0.selectController_:SetSelectedState("false")
	end

	local var_2_1 = ChessBoardLevelCfg.get_id_list_by_activity[arg_2_0.activityID_]
	local var_2_2 = true

	if var_2_1 then
		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			local var_2_3 = SummerChessBoardTools.GetTaskIDByChessBoardID(arg_2_0.activityID_)
			local var_2_4 = SummerChessBoardData:CallFun("GetTaskIDListInLevelID", arg_2_0.activityID_, var_2_3, iter_2_1)

			if table.isEmpty(var_2_4) then
				var_2_2 = false
			else
				for iter_2_2, iter_2_3 in pairs(var_2_4) do
					local var_2_5 = AssignmentCfg[iter_2_3]
					local var_2_6 = TaskData2:GetTask(iter_2_3)

					if var_2_5.need > var_2_6.progress then
						var_2_2 = false

						break
					end
				end

				if var_2_2 == false then
					break
				end
			end
		end
	else
		var_2_2 = false
	end

	if var_2_2 then
		arg_2_0.finishController_:SetSelectedState("true")
	else
		arg_2_0.finishController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	var_0_0.super.AddListeners(arg_5_0)
end

function var_0_0.AddTimer(arg_6_0)
	arg_6_0:StopTimer()

	local var_6_0 = ActivityData:GetActivityData(arg_6_0.activityID_)
	local var_6_1 = ActivityData:GetActivityIsOpen(arg_6_0.activityID_)
	local var_6_2 = manager.time:GetServerTime()

	if not arg_6_0:IsUnlock() and var_6_1 == false then
		local var_6_3

		for iter_6_0, iter_6_1 in pairs(ActivityConst.SUMMER_CHESS_BOARD_SHOW_ACTIVITY) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				if arg_6_0.activityID_ == iter_6_3 then
					var_6_3 = iter_6_0
				end
			end
		end

		if not ActivityData:GetActivityIsOpen(var_6_3) then
			arg_6_0:Show(false)

			return
		end
	end

	arg_6_0:Show(true)
	arg_6_0:RefreshTimeText(var_6_0.startTime)

	arg_6_0.timer_ = Timer.New(function()
		local var_7_0 = ActivityData:GetActivityData(arg_6_0.activityID_)
		local var_7_1 = manager.time:GetServerTime()
		local var_7_2 = ActivityData:GetActivityData(arg_6_0.activityID_)

		if manager.time:GetServerTime() < var_7_2.startTime then
			arg_6_0:RefreshTimeText(var_7_2.startTime)
		else
			arg_6_0:RefreshTimeText(var_7_2.stopTime)
			arg_6_0:Show(true)
			arg_6_0:StopTimer()
		end
	end, 1, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.IsUnlock(arg_8_0)
	return SummerChessBoardData:CallFun("IsUnlockGamePlay", arg_8_0.activityID_)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	if arg_9_1 then
		local var_9_0, var_9_1 = arg_9_0:IsUnlockActivity()

		if var_9_0 and var_9_1 ~= 0 then
			if ActivityUnlockStateData:GetUnlockState(var_9_1)[ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT] ~= 1 then
				arg_9_0.stateController_:SetSelectedState("new")
			else
				arg_9_0.stateController_:SetSelectedState("normal")
			end
		elseif #(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_9_0.activityID_] or {}) <= 0 then
			arg_9_0.stateController_:SetSelectedState("normal")
		else
			arg_9_0.stateController_:SetSelectedState("lock")
		end

		if not arg_9_0:IsUnlock() then
			arg_9_0.lockController_:SetSelectedState("true")
		elseif ActivityTools.GetActivityStatus(arg_9_0.activityID_) == ActivityConst.ACTIVITY_STATE.ACTIVING then
			arg_9_0.lockController_:SetSelectedState("false")
		else
			arg_9_0.lockController_:SetSelectedState("timeLock")
		end
	end

	SetActive(arg_9_0.gameObject_, arg_9_1)
end

return var_0_0
