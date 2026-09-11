local var_0_0 = singletonClass("DemonChallengeData")

function var_0_0:Init()
	self.levelIdList_ = StageGroupCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	self.activityIdList_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]
	self.levelCount_ = #self.levelIdList_
	self.levelDataList_ = {}
	self.receivedList_ = {}
	self.completedList_ = {}
	self.stageIdToIndex_ = {}
	self.selectDifficultyIndexList_ = {}
	self.selectedList_ = {}
	self.openTimeStamp_ = {}
	self.remainTimeStamp_ = 0
	self.test = false

	manager.notify:RegistListener(ACTIVITY_UPDATE, handler(self, self.InitData))
end

function var_0_0:InitData()
	if self.test == true then
		for iter_2_0 = 1, self.levelCount_ do
			local var_2_0 = self.openTimeStamp_[iter_2_0] - manager.time:GetServerTime() <= 0
		end
	end

	for iter_2_1 = 1, self.levelCount_ do
		if self.receivedList_[iter_2_1] == nil then
			self.receivedList_[iter_2_1] = {}
			self.completedList_[iter_2_1] = {}
		end
	end

	if self.test == false then
		self:UpdateTimeData()
	end
end

function var_0_0:SetData(arg_3_1)
	self.levelDataList_[arg_3_1.activity_info.activity_id] = arg_3_1.activity_info

	local var_3_0 = self:GetLevelIndex(arg_3_1.activity_info.activity_id)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.activity_info.info) do
		local var_3_1 = iter_3_1.difficulty
		local var_3_2 = self:GetStageId(var_3_0, iter_3_1.difficulty)

		if iter_3_1.challenge_state == 2 and table.keyof(self.receivedList_[var_3_0], var_3_1) == nil then
			table.insert(self.receivedList_[var_3_0], var_3_1)
		end

		if (iter_3_1.challenge_state == 1 or iter_3_1.challenge_state == 2) and table.keyof(self.completedList_[var_3_0], var_3_1) == nil then
			table.insert(self.completedList_[var_3_0], var_3_1)
		end

		self.stageIdToIndex_[var_3_2] = {
			var_3_0,
			var_3_1
		}
	end

	self:CalcRedPoint()
end

function var_0_0:UpdateTimeData()
	if self.test == true then
		return
	end

	local var_4_0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON)

	if var_4_0 ~= nil then
		self.remainTimeStamp_ = var_4_0.stopTime
	end

	for iter_4_0, iter_4_1 in ipairs(self.levelIdList_) do
		local var_4_2 = ActivityData:GetActivityData(ActivityConst[self:GetRedPointConst(iter_4_0)])

		if var_4_2 ~= nil then
			self.openTimeStamp_[iter_4_0] = var_4_2.startTime
		end
	end
end

function var_0_0:GetLevelIndex(arg_5_1)
	local var_5_0 = table.keyof(self.activityIdList_, arg_5_1)

	if var_5_0 ~= nil then
		return var_5_0 - 1
	end
end

function var_0_0:GetSubActivityID(arg_6_1)
	if arg_6_1 + 1 <= #self.activityIdList_ then
		return self.activityIdList_[arg_6_1 + 1]
	end
end

function var_0_0:GetLevelCount()
	return self.levelCount_
end

function var_0_0.GetCacheSelectLevelIndex(arg_8_0)
	return getData("DemonChallenge", "levelIndex")
end

function var_0_0.GetDemonChallengeCfg(arg_9_0)
	return
end

function var_0_0.SaveSelectLevelIndex(arg_10_0, arg_10_1)
	saveData("DemonChallenge", "levelIndex", arg_10_1)
end

function var_0_0:GetLevelId(arg_11_1)
	return self.levelIdList_[arg_11_1]
end

function var_0_0:GetStageId(arg_12_1, arg_12_2)
	return StageGroupCfg[self.levelIdList_[arg_12_1]].stage_list[arg_12_2]
end

function var_0_0:GetBoosId(arg_13_1)
	return StageGroupCfg[self.levelIdList_[arg_13_1]].boss_id
end

function var_0_0:SetReceiveList(arg_14_1, arg_14_2)
	if table.keyof(self.receivedList_[arg_14_2], arg_14_1) == nil then
		table.insert(self.receivedList_[arg_14_2], arg_14_1)
		self:CalcRedPoint()
	end
end

function var_0_0:GetReceiveList(arg_15_1)
	return self.receivedList_[arg_15_1]
end

function var_0_0:GetCompletedList(arg_16_1)
	return self.completedList_[arg_16_1]
end

