local var_0_0 = singletonClass("TowerData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitTowerData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_1.area
		local var_2_1 = iter_2_1.stage

		var_0_1[var_2_0] = var_2_1
	end
end

function var_0_0.UpdateOverTower(arg_3_0, arg_3_1, arg_3_2)
	if not var_0_1[arg_3_1] then
		var_0_1[arg_3_1] = arg_3_2
	else
		var_0_1[arg_3_1] = Mathf.Max(var_0_1[arg_3_1], arg_3_2)
	end
end

function var_0_0.GetCurId(arg_4_0, arg_4_1)
	local var_4_0 = ChapterCfg[arg_4_1].section_id_list
	local var_4_1 = var_0_1[arg_4_1]

	return var_4_0[(var_4_1 and table.indexof(var_4_0, var_4_1) or 0) + 1]
end

function var_0_0.GetOverId(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or 0
end

function var_0_0.GetTowerList(arg_6_0, arg_6_1)
	return ChapterCfg[arg_6_1].section_id_list
end

function var_0_0.GetTowerMaxId(arg_7_0)
	local var_7_0 = 0

	if var_0_1 then
		for iter_7_0, iter_7_1 in pairs(var_0_1) do
			var_7_0 = var_7_0 < iter_7_1 and iter_7_1 or var_7_0
		end
	end

	return var_7_0
end

function var_0_0.CheckIsOverStage(arg_8_0, arg_8_1, arg_8_2)
	if var_0_1[arg_8_1] and arg_8_2 <= var_0_1[arg_8_1] then
		return true
	end

	return false
end

function var_0_0.ReverseTable(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, #arg_9_1 do
		var_9_0[iter_9_0] = arg_9_1[#arg_9_1 + 1 - iter_9_0]
	end

	return var_9_0
end

function var_0_0.GetAllTowerList(arg_10_0)
	return BattleTowerStageCfg.all
end

function var_0_0.CacheTowerStageViewScrollPos(arg_11_0, arg_11_1)
	arg_11_0.towerStageViewScrollPos_ = arg_11_1
end

function var_0_0.GetTowerStageViewScrollPos(arg_12_0)
	return arg_12_0.towerStageViewScrollPos_
end

function var_0_0.CheckTowerOver(arg_13_0)
	local var_13_0 = ChapterClientCfg.get_id_list_by_toggle[401]

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = ChapterCfg[iter_13_1]
		local var_13_2 = var_13_1.section_id_list
		local var_13_3 = var_0_1[iter_13_1] or 0
		local var_13_4 = var_13_2[#var_13_2] or 0

		if PlayerData:GetPlayerInfo().userLevel >= var_13_1.level and var_13_3 < var_13_4 then
			return true
		end
	end

	return false
end

function var_0_0.GetMaxLevelReward(arg_14_0)
	local var_14_0 = ChapterClientCfg.get_id_list_by_toggle[401]
	local var_14_1
	local var_14_2
	local var_14_3

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_4 = ChapterCfg[iter_14_1]

		if PlayerData:GetPlayerInfo().userLevel >= var_14_4.level then
			var_14_1 = var_14_4
		end
	end

	local var_14_5 = var_14_1.section_id_list
	local var_14_6 = var_14_5[#var_14_5]
	local var_14_7 = BattleTowerStageCfg[var_14_6].drop_lib_id

	if var_14_7 ~= 0 then
		local var_14_8 = getRewardFromDropCfg(var_14_7, true)

		if var_14_8[1] then
			var_14_2 = var_14_8[1].id
		end

		if var_14_8[2] then
			var_14_3 = var_14_8[2].id
		end
	end

	return var_14_2, var_14_3
end

return var_0_0
