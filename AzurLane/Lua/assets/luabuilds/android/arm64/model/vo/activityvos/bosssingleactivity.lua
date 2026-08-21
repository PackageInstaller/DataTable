local var_0_0 = class("BossSingleActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.enemyData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetEnemyIds()) do
		arg_1_0.enemyData[iter_1_1] = BossSingleEnemyData.New({
			id = iter_1_1,
			index = iter_1_0
		})
	end

	return
end

function var_0_0.GetEnemyDatas(arg_2_0)
	return arg_2_0.enemyData
end

function var_0_0.GetEnemyDataById(arg_3_0, arg_3_1)
	return arg_3_0.enemyData[arg_3_1]
end

function var_0_0.GetEnemyDataByStageId(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.enemyData) do
		if iter_4_1:GetExpeditionId() == arg_4_1 then
			return iter_4_1
		end
	end

	return
end

function var_0_0.GetEnemyDataByFleetIdx(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.enemyData) do
		if iter_5_1:GetFleetIdx() == arg_5_1 then
			return iter_5_1
		end
	end

	return
end

function var_0_0.GetEnemyDataByType(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.enemyData) do
		if iter_6_1:GetType() == arg_6_1 then
			return iter_6_1
		end
	end

	return
end

function var_0_0.GetCommonEnemyDatas(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.enemyData) do
		if iter_7_1:GetType() == BossSingleEnemyData.TYPE.EAST or iter_7_1:GetType() == BossSingleEnemyData.TYPE.NORMAL or iter_7_1:GetType() == BossSingleEnemyData.TYPE.HARD then
			table.insert({}, iter_7_1)
		end
	end

	return {}
end

function var_0_0.GetStageIDs(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.enemyData) do
		({})[iter_8_1:GetFleetIdx()] = iter_8_1:GetExpeditionId()
	end

	return {}
end

function var_0_0.GetOilLimits(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.enemyData) do
		({})[iter_9_1:GetFleetIdx()] = iter_9_1:GetOilLimit()
	end

	return {}
end

function var_0_0.GetEnemyIds(arg_10_0)
	return arg_10_0:getConfig("config_data")
end

function var_0_0.GetDailyCounts(arg_11_0)
	return arg_11_0.data1_list
end

function var_0_0.AddDailyCount(arg_12_0, arg_12_1)
	if not arg_12_0:IsCountLimit(arg_12_1) then
		return
	end

	local var_12_0 = arg_12_0.enemyData[arg_12_1]:GetFleetIdx()
	local var_12_1 = arg_12_0:GetDailyCounts()[var_12_0] or 0

	arg_12_0:GetDailyCounts()[var_12_0] = var_12_1 + 1

	return
end

function var_0_0.GetPassStages(arg_13_0)
	return arg_13_0.data2_list
end

function var_0_0.AddPassStage(arg_14_0, arg_14_1)
	if arg_14_0:HasPassStage(arg_14_1) then
		return
	end

	table.insert(arg_14_0:GetPassStages(), arg_14_1)

	return
end

function var_0_0.HasPassStage(arg_15_0, arg_15_1)
	return table.contains(arg_15_0:GetPassStages(), arg_15_1)
end

function var_0_0.IsUnlockByEnemyId(arg_16_0, arg_16_1)
	if not arg_16_0.enemyData[arg_16_1] then
		return false
	end

	local var_16_0 = arg_16_0.enemyData[arg_16_1]:GetPreChapterId()

	return var_16_0 == 0 or arg_16_0:HasPassStage(arg_16_0.enemyData[var_16_0]:GetExpeditionId())
end

function var_0_0.IsCountLimit(arg_17_0, arg_17_1)
	if not arg_17_0.enemyData[arg_17_1] then
		return false
	end

	return arg_17_0.enemyData[arg_17_1]:GetCount() > 0
end

function var_0_0.GetCounts(arg_18_0, arg_18_1)
	if not arg_18_0.enemyData[arg_18_1] then
		return
	end

	local var_18_0 = arg_18_0.enemyData[arg_18_1]:GetCount() - arg_18_0:GetDailyCounts()[arg_18_0.enemyData[arg_18_1]:GetFleetIdx()]
	local var_18_1 = arg_18_0.enemyData[arg_18_1]:GetCount()
end

function var_0_0.CheckEntranceByIdx(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetEnemyDataByFleetIdx(arg_19_1)

	if not var_19_0 then
		return false, "not exist enemy data, index: " .. arg_19_1
	end

	if not var_19_0:InTime() then
		local var_19_2 = i18n("common_activity_end")

		return
	end

	if not arg_19_0:IsUnlockByEnemyId(var_19_0.id) then
		local var_19_4 = i18n("adventure_unlock_tip")

		return
	end

	return true
end

function var_0_0.CheckCntByIdx(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetEnemyDataByFleetIdx(arg_20_1)

	if not var_20_0 then
		return false, "not exist enemy data, index: " .. arg_20_1
	end

	if arg_20_0:IsCountLimit(var_20_0.id) and arg_20_0:GetCounts(var_20_0.id) <= 0 then
		local var_20_2 = i18n("sp_no_quota")

		return
	end

	return true
end

function var_0_0.GetBuffIdsByStageId(arg_21_0, arg_21_1)
	local var_21_0 = getProxy(ActivityProxy):getActivityById(arg_21_0:getConfig("config_id"))

	if not var_21_0 or var_21_0:isEnd() then
		return {}
	end

	local var_21_1 = arg_21_0:GetEnemyDataByStageId(arg_21_1)

	if not var_21_1:IsGuardianEffective() then
		return {}
	end

	return _.map(var_21_0.data2_list, function(arg_22_0)
		return pg.guardian_template[arg_22_0].buff
	end)
end

function var_0_0.IsShowExpTagDaily(arg_23_0, arg_23_1)
	if not arg_23_0:IsUnlockByEnemyId(arg_23_1.id) then
		return false
	end

	if not arg_23_1:InTime() then
		return false
	end

	local var_23_0 = arg_23_0:GetDailyCounts()[arg_23_1:GetFleetIdx()] or 0

	if var_23_0 >= 1 then
		return false
	end

	return true
end

return var_0_0
