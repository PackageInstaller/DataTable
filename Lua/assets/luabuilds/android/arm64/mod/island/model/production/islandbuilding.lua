local var_0_0 = class("IslandBuilding", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isSelf = arg_1_2
	arg_1_0.timer = {}
	arg_1_0.configId = arg_1_1.id
	arg_1_0.level = arg_1_1.lv or 1
	arg_1_0.delegationSlotData = {}

	local var_1_0 = arg_1_1.appoint_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.delegationSlotData[iter_1_1.id] = IslandRoleDelegationSlot.New(arg_1_0.configId, iter_1_1, arg_1_0.isSelf)
	end

	local var_1_1 = arg_1_1.ship_appoint_list or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		arg_1_0:UpdateDeleationRoleDataBySlotId(iter_1_3.id, iter_1_3)
	end

	local var_1_2 = arg_1_1.award_list or {}

	for iter_1_4, iter_1_5 in ipairs(var_1_2) do
		arg_1_0:UpdateDeleationRewardDataBySlotId(iter_1_5.id, iter_1_5)
	end

	arg_1_0.handSlotData = {}

	local var_1_3 = arg_1_1.hand_list or {}

	for iter_1_6, iter_1_7 in ipairs(var_1_3) do
		arg_1_0.handSlotData[iter_1_7.id] = IslandHandSlot.New(arg_1_0.configId, iter_1_7)
	end

	if arg_1_1.build_collect then
		arg_1_0.collectPlaceSystem = IslandCollectSlotPlace.New(arg_1_1.id, arg_1_1.build_collect)
	end

	return
end

function var_0_0.GetBuildingCollectData(arg_2_0)
	return arg_2_0.collectPlaceSystem
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_production_place
end

function var_0_0.GetDelegationSlotData(arg_4_0, arg_4_1)
	return arg_4_0.delegationSlotData[arg_4_1]
end

function var_0_0.GetDelegationSlotDatas(arg_5_0)
	return arg_5_0.delegationSlotData
end

function var_0_0.GetDelegationSlotDataByFormulaId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.delegationSlotData) do
		if iter_6_1:GetFormulaId() and iter_6_1:GetFormulaId() == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.GetHandPlantSlotData(arg_7_0, arg_7_1)
	return arg_7_0.handSlotData[arg_7_1]
end

function var_0_0.InitSlotRoleDataByAbility(arg_8_0, arg_8_1)
	if arg_8_0.delegationSlotData[arg_8_1] then
		warning("已经存在当前槽位的信息了")

		return
	end

	local var_8_0 = {}
	local var_8_1 = getProxy(IslandProxy):GetIsland()

	if pg.island_production_slot[arg_8_1].type == 3 then
		if pg.island_production_slot[arg_8_1].animal == "" then
			local var_8_2 = {}

			if not {} then
				var_8_2 = pg.island_production_slot[arg_8_1].animal
			end

			for iter_8_0, iter_8_1 in ipairs(var_8_2) do
				if pg.island_ranch_animal[iter_8_1].unlock_type == 0 then
					table.insert(var_8_0, iter_8_1)
				end
			end

			var_8_1:DispatchEvent(IslandBuildingAgency.GEN_ANIMAL_INT, {
				aniList = var_8_0,
				slotId = arg_8_1
			})

			if pg.island_production_slot[arg_8_1].type == 9 then
				var_8_1:DispatchEvent(IslandBuildingAgency.SLOT_DELEGATE_INIT, {
					slotId = arg_8_1
				})
			end

			arg_8_0.delegationSlotData[arg_8_1] = IslandRoleDelegationSlot.New(arg_8_0.configId, {
				id = arg_8_1,
				part_list = var_8_0,
				formula_list = {}
			}, true)

			return
		end
	end
end

function var_0_0.InitSlotHandPlantByAbility(arg_9_0, arg_9_1)
	if arg_9_0.handSlotData[arg_9_1] then
		warning("已经存在当前槽位的信息了")

		return
	end

	arg_9_0.handSlotData[arg_9_1] = IslandHandSlot.New(arg_9_1, {
		formula_id = 0,
		state = 0,
		end_time = 0,
		start_time = 0,
		id = arg_9_1
	})

	return
