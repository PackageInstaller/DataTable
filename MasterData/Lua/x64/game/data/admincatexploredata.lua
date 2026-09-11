local var_0_0 = singletonClass("AdminCatExploreData")

local function var_0_1(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		var_1_0[iter_1_0] = {}
		var_1_0[iter_1_0].time = iter_1_1.time
		var_1_0[iter_1_0].address = iter_1_1.address_id
		var_1_0[iter_1_0].content = iter_1_1.content_id
	end

	return var_1_0
end

function var_0_0:Init()
	self.nextLockAdminCat = {}
	self.nextLockRegion = {}
	self.skillData = {}
	self.adminCatLockList = {}
	self.maxLevel = ExploreLevelCfg[#ExploreLevelCfg.all].id
	self.unlockAdminCat = {}
	self.exp = 0
	self.regionUnlockLevel = {}
	self.regionData = {}
	self.isView = false

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(ExploreLevelCfg[1].area) do
		var_2_0[iter_2_1] = iter_2_1
	end

	for iter_2_2, iter_2_3 in pairs(ExploreLevelCfg[1].meow) do
		var_2_1[iter_2_3] = iter_2_3
	end

	for iter_2_4 = 2, self.maxLevel do
		for iter_2_5, iter_2_6 in pairs(ExploreLevelCfg[iter_2_4].area) do
			if var_2_0[iter_2_6] == nil then
				var_2_0[iter_2_6] = iter_2_6
				self.nextLockRegion[iter_2_4] = iter_2_6
				self.regionUnlockLevel[iter_2_6] = iter_2_4
			end
		end

		for iter_2_7, iter_2_8 in pairs(ExploreLevelCfg[iter_2_4].meow) do
			if var_2_1[iter_2_8] == nil then
				var_2_1[iter_2_8] = iter_2_8
				self.nextLockAdminCat[iter_2_4] = iter_2_8
				self.adminCatLockList[iter_2_8] = iter_2_4
			end
		end
	end

	self.totalAdminCat = #ExploreMeowCfg.all
	self.rate = GameSetting.explore_accumulation_multiplying_power.value
	self.rate[0] = 0
	self.level = nil
end

function var_0_0:CalculateLevel()
	local var_3_0 = ItemTools.getItemNum(53)
	local var_3_1 = 1

	for iter_3_0 = 1, self.maxLevel do
		if var_3_0 >= ExploreLevelCfg[iter_3_0].exp and ExploreLevelCfg[iter_3_0].exp ~= 0 then
			var_3_0 = var_3_0 - ExploreLevelCfg[iter_3_0].exp
			var_3_1 = var_3_1 + 1
		end
	end

	if self.level ~= nil and var_3_1 > self.level then
		self.level = var_3_1

		JumpTools.GoToSystem("/adminCatExploreLevelUpPop", {})
	end

	self.level = var_3_1
	self.exp = var_3_0
end

function var_0_0.CheckCanGetWeeklyReward(arg_4_0)
	local var_4_0 = manager.time:GetGameServerWeek()

	return var_4_0 == 6 or var_4_0 == 7
end

function var_0_0:CalculateMaxExploreHour()
	self.maxExploreHour = ExploreLevelCfg[self.level].time
end

function var_0_0:GetRegionIdByIndex(arg_6_1)
	return ExploreLevelCfg[self.maxLevel].area[arg_6_1]
end

function var_0_0:ResetExploreDay()
	self.exploreDay = 0
	self.getWeeklyReward = 1

	self:UpdateRewardRedPoint()
end

function var_0_0:GetDataByPara(arg_8_1)
	return self[arg_8_1]
end

function var_0_0:ModifyData(arg_9_1, arg_9_2)
	self:CalculateLevel()
end

function var_0_0.UpdateWeeklyFirst(arg_10_0)
	arg_10_0.isFirstOpen = 1
end

function var_0_0:InitExploreData(arg_11_1)
	self.exploringCount = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.explore_queue) do
		self.regionData[iter_11_1.area_id] = {}
		self.regionData[iter_11_1.area_id].regionID = iter_11_1.area_id
		self.regionData[iter_11_1.area_id].startTime = iter_11_1.start_time
		self.regionData[iter_11_1.area_id].adminCatID = iter_11_1.mimir_id
		self.regionData[iter_11_1.area_id].stopTime = iter_11_1.stop_time
		self.regionData[iter_11_1.area_id].exploreHour = iter_11_1.target_explore_hour
		self.regionData[iter_11_1.area_id].eventData = var_0_1(iter_11_1.explore_event)
		self.exploringCount = self.exploringCount + 1
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.mimir) do
		self.skillData[iter_11_3.skill[1].skill_id] = iter_11_3.skill[1].skill_level
		self.unlockAdminCat[iter_11_3.mimir_id] = true
	end

	self.exploreDay = arg_11_1.weekly_time
	self.isFirstOpen = arg_11_1.weekly_scene_open
	self.dailyTime = arg_11_1.daily_time
	self.getWeeklyReward = arg_11_1.weekly_reward_state
	self.accumulateC = arg_11_1.total_explore_c or 0

	self:CalculateLevel()
	self:UpdateFirstViewRedPoint()
	self:UpdateRewardRedPoint()
