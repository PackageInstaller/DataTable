local var_0_0 = singletonClass("AchievementData")

function var_0_0:Init()
	self.achievementData_ = {}

	for iter_1_0, iter_1_1 in ipairs(AchievementCfg.all) do
		self.achievementData_[iter_1_1] = {
			process = 0,
			timestamp = 0,
			rewardState = 0,
			id = iter_1_1
		}
	end

	self.achievementSortData_ = {}

	for iter_1_2, iter_1_3 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		self.achievementSortData_[iter_1_2] = {}

		for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
			if AchievementCfg[iter_1_5].is_hide ~= 1 then
				table.insert(self.achievementSortData_[iter_1_2], iter_1_5)
			end
		end
	end

	self.needSortFlag_ = {}
	self.canReceiveReward_ = {}
	self.finishAchievementList_ = {}
	self.achievementPoint_ = 0
	self.storyReadList_ = {}
	self.achievementLevel_ = 0
	self.achievementOldLevel_ = 0
	self.readyAchievementList_ = {}
	self.hadCheckShield_ = {}
	self.finishShieldList_ = {}
	self.canReceiveShieldList_ = {}
end

function var_0_0:GetFinishAchievementCnt(arg_2_1)
	if arg_2_1 == nil then
		local var_2_0 = 0

		for iter_2_0, iter_2_1 in pairs(self.finishAchievementList_) do
			var_2_0 = var_2_0 + #iter_2_1
		end

		local var_2_1 = 0

		for iter_2_2, iter_2_3 in pairs(self.canReceiveShieldList_) do
			var_2_1 = var_2_1 + #iter_2_3
		end

		return var_2_0 - var_2_1
	else
		local var_2_2

		if self.finishShieldList_[arg_2_1] then
			var_2_2 = #self.finishShieldList_[arg_2_1] or 0

			local var_2_3

			if self.finishAchievementList_[arg_2_1] then
				var_2_3 = #self.finishAchievementList_[arg_2_1] or 0
			end
		end

		return var_2_3 - var_2_2
	end
end

function var_0_0:GetReadyAchievementList(arg_3_1)
	if arg_3_1 == nil then
		return self.readyAchievementList_
	else
		return self.readyAchievementList_[arg_3_1] or {}
	end
end

