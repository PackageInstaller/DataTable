local BossSingleActivity = class("BossSingleActivity", import("model.vo.Activity"))

function BossSingleActivity:Ctor(arg_1_1)
	BossSingleActivity.super.Ctor(self, arg_1_1)

	self.enemyData = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetEnemyIds()) do
		self.enemyData[iter_1_1] = BossSingleEnemyData.New({
			id = iter_1_1,
			index = iter_1_0
		})
	end

	return
end

function BossSingleActivity:GetEnemyDatas()
	return self.enemyData
end

function BossSingleActivity:GetEnemyDataById(arg_3_1)
	return self.enemyData[arg_3_1]
end

function BossSingleActivity:GetEnemyDataByStageId(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.enemyData) do
		if iter_4_1:GetExpeditionId() == arg_4_1 then
			return iter_4_1
		end
	end

	return
end

function BossSingleActivity:GetEnemyDataByFleetIdx(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.enemyData) do
		if iter_5_1:GetFleetIdx() == arg_5_1 then
			return iter_5_1
		end
	end

	return
end

function BossSingleActivity:GetEnemyDataByType(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.enemyData) do
		if iter_6_1:GetType() == arg_6_1 then
			return iter_6_1
		end
	end

	return
end

function BossSingleActivity:GetCommonEnemyDatas()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.enemyData) do
		if iter_7_1:GetType() == BossSingleEnemyData.TYPE.EAST or iter_7_1:GetType() == BossSingleEnemyData.TYPE.NORMAL or iter_7_1:GetType() == BossSingleEnemyData.TYPE.HARD then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function BossSingleActivity:GetStageIDs()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.enemyData) do
		var_8_0[iter_8_1:GetFleetIdx()] = iter_8_1:GetExpeditionId()
	end

	return var_8_0
end

function BossSingleActivity:GetOilLimits()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.enemyData) do
		var_9_0[iter_9_1:GetFleetIdx()] = iter_9_1:GetOilLimit()
	end

	return var_9_0
end

function BossSingleActivity:GetEnemyIds()
	return self:getConfig("config_data")
end

function BossSingleActivity:GetDailyCounts()
	return self.data1_list
end

function BossSingleActivity:AddDailyCount(arg_12_1)
	if not self:IsCountLimit(arg_12_1) then
		return
	end

	local var_12_0 = self.enemyData[arg_12_1]:GetFleetIdx()

	self:GetDailyCounts()[var_12_0] = (self:GetDailyCounts()[var_12_0] or 0) + 1

	return
end

function BossSingleActivity:GetPassStages()
	return self.data2_list
end

function BossSingleActivity:AddPassStage(arg_14_1)
	if self:HasPassStage(arg_14_1) then
		return
	end

	table.insert(self:GetPassStages(), arg_14_1)

	return
end

function BossSingleActivity:HasPassStage(arg_15_1)
	return table.contains(self:GetPassStages(), arg_15_1)
end

function BossSingleActivity:IsUnlockByEnemyId(arg_16_1)
	if not self.enemyData[arg_16_1] then
		return false
	end

	local var_16_0 = self.enemyData[arg_16_1]:GetPreChapterId()

	return var_16_0 == 0 or self:HasPassStage(self.enemyData[var_16_0]:GetExpeditionId())
end

function BossSingleActivity:IsCountLimit(arg_17_1)
	if not self.enemyData[arg_17_1] then
		return false
	end

	return self.enemyData[arg_17_1]:GetCount() > 0
end

function BossSingleActivity:GetCounts(arg_18_1)
	if not self.enemyData[arg_18_1] then
		return
	end

	local var_18_0 = self.enemyData[arg_18_1]:GetCount() - self:GetDailyCounts()[self.enemyData[arg_18_1]:GetFleetIdx()]
	local var_18_1 = self.enemyData[arg_18_1]:GetCount()
end

function BossSingleActivity:CheckEntranceByIdx(arg_19_1)
	local var_19_0 = self:GetEnemyDataByFleetIdx(arg_19_1)

	if not var_19_0 then
		return false, "not exist enemy data, index: " .. arg_19_1
	end

	if not var_19_0:InTime() then
		local var_19_2 = i18n("common_activity_end")

		return
	end

	if not self:IsUnlockByEnemyId(var_19_0.id) then
		local var_19_4 = i18n("adventure_unlock_tip")

		return
	end

	return true
end

function BossSingleActivity:CheckCntByIdx(arg_20_1)
	local var_20_0 = self:GetEnemyDataByFleetIdx(arg_20_1)

	if not var_20_0 then
		return false, "not exist enemy data, index: " .. arg_20_1
	end

	if self:IsCountLimit(var_20_0.id) and self:GetCounts(var_20_0.id) <= 0 then
		local var_20_2 = i18n("sp_no_quota")

		return
	end

	return true
end

function BossSingleActivity:GetBuffIdsByStageId(arg_21_1)
	local var_21_0 = getProxy(ActivityProxy):getActivityById(self:getConfig("config_id"))

	if not var_21_0 or var_21_0:isEnd() then
		return {}
	end

	if not self:GetEnemyDataByStageId(arg_21_1):IsGuardianEffective() then
		return {}
	end

	return _.map(var_21_0.data2_list, function(arg_22_0)
		return pg.guardian_template[arg_22_0].buff
	end)
end

function BossSingleActivity:IsShowExpTagDaily(arg_23_1)
	if not self:IsUnlockByEnemyId(arg_23_1.id) then
		return false
	end

	if not arg_23_1:InTime() then
		return false
	end

	if (self:GetDailyCounts()[arg_23_1:GetFleetIdx()] or 0) >= 1 then
		return false
	end

	return true
end

return BossSingleActivity
