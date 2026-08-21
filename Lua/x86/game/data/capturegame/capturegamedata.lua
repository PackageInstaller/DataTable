local var_0_0 = singletonClass("CaptureGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.captureData = {
		activity = {},
		freeActivity = {}
	}
	arg_1_0.completeRewardData = {}
	arg_1_0.lastSectionData = nil
	arg_1_0.redPoint = {
		single = {
			redmap = {}
		},
		multi = {
			redmap = {}
		}
	}
end

function var_0_0.UpdateGameData(arg_2_0, arg_2_1)
	if arg_2_1 then
		local var_2_0 = {}

		arg_2_0.data[arg_2_1.activity_id] = var_2_0

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_info) do
			var_2_0[iter_2_1.stage_id] = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.task_id) do
				var_2_0[iter_2_1.stage_id][iter_2_3] = true
			end

			if not CaptureGameTools:IsFreeActivity(arg_2_1.activity_id) then
				if arg_2_0:CheckStageIsReached(iter_2_1.stage_id, iter_2_1.task_id) then
					arg_2_0:RecordCaptureSuceess(arg_2_1.activity_id, iter_2_1.stage_id)
				end
			else
				arg_2_0:RecordFreeCaptureSuceess(arg_2_1.activity_id, iter_2_1.task_id)
			end
		end

		arg_2_0:UpdateRedPoint(arg_2_1.activity_id)
	end
end

function var_0_0.RecordCaptureSuceess(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.captureData.activity[arg_3_1] = arg_3_0.captureData.activity[arg_3_1] or {}
	arg_3_0.captureData.activity[arg_3_1][arg_3_2] = true
end

function var_0_0.RecordFreeCaptureSuceess(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.captureData.freeActivity[arg_4_1] = arg_4_0.captureData.freeActivity[arg_4_1] or 0
	arg_4_0.captureData.freeActivity[arg_4_1] = #arg_4_2
end

function var_0_0.RecordFreeCaptureSuceessLocal(arg_5_0, arg_5_1)
	arg_5_0.captureData.freeActivity[arg_5_1] = (arg_5_0.captureData.freeActivity[arg_5_1] or 0) + 1
end

function var_0_0.UpdateTaskReceiveStatus(arg_6_0, arg_6_1)
	if arg_6_1 then
		local var_6_0 = {}

		arg_6_0.completeRewardData[arg_6_1.activity_id] = var_6_0

		for iter_6_0, iter_6_1 in ipairs(arg_6_1.admitted_reward_list) do
			var_6_0[iter_6_1] = true
		end
	end
end

function var_0_0.RecordTaskReceived(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = ActivityPointRewardCfg[iter_7_1]

		arg_7_0.completeRewardData[var_7_0.activity_id] = arg_7_0.completeRewardData[var_7_0.activity_id] or {}
		arg_7_0.completeRewardData[var_7_0.activity_id][var_7_0.id] = true
	end

	manager.notify:Invoke(CAPTURE_GAME_OUTGAME_TASK_UPDATE)
end

function var_0_0.OnRecordSectionTask(arg_8_0, arg_8_1)
	if arg_8_1 then
		if not arg_8_0.data[arg_8_1.activity_id] then
			arg_8_0.data[arg_8_1.activity_id] = {}
		end

		if not arg_8_0.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id] then
			arg_8_0.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id] = {}
		end

		if arg_8_1.capture_mode ~= CaptureGameConst.ServerNeedGameMode.FreeMode then
			local var_8_0 = arg_8_0.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id]

			for iter_8_0, iter_8_1 in ipairs(arg_8_1.stage_info.task_id) do
				if not var_8_0[iter_8_1] then
					var_8_0[iter_8_1] = true
				end
			end

			if arg_8_0:CheckStageIsReached(arg_8_1.stage_info.stage_id, arg_8_1.stage_info.task_id) then
				arg_8_0:RecordCaptureSuceess(arg_8_1.activity_id, arg_8_1.stage_info.stage_id)
			end
		else
			arg_8_0:RecordFreeCaptureSuceessLocal(arg_8_1.activity_id)
		end

		arg_8_0:UpdateRedPoint(arg_8_1.activity_id)
	end
