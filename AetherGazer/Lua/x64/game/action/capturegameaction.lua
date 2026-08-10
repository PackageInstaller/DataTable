local var_0_0 = {}

manager.net:Bind(83201, function(arg_1_0)
	if arg_1_0 then
		CaptureGameData:UpdateGameData(arg_1_0)
	end
end)
manager.net:Bind(83203, function(arg_2_0)
	if arg_2_0 then
		CaptureGameData:UpdateTaskReceiveStatus(arg_2_0)
		CaptureGameData:RefreshRewardRed()
	end
end)

function var_0_0.ReceiveTaskReward(arg_3_0)
	CaptureGameData:RecordTaskReceived(arg_3_0)
	manager.net:SendWithLoadingNew(83206, {
		point_reward_id_list = arg_3_0
	}, 83207, var_0_0.OnReceiveSuccess)
end

function var_0_0.OnReceiveSuccess(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		getReward2(mergeReward2(arg_4_0.reward_list))
		CaptureGameData:RefreshRewardRed()
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.RecordSectionTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		activity_id = arg_5_0,
		stage_info = arg_5_1,
		capture_mode = arg_5_2
	}

	CaptureGameData:OnRecordSectionTask(var_5_0)
	manager.net:Push(83204, var_5_0)
end

return var_0_0