end

function var_0_0:UpdateSkillList(arg_12_1)
	self.skillData[arg_12_1] = self.skillData[arg_12_1] == nil and 1 or self.skillData[arg_12_1] + 1
end

function var_0_0:UpdateUnlockAdminCatList(arg_13_1)
	self.unlockAdminCat[arg_13_1] = true

	self:UpdateSkillList(ExploreMeowCfg[arg_13_1].skill)
	self:UpdateAdminCatRedPoint()
end

function var_0_0:UpdateFinishExploreData(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:CalculateAdminCatRate(self.regionData[arg_14_1].adminCatID, self.regionData[arg_14_1].exploreHour)
	self:CalculateInbornRate(self.regionData[arg_14_1].adminCatID, arg_14_1)
	manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. self.regionData[arg_14_1].regionID, 0)
	JumpTools.OpenPageByJump("adminCatExploreFinishPop", {
		regionId = arg_14_1,
		eventId = arg_14_2,
		reward = arg_14_3,
		adminCatID = self.regionData[arg_14_1].adminCatID,
		callBack = arg_14_4
	})

	self.regionData[arg_14_1] = nil

	self:UpdateRewardRedPoint()
end

function var_0_0.CalculateAdminCatRate(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.skillEffect = true

	if ExploreMeowSkillCfg[ExploreMeowCfg[arg_15_1].skill].skill_type == 1 and arg_15_2 <= 8 then
		-- block empty
	elseif ExploreMeowSkillCfg[ExploreMeowCfg[arg_15_1].skill].skill_type == 2 and arg_15_2 <= 8 then
		-- block empty
	elseif ExploreMeowSkillCfg[ExploreMeowCfg[arg_15_1].skill].skill_type == 3 and arg_15_2 > 8 then
		-- block empty
	elseif ExploreMeowSkillCfg[ExploreMeowCfg[arg_15_1].skill].skill_type == 4 and arg_15_2 > 8 then
		-- block empty
	elseif ExploreMeowSkillCfg[ExploreMeowCfg[arg_15_1].skill].skill_type == 5 then
		-- block empty
	else
		arg_15_0.skillEffect = false
	end
end

function var_0_0.CalculateInbornRate(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.inbornEffect = false

	for iter_16_0, iter_16_1 in ipairs(ExploreMeowCfg[arg_16_1].area_recommend) do
		if iter_16_1 == arg_16_2 then
			arg_16_0.inbornEffect = true
		end
	end
end

function var_0_0:UpdateRegionRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	for iter_17_0, iter_17_1 in pairs(self.regionData) do
		manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. iter_17_1.regionID, manager.time:GetServerTime() >= iter_17_1.stopTime and 1 or 0)
	end

	self:UpdateAdminCatRedPoint()
	self:UpdateRewardRedPoint()
end

function var_0_0:UpdateFirstViewRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if self.isView then
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, self.level and self.exploringCount < ExploreLevelCfg[self.level].amount and 1 or 0)
	end