function var_0_0:IsCompleted(arg_17_1, arg_17_2)
	if self.completedList_[arg_17_1] == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", arg_17_1))

		return false
	end

	if table.keyof(self.completedList_[arg_17_1], arg_17_2) then
		return true
	end

	return false
end

function var_0_0:IsCompletedLevel(arg_18_1)
	if self.completedList_[arg_18_1] == nil then
		print(string.format("**********************self.completedList_[%d] 为空***********************************", arg_18_1))

		return false
	end

	return #self.completedList_[arg_18_1] > 0
end

function var_0_0:IsOpened(arg_19_1)
	return self.openTimeStamp_[arg_19_1] - manager.time:GetServerTime() <= 0
end

function var_0_0:SetSelectDifficultyIndex(arg_20_1, arg_20_2)
	self.selectDifficultyIndexList_[arg_20_1] = arg_20_2
end

function var_0_0:GetSelectDifficultyIndex(arg_21_1)
	return self.selectDifficultyIndexList_[arg_21_1]
end

function var_0_0:GetDifficultyDes(arg_22_1, arg_22_2)
	return DemonChallengeCfg[self:GetStageId(arg_22_1, arg_22_2)].difficulty_desc
end

function var_0_0:GetLevelName(arg_23_1)
	return BattleHeartDemonStageCfg[self:GetStageId(arg_23_1, 1)].name
end

function var_0_0:GetDescText(arg_24_1)
	return BattleHeartDemonStageCfg[self:GetStageId(arg_24_1, 1)].tips
end

function var_0_0:GetLevelOpenTimeByIndex(arg_25_1)
	return self.openTimeStamp_[arg_25_1]
end

function var_0_0:GetRemainTime()
	return self.remainTimeStamp_
end

function var_0_0:GetDropId(arg_27_1, arg_27_2)
	return BattleHeartDemonStageCfg[self:GetStageId(arg_27_1, arg_27_2)].drop_lib_id
end

function var_0_0:GetSortedRewardIndexList(arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs(StageGroupCfg[self:GetLevelId(arg_28_1)].stage_list) do
		if table.keyof(self.completedList_[arg_28_1], iter_28_0) == nil then
			table.insert(var_28_1, iter_28_0)
		elseif table.keyof(self.receivedList_[arg_28_1], iter_28_0) == nil then
			table.insert(var_28_0, iter_28_0)
		end
	end

	table.insertto(var_28_0, var_28_1)
	table.insertto(var_28_0, self.receivedList_[arg_28_1])

	return var_28_0
end

function var_0_0:CalcRedPoint()
	for iter_29_0, iter_29_1 in pairs(self.completedList_) do
		local var_29_0 = self:GetRedPointConst(iter_29_0)
		local var_29_1 = false
		local var_29_2 = self:IsCompletedLevel(iter_29_0)
		local var_29_3 = self:IsOpened(iter_29_0)

		if var_29_3 and not var_29_2 and self.selectedList_[iter_29_0] == nil then
			var_29_1 = true
		elseif var_29_3 and var_29_2 then
			for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
				if table.keyof(self.receivedList_[iter_29_0], iter_29_3) == nil then
					var_29_1 = true

					break
				end
			end
		end

		if var_29_1 then
			manager.redPoint:setTip(RedPointConst[var_29_0], 1)
		else
			manager.redPoint:setTip(RedPointConst[var_29_0], 0)
		end
	end
end

function var_0_0:SaveSelected(arg_30_1)
	if self:IsOpened(arg_30_1) then
		self.selectedList_[arg_30_1] = true

		self:CalcRedPoint()
	end
end

function var_0_0:IsSelected(arg_31_1)
	if self.selectedList_[arg_31_1] == nil then
		return false
	else
		return true
	end
end

function var_0_0.GetRedPointConst(arg_32_0, arg_32_1)
	return "OSIRIS_DEMON_LEVEL" .. tostring(arg_32_1)
end

function var_0_0:SetAllRedPoint(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(self.levelIdList_) do
		manager.redPoint:setTip(RedPointConst[self:GetRedPointConst(iter_33_0)], arg_33_1)
	end
end

function var_0_0:GetRoleImg(arg_34_1)
	return getSpriteWithoutAtlas("TextureConfig/VersionUI/OsirisUI/" .. BattleHeartDemonStageCfg[self:GetStageId(arg_34_1, 1)].background_1)
end

function var_0_0:GetAnyOpen()
	for iter_35_0 = 1, self.levelCount_ do
		if self:IsOpened(iter_35_0) then
			return iter_35_0
		end
	end

	return -1
end

return var_0_0
