local var_0_0 = class("ChapterVariantSubPlotBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "lockState")
	arg_1_0.stageDataChangeHandler_ = handler(arg_1_0, arg_1_0.StageDataChange)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.chapterID_ = arg_2_1

	arg_2_0:RefreshStageLockState()
	arg_2_0:BindRedPoint()

	if ChapterCfg[arg_2_1].activity_id ~= 0 then
		arg_2_0:AddTimer()
	else
		arg_2_0:RefreshControllerState()
	end

	manager.notify:RegistListener(BATTLE_STAGE_PLOT_CHANGE, arg_2_0.stageDataChangeHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(BATTLE_STAGE_PLOT_CHANGE, arg_3_0.stageDataChangeHandler_)
	arg_3_0:UnBindRedPoint()
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.stageDataChangeHandler_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		JumpTools.Jump2SubPlotByChapterID(arg_5_0.chapterID_, true)
	end)
end

function var_0_0.BindRedPoint(arg_7_0)
	return
end

function var_0_0.UnBindRedPoint(arg_8_0)
	return
end

function var_0_0.RefreshStageLockState(arg_9_0)
	local var_9_0 = ChapterCfg[arg_9_0.chapterID_].section_id_list[1]

	if var_9_0 == nil or BattleStageData:GetStageData()[var_9_0] then
		arg_9_0.isLock_ = false
	else
		arg_9_0.isLock_ = true
	end

	arg_9_0:RefreshControllerState()
end

function var_0_0.StageDataChange(arg_10_0)
	arg_10_0:RefreshStageLockState()
end

function var_0_0.AddTimer(arg_11_0)
	arg_11_0:StopTimer()

	local var_11_0 = ChapterCfg[arg_11_0.chapterID_].activity_id
	local var_11_1 = ActivityData:GetActivityRefreshTime(var_11_0)

	arg_11_0.timeLock_ = false

	if var_11_1 < manager.time:GetServerTime() then
		arg_11_0:RefreshControllerState()

		return
	end

	arg_11_0.controller_:SetSelectedState("timeLock")

	arg_11_0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_1))
	arg_11_0.timeLock_ = true
	arg_11_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_11_1 then
			arg_11_0.timeLock_ = false

			arg_11_0:RefreshControllerState()
			arg_11_0:StopTimer()
		else
			arg_11_0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_1))
		end
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.RefreshControllerState(arg_14_0)
	if arg_14_0.timeLock_ then
		arg_14_0.controller_:SetSelectedState("timeLock")
	elseif arg_14_0.isLock_ then
		arg_14_0.controller_:SetSelectedState("lock")
	else
		arg_14_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0
