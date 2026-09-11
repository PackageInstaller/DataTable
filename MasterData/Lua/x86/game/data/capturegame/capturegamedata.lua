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

function var_0_0:UpdateGameData(arg_2_1)
	if arg_2_1 then
		local var_2_0 = {}

		self.data[arg_2_1.activity_id] = var_2_0

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_info) do
			var_2_0[iter_2_1.stage_id] = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.task_id) do
				var_2_0[iter_2_1.stage_id][iter_2_3] = true
			end

			if not CaptureGameTools:IsFreeActivity(arg_2_1.activity_id) then
				if self:CheckStageIsReached(iter_2_1.stage_id, iter_2_1.task_id) then
					self:RecordCaptureSuceess(arg_2_1.activity_id, iter_2_1.stage_id)
				end
			else
				self:RecordFreeCaptureSuceess(arg_2_1.activity_id, iter_2_1.task_id)
			end
		end

		self:UpdateRedPoint(arg_2_1.activity_id)
	end
end

function var_0_0:RecordCaptureSuceess(arg_3_1, arg_3_2)
	self.captureData.activity[arg_3_1] = self.captureData.activity[arg_3_1] or {}
	self.captureData.activity[arg_3_1][arg_3_2] = true
end

function var_0_0:RecordFreeCaptureSuceess(arg_4_1, arg_4_2)
	self.captureData.freeActivity[arg_4_1] = self.captureData.freeActivity[arg_4_1] or 0
	self.captureData.freeActivity[arg_4_1] = #arg_4_2
end

function var_0_0:RecordFreeCaptureSuceessLocal(arg_5_1)
	self.captureData.freeActivity[arg_5_1] = (self.captureData.freeActivity[arg_5_1] or 0) + 1
end

function var_0_0:UpdateTaskReceiveStatus(arg_6_1)
	if arg_6_1 then
		local var_6_0 = {}

		self.completeRewardData[arg_6_1.activity_id] = var_6_0

		for iter_6_0, iter_6_1 in ipairs(arg_6_1.admitted_reward_list) do
			var_6_0[iter_6_1] = true
		end
	end
end

function var_0_0:RecordTaskReceived(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self.completeRewardData[ActivityPointRewardCfg[iter_7_1].activity_id] = self.completeRewardData[ActivityPointRewardCfg[iter_7_1].activity_id] or {}
		self.completeRewardData[ActivityPointRewardCfg[iter_7_1].activity_id][ActivityPointRewardCfg[iter_7_1].id] = true
	end

	manager.notify:Invoke(CAPTURE_GAME_OUTGAME_TASK_UPDATE)
end

function var_0_0:OnRecordSectionTask(arg_8_1)
	if arg_8_1 then
		self.data[arg_8_1.activity_id] = self.data[arg_8_1.activity_id] or {}
		self.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id] = self.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id] or {}

		if arg_8_1.capture_mode ~= CaptureGameConst.ServerNeedGameMode.FreeMode then
			for iter_8_0, iter_8_1 in ipairs(arg_8_1.stage_info.task_id) do
				self.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id][iter_8_1] = self.data[arg_8_1.activity_id][arg_8_1.stage_info.stage_id][iter_8_1] or true
			end

			if self:CheckStageIsReached(arg_8_1.stage_info.stage_id, arg_8_1.stage_info.task_id) then
				self:RecordCaptureSuceess(arg_8_1.activity_id, arg_8_1.stage_info.stage_id)
			end
		else
			self:RecordFreeCaptureSuceessLocal(arg_8_1.activity_id)
		end

		self:UpdateRedPoint(arg_8_1.activity_id)
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

