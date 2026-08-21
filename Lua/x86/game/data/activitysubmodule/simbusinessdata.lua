local var_0_0 = singletonClass("SimBusinessData")

function var_0_0.Init(arg_1_0)
	arg_1_0.shelf = {}
	arg_1_0.cacheEditShelfInfo = nil
	arg_1_0.cost = 0
end

function var_0_0.NetToLocalLayoutInfo(arg_2_0)
	return {
		cfgID = arg_2_0.id,
		goods = arg_2_0.goods_id,
		pos = Vector3(arg_2_0.x, 0, arg_2_0.y),
		forward = Vector3.forward * Quaternion.AngleAxis(arg_2_0.rotation, Vector3.up)
	}
end

function var_0_0.LocalToNetLayoutInfo(arg_3_0)
	return {
		id = arg_3_0.cfgID,
		goods_id = arg_3_0.goods or 0,
		x = arg_3_0.pos.x,
		y = arg_3_0.pos.z,
		rotation = math.round(Vector3.AngleAroundAxis(Vector3.forward, arg_3_0.forward, Vector3.up))
	}
end

local function var_0_1(arg_4_0, arg_4_1)
	arg_4_0.layout = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.shelf_pos_list) do
		table.insert(arg_4_0.layout, var_0_0.NetToLocalLayoutInfo(iter_4_1))
	end
end

local var_0_2 = 0

local function var_0_3(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[var_0_2]) do
		if SimBusinessStageCfg[iter_5_1].pre == arg_5_0 then
			return iter_5_1
		end
	end

	return nil
end

local function var_0_4(arg_6_0)
	local var_6_0 = SimBusinessStageCfg[arg_6_0]
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.wave) do
		local var_6_2 = iter_6_1[1]

		var_6_1[var_6_2] = (var_6_1[var_6_2] or 0) + 1
	end

	return var_6_1
end

local function var_0_5(arg_7_0)
	return {
		clear = false,
		id = arg_7_0
	}
end

local function var_0_6(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = arg_8_0[iter_8_1.guest_id]

		if var_8_1 ~= nil then
			arg_8_0[iter_8_1.guest_id] = math.max(0, var_8_1 - 1)

			table.insert(var_8_0, {
				id = iter_8_1.guest_id,
				remain = iter_8_1.remain_hp
			})
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0) do
		if iter_8_3 > 0 then
			for iter_8_4 = 1, iter_8_3 do
				table.insert(var_8_0, {
					remain = 0,
					id = iter_8_2
				})
			end
		end
	end

	return var_8_0
end

local function var_0_7(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[var_0_2]) do
		local var_9_0 = var_0_5(iter_9_1)

		arg_9_0.level[iter_9_1] = var_9_0
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
		local var_9_1 = iter_9_3.id

		arg_9_0.level[var_9_1].clear = iter_9_3.is_clear
	end
end

local function var_0_8(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = iter_10_1.id
		local var_10_1 = var_0_5(var_10_0)

		var_10_1.clear = iter_10_1.is_clear
		var_10_1.costMinRecord = iter_10_1.cost_min_coin
		arg_10_0.level[var_10_0] = var_10_1
	end
end

function var_0_0.InitFromServer(arg_11_0, arg_11_1)
	arg_11_0.activityID = arg_11_1.activity_id
	arg_11_0.businessLevel = arg_11_1.business_level
	arg_11_0.shelf = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.shelf_list) do
		arg_11_0.shelf[iter_11_1.id] = iter_11_1.level
	end

	arg_11_0.unlockGoods = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.goods_id_list) do
		arg_11_0.unlockGoods[iter_11_3] = true
	end

	arg_11_0.level = {}

	var_0_1(arg_11_0, arg_11_1.layout)
	var_0_7(arg_11_0, arg_11_1.wave_stage)
	var_0_8(arg_11_0, arg_11_1.challenge_stage_list)
end