function var_0_0:UpdateAchievementList(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self:UpdateAchievement(iter_4_1, arg_4_2)
	end
end

function var_0_0:UpdateAchievement(arg_5_1, arg_5_2)
	local var_5_0 = tonumber(arg_5_1.progress)
	local var_5_1 = AchievementCfg[arg_5_1.id]

	if not AchievementCfg[arg_5_1.id] then
		return
	end

	local var_5_2 = var_5_1.type_id
	local var_5_3 = 0

	if arg_5_1.complete_flag == 1 then
		var_5_3 = -1
	elseif var_5_0 >= var_5_1.need then
		var_5_3 = 1
	end

	if not self.hadCheckShield_[arg_5_1.id] then
		self.hadCheckShield_[arg_5_1.id] = true

		local var_5_4 = false

		if type(AchievementCfg[arg_5_1.id].system) == "table" then
			for iter_5_0, iter_5_1 in ipairs(AchievementCfg[arg_5_1.id].system) do
				if SystemCfg[iter_5_1].system_hide == 1 then
					var_5_4 = true

					break
				end
			end
		end

		if var_5_4 then
			if var_5_3 == 0 then
				if self.achievementSortData_[AchievementCfg[arg_5_1.id].type_id] then
					local var_5_5 = table.indexof(self.achievementSortData_[AchievementCfg[arg_5_1.id].type_id], arg_5_1.id)

					if var_5_5 then
						table.remove(self.achievementSortData_[AchievementCfg[arg_5_1.id].type_id], var_5_5)
					end
				end
			elseif var_5_3 == -1 then
				self.finishShieldList_[AchievementCfg[arg_5_1.id].type_id] = self.finishShieldList_[AchievementCfg[arg_5_1.id].type_id] or {}

				table.insert(self.finishShieldList_[AchievementCfg[arg_5_1.id].type_id], arg_5_1.id)
			elseif var_5_3 == 1 then
				self.canReceiveShieldList_[AchievementCfg[arg_5_1.id].type_id] = self.canReceiveShieldList_[AchievementCfg[arg_5_1.id].type_id] or {}

				table.insert(self.canReceiveShieldList_[AchievementCfg[arg_5_1.id].type_id], arg_5_1.id)
			end
		end
	end

	if var_5_3 == 1 or var_5_3 == -1 then
		if var_5_3 == 1 then
			if self.readyAchievementList_[var_5_2] then
				if not table.keyof(self.readyAchievementList_[var_5_2], arg_5_1.id) then
					table.insert(self.readyAchievementList_[var_5_2], arg_5_1.id)
				end
			else
				self.readyAchievementList_[var_5_2] = {
					arg_5_1.id
				}
			end
		end

		if self.finishAchievementList_[var_5_2] then
			if not table.keyof(self.finishAchievementList_[var_5_2], arg_5_1.id) then
				table.insert(self.finishAchievementList_[var_5_2], arg_5_1.id)
			end
		else
			self.finishAchievementList_[var_5_2] = {
				arg_5_1.id
			}
		end

		if AchievementCfg[arg_5_1.id].is_hide ~= 0 and not table.keyof(self.achievementSortData_[var_5_2], arg_5_1.id) then
			table.insert(self.achievementSortData_[var_5_2], arg_5_1.id)
		end
	end

	if not (var_5_3 == 1 and self.achievementData_[arg_5_1.id] and self.achievementData_[arg_5_1.id].rewardState == var_5_3) == true then
		local var_5_6 = self.achievementData_
		local var_5_7 = {
			id = arg_5_1.id
		}

		if var_5_0 > var_5_1.need then
			var_5_7.process = var_5_1.need or var_5_0
		end

		var_5_7.rewardState = var_5_3
		var_5_7.timestamp = arg_5_1.achieve_time + manager.time:GetDeltaTimeZone()
		var_5_6[arg_5_1.id] = var_5_7

		if var_5_3 == 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, var_5_2), 1)

			self.canReceiveReward_[var_5_2] = self.canReceiveReward_[var_5_2] or {}

			if not table.keyof(self.canReceiveReward_[var_5_2], arg_5_1.id) then
				table.insert(self.canReceiveReward_[var_5_2], arg_5_1.id)
			end

			if arg_5_2 == false then
				manager.achievementTips:AddAchievementID(arg_5_1.id)
			end
		end
	end

	self.needSortFlag_[var_5_2] = true
end

function var_0_0:GetAchievementIDList(arg_6_1)
	if self.needSortFlag_[arg_6_1] then
		table.sort(self.achievementSortData_[arg_6_1], function(arg_7_0, arg_7_1)
			local var_7_0 = self.achievementData_[arg_7_0].rewardState
			local var_7_1 = self.achievementData_[arg_7_1].rewardState

			if self.achievementData_[arg_7_0].rewardState == self.achievementData_[arg_7_1].rewardState then
				return arg_7_0 < arg_7_1
			else
				return var_7_1 < var_7_0
			end
		end)

		self.needSortFlag_[arg_6_1] = false
	end

	return self.achievementSortData_[arg_6_1]
end

function var_0_0:GetAchievementTotalCnt()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self.achievementSortData_) do
		var_8_0 = var_8_0 + #iter_8_1
	end

	local var_8_1 = 0

	for iter_8_2, iter_8_3 in pairs(self.canReceiveShieldList_) do
		var_8_1 = var_8_1 + #iter_8_3
	end

	return var_8_0 - var_8_1
end

function var_0_0:GetAchievementCnt(arg_9_1)
	return #self.achievementSortData_[arg_9_1] - ((self.finishShieldList_[arg_9_1] or nil) and (#self.finishShieldList_[arg_9_1] or 0))
end

function var_0_0:GetAchievementData(arg_10_1)
	self.achievementData_[arg_10_1] = self.achievementData_[arg_10_1] or {
		process = 0,
		timestamp = 0,
		rewardState = 0,
		id = arg_10_1
	}

	return self.achievementData_[arg_10_1]
