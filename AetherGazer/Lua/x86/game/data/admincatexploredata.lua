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

function var_0_0.Init(arg_2_0)
	arg_2_0.nextLockAdminCat = {}
	arg_2_0.nextLockRegion = {}
	arg_2_0.skillData = {}
	arg_2_0.adminCatLockList = {}
	arg_2_0.maxLevel = ExploreLevelCfg[#ExploreLevelCfg.all].id
	arg_2_0.unlockAdminCat = {}
	arg_2_0.exp = 0
	arg_2_0.regionUnlockLevel = {}
	arg_2_0.regionData = {}
	arg_2_0.isView = false

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(ExploreLevelCfg[1].area) do
		var_2_0[iter_2_1] = iter_2_1
	end

	for iter_2_2, iter_2_3 in pairs(ExploreLevelCfg[1].meow) do
		var_2_1[iter_2_3] = iter_2_3
	end

	for iter_2_4 = 2, arg_2_0.maxLevel do
		local var_2_2 = ExploreLevelCfg[iter_2_4]

		for iter_2_5, iter_2_6 in pairs(var_2_2.area) do
			if var_2_0[iter_2_6] == nil then
				var_2_0[iter_2_6] = iter_2_6
				arg_2_0.nextLockRegion[iter_2_4] = iter_2_6
				arg_2_0.regionUnlockLevel[iter_2_6] = iter_2_4
			end
		end

		for iter_2_7, iter_2_8 in pairs(var_2_2.meow) do
			if var_2_1[iter_2_8] == nil then
				var_2_1[iter_2_8] = iter_2_8
				arg_2_0.nextLockAdminCat[iter_2_4] = iter_2_8
				arg_2_0.adminCatLockList[iter_2_8] = iter_2_4
			end
		end
	end

	arg_2_0.totalAdminCat = #ExploreMeowCfg.all
	arg_2_0.rate = GameSetting.explore_accumulation_multiplying_power.value
	arg_2_0.rate[0] = 0
	arg_2_0.level = nil
end

function var_0_0.CalculateLevel(arg_3_0)
	local var_3_0 = ItemTools.getItemNum(53)
	local var_3_1 = 1

	for iter_3_0 = 1, arg_3_0.maxLevel do
		if var_3_0 >= ExploreLevelCfg[iter_3_0].exp and ExploreLevelCfg[iter_3_0].exp ~= 0 then
			var_3_0 = var_3_0 - ExploreLevelCfg[iter_3_0].exp
			var_3_1 = var_3_1 + 1
		end
	end

	if arg_3_0.level ~= nil and var_3_1 > arg_3_0.level then
		arg_3_0.level = var_3_1

		JumpTools.GoToSystem("/adminCatExploreLevelUpPop", {})
	end

	arg_3_0.level = var_3_1
	arg_3_0.exp = var_3_0
end

function var_0_0.CheckCanGetWeeklyReward(arg_4_0)
	local var_4_0 = manager.time:GetGameServerWeek()

	return var_4_0 == 6 or var_4_0 == 7
end

function var_0_0.CalculateMaxExploreHour(arg_5_0)
	arg_5_0.maxExploreHour = ExploreLevelCfg[arg_5_0.level].time
end

function var_0_0.GetRegionIdByIndex(arg_6_0, arg_6_1)
	return ExploreLevelCfg[arg_6_0.maxLevel].area[arg_6_1]
end

function var_0_0.ResetExploreDay(arg_7_0)
	arg_7_0.exploreDay = 0
	arg_7_0.getWeeklyReward = 1

	arg_7_0:UpdateRewardRedPoint()
end

function var_0_0.GetDataByPara(arg_8_0, arg_8_1)
	return arg_8_0[arg_8_1]
end

function var_0_0.ModifyData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:CalculateLevel()
end

function var_0_0.UpdateWeeklyFirst(arg_10_0)
	arg_10_0.isFirstOpen = 1
end

function var_0_0.InitExploreData(arg_11_0, arg_11_1)
	arg_11_0.exploringCount = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.explore_queue) do
		arg_11_0.regionData[iter_11_1.area_id] = {}
		arg_11_0.regionData[iter_11_1.area_id].regionID = iter_11_1.area_id
		arg_11_0.regionData[iter_11_1.area_id].startTime = iter_11_1.start_time
		arg_11_0.regionData[iter_11_1.area_id].adminCatID = iter_11_1.mimir_id
		arg_11_0.regionData[iter_11_1.area_id].stopTime = iter_11_1.stop_time
		arg_11_0.regionData[iter_11_1.area_id].exploreHour = iter_11_1.target_explore_hour
		arg_11_0.regionData[iter_11_1.area_id].eventData = var_0_1(iter_11_1.explore_event)
		arg_11_0.exploringCount = arg_11_0.exploringCount + 1
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.mimir) do
		arg_11_0.skillData[iter_11_3.skill[1].skill_id] = iter_11_3.skill[1].skill_level
		arg_11_0.unlockAdminCat[iter_11_3.mimir_id] = true
	end

	arg_11_0.exploreDay = arg_11_1.weekly_time
	arg_11_0.isFirstOpen = arg_11_1.weekly_scene_open
	arg_11_0.dailyTime = arg_11_1.daily_time
	arg_11_0.getWeeklyReward = arg_11_1.weekly_reward_state
	arg_11_0.accumulateC = arg_11_1.total_explore_c or 0

	arg_11_0:CalculateLevel()
	arg_11_0:UpdateFirstViewRedPoint()
	arg_11_0:UpdateRewardRedPoint()
end

