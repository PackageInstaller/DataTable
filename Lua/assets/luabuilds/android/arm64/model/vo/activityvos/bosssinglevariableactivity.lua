local var_0_0 = class("BossSingleVariableActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.enemyData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetEnemyIds()) do
		arg_1_0.enemyData[iter_1_1] = BossSingleVariableEnemyData.New({
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
		if iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.EAST or iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.NORMAL or iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.HARD then
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

function var_0_0.GetPassStages(arg_11_0)
	return arg_11_0.data2_list
end

function var_0_0.AddPassStage(arg_12_0, arg_12_1)
	if arg_12_0:HasPassStage(arg_12_1) then
		return
	end

	table.insert(arg_12_0:GetPassStages(), arg_12_1)

	return
end

function var_0_0.HasPassStage(arg_13_0, arg_13_1)
	return table.contains(arg_13_0:GetPassStages(), arg_13_1)
end

function var_0_0.IsUnlockByEnemyId(arg_14_0, arg_14_1)
	if not arg_14_0.enemyData[arg_14_1] then
		return false
	end

	local var_14_0 = arg_14_0.enemyData[arg_14_1]:GetPreChapterId()

	return var_14_0 == 0 or arg_14_0:HasPassStage(arg_14_0.enemyData[var_14_0]:GetExpeditionId())
end

function var_0_0.IsCountLimit(arg_15_0, arg_15_1)
	if not arg_15_0.enemyData[arg_15_1] then
		return false
	end

	return arg_15_0.enemyData[arg_15_1]:GetCount() > 0
end

function var_0_0.CheckEntranceByIdx(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetEnemyDataByFleetIdx(arg_16_1)

	if not var_16_0 then
		return false, "not exist enemy data, index: " .. arg_16_1
	end

	if not var_16_0:InTime() then
		local var_16_2 = i18n("common_activity_end")

		return
	end

	if not arg_16_0:IsUnlockByEnemyId(var_16_0.id) then
		local var_16_4 = i18n("adventure_unlock_tip")

		return
	end

	return true
end

function var_0_0.CheckCntByIdx(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetEnemyDataByFleetIdx(arg_17_1)

	if not var_17_0 then
		return false, "not exist enemy data, index: " .. arg_17_1
	end

	if arg_17_0:IsCountLimit(var_17_0.id) and arg_17_0:GetCounts(var_17_0.id) <= 0 then
		local var_17_2 = i18n("sp_no_quota")

		return
	end

	return true
end

function var_0_0.GetBuffIdsByStageId(arg_18_0, arg_18_1)
	local var_18_0 = getProxy(ActivityProxy):getActivityById(arg_18_0:getConfig("config_id"))

	if not var_18_0 or var_18_0:isEnd() then
		return {}
	end

	local var_18_1 = arg_18_0:GetEnemyDataByStageId(arg_18_1)

	if not var_18_1:IsGuardianEffective() then
		return {}
	end

	return _.map(var_18_0.data2_list, function(arg_19_0)
		return pg.guardian_template[arg_19_0].buff
	end)
end

return var_0_0