end

function var_0_0:ChangedAchievementState(arg_11_1, arg_11_2)
	self.achievementData_[arg_11_1].rewardState = arg_11_2
	self.needSortFlag_[AchievementCfg[arg_11_1].type_id] = true

	table.remove(self.canReceiveReward_[AchievementCfg[arg_11_1].type_id], (table.keyof(self.canReceiveReward_[AchievementCfg[arg_11_1].type_id], arg_11_1)))
	table.remove(self.readyAchievementList_[AchievementCfg[arg_11_1].type_id], (table.keyof(self.readyAchievementList_[AchievementCfg[arg_11_1].type_id], arg_11_1)))

	if table.length(self.canReceiveReward_[AchievementCfg[arg_11_1].type_id]) <= 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT, AchievementCfg[arg_11_1].type_id), 0)
	end
end

function var_0_0:InitAchievementPoint(arg_12_1)
	self.achievementPoint_ = arg_12_1
	self.achievementLevel_ = self:CalcAchievementLevel(arg_12_1)
	self.achievementOldLevel_ = self.achievementLevel_

	for iter_12_0 = 1, self.achievementLevel_ do
		if not self.storyReadList_[iter_12_0] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_12_0), 1)
		end
	end
end

function var_0_0:SetAchievementPoint(arg_13_1)
	self.achievementPoint_ = arg_13_1
	self.achievementLevel_ = self:CalcAchievementLevel(self.achievementPoint_)

	for iter_13_0 = self.achievementOldLevel_, self.achievementLevel_ do
		if not self.storyReadList_[iter_13_0] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_13_0), 1)
		end
	end
end

function var_0_0:GetAchievementPoint()
	return self.achievementPoint_
end

function var_0_0:InitAchievementStoryReadList(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		self.storyReadList_[iter_15_1] = true

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_15_1), 0)
	end
end

function var_0_0:UpdateStoryRead(arg_16_1)
	self.storyReadList_[arg_16_1] = true

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, arg_16_1), 0)
end

function var_0_0:GetStoryReadFlag(arg_17_1)
	return self.storyReadList_[arg_17_1]
end

function var_0_0:NeedUpgradeLevel()
	return self.achievementOldLevel_ < self.achievementLevel_
end

function var_0_0:RefreshOldLevel()
	self.achievementOldLevel_ = self.achievementLevel_
end

function var_0_0:GetCurrentPoint()
	if self.achievementLevel_ + 1 > #AchievementStoryCfg.all then
		return self.achievementPoint_ - AchievementStoryCfg[self.achievementLevel_ - 1].unlock_point
	elseif self.achievementLevel_ + 1 == 1 then
		return self.achievementPoint_
	elseif self.achievementLevel_ + 1 > 1 then
		return self.achievementPoint_ - AchievementStoryCfg[self.achievementLevel_ + 1 - 1].unlock_point
	end
end

function var_0_0:GetCurrentLevelPoint()
	if self.achievementLevel_ + 1 > #AchievementStoryCfg.all then
		return AchievementStoryCfg[self.achievementLevel_].unlock_point - AchievementStoryCfg[self.achievementLevel_ - 1].unlock_point
	elseif self.achievementLevel_ + 1 == 1 then
		return AchievementStoryCfg[self.achievementLevel_ + 1].unlock_point
	elseif self.achievementLevel_ + 1 > 1 then
		return AchievementStoryCfg[self.achievementLevel_ + 1].unlock_point - AchievementStoryCfg[self.achievementLevel_ + 1 - 1].unlock_point
	end
end

function var_0_0.CalcAchievementLevel(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(AchievementStoryCfg.all) do
		if arg_22_1 - AchievementStoryCfg[iter_22_1].unlock_point < 0 then
			return iter_22_1 - 1
		end

		var_22_0 = iter_22_1
	end

	return var_22_0
end

function var_0_0.SetScrollRecord(arg_23_0, arg_23_1)
	arg_23_0.scrollRecord_ = arg_23_1
end

function var_0_0:GetScrollRecord()
	return self.scrollRecord_
end

return var_0_0