function var_0_0.UpdateSimBusinessLevel(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1

	var_12_1, arg_12_0.businessLevel = arg_12_0.businessLevel, arg_12_1

	for iter_12_0, iter_12_1 in ipairs(SimBusinessShelfCfg.all) do
		local var_12_2 = SimBusinessTools.GetShelfUnlockLevel(iter_12_1)

		if not arg_12_0.shelf[iter_12_1] and var_12_2 ~= nil and var_12_2 <= arg_12_1 then
			arg_12_0.shelf[iter_12_1] = 1
		end
	end

	return var_12_1, arg_12_0.businessLevel
end

function var_0_0.GetLevelGuestInfo(arg_13_0, arg_13_1)
	return nullable(arg_13_0.level, arg_13_1, "guestList")
end

function var_0_0.UpdateLevelStatus(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_0.level[arg_14_1] or {}

	if arg_14_2 then
		var_14_0.clear = true

		if arg_14_4 then
			local var_14_1 = var_14_0.costMinRecord or math.huge

			var_14_0.costMinRecord = math.min(arg_14_4, var_14_1)
		end
	end

	arg_14_0.level[arg_14_1] = var_14_0
end

function var_0_0.UpdateLocalShelvesDeployment(arg_15_0, arg_15_1)
	arg_15_0.layout = arg_15_1
end

function var_0_0.ClearLocalShelfGoods(arg_16_0, arg_16_1)
	SimBusinessTools.ClearLocalShelfGoods(arg_16_0.layout, arg_16_1)
end

function var_0_0.SetGoodsUnlock(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0.unlockGoods[iter_17_1] = arg_17_2
	end
end

function var_0_0.GetUnlockGoodsList(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.unlockGoods) do
		table.insert(var_18_0, iter_18_0)
	end

	return var_18_0
end

function var_0_0.UpgradeShelf(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.shelf[arg_19_1] or 0

	arg_19_0.shelf[arg_19_1] = var_19_0 + arg_19_2
end

function var_0_0.EntityDataToLocalLayoutInfo(arg_20_0, arg_20_1)
	return {
		cfgID = arg_20_1.cfgID,
		goods = arg_20_1.goods,
		pos = Dorm.DormEntityManager.QueryPosition(arg_20_0),
		forward = Dorm.DormEntityManager.QueryForwardDir(arg_20_0)
	}
end

function var_0_0.CacheExisingShelvesBeforeEdit(arg_21_0)
	Debug.LogWarning("SimBusiness BuildEditCache")

	arg_21_0.cacheBeforeEditFund = arg_21_0:GetSimBusinessFund()
	arg_21_0.cacheEditShelfInfo = {}

	for iter_21_0, iter_21_1 in SimBusinessGame.EnumerateShelves() do
		local var_21_0 = DormUtils.GetEntityData(iter_21_1)

		arg_21_0.cacheEditShelfInfo[iter_21_1] = var_0_0.EntityDataToLocalLayoutInfo(iter_21_1, var_21_0)
	end

	arg_21_0.cacheBeforeEditFund = arg_21_0.cacheBeforeEditFund + SimBusinessTools.CalcEditCacheShelfCostFund()
end

function var_0_0.GetPrevCachedShelfInfo(arg_22_0, arg_22_1)
	return nullable(arg_22_0.cacheEditShelfInfo, arg_22_1)
end

function var_0_0.CalcTotalFund(arg_23_0)
	if arg_23_0.cacheBeforeEditFund then
		return arg_23_0.cacheBeforeEditFund
	else
		return arg_23_0:GetSimBusinessFund() + SimBusinessTools.CalcRealtimeShelfTotalCostFund()
	end
end

function var_0_0.CleanupEditCache(arg_24_0)
	Debug.LogWarning("SimBusiness CleanupEditCache")

	arg_24_0.cacheBeforeEditFund = nil
	arg_24_0.cacheEditShelfInfo = nil
end

function var_0_0.ClaimUseShelfCost(arg_25_0, arg_25_1)
	local var_25_0 = nullable(SimBusinessShelfCfg, arg_25_1, "cost")

	arg_25_0.cost = arg_25_0.cost + var_25_0

	manager.notify:Invoke("SIM_BUSINESS_SHELF_COST_UPDATE")
end

function var_0_0.ReleaseUseShelfCost(arg_26_0, arg_26_1)
	local var_26_0 = nullable(SimBusinessShelfCfg, arg_26_1, "cost")

	arg_26_0.cost = arg_26_0.cost - var_26_0

	manager.notify:Invoke("SIM_BUSINESS_SHELF_COST_UPDATE")
end

function var_0_0.GetShelfUseFund(arg_27_0)
	return arg_27_0.cost
end

function var_0_0.GetSimBusinessFundItemID(arg_28_0)
	return SimBusinessCfg[arg_28_0.activityID].coin_id
end

function var_0_0.GetSimBusinessFund(arg_29_0)
	local var_29_0 = arg_29_0:GetSimBusinessFundItemID()

	return ItemTools.getItemNum(var_29_0)
end

function var_0_0.GetSimBusinessMaxLevel(arg_30_0)
	local var_30_0 = SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[arg_30_0.activityID]
	local var_30_1 = 1

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if var_30_1 < iter_30_0 then
			var_30_1 = iter_30_0
		end
	end

	return var_30_1 + 1
end

function var_0_0.GetLevelUpNeedExp(arg_31_0, arg_31_1)
	if arg_31_1 >= arg_31_0:GetSimBusinessMaxLevel() then
		return math.huge
	end

	local var_31_0 = SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[arg_31_0.activityID]
	local var_31_1 = nullable(var_31_0, arg_31_1, 1)

	return nullable(SimBusinessPlayerLevelCfg, var_31_1, "cost") or 0
end

function var_0_0.GetSimBusinessLevel(arg_32_0)
	return arg_32_0.businessLevel
end

function var_0_0.GetShelfLevel(arg_33_0, arg_33_1)
	return nullable(arg_33_0.shelf, arg_33_1) or 0
end

function var_0_0.GetLevelMinCostRecord(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.level[arg_34_1]

	if var_34_0 and var_34_0.clear then
		return var_34_0.costMinRecord
	end

	return nil
end

return var_0_0
