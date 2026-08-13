class = var_0_10000

local var_0_0 = "BossSingleActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.enemyData = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:GetEnemyIds()) do
		BossSingleEnemyData = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_1_1,
			index = iter_1_0
		})
		arg_1_0.enemyData[iter_1_1] = var_1_10007
	end

	return
end

function var_0_1.GetEnemyDatas(arg_2_0)
	return arg_2_0.enemyData
end

function var_0_1.GetEnemyDataById(arg_3_0, arg_3_1)
	return arg_3_0.enemyData[arg_3_1]
end

function var_0_1.GetEnemyDataByStageId(arg_4_0, arg_4_1)
	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.enemyData) do
		if iter_4_1:GetExpeditionId() == arg_4_1 then
			return iter_4_1
		end
	end

	return
end

function var_0_1.GetEnemyDataByFleetIdx(arg_5_0, arg_5_1)
	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.enemyData) do
		if iter_5_1:GetFleetIdx() == arg_5_1 then
			return iter_5_1
		end
	end

	return
end

function var_0_1.GetEnemyDataByType(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.enemyData) do
		if iter_6_1:GetType() == arg_6_1 then
			return iter_6_1
		end
	end

	return
end

function var_0_1.GetCommonEnemyDatas(arg_7_0)
	local var_7_0 = {}

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.enemyData) do
		local var_7_1 = iter_7_1:GetType()

		BossSingleEnemyData = var_1_10008

		if var_7_1 ~= var_1_10008.TYPE.EAST then
			var_7_1 = iter_7_1:GetType()
			BossSingleEnemyData = var_1_10008

			if var_7_1 ~= var_1_10008.TYPE.NORMAL then
				var_7_1 = iter_7_1:GetType()
				BossSingleEnemyData = var_1_10008

				if var_7_1 == var_1_10008.TYPE.HARD then
					table = var_7_1

					var_7_1.insert(var_7_0, iter_7_1)
				end
			end
		end
	end

	return var_7_0
end

function var_0_1.GetStageIDs(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.enemyData) do
		var_8_0[iter_8_1:GetFleetIdx()] = iter_8_1:GetExpeditionId()
	end

	return var_8_0
end

function var_0_1.GetOilLimits(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.enemyData) do
		var_9_0[iter_9_1:GetFleetIdx()] = iter_9_1:GetOilLimit()
	end

	return var_9_0
end

function var_0_1.GetEnemyIds(arg_10_0)
	return arg_10_0:getConfig("config_data")
end

function var_0_1.GetDailyCounts(arg_11_0)
	return arg_11_0.data1_list
end

function var_0_1.AddDailyCount(arg_12_0, arg_12_1)
	if not arg_12_0:IsCountLimit(arg_12_1) then
		return
	end

	local var_12_0 = arg_12_0.enemyData[arg_12_1]
	local var_12_1 = var_2.GetFleetIdx(var_12_0)
	local var_12_2 = arg_12_0:GetDailyCounts()
	local var_12_3

	if not arg_12_0:GetDailyCounts()[var_12_1] then
		var_12_3 = 0
	end

	var_12_2[var_12_1] = var_12_3 + 1

	return
end

function var_0_1.GetPassStages(arg_13_0)
	return arg_13_0.data2_list
end

function var_0_1.AddPassStage(arg_14_0, arg_14_1)
	if arg_14_0:HasPassStage(arg_14_1) then
		return
	end

	table = var_2

	var_2.insert(arg_14_0:GetPassStages(), arg_14_1)

	return
end

function var_0_1.HasPassStage(arg_15_0, arg_15_1)
	table = var_1_10002

	return var_1_10002.contains(arg_15_0:GetPassStages(), arg_15_1)
end

function var_0_1.IsUnlockByEnemyId(arg_16_0, arg_16_1)
	if not arg_16_0.enemyData[arg_16_1] then
		return false
	end

	local var_16_0 = arg_16_0.enemyData[arg_16_1]
	local var_16_4

	if var_2.GetPreChapterId(var_16_0) ~= 0 then
		local var_16_1 = arg_16_0
		local var_16_2 = arg_16_0.HasPassStage
		local var_16_3 = arg_16_0.enemyData[var_2]

		var_16_4 = var_16_2(var_16_1, var_6.GetExpeditionId(var_16_3))

		if false then
			var_16_4 = false
		end
	else
		var_16_4 = true
	end

	return var_16_4
end

function var_0_1.IsCountLimit(arg_17_0, arg_17_1)
	if not arg_17_0.enemyData[arg_17_1] then
		return false
	end

	local var_17_0 = arg_17_0.enemyData[arg_17_1]

	return var_2.GetCount(var_17_0) > 0
end

function var_0_1.GetCounts(arg_18_0, arg_18_1)
	if not arg_18_0.enemyData[arg_18_1] then
		return
	end

	local var_18_0 = var_2:GetFleetIdx()
	local var_18_1 = var_2:GetCount() - arg_18_0:GetDailyCounts()[var_18_0]
	local var_18_2 = var_2:GetCount()
end

function var_0_1.CheckEntranceByIdx(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0

	if not arg_19_0.GetEnemyDataByFleetIdx(var_19_0, arg_19_1) then
		return false, "not exist enemy data, index: " .. arg_19_1
	end

	if not var_2:InTime() then
		local var_19_1 = false

		i18n = var_19_0
		var_19_0 = var_19_0("common_activity_end")

		return
	end

	if not arg_19_0:IsUnlockByEnemyId(var_2.id) then
		local var_19_2 = false

		i18n = var_19_0

		local var_19_3 = var_19_0("adventure_unlock_tip")

		return
	end

	return true
end

function var_0_1.CheckCntByIdx(arg_20_0, arg_20_1)
	if not arg_20_0:GetEnemyDataByFleetIdx(arg_20_1) then
		return false, "not exist enemy data, index: " .. arg_20_1
	end

	if arg_20_0:IsCountLimit(var_2.id) and arg_20_0:GetCounts(var_2.id) <= 0 then
		local var_20_0 = false

		i18n = var_4

		local var_20_1 = var_4("sp_no_quota")

		return
	end

	return true
end

function var_0_1.GetBuffIdsByStageId(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_21_0 = var_1_10002(var_1_10004)

	if not var_2.getActivityById(var_21_0, arg_21_0:getConfig("config_id")) or var_2:isEnd() then
		return {}
	end

	local var_21_1 = arg_21_0:GetEnemyDataByStageId(arg_21_1)

	if not var_3.IsGuardianEffective(var_21_1) then
		return {}
	end

	_ = var_4

	return var_4.map(var_2.data2_list, function(arg_22_0)
		pg = var_2_10001

		return var_2_10001.guardian_template[arg_22_0].buff
	end)
end

function var_0_1.IsShowExpTagDaily(arg_23_0, arg_23_1)
	if not arg_23_0:IsUnlockByEnemyId(arg_23_1.id) then
		return false
	end

	if not arg_23_1:InTime() then
		return false
	end

	local var_23_0 = arg_23_1:GetFleetIdx()
	local var_23_1

	if not arg_23_0:GetDailyCounts()[var_23_0] then
		var_23_1 = 0
	end

	if var_23_1 >= 1 then
		return false
	end

	return true
end

return var_0_1