end

function var_0_0.CheckStageIsReached(arg_9_0, arg_9_1, arg_9_2)
	if ActivitySwimSkinSubSectionCfg[arg_9_1] then
		return #arg_9_2 == #ActivitySwimSkinSubSectionCfg[arg_9_1].task_list
	else
		if arg_9_1 == 3 then
			return true
		end

		return false
	end
end

function var_0_0.GetCaptureCountByMode(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.captureData.activity) do
		if ActivitySwimSkinSectionCfg[iter_10_0].mode == arg_10_1 then
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				var_10_0 = var_10_0 + 1
			end
		end
	end

	return var_10_0
end

function var_0_0.GetCaptureCountByActivity(arg_11_0, arg_11_1)
	if arg_11_1 == CaptureGameConst.ModeMainActivity.Common then
		return arg_11_0:GetCaptureCountFull()
	end

	if not CaptureGameTools:IsFreeActivity(arg_11_1) then
		local var_11_0 = 0
		local var_11_1 = arg_11_0.captureData.activity[arg_11_1] or {}

		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			var_11_0 = var_11_0 + 1
		end

		return var_11_0
	else
		return arg_11_0.captureData.freeActivity[arg_11_1] or 0
	end
end

function var_0_0.GetCompleteNumByMainActivity(arg_12_0, arg_12_1)
	if arg_12_1 == CaptureGameConst.ModeMainActivity.Single then
		return arg_12_0:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.Multi then
		return arg_12_0:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.MultiFree then
		return arg_12_0:GetCaptureCountByActivity(CaptureGameConst.ModeMainActivity.MultiFree)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.SingleFree then
		return arg_12_0:GetCaptureCountByActivity(CaptureGameConst.ModeMainActivity.SingleFree)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.Common then
		return arg_12_0:GetCaptureCountFull()
	end
end

function var_0_0.GetCaptureCountFull(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.captureData.activity) do
		if ActivitySwimSkinSectionCfg[iter_13_0].mode ~= CaptureGameConst.ServerNeedGameMode.FreeMode then
			for iter_13_2, iter_13_3 in pairs(iter_13_1) do
				var_13_0 = var_13_0 + 1
			end
		end
	end

	return var_13_0
end

function var_0_0.GetReachActivityCountByMode(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.captureData.activity) do
		local var_14_1 = 0

		if ActivitySwimSkinSectionCfg[iter_14_0].mode == arg_14_1 then
			for iter_14_2, iter_14_3 in pairs(iter_14_1) do
				var_14_1 = var_14_1 + 1
			end
		end

		if var_14_1 == #ActivitySwimSkinSectionCfg[iter_14_0].sub_section_list then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_0.GetSectionTaskCompleteMap(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0.data[arg_15_1] then
		return {}
	end

	return arg_15_0.data[arg_15_1][arg_15_2] or {}
end

function var_0_0.CheckSectionTaskComplete(arg_16_0, arg_16_1, arg_16_2)
	return (arg_16_0.captureData.activity[arg_16_1] or {})[arg_16_2] or false
end

function var_0_0.CheckTaskIsComplete(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.completeRewardData) do
		if iter_17_1[arg_17_1] then
			return true
		end
	end

	return false
end