end

function var_0_0.UpdateQueueRedPoint(arg_19_0)
	arg_19_0.isView = true

	manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
end

function var_0_0:UpdateRewardRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if self:CheckCanGetWeeklyReward() and self.getWeeklyReward == 0 and self.exploreDay > 0 then
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 0)
	end
end

function var_0_0:CheckCanLock(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if self.accumulateC < iter_21_1[2] then
			return false
		end
	end

	return true
end

function var_0_0:UpdateAdminCatRedPoint()
	for iter_22_0 = 1, self.totalAdminCat do
		local var_22_0 = ExploreMeowCfg[ExploreMeowCfg.all[iter_22_0]]

		if self.unlockAdminCat[ExploreMeowCfg[ExploreMeowCfg.all[iter_22_0]].id] ~= true and self.level ~= nil then
			local var_22_2

			if (self.adminCatLockList[var_22_0.id] or 0) <= self.level then
				var_22_2 = self:CheckCanLock(var_22_0.unlock_condition)

				goto label_22_0
			end
		end

		var_22_2 = false and true

		::label_22_0::

		manager.redPoint:setTip(RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. var_22_0.id, var_22_2 and 1 or 0)
	end
end

function var_0_0:SortAdminCatList(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.unlockAdminCat) do
		local var_23_1 = 1000
		local var_23_2 = false

		for iter_23_2, iter_23_3 in ipairs(ExploreMeowCfg[iter_23_0].area_recommend) do
			if iter_23_3 == arg_23_1 then
				var_23_1 = var_23_1 * 1000
				var_23_2 = true
			end
		end

		table.insert(var_23_0, {
			canUse = true,
			sort = var_23_1,
			id = iter_23_0,
			recommend = var_23_2
		})
	end

	for iter_23_4, iter_23_5 in pairs(self.regionData) do
		for iter_23_6, iter_23_7 in ipairs(var_23_0) do
			if iter_23_7.id == iter_23_5.adminCatID then
				iter_23_7.sort = iter_23_7.sort / 1000
				iter_23_7.canUse = false
			end
		end
	end

	for iter_23_8, iter_23_9 in pairs(var_23_0) do
		iter_23_9.sort = iter_23_9.sort + iter_23_9.id
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		return arg_24_0.sort > arg_24_1.sort
	end)

	return var_23_0
end

function var_0_0:SortAllAdminCatList()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(ExploreMeowCfg.all) do
		local var_25_1

		if self.unlockAdminCat[iter_25_1] then
			var_25_1 = 100000 / 1000

			local var_25_3

			if not (100000 / 1000) then
				var_25_1 = 100000
				var_25_3 = {}
			end
		end

		var_25_3.sort = var_25_1 + iter_25_1
		var_25_3.id = iter_25_1
		var_25_3.canUse = self.unlockAdminCat[iter_25_1] or false

		table.insert(var_25_0, var_25_3)
	end

	for iter_25_2, iter_25_3 in pairs(self.regionData) do
		for iter_25_4, iter_25_5 in ipairs(var_25_0) do
			if iter_25_5.id == iter_25_3.adminCatID then
				iter_25_5.canLevelUp = false
			end
		end
	end

	table.sort(var_25_0, function(arg_26_0, arg_26_1)
		return arg_26_0.sort < arg_26_1.sort
	end)

	return var_25_0
end

function var_0_0:GetMinStopTime()
	local var_27_0 = 9999999999

	if self.regionData then
		for iter_27_0, iter_27_1 in pairs(self.regionData) do
			if iter_27_1.stopTime then
				var_27_0 = math.min(iter_27_1.stopTime, var_27_0)
			end
		end
	end

	return var_27_0
end

return var_0_0
