local var_0_0 = class("XH3rdWaterDialogTask")

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.activityId_ = arg_1_1
	arg_1_0.unSelectDialogGroupIndex_ = 0
	arg_1_0.talkGroupIdList_ = {}

	if ActivityWaterData:GetCurrentSchedule(arg_1_0.activityId_) then
		local var_1_0 = ActivityWaterData:GetCurrentSchedule(arg_1_0.activityId_).schedule_id

		arg_1_0.talkGroupIdList_ = ActivityWaterCfg[var_1_0].groups
	end
end

function var_0_0.StartDialogTimer(arg_2_0)
	arg_2_0:StopDialogTimer()

	arg_2_0.selectDialogIndex_ = 0
	arg_2_0.unselectDialogIndex_ = 0
	arg_2_0.dialogTimer_ = Timer.New(function()
		arg_2_0:ShowDialog()
	end, 3, -1)

	arg_2_0.dialogTimer_:Start()
	arg_2_0:ShowDialog()
end

function var_0_0.StopDialogTimer(arg_4_0)
	if arg_4_0.dialogTimer_ then
		arg_4_0.dialogTimer_:Stop()

		arg_4_0.dialogTimer_ = nil
	end
end

function var_0_0.StartScheduleTimer(arg_5_0)
	arg_5_0:StopScheduleTimer()

	arg_5_0.scheduleTimer_ = Timer.New(function()
		if ActivityWaterData:GetCurrentAssistantRole(arg_5_0.activityId_) == 0 then
			local var_6_0 = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(arg_5_0.activityId_).schedule_id]

			arg_5_0.unSelectDialogGroupIndex_ = arg_5_0.unSelectDialogGroupIndex_ % #var_6_0.groups + 1

			arg_5_0:StartDialogTimer()
		end

		arg_5_0:StopScheduleTimer()
	end, 30, 1)

	arg_5_0.scheduleTimer_:Start()
end

function var_0_0.StopScheduleTimer(arg_7_0)
	if arg_7_0.scheduleTimer_ then
		arg_7_0.scheduleTimer_:Stop()

		arg_7_0.scheduleTimer_ = nil
	end
end

function var_0_0.SetOnDialogHandler(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.onSinglePlayerDialog_ = arg_8_1
	arg_8_0.onMultiPlayerDialog_ = arg_8_3
	arg_8_0.onSinglePlayerStop_ = arg_8_2
	arg_8_0.onMultiPlayerStop_ = arg_8_4
end

function var_0_0.ShowDialog(arg_9_0)
	if ActivityWaterData:GetCurrentAssistantRole(arg_9_0.activityId_) == 0 then
		arg_9_0:NextUnSelectTalk()
	end
end

function var_0_0.NextSelectTalk(arg_10_0)
	local var_10_0 = ActivityWaterData:GetCurrentAssistantRole(arg_10_0.activityId_)

	if not arg_10_0.selectDialogGroup_ or var_10_0 ~= arg_10_0.currentCompetitionId_ then
		arg_10_0.currentCompetitionId_ = ActivityWaterData:GetCurrentAssistantRole(arg_10_0.activityId_)
		arg_10_0.selectDialogGroup_ = ActivityWaterCompetitionCfg[arg_10_0.currentCompetitionId_].dialog_group
		arg_10_0.currentSelectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[arg_10_0.selectDialogGroup_]
	end

	if arg_10_0.selectTimer_ then
		arg_10_0.selectTimer_:Stop()
	end

	if not arg_10_0.selectDialogIndex_ then
		arg_10_0.selectDialogIndex_ = 0
	end

	arg_10_0.selectDialogIndex_ = arg_10_0.selectDialogIndex_ % #arg_10_0.currentSelectDialogIdList_ + 1

	if arg_10_0.onSinglePlayerDialog_ ~= nil then
		local var_10_1 = ActivityWaterData:GetCurrentAssistantRole(arg_10_0.activityId_)

		arg_10_0.onSinglePlayerDialog_(var_10_1, arg_10_0.currentSelectDialogIdList_[arg_10_0.selectDialogIndex_])
	end

	arg_10_0.selectTimer_ = TimeTools.StartAfterSeconds(3, function()
		if arg_10_0.onSinglePlayerStop_ ~= nil then
			arg_10_0.onSinglePlayerStop_()
		end

		arg_10_0.selectTimer_ = nil
	end, {})
end

function var_0_0.NextUnSelectTalk(arg_12_0)
	if not arg_12_0.unselectDialogGroup_ then
		arg_12_0.unselectDialogGroup_ = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(arg_12_0.activityId_).schedule_id].groups[arg_12_0.unSelectDialogGroupIndex_]
		arg_12_0.currentUnselectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[arg_12_0.unselectDialogGroup_]
	end

	if not arg_12_0.unselectDialogIndex_ then
		arg_12_0.unselectDialogIndex_ = 0
	end

	if arg_12_0.unselectDialogIndex_ >= #arg_12_0.currentUnselectDialogIdList_ then
		if arg_12_0.onMultiPlayerStop_ ~= nil then
			arg_12_0.onMultiPlayerStop_()
		end

		arg_12_0.unselectDialogIndex_ = 0

		arg_12_0:StopDialogTimer()
		arg_12_0:StartScheduleTimer()

		return
	end

	arg_12_0.unselectDialogIndex_ = arg_12_0.unselectDialogIndex_ + 1

	if arg_12_0.onMultiPlayerDialog_ ~= nil then
		arg_12_0.onMultiPlayerDialog_(arg_12_0.currentUnselectDialogIdList_[arg_12_0.unselectDialogIndex_])
	end
end

function var_0_0.OnEnter(arg_13_0)
	if ActivityWaterData:GetCurrentAssistantRole(arg_13_0.activityId_) == 0 then
		arg_13_0:StartScheduleTimer()
	end
end

function var_0_0.OnExit(arg_14_0)
	if ActivityWaterData:GetCurrentAssistantRole(arg_14_0.activityId_) ~= 0 then
		if arg_14_0.onSinglePlayerStop_ ~= nil then
			arg_14_0.onSinglePlayerStop_()
		end
	elseif arg_14_0.onMultiPlayerStop_ ~= nil then
		arg_14_0.onMultiPlayerStop_()
	end

	arg_14_0:StopDialogTimer()
	arg_14_0:StopScheduleTimer()
end

function var_0_0.Disturb(arg_15_0)
	if ActivityWaterData:GetCurrentAssistantRole(arg_15_0.activityId_) ~= 0 then
		if arg_15_0.onSinglePlayerStop_ ~= nil then
			arg_15_0.onSinglePlayerStop_()
		end
	elseif arg_15_0.onMultiPlayerStop_ ~= nil then
		arg_15_0.onMultiPlayerStop_()
	end

	arg_15_0:StopDialogTimer()
	arg_15_0:StartScheduleTimer()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopDialogTimer()
	arg_16_0:StopScheduleTimer()
end

return var_0_0