function var_0_0:GetCaptureCountByMode(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(self.captureData.activity) do
		if ActivitySwimSkinSectionCfg[iter_10_0].mode == arg_10_1 then
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				var_10_0 = var_10_0 + 1
			end
		end
	end

	return var_10_0
end

function var_0_0:GetCaptureCountByActivity(arg_11_1)
	if arg_11_1 == CaptureGameConst.ModeMainActivity.Common then
		return self:GetCaptureCountFull()
	end

	if not CaptureGameTools:IsFreeActivity(arg_11_1) then
		local var_11_0 = 0

		for iter_11_0, iter_11_1 in pairs(self.captureData.activity[arg_11_1] or {}) do
			var_11_0 = var_11_0 + 1
		end

		return var_11_0
	else
		return self.captureData.freeActivity[arg_11_1] or 0
	end
end

function var_0_0:GetCompleteNumByMainActivity(arg_12_1)
	if arg_12_1 == CaptureGameConst.ModeMainActivity.Single then
		return self:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.Multi then
		return self:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.MultiFree then
		return self:GetCaptureCountByActivity(CaptureGameConst.ModeMainActivity.MultiFree)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.SingleFree then
		return self:GetCaptureCountByActivity(CaptureGameConst.ModeMainActivity.SingleFree)
	end

	if arg_12_1 == CaptureGameConst.ModeMainActivity.Common then
		return self:GetCaptureCountFull()
	end
end

function var_0_0:GetCaptureCountFull()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(self.captureData.activity) do
		if ActivitySwimSkinSectionCfg[iter_13_0].mode ~= CaptureGameConst.ServerNeedGameMode.FreeMode then
			for iter_13_2, iter_13_3 in pairs(iter_13_1) do
				var_13_0 = var_13_0 + 1
			end
		end
	end

	return var_13_0
end

function var_0_0:GetReachActivityCountByMode(arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.captureData.activity) do
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

function var_0_0:GetSectionTaskCompleteMap(arg_15_1, arg_15_2)
	if not self.data[arg_15_1] then
		return {}
	end

	return self.data[arg_15_1][arg_15_2] or {}
end

function var_0_0:CheckSectionTaskComplete(arg_16_1, arg_16_2)
	return (self.captureData.activity[arg_16_1] or {})[arg_16_2] or false
end

function var_0_0:CheckTaskIsComplete(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self.completeRewardData) do
		if iter_17_1[arg_17_1] then
			return true
		end
	end

	return false
end

function var_0_0.CheckFreeCaptureOpen(arg_18_0, arg_18_1)
	return (not arg_18_1 and CaptureGameData:GetReachActivityCountByMode(CaptureGameConst.CaptureGameMode.Multiple) or CaptureGameData:GetReachActivityCountByMode(CaptureGameConst.CaptureGameMode.Single)) == 7
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

function var_0_0:GetSectionData()
	return self.lastSectionData
end

function var_0_0.ClearSectionData(arg_22_0)
	arg_22_0.lastSectionData = nil
end

function var_0_0:UpdateRedPoint(arg_23_1)
	local var_23_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0
	}

	for iter_23_0, iter_23_1 in ipairs(ActivitySwimSkinSectionCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_23_1) and CaptureGameTools:CaptureGameCanOpen(iter_23_1) then
			if ActivitySwimSkinSectionCfg[iter_23_1].mode == CaptureGameConst.CaptureGameMode.Single then
				for iter_23_2, iter_23_3 in ipairs(ActivitySwimSkinSectionCfg[iter_23_1].sub_section_list) do
					var_23_0[3] = iter_23_3

					if not self:CheckSectionTaskComplete(iter_23_1, iter_23_3) and not self.redPoint.single.redmap[iter_23_3] then
						manager.redPoint:setTip(table.concat(var_23_0), 1)
					else
						self:CancelRedPoint(iter_23_1, iter_23_3)
					end
				end
			elseif ActivitySwimSkinSectionCfg[iter_23_1].mode == CaptureGameConst.CaptureGameMode.Multiple then
				for iter_23_4, iter_23_5 in ipairs(ActivitySwimSkinSectionCfg[iter_23_1].sub_section_list) do
					var_23_0[3] = iter_23_5

					if not self:CheckSectionTaskComplete(iter_23_1, iter_23_5) and not self.redPoint.multi.redmap[iter_23_5] then
						manager.redPoint:setTip(table.concat(var_23_0), 1)
					else
						self:CancelRedPoint(iter_23_1, iter_23_5)
					end
				end
			end
		end
	end

	self:RefreshRewardRed()
end

function var_0_0:CancelRedPoint(arg_24_1, arg_24_2)
	local var_24_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0
	}

	if ActivitySwimSkinSectionCfg[arg_24_1].mode == CaptureGameConst.CaptureGameMode.Single then
		self.redPoint.single.redmap[arg_24_2] = true
		var_24_0[3] = arg_24_2

		manager.redPoint:setTip(table.concat(var_24_0), 0)
	elseif ActivitySwimSkinSectionCfg[arg_24_1].mode == CaptureGameConst.CaptureGameMode.Multiple then
		self.redPoint.multi.redmap[arg_24_2] = true
		var_24_0[3] = arg_24_2

		manager.redPoint:setTip(table.concat(var_24_0), 0)
	end
end

function var_0_0:RefreshRewardRed()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs({
		CaptureGameConst.ModeMainActivity.Single,
		CaptureGameConst.ModeMainActivity.Multi,
		CaptureGameConst.ModeMainActivity.Common
	}) do
		for iter_25_2, iter_25_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_25_1]) do
			table.insert(var_25_0, iter_25_3)
		end
	end

	local var_25_1 = {
		[CaptureGameConst.ModeMainActivity.Single] = self:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single),
		[CaptureGameConst.ModeMainActivity.Multi] = self:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple),
		[CaptureGameConst.ModeMainActivity.Common] = CaptureGameData:GetCaptureCountFull()
	}

	for iter_25_4, iter_25_5 in ipairs(var_25_0) do
		if self:CheckSingleTaskCanReceive(iter_25_5, var_25_1) == 1 then
			manager.redPoint:setTip(RedPointConst.CAPTURE_GAME_TASK_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.CAPTURE_GAME_TASK_REWARD, 0)
end

function var_0_0:CheckSingleTaskCanReceive(arg_26_1, arg_26_2)
	local var_26_0 = self:CheckTaskIsComplete(arg_26_1)

	if var_26_0 then
		return 2
	end

	if ActivityPointRewardCfg[arg_26_1].need <= (arg_26_2[ActivityPointRewardCfg[arg_26_1].activity_id] or 0) and not var_26_0 then
		return 1
	end

	return 0
end

return var_0_0
