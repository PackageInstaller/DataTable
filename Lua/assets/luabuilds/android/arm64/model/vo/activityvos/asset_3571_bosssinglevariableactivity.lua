local BossSingleVariableActivity = class("BossSingleVariableActivity", import("model.vo.Activity"))

function BossSingleVariableActivity:Ctor(arg_1_1)
	BossSingleVariableActivity.super.Ctor(self, arg_1_1)

	self.enemyData = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetEnemyIds()) do
		self.enemyData[iter_1_1] = BossSingleVariableEnemyData.New({
			id = iter_1_1,
			index = iter_1_0
		})
	end

	return
end

function BossSingleVariableActivity:GetEnemyDatas()
	return self.enemyData
end

function BossSingleVariableActivity:GetEnemyDataById(arg_3_1)
	return self.enemyData[arg_3_1]
end

function BossSingleVariableActivity:GetEnemyDataByStageId(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.enemyData) do
		if iter_4_1:GetExpeditionId() == arg_4_1 then
			return iter_4_1
		end
	end

	return
end

function BossSingleVariableActivity:GetEnemyDataByFleetIdx(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.enemyData) do
		if iter_5_1:GetFleetIdx() == arg_5_1 then
			return iter_5_1
		end
	end

	return
end

function BossSingleVariableActivity:GetEnemyDataByType(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.enemyData) do
		if iter_6_1:GetType() == arg_6_1 then
			return iter_6_1
		end
	end

	return
end

function BossSingleVariableActivity:GetCommonEnemyDatas()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.enemyData) do
		if iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.EAST or iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.NORMAL or iter_7_1:GetType() == BossSingleVariableEnemyData.TYPE.HARD then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function BossSingleVariableActivity:GetStageIDs()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.enemyData) do
		var_8_0[iter_8_1:GetFleetIdx()] = iter_8_1:GetExpeditionId()
	end

	return var_8_0
end

function BossSingleVariableActivity:GetOilLimits()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.enemyData) do
		var_9_0[iter_9_1:GetFleetIdx()] = iter_9_1:GetOilLimit()
	end

	return var_9_0
end

function BossSingleVariableActivity:GetEnemyIds()
	return self:getConfig("config_data")
end

function BossSingleVariableActivity:GetPassStages()
	return self.data2_list
end

function BossSingleVariableActivity:AddPassStage(arg_12_1)
	if self:HasPassStage(arg_12_1) then
		return
	end

	table.insert(self:GetPassStages(), arg_12_1)

	return
end

function BossSingleVariableActivity:HasPassStage(arg_13_1)
	return table.contains(self:GetPassStages(), arg_13_1)
end

function BossSingleVariableActivity:IsUnlockByEnemyId(arg_14_1)
	if not self.enemyData[arg_14_1] then
		return false
	end

	local var_14_0 = self.enemyData[arg_14_1]:GetPreChapterId()

	return var_14_0 == 0 or self:HasPassStage(self.enemyData[var_14_0]:GetExpeditionId())
end

function BossSingleVariableActivity:IsCountLimit(arg_15_1)
	if not self.enemyData[arg_15_1] then
		return false
	end

	return self.enemyData[arg_15_1]:GetCount() > 0
end

function BossSingleVariableActivity:CheckEntranceByIdx(arg_16_1)
	local var_16_0 = self:GetEnemyDataByFleetIdx(arg_16_1)

	if not var_16_0 then
		return false, "not exist enemy data, index: " .. arg_16_1
	end

	if not var_16_0:InTime() then
		local var_16_2 = i18n("common_activity_end")

		return
	end

	if not self:IsUnlockByEnemyId(var_16_0.id) then
		local var_16_4 = i18n("adventure_unlock_tip")

		return
	end

	return true
end

function BossSingleVariableActivity:CheckCntByIdx(arg_17_1)
	local var_17_0 = self:GetEnemyDataByFleetIdx(arg_17_1)

	if not var_17_0 then
		return false, "not exist enemy data, index: " .. arg_17_1
	end

	if self:IsCountLimit(var_17_0.id) and self:GetCounts(var_17_0.id) <= 0 then
		local var_17_2 = i18n("sp_no_quota")

		return
	end

	return true
end

function BossSingleVariableActivity:GetBuffIdsByStageId(arg_18_1)
	local var_18_0 = getProxy(ActivityProxy):getActivityById(self:getConfig("config_id"))

	if not var_18_0 or var_18_0:isEnd() then
		return {}
	end

	if not self:GetEnemyDataByStageId(arg_18_1):IsGuardianEffective() then
		return {}
	end

	return _.map(var_18_0.data2_list, function(arg_19_0)
		return pg.guardian_template[arg_19_0].buff
	end)
end

return BossSingleVariableActivity