end

function var_0_0.InitHandSlotData(arg_10_0, arg_10_1)
	if arg_10_0.collectPlaceSystem then
		arg_10_0.collectPlaceSystem:InitHandSlotData(arg_10_1)
	end

	return
end

function var_0_0.UpdateDeleationRoleDataBySlotId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetDelegationSlotData(arg_11_1)

	if not var_11_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_11_1)

		return
	end

	var_11_0:UpdateSlotRoleData(arg_11_2)

	return
end

function var_0_0.UpdateDeleationRewardDataBySlotId(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:GetDelegationSlotData(arg_12_1)

	if not var_12_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_12_1)

		return
	end

	var_12_0:UpdateSlotRewardData(arg_12_2)

	return
end

function var_0_0.GetShipAddExpData(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1 = arg_13_0:GetDelegationSlotData(arg_13_1):GetSlotRewardData()

	if var_13_1 then
		var_13_0 = {
			addShipId = var_13_1.ship_id,
			addExp = var_13_1.exp
		}
	end

	return var_13_0
end

function var_0_0.UpdateCollectDataBySlotId(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.collectPlaceSystem then
		arg_14_0.collectPlaceSystem:UpdateCollectDataBySlotId(arg_14_1, arg_14_2)
	end

	return
end

function var_0_0.UpdateHandPlantDataBySlotId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetHandPlantSlotData(arg_15_1.id)

	if not var_15_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_15_1.id)

		return
	end

	var_15_0:UpdateData(arg_15_1)

	return
end

function var_0_0.GetFormulaList(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.formulaData) do
		table.insert({}, iter_16_1)
	end

	return {}
end

function var_0_0.GetLevel(arg_17_0)
	return arg_17_0.level
end

function var_0_0.IsMaxLevel(arg_18_0)
	return arg_18_0:GetUpgradeCost() == ""
end

function var_0_0.GetName(arg_19_0)
	return arg_19_0:getConfig("name")
end

function var_0_0.UpdatePerSecond(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.delegationSlotData) do
		iter_20_1:UpdatePerSecond(arg_20_0.isSelf)
	end

	if arg_20_0.collectPlaceSystem then
		arg_20_0.collectPlaceSystem:UpdatePerSecond()
	end

	return
end

function var_0_0.GetSlotUnitDataByModelData(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.collectionSlotData) do
		local var_21_0 = iter_21_1:GetUnitData()

		if var_21_0 then
			table.insert({}, var_21_0)
		end
	end

	return {}
end

function var_0_0.GetMinRoleDeleGationTime(arg_22_0)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(arg_22_0.delegationSlotData) do
		local var_22_1 = iter_22_1:GetRoleDelegateFinishTime()

		if var_22_1 ~= -1 then
			var_22_0 = var_22_0 and math.min(var_22_1, var_22_0) or var_22_1
		end
	end

	return var_22_0 and var_22_0 or -1
end

function var_0_0.GetShipIdAndAreaIdList(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.delegationSlotData) do
		local var_23_0 = iter_23_1:GetRoleShipData()

		if var_23_0 then
			table.insert({}, var_23_0)
		end
	end

	return {}
end

function var_0_0.GetDelegateingSlotAndFormulaList(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.delegationSlotData) do
		local var_24_0 = iter_24_1:GetRoleSlotAndFormulaData()

		if var_24_0 then
			table.insert({}, var_24_0)
		end
	end

	return {}
end

function var_0_0.IsPostTip(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.delegationSlotData) do
		if iter_25_1:CanStartDelegationTip() or iter_25_1:GetSlotRewardData() then
			return true
		end
	end

	return false
end

function var_0_0.GetCollectSlotData(arg_26_0, arg_26_1)
	if arg_26_0.collectPlaceSystem then
		return arg_26_0.collectPlaceSystem:GetCollectSlotData(arg_26_1)
	end

	return
end

return var_0_0
