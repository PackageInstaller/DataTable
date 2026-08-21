local var_0_0 = singletonClass("HeroRaceCollectData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4

function var_0_0.GetHeroCntNeedOfEachTier()
	return var_0_4
end

local var_0_5

function var_0_0.GetRewardOfTier(arg_2_0)
	return var_0_5
end

local var_0_6

function var_0_0.Init(arg_3_0)
	var_0_6 = nil
	var_0_4 = nullable(GameSetting, "hero_race_collect_each_tier", "value", 1) or 3

	local var_3_0 = nullable(GameSetting, "hero_race_collect_reward_list", "value") or {}

	var_0_5 = formatRewardCfgList(var_3_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}

	local var_3_1 = RaceEffectCfg.all

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		var_0_1[iter_3_1] = 0
	end
end

function var_0_0.InitData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.hero_race_collect) do
		local var_4_0 = iter_4_1.race_type
		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.cnt_list) do
			var_4_1[iter_4_3] = true
		end

		var_0_2[var_4_0] = var_4_1
	end

	arg_4_0:RefreshHeroRaceCounts()

	for iter_4_4, iter_4_5 in pairs(RaceEffectCfg.all) do
		var_0_2[iter_4_5] = var_0_2[iter_4_5] or {}

		arg_4_0:RefreshTasksState(iter_4_5)
	end

	arg_4_0:UpdateRedPoint()
end

function var_0_0.RefreshHeroRaceCounts(arg_5_0)
	local var_5_0 = RaceEffectCfg.all

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		var_0_1[iter_5_1] = 0
	end

	local var_5_1 = HeroData:GetUnlockHeros()

	for iter_5_2, iter_5_3 in pairs(var_5_1) do
		local var_5_2 = HeroCfg[iter_5_3].race

		var_0_1[var_5_2] = var_0_1[var_5_2] + 1
	end
end

function var_0_0.NewHeroUnlock(arg_6_0, arg_6_1)
	local var_6_0 = HeroCfg[arg_6_1].race

	arg_6_0:RefreshHeroRaceCounts()
	arg_6_0:RefreshTasksState(var_6_0)
	arg_6_0:UpdateRedPoint()
end

local function var_0_7()
	var_0_6 = {}

	local var_7_0 = HeroData:GetHeroIDList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_1 = HeroCfg[iter_7_1].race

		var_0_6[var_7_1] = (var_0_6[var_7_1] or 0) + 1
	end
end

function var_0_0.GetHeroCollectLimit(arg_8_0)
	if var_0_6 == nil then
		var_0_7()
	end

	return var_0_6[arg_8_0] or 0
end

function var_0_0.GetHeroCollectoMaxTier(arg_9_0)
	return math.floor(var_0_0.GetHeroCollectLimit(arg_9_0) / var_0_0.GetHeroCntNeedOfEachTier())
end

function var_0_0.GetHeroRaceCount(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return var_0_1[arg_10_1]
	end
end

function var_0_0.GetTaskID(arg_11_0, arg_11_1)
	return string.format("1%d%02d", arg_11_0, arg_11_1)
end

function var_0_0.RefreshTasksState(arg_12_0, arg_12_1)
	for iter_12_0 = 1, var_0_0.GetHeroCollectoMaxTier(arg_12_1) do
		local var_12_0 = iter_12_0 * var_0_0.GetHeroCntNeedOfEachTier()
		local var_12_1 = var_0_1[arg_12_1]

		if var_0_2[arg_12_1][var_12_0] then
			arg_12_0:SetTaskState(arg_12_1, iter_12_0, 2)
		elseif var_12_1 < var_12_0 then
			arg_12_0:SetTaskState(arg_12_1, iter_12_0, 0)
		else
			arg_12_0:SetTaskState(arg_12_1, iter_12_0, 1)
		end
	end
end

function var_0_0.GetTaskState(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_0.GetTaskID(arg_13_1, arg_13_2)

	return nullable(var_0_3, var_13_0, "state") or 0
end

function var_0_0.SetTaskState(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = var_0_0.GetTaskID(arg_14_1, arg_14_2)
	local var_14_1 = var_0_3[var_14_0]

	if var_14_1 == nil then
		var_14_1 = {
			race = arg_14_1,
			tier = arg_14_2
		}
	end

	var_14_1.state = arg_14_3
	var_0_3[var_14_0] = var_14_1
end

function var_0_0.GetAllCanReceiveTasks(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(var_0_3) do
		if iter_15_1.state == 1 then
			local var_15_1 = iter_15_1.race
			local var_15_2 = var_15_0[var_15_1] or {}

			var_15_2[iter_15_1.tier] = true
			var_15_0[var_15_1] = var_15_2
		end
	end

	local var_15_3 = {}

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		local var_15_4 = {
			race_type = iter_15_2,
			cnt_list = {}
		}

		for iter_15_4, iter_15_5 in pairs(iter_15_3) do
			if iter_15_5 then
				local var_15_5 = iter_15_4 * var_0_0.GetHeroCntNeedOfEachTier()

				table.insert(var_15_4.cnt_list, var_15_5)
			end
		end

		table.insert(var_15_3, var_15_4)
	end

	return var_15_3
end

function var_0_0.SetTasksReceived(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_0 = iter_16_1.race_type
		local var_16_1 = var_0_2[var_16_0]

		for iter_16_2, iter_16_3 in ipairs(iter_16_1.cnt_list) do
			var_16_1[iter_16_3] = true
		end

		arg_16_0:RefreshTasksState(var_16_0)
	end

	arg_16_0:UpdateRedPoint()
end

function var_0_0.GetTasksReceivedCount(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(var_0_3) do
		if iter_17_1.state == 2 then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_0.GetTaskTotalCount(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(RaceEffectCfg.all) do
		var_18_0 = var_18_0 + var_0_0.GetHeroCollectoMaxTier(iter_18_1)
	end

	return var_18_0
end

function var_0_0.UpdateRedPoint(arg_19_0)
	local var_19_0 = arg_19_0:HasRewardReceive()

	manager.redPoint:setTip(RedPointConst.HERO_RACE_COLLECT_REWARD, var_19_0 and 1 or 0)
end

function var_0_0.HasRewardReceive(arg_20_0)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(var_0_3) do
		if iter_20_1.state == 1 then
			var_20_0 = true

			break
		end
	end

	return var_20_0
end

return var_0_0
