local var_0_0 = class("OsirisChessBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0 = ChessTools.GetChapterProgress(arg_2_0.chapterID_)

	arg_2_0.imageProgress_.fillAmount = var_2_0 / 100
	arg_2_0.textProress_.text = var_2_0
	arg_2_0.textName_.text = WarchessLevelCfg[arg_2_0.chapterID_].name_level

	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS, arg_2_0.chapterID_))
	arg_2_0:AddTimer()
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS, arg_3_0.chapterID_))
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_5_0:GetOpenTimestamp() then
			local var_6_0 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_0, manager.time:GetLostTimeStr(arg_5_0:GetOpenTimestamp())))

			return
		end

		if arg_5_0:IsPrestageLock() then
			local var_6_1 = arg_5_0.chapterID_
			local var_6_2 = WarchessLevelCfg[var_6_1].unlock_level
			local var_6_3 = WarchessLevelCfg[var_6_2].type

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityCfg[var_6_3].remark), WarchessLevelCfg[var_6_2].name_level))

			return
		end

		if arg_5_0:IsLock() then
			local var_6_4 = WarchessLevelCfg[arg_5_0.chapterID_].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[var_6_4[2][1]].name), BattleActivityStoryStageCfg[var_6_4[2][2]].name))

			return
		end

		ChessTools.EnterChessMap(arg_5_0.chapterID_, true)
	end)
end

function var_0_0.IsPrestageLock(arg_7_0)
	local var_7_0 = arg_7_0.chapterID_
	local var_7_1 = WarchessLevelCfg[var_7_0]
	local var_7_2 = var_7_1.unlock_level

	if var_7_2 ~= 0 and ChessTools.GetChapterProgress(var_7_2) < var_7_1.success_progress then
		return true
	end

	return false
end

function var_0_0.IsLock(arg_8_0)
	local var_8_0 = arg_8_0.chapterID_

	if WarchessLevelCfg[var_8_0].type == ActivityConst.OSIRIS_CHESS then
		local var_8_1 = WarchessLevelCfg[var_8_0].unlock_condition

		if var_8_1 ~= "" then
			local var_8_2 = StoryStageActivityData:GetStageData(var_8_1[1])[var_8_1[2]]

			if var_8_2 and var_8_2.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		end
	end

	return false
end

function var_0_0.GetOpenTimestamp(arg_9_0)
	return WarChessData:GetChessTime(arg_9_0.chapterID_) or 0
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:RefreshState()

	local var_10_0 = manager.time:GetServerTime() - arg_10_0:GetOpenTimestamp()

	if var_10_0 >= 0 then
		return
	end

	local var_10_1 = manager.time:GetLostTimeStr(arg_10_0:GetOpenTimestamp())

	arg_10_0.textTime_.text = string.format(GetTips("OPEN_TIME"), var_10_1)

	arg_10_0:StopTimer()

	arg_10_0.timer_ = Timer.New(function()
		var_10_0 = manager.time:GetServerTime() - arg_10_0:GetOpenTimestamp()

		arg_10_0:RefreshState()

		local var_11_0 = manager.time:GetLostTimeStr(arg_10_0:GetOpenTimestamp())

		arg_10_0.textTime_.text = string.format(GetTips("OPEN_TIME"), var_11_0)

		if var_10_0 >= 0 then
			arg_10_0:StopTimer()
		end
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.RefreshState(arg_13_0)
	local var_13_0 = WarchessLevelCfg[arg_13_0.chapterID_].type
	local var_13_1 = WarChessData:GetCurrentChapter(var_13_0)

	if manager.time:GetServerTime() >= arg_13_0:GetOpenTimestamp() then
		if arg_13_0:IsPrestageLock() or arg_13_0:IsLock() then
			arg_13_0.controller_:SetSelectedState("open")

			return
		end

		if var_13_1 == arg_13_0.chapterID_ then
			arg_13_0.controller_:SetSelectedState("challenge")
		else
			arg_13_0.controller_:SetSelectedState("normal")
		end
	else
		arg_13_0.controller_:SetSelectedState("lock")
	end
end

return var_0_0
