local var_0_0 = singletonClass("SimBusinessData")

function var_0_0.Init(arg_1_0)
	arg_1_0.shelf = {}
	arg_1_0.cacheEditShelfInfo = nil
	arg_1_0.cost = 0
end

function var_0_0:NetToLocalLayoutInfo()
	return {
		cfgID = self.id,
		goods = self.goods_id,
		pos = Vector3(self.x, 0, self.y),
		forward = Vector3.forward * Quaternion.AngleAxis(self.rotation, Vector3.up)
	}
end

function var_0_0:LocalToNetLayoutInfo()
	local var_3_0 = {
		id = self.cfgID
	}

	var_3_0.goods_id = self.goods or 0
	var_3_0.x = self.pos.x
	var_3_0.y = self.pos.z
	var_3_0.rotation = math.round(Vector3.AngleAroundAxis(Vector3.forward, self.forward, Vector3.up))

	return var_3_0
end

local function var_0_1(arg_4_0, arg_4_1)
	arg_4_0.layout = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.shelf_pos_list) do
		table.insert(arg_4_0.layout, var_0_0.NetToLocalLayoutInfo(iter_4_1))
	end
end

local var_0_2 = 0

local function var_0_5(arg_7_0)
	return {
		clear = false,
		id = arg_7_0
	}
end

local function var_0_7(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[var_0_2]) do
		arg_9_0.level[iter_9_1] = var_0_5(iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
		arg_9_0.level[iter_9_3.id].clear = iter_9_3.is_clear
	end
end

local function var_0_8(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = var_0_5(iter_10_1.id)

		var_10_0.clear = iter_10_1.is_clear
		var_10_0.costMinRecord = iter_10_1.cost_min_coin
		arg_10_0.level[iter_10_1.id] = var_10_0
	end
end

function var_0_0:InitFromServer(arg_11_1)
	self.activityID = arg_11_1.activity_id
	self.businessLevel = arg_11_1.business_level
	self.shelf = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.shelf_list) do
		self.shelf[iter_11_1.id] = iter_11_1.level
	end

	self.unlockGoods = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.goods_id_list) do
		self.unlockGoods[iter_11_3] = true
	end

	self.level = {}

	var_0_1(self, arg_11_1.layout)
	var_0_7(self, arg_11_1.wave_stage)
	var_0_8(self, arg_11_1.challenge_stage_list)
end

function var_0_0:UpdateSimBusinessLevel(arg_12_1)
	local var_12_1

	var_12_1, self.businessLevel = self.businessLevel, arg_12_1

	for iter_12_0, iter_12_1 in ipairs(SimBusinessShelfCfg.all) do
		local var_12_2 = SimBusinessTools.GetShelfUnlockLevel(iter_12_1)

		if not self.shelf[iter_12_1] and var_12_2 ~= nil and var_12_2 <= arg_12_1 then
			self.shelf[iter_12_1] = 1
		end
	end

	return var_12_1, self.businessLevel
end

function var_0_0:GetLevelGuestInfo(arg_13_1)
	return nullable(self.level, arg_13_1, "guestList")
end

