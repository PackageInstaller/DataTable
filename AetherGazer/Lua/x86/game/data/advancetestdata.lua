local var_0_0 = singletonClass("AdvanceTestData", BaseHeroViewData)
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	arg_1_0.cacheActivityID = 0
	arg_1_0.lastSelectIndex = {}
	arg_1_0.battleResultScore = 0
	arg_1_0.activityIDList = {}
	arg_1_0.scoreList = {}
	arg_1_0.affixList_ = {}
	arg_1_0.recordSelectBuffList = {}
end

function var_0_0.GetActivityList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.activityIDList) do
		table.insert(var_2_0, iter_2_1)
	end

	return var_2_0
end

function var_0_0.GetCacheActivityID(arg_3_0)
	return arg_3_0.cacheActivityID
end

function var_0_0.SetCacheActivityID(arg_4_0, arg_4_1)
	arg_4_0.cacheActivityID = arg_4_1
end

function var_0_0.GetLastSelectIndex(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.lastSelectIndex[arg_5_1]

	if var_5_0 and AdvanceTestCfg[var_5_0] then
		return var_5_0
	else
		local var_5_1 = AdvanceTestCfg.get_id_list_by_activity_id[arg_5_1]

		return var_5_1 and var_5_1[1]
	end
end

function var_0_0.SetLastSelectIndex(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.lastSelectIndex[arg_6_2] = arg_6_1
end

function var_0_0.InitDefalutHeroList(arg_7_0)
	arg_7_0.heroList = clone(HeroData:GetHeroList())

	for iter_7_0, iter_7_1 in pairs(arg_7_0.heroList) do
		iter_7_1.servantInfo = clone(iter_7_1:GetServantInfo())

		function iter_7_1.GetServantInfo()
			return iter_7_1.servantInfo
		end
	end
end

function var_0_0.GetHeroList(arg_9_0)
	return arg_9_0.heroList
end

function var_0_0.GetSortedHeroList(arg_10_0)
	return (HeroTools.Sort(arg_10_0:GetHeroList()))
end

function var_0_0.GetAdvanceHeroData(arg_11_0, arg_11_1)
	return arg_11_0.heroList[arg_11_1]
end

function var_0_0.GetCurCfgByIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = AdvanceTestCfg.get_id_list_by_activity_id[arg_12_2]
	local var_12_1

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if AdvanceTestCfg[iter_12_1].stage_type == arg_12_1 then
			var_12_1 = AdvanceTestCfg[iter_12_1]

			break
		end
	end

	return var_12_1
end

function var_0_0.SetHeroListByDifficult(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetCurCfgByIndex(arg_13_1, arg_13_2)
	local var_13_1 = var_13_0.character
	local var_13_2 = var_13_0.weapon
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0.limit_hero) do
		if iter_13_1[1] == 8 then
			local var_13_4 = iter_13_1[2]

			table.insert(var_13_3, var_13_4[1], var_13_4[2])
		end
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.heroList) do
		iter_13_3.star = var_13_1

		if iter_13_3.servant_uid ~= 0 and iter_13_3.unlock == 1 then
			iter_13_3.servantInfo.stage = var_13_2
		end

		local var_13_5 = iter_13_3.id
		local var_13_6 = var_13_3[var_13_5]

		if var_13_6 then
			local var_13_7 = HeroCfg[var_13_5].astrolabe[var_13_6]

			iter_13_3.using_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_13_7]
		end
	end
end

function var_0_0.GetIsActivityOpen(arg_14_0)
	local var_14_0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.activityIDList) do
		if ActivityData:GetActivityIsOpen(iter_14_1) then
			return true
		end
	end

	return false
end

function var_0_0.OnReceviedAdvanceTestData(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		return
	else
		if not arg_15_0.scoreList[arg_15_1.activity_id] then
			arg_15_0.scoreList[arg_15_1.activity_id] = {}
		end

		if not arg_15_0.activityIDList[arg_15_1.activity_id] then
			arg_15_0.activityIDList[arg_15_1.activity_id] = arg_15_1.activity_id
		end

		arg_15_0.subActivityList = AdvanceTestCfg.get_id_list_by_activity_id[arg_15_1.activity_id]

		for iter_15_0, iter_15_1 in ipairs(arg_15_1.stage_list) do
			local var_15_0 = AdvanceTestCfg[arg_15_0.subActivityList[iter_15_0]].stage_type

			arg_15_0.scoreList[arg_15_1.activity_id][var_15_0] = iter_15_1.history_max_score
		end
	end
end

function var_0_0.OnReceviedBattleResult(arg_16_0, arg_16_1)
	local var_16_0 = AdvanceTestCfg[arg_16_1.id]

	arg_16_0.battleResultScore = arg_16_1.score

	if not arg_16_0.scoreList[arg_16_1.activity_id] then
		arg_16_0.scoreList[arg_16_1.activity_id] = {}
	end

	arg_16_0.scoreList[arg_16_1.activity_id][var_16_0.stage_type] = arg_16_1.history_max_score
end

function var_0_0.GetBattleResultScore(arg_17_0)
	return arg_17_0.battleResultScore
end

function var_0_0.GetHistortyMaxScoreByIndex(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0.scoreList or not arg_18_0.scoreList[arg_18_2] or not arg_18_0.scoreList[arg_18_2][arg_18_1] then
		return -1
	end

	return arg_18_0.scoreList[arg_18_2][arg_18_1]
end

function var_0_0.SetAffixList(arg_19_0, arg_19_1)
	arg_19_0.affixList_ = arg_19_1
end

function var_0_0.GetAffixList(arg_20_0)
	return arg_20_0.affixList_ or {}
end

local var_0_2 = {
	ALL = 1,
	GUILD = 2
}
local var_0_3 = var_0_2.ALL

function var_0_0.GetCurActivityID(arg_21_0)
	local var_21_0 = ActivityCfg[arg_21_0.cacheActivityID].sub_activity_list

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_1 = ActivityData:GetActivityData(iter_21_1)

		if manager.time:GetServerTime() >= var_21_1.startTime and manager.time:GetServerTime() < var_21_1.stopTime then
			return iter_21_1
		end
	end

	return 0
end

function var_0_0.GetRankTypeConst(arg_22_0)
	return var_0_2
end

function var_0_0.GetCurRankType(arg_23_0)
	return var_0_3
end

function var_0_0.SetCurRankType(arg_24_0, arg_24_1)
	var_0_3 = arg_24_1
end

function var_0_0.RecordSelectAffix(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0.recordSelectBuffList[arg_25_1] = {
		select_gen_list = arg_25_2,
		buff_id_list = arg_25_3
	}
end

function var_0_0.GetSelectBuffList(arg_26_0, arg_26_1)
	return arg_26_0.recordSelectBuffList[arg_26_1] and arg_26_0.recordSelectBuffList[arg_26_1].buff_id_list or {}
end

function var_0_0.GetSelectGen(arg_27_0, arg_27_1)
	return arg_27_0.recordSelectBuffList[arg_27_1] and arg_27_0.recordSelectBuffList[arg_27_1].select_gen_list or {}
end

return var_0_0