function var_0_0.CheckFreeCaptureOpen(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if not arg_18_1 then
		var_18_0 = CaptureGameData:GetReachActivityCountByMode(CaptureGameConst.CaptureGameMode.Multiple)
	else
		var_18_0 = CaptureGameData:GetReachActivityCountByMode(CaptureGameConst.CaptureGameMode.Single)
	end

	return var_18_0 == 7
end

function var_0_0.CheckCanEnterMulti(arg_19_0)
	return ActivityData:GetActivityIsOpen(CaptureGameConst.ModeMainActivity.Multi)
end

function var_0_0.RegisterSectionData(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0.lastSectionData = {
		mainStageId = arg_20_1,
		subSectionId = arg_20_2,
		isFree = arg_20_3
	}
end

function var_0_0.GetSectionData(arg_21_0)
	return arg_21_0.lastSectionData
end

function var_0_0.ClearSectionData(arg_22_0)
	arg_22_0.lastSectionData = nil
end

function var_0_0.UpdateRedPoint(arg_23_0, arg_23_1)
	local var_23_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0
	}

	for iter_23_0, iter_23_1 in ipairs(ActivitySwimSkinSectionCfg.all) do
		local var_23_1 = ActivitySwimSkinSectionCfg[iter_23_1]

		if ActivityData:GetActivityIsOpen(iter_23_1) and CaptureGameTools:CaptureGameCanOpen(iter_23_1) then
			if var_23_1.mode == CaptureGameConst.CaptureGameMode.Single then
				for iter_23_2, iter_23_3 in ipairs(var_23_1.sub_section_list) do
					var_23_0[3] = iter_23_3

					local var_23_2 = table.concat(var_23_0)

					if not arg_23_0:CheckSectionTaskComplete(iter_23_1, iter_23_3) and not arg_23_0.redPoint.single.redmap[iter_23_3] then
						manager.redPoint:setTip(var_23_2, 1)
					else
						arg_23_0:CancelRedPoint(iter_23_1, iter_23_3)
					end
				end
			elseif var_23_1.mode == CaptureGameConst.CaptureGameMode.Multiple then
				for iter_23_4, iter_23_5 in ipairs(var_23_1.sub_section_list) do
					var_23_0[3] = iter_23_5

					local var_23_3 = table.concat(var_23_0)

					if not arg_23_0:CheckSectionTaskComplete(iter_23_1, iter_23_5) and not arg_23_0.redPoint.multi.redmap[iter_23_5] then
						manager.redPoint:setTip(var_23_3, 1)
					else
						arg_23_0:CancelRedPoint(iter_23_1, iter_23_5)
					end
				end
			end
		end
	end

	arg_23_0:RefreshRewardRed()
end

function var_0_0.CancelRedPoint(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0
	}
	local var_24_1 = ActivitySwimSkinSectionCfg[arg_24_1]

	if var_24_1.mode == CaptureGameConst.CaptureGameMode.Single then
		arg_24_0.redPoint.single.redmap[arg_24_2] = true
		var_24_0[3] = arg_24_2

		manager.redPoint:setTip(table.concat(var_24_0), 0)
	elseif var_24_1.mode == CaptureGameConst.CaptureGameMode.Multiple then
		arg_24_0.redPoint.multi.redmap[arg_24_2] = true
		var_24_0[3] = arg_24_2

		manager.redPoint:setTip(table.concat(var_24_0), 0)
	end
end

function var_0_0.RefreshRewardRed(arg_25_0)
	local var_25_0 = {
		CaptureGameConst.ModeMainActivity.Single,
		CaptureGameConst.ModeMainActivity.Multi,
		CaptureGameConst.ModeMainActivity.Common
	}
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_25_1]

		for iter_25_2, iter_25_3 in ipairs(var_25_2) do
			table.insert(var_25_1, iter_25_3)
		end
	end

	local var_25_3 = {
		[CaptureGameConst.ModeMainActivity.Single] = arg_25_0:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single),
		[CaptureGameConst.ModeMainActivity.Multi] = arg_25_0:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple),
		[CaptureGameConst.ModeMainActivity.Common] = CaptureGameData:GetCaptureCountFull()
	}
	local var_25_4 = {}

	for iter_25_4, iter_25_5 in ipairs(var_25_1) do
		if arg_25_0:CheckSingleTaskCanReceive(iter_25_5, var_25_3) == 1 then
			manager.redPoint:setTip(RedPointConst.CAPTURE_GAME_TASK_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.CAPTURE_GAME_TASK_REWARD, 0)
end

function var_0_0.CheckSingleTaskCanReceive(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:CheckTaskIsComplete(arg_26_1)

	if var_26_0 then
		return 2
	end

	local var_26_1 = ActivityPointRewardCfg[arg_26_1]
	local var_26_2 = var_26_1.activity_id

	if var_26_1.need <= (arg_26_2[var_26_2] or 0) and not var_26_0 then
		return 1
	end

	return 0
end

return var_0_0