function var_0_0:UpdateLevelStatus(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = self.level[arg_14_1] or {}

	if arg_14_2 then
		var_14_0.clear = true

		if arg_14_4 then
			var_14_0.costMinRecord = math.min(arg_14_4, var_14_0.costMinRecord or math.huge)
		end
	end

	self.level[arg_14_1] = var_14_0
end

function var_0_0.UpdateLocalShelvesDeployment(arg_15_0, arg_15_1)
	arg_15_0.layout = arg_15_1
end

function var_0_0:ClearLocalShelfGoods(arg_16_1)
	SimBusinessTools.ClearLocalShelfGoods(self.layout, arg_16_1)
end

function var_0_0:SetGoodsUnlock(arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self.unlockGoods[iter_17_1] = arg_17_2
	end
end

function var_0_0:GetUnlockGoodsList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.unlockGoods) do
		table.insert(var_18_0, iter_18_0)
	end

	return var_18_0
end

function var_0_0:UpgradeShelf(arg_19_1, arg_19_2)
	self.shelf[arg_19_1] = (self.shelf[arg_19_1] or 0) + arg_19_2
end

function var_0_0.EntityDataToLocalLayoutInfo(arg_20_0, arg_20_1)
	return {
		cfgID = arg_20_1.cfgID,
		goods = arg_20_1.goods,
		pos = Dorm.DormEntityManager.QueryPosition(arg_20_0),
		forward = Dorm.DormEntityManager.QueryForwardDir(arg_20_0)
	}
end

function var_0_0:CacheExisingShelvesBeforeEdit()
	Debug.LogWarning("SimBusiness BuildEditCache")

	self.cacheBeforeEditFund = self:GetSimBusinessFund()
	self.cacheEditShelfInfo = {}

	for iter_21_0, iter_21_1 in SimBusinessGame.EnumerateShelves() do
		self.cacheEditShelfInfo[iter_21_1] = var_0_0.EntityDataToLocalLayoutInfo(iter_21_1, (DormUtils.GetEntityData(iter_21_1)))
	end

	self.cacheBeforeEditFund = self.cacheBeforeEditFund + SimBusinessTools.CalcEditCacheShelfCostFund()
end

function var_0_0:GetPrevCachedShelfInfo(arg_22_1)
	return nullable(self.cacheEditShelfInfo, arg_22_1)
end

function var_0_0:CalcTotalFund()
	if self.cacheBeforeEditFund then
		return self.cacheBeforeEditFund
	else
		return self:GetSimBusinessFund() + SimBusinessTools.CalcRealtimeShelfTotalCostFund()
	end
end

function var_0_0.CleanupEditCache(arg_24_0)
	Debug.LogWarning("SimBusiness CleanupEditCache")

	arg_24_0.cacheBeforeEditFund = nil
	arg_24_0.cacheEditShelfInfo = nil
end

function var_0_0:ClaimUseShelfCost(arg_25_1)
	self.cost = self.cost + nullable(SimBusinessShelfCfg, arg_25_1, "cost")

	manager.notify:Invoke("SIM_BUSINESS_SHELF_COST_UPDATE")
end

function var_0_0:ReleaseUseShelfCost(arg_26_1)
	self.cost = self.cost - nullable(SimBusinessShelfCfg, arg_26_1, "cost")

	manager.notify:Invoke("SIM_BUSINESS_SHELF_COST_UPDATE")
end

function var_0_0:GetShelfUseFund()
	return self.cost
end

function var_0_0:GetSimBusinessFundItemID()
	return SimBusinessCfg[self.activityID].coin_id
end

function var_0_0:GetSimBusinessFund()
	return ItemTools.getItemNum((self:GetSimBusinessFundItemID()))
end

function var_0_0:GetSimBusinessMaxLevel()
	local var_30_0 = 1

	for iter_30_0, iter_30_1 in pairs(SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[self.activityID]) do
		if var_30_0 < iter_30_0 then
			var_30_0 = iter_30_0
		end
	end

	return var_30_0 + 1
end

function var_0_0:GetLevelUpNeedExp(arg_31_1)
	if arg_31_1 >= self:GetSimBusinessMaxLevel() then
		return math.huge
	end

	local var_31_0 = nullable(SimBusinessPlayerLevelCfg, nullable(SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[self.activityID], arg_31_1, 1), "cost")

	var_31_0 = var_31_0 or 0

	return var_31_0
end

function var_0_0:GetSimBusinessLevel()
	return self.businessLevel
end

function var_0_0:GetShelfLevel(arg_33_1)
	return nullable(self.shelf, arg_33_1) or 0
end

function var_0_0:GetLevelMinCostRecord(arg_34_1)
	if self.level[arg_34_1] and self.level[arg_34_1].clear then
		return self.level[arg_34_1].costMinRecord
	end

	return nil
end

return var_0_0