function var_0_0.UpdateSkillList(arg_12_0, arg_12_1)
	if arg_12_0.skillData[arg_12_1] == nil then
		arg_12_0.skillData[arg_12_1] = 1
	else
		arg_12_0.skillData[arg_12_1] = arg_12_0.skillData[arg_12_1] + 1
	end
end

function var_0_0.UpdateUnlockAdminCatList(arg_13_0, arg_13_1)
	arg_13_0.unlockAdminCat[arg_13_1] = true

	local var_13_0 = ExploreMeowCfg[arg_13_1]

	arg_13_0:UpdateSkillList(var_13_0.skill)
	arg_13_0:UpdateAdminCatRedPoint()
end

function var_0_0.UpdateFinishExploreData(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_0.regionData[arg_14_1]

	arg_14_0:CalculateAdminCatRate(var_14_0.adminCatID, var_14_0.exploreHour)
	arg_14_0:CalculateInbornRate(var_14_0.adminCatID, arg_14_1)
	manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. var_14_0.regionID, 0)
	JumpTools.OpenPageByJump("adminCatExploreFinishPop", {
		regionId = arg_14_1,
		eventId = arg_14_2,
		reward = arg_14_3,
		adminCatID = var_14_0.adminCatID,
		callBack = arg_14_4
	})

	arg_14_0.regionData[arg_14_1] = nil

	arg_14_0:UpdateRewardRedPoint()
end

function var_0_0.CalculateAdminCatRate(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ExploreMeowCfg[arg_15_1].skill
	local var_15_1 = ExploreMeowSkillCfg[var_15_0].skill_type

	arg_15_0.skillEffect = true

	if var_15_1 == 1 and arg_15_2 <= 8 then
		-- block empty
	elseif var_15_1 == 2 and arg_15_2 <= 8 then
		-- block empty
	elseif var_15_1 == 3 and arg_15_2 > 8 then
		-- block empty
	elseif var_15_1 == 4 and arg_15_2 > 8 then
		-- block empty
	elseif var_15_1 == 5 then
		-- block empty
	else
		arg_15_0.skillEffect = false
	end
end

function var_0_0.CalculateInbornRate(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ExploreMeowCfg[arg_16_1]

	arg_16_0.inbornEffect = false

	for iter_16_0, iter_16_1 in ipairs(var_16_0.area_recommend) do
		if iter_16_1 == arg_16_2 then
			arg_16_0.inbornEffect = true
		end
	end
end

function var_0_0.UpdateRegionRedPoint(arg_17_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.regionData) do
		manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. iter_17_1.regionID, manager.time:GetServerTime() >= iter_17_1.stopTime and 1 or 0)
	end

	arg_17_0:UpdateAdminCatRedPoint()
	arg_17_0:UpdateRewardRedPoint()
end

function var_0_0.UpdateFirstViewRedPoint(arg_18_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if arg_18_0.isView then
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, arg_18_0.level and arg_18_0.exploringCount < ExploreLevelCfg[arg_18_0.level].amount and 1 or 0)
	end
end

function var_0_0.UpdateQueueRedPoint(arg_19_0)
	arg_19_0.isView = true

	manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
end

function var_0_0.UpdateRewardRedPoint(arg_20_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if arg_20_0:CheckCanGetWeeklyReward() and arg_20_0.getWeeklyReward == 0 and arg_20_0.exploreDay > 0 then
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 0)
	end
end

function var_0_0.CheckCanLock(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if arg_21_0.accumulateC < iter_21_1[2] then
			return false
		end
	end

	return true
end

function var_0_0.UpdateAdminCatRedPoint(arg_22_0)
	for iter_22_0 = 1, arg_22_0.totalAdminCat do
		local var_22_0 = ExploreMeowCfg[ExploreMeowCfg.all[iter_22_0]]
		local var_22_1 = arg_22_0.unlockAdminCat[var_22_0.id] ~= true and arg_22_0.level ~= nil and arg_22_0.level >= (arg_22_0.adminCatLockList[var_22_0.id] or 0) and arg_22_0:CheckCanLock(var_22_0.unlock_condition)

		manager.redPoint:setTip(RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. var_22_0.id, var_22_1 and 1 or 0)
	end
end

function var_0_0.SortAdminCatList(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0.unlockAdminCat) do
		local var_23_1 = ExploreMeowCfg[iter_23_0]
		local var_23_2 = 1000
		local var_23_3 = false

		for iter_23_2, iter_23_3 in ipairs(var_23_1.area_recommend) do
			if iter_23_3 == arg_23_1 then
				var_23_2 = var_23_2 * 1000
				var_23_3 = true
			end
		end

		table.insert(var_23_0, {
			canUse = true,
			sort = var_23_2,
			id = iter_23_0,
			recommend = var_23_3
		})
	end

	for iter_23_4, iter_23_5 in pairs(arg_23_0.regionData) do
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

function var_0_0.SortAllAdminCatList(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(ExploreMeowCfg.all) do
		local var_25_1 = 100000
		local var_25_2 = (arg_25_0.unlockAdminCat[iter_25_1] and var_25_1 / 1000 or var_25_1) + iter_25_1

		table.insert(var_25_0, {
			sort = var_25_2,
			id = iter_25_1,
			canUse = arg_25_0.unlockAdminCat[iter_25_1] or false
		})
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_0.regionData) do
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

function var_0_0.GetMinStopTime(arg_27_0)
	local var_27_0 = 9999999999

	if arg_27_0.regionData then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.regionData) do
			if iter_27_1.stopTime then
				var_27_0 = math.min(iter_27_1.stopTime, var_27_0)
			end
		end
	end

	return var_27_0
end

return var_0_0
