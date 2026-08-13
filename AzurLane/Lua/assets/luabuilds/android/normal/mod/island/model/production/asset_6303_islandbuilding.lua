class = var_0_10000

local var_0_0 = "IslandBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isSelf = arg_1_2
	arg_1_0.timer = {}
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.lv then
		var_1_0 = 1
	end

	arg_1_0.level = var_1_0
	arg_1_0.delegationSlotData = {}
	ipairs = var_3

	local var_1_1

	if not arg_1_1.appoint_list then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		local var_1_2 = arg_1_0.delegationSlotData
		local var_1_3 = iter_1_1.id

		IslandRoleDelegationSlot = var_1_10010
		var_1_2[var_1_3] = var_1_10010.New(arg_1_0.configId, iter_1_1, arg_1_0.isSelf)
	end

	ipairs = var_3

	local var_1_4

	if not arg_1_1.ship_appoint_list then
		var_1_4 = {}
	end

	for iter_1_2, iter_1_3 in var_3(var_1_4) do
		arg_1_0:UpdateDeleationRoleDataBySlotId(iter_1_3.id, iter_1_3)
	end

	ipairs = var_3

	local var_1_5

	if not arg_1_1.award_list then
		var_1_5 = {}
	end

	for iter_1_4, iter_1_5 in var_3(var_1_5) do
		arg_1_0:UpdateDeleationRewardDataBySlotId(iter_1_5.id, iter_1_5)
	end

	arg_1_0.handSlotData = {}
	ipairs = var_3

	local var_1_6

	if not arg_1_1.hand_list then
		var_1_6 = {}
	end

	for iter_1_6, iter_1_7 in var_3(var_1_6) do
		local var_1_7 = arg_1_0.handSlotData
		local var_1_8 = iter_1_7.id

		IslandHandSlot = var_1_10010
		var_1_7[var_1_8] = var_1_10010.New(arg_1_0.configId, iter_1_7)
	end

	if arg_1_1.build_collect then
		IslandCollectSlotPlace = var_3
		arg_1_0.collectPlaceSystem = var_3.New(arg_1_1.id, arg_1_1.build_collect)
	end

	return
end

function var_0_1.GetBuildingCollectData(arg_2_0)
	return arg_2_0.collectPlaceSystem
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_production_place
end

function var_0_1.GetDelegationSlotData(arg_4_0, arg_4_1)
	return arg_4_0.delegationSlotData[arg_4_1]
end

function var_0_1.GetDelegationSlotDatas(arg_5_0)
	return arg_5_0.delegationSlotData
end

function var_0_1.GetDelegationSlotDataByFormulaId(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.delegationSlotData) do
		if iter_6_1:GetFormulaId() and iter_6_1:GetFormulaId() == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_1.GetHandPlantSlotData(arg_7_0, arg_7_1)
	return arg_7_0.handSlotData[arg_7_1]
end

function var_0_1.InitSlotRoleDataByAbility(arg_8_0, arg_8_1)
	pg = var_1_10002

	local var_8_0 = var_1_10002.island_production_slot[arg_8_1]

	if arg_8_0.delegationSlotData[arg_8_1] then
		warning = var_3

		var_3("已经存在当前槽位的信息了")

		return
	end

	local var_8_1 = {}

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_8_2 = var_1_10004(var_1_10005)
	local var_8_3 = var_4.GetIsland(var_8_2)

	if var_8_0.type == 3 then
		local var_8_4

		if var_8_0.animal ~= "" or not {} then
			var_8_4 = var_8_0.animal
		end

		ipairs = var_1_10006

		for iter_8_0, iter_8_1 in var_1_10006(var_8_4) do
			pg = var_1_10011

			if var_1_10011.island_ranch_animal[iter_8_1].unlock_type == 0 then
				table = var_12

				var_12.insert(var_8_1, iter_8_1)
			end
		end

		var_1_10007 = var_8_3
		var_1_10006 = var_8_3.DispatchEvent
		IslandBuildingAgency = var_8

		var_1_10006(var_1_10007, var_8.GEN_ANIMAL_INT, {
			aniList = var_8_1,
			slotId = arg_8_1
		})
	end

	if var_8_0.type == 9 then
		var_1_10006 = var_8_3

		local var_8_5 = var_8_3.DispatchEvent

		IslandBuildingAgency = var_1_10007

		var_8_5(var_1_10006, var_1_10007.SLOT_DELEGATE_INIT, {
			slotId = arg_8_1
		})
	end

	local var_8_6 = arg_8_0.delegationSlotData

	IslandRoleDelegationSlot = var_1_10006
	var_8_6[arg_8_1] = var_1_10006.New(arg_8_0.configId, {
		id = arg_8_1,
		part_list = var_8_1,
		formula_list = {}
	}, true)

	return
end

function var_0_1.InitSlotHandPlantByAbility(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.island_production_slot[arg_9_1]

	if arg_9_0.handSlotData[arg_9_1] then
		warning = var_3

		var_3("已经存在当前槽位的信息了")

		return
	end

	local var_9_1 = arg_9_0.handSlotData

	IslandHandSlot = var_1_10004
	var_9_1[arg_9_1] = var_1_10004.New(arg_9_1, {
		formula_id = 0,
		state = 0,
		end_time = 0,
		start_time = 0,
		id = arg_9_1
	})

	return
end

function var_0_1.InitHandSlotData(arg_10_0, arg_10_1)
	if arg_10_0.collectPlaceSystem then
		local var_10_0 = arg_10_0.collectPlaceSystem

		var_2.InitHandSlotData(var_10_0, arg_10_1)
	end

	return
end

function var_0_1.UpdateDeleationRoleDataBySlotId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0

	if not arg_11_0.GetDelegationSlotData(var_11_0, arg_11_1) then
		warning = var_11_0

		var_11_0("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_11_1)

		return
	end

	var_3:UpdateSlotRoleData(arg_11_2)

	return
end

function var_0_1.UpdateDeleationRewardDataBySlotId(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0

	if not arg_12_0.GetDelegationSlotData(var_12_0, arg_12_1) then
		warning = var_12_0

		var_12_0("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_12_1)

		return
	end

	var_3:UpdateSlotRewardData(arg_12_2)

	return
end

function var_0_1.GetShipAddExpData(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1 = arg_13_0:GetDelegationSlotData(arg_13_1)

	if var_3.GetSlotRewardData(var_13_1) then
		var_13_0 = {
			addShipId = var_4.ship_id,
			addExp = var_4.exp
		}
	end

	return var_13_0
end

function var_0_1.UpdateCollectDataBySlotId(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.collectPlaceSystem then
		local var_14_0 = arg_14_0.collectPlaceSystem

		var_3.UpdateCollectDataBySlotId(var_14_0, arg_14_1, arg_14_2)
	end

	return
end

function var_0_1.UpdateHandPlantDataBySlotId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0

	if not arg_15_0.GetHandPlantSlotData(var_15_0, arg_15_1.id) then
		warning = var_15_0

		var_15_0("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_15_1.id)

		return
	end

	var_2:UpdateData(arg_15_1)

	return
end

function var_0_1.GetFormulaList(arg_16_0)
	local var_16_0 = {}

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.formulaData) do
		table = var_1_10007

		var_1_10007.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

function var_0_1.GetLevel(arg_17_0)
	return arg_17_0.level
end

function var_0_1.IsMaxLevel(arg_18_0)
	return arg_18_0:GetUpgradeCost() == ""
end

function var_0_1.GetName(arg_19_0)
	return arg_19_0:getConfig("name")
end

function var_0_1.UpdatePerSecond(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.delegationSlotData) do
		iter_20_1:UpdatePerSecond(arg_20_0.isSelf)
	end

	if arg_20_0.collectPlaceSystem then
		local var_20_0 = arg_20_0.collectPlaceSystem

		var_1.UpdatePerSecond(var_20_0)
	end

	return
end

function var_0_1.GetSlotUnitDataByModelData(arg_21_0)
	local var_21_0 = {}

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.collectionSlotData) do
		local var_21_1 = iter_21_1

		if iter_21_1.GetUnitData(var_21_1) then
			table = var_21_1

			var_21_1.insert(var_21_0, var_7)
		end
	end

	return var_21_0
end

function var_0_1.GetMinRoleDeleGationTime(arg_22_0)
	local var_22_0

	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.delegationSlotData) do
		local var_22_1 = iter_22_1

		if iter_22_1.GetRoleDelegateFinishTime(var_22_1) ~= -1 then
			if var_22_0 then
				math = var_22_1

				if not var_22_1.min(var_7, var_22_0) then
					::label_22_0::

					var_22_0 = var_7
				end
			end
		end
	end

	return var_22_0 and var_22_0 or -1
end

function var_0_1.GetShipIdAndAreaIdList(arg_23_0)
	local var_23_0 = {}

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.delegationSlotData) do
		local var_23_1 = iter_23_1

		if iter_23_1.GetRoleShipData(var_23_1) then
			table = var_23_1

			var_23_1.insert(var_23_0, var_7)
		end
	end

	return var_23_0
end

function var_0_1.GetDelegateingSlotAndFormulaList(arg_24_0)
	local var_24_0 = {}

	pairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.delegationSlotData) do
		local var_24_1 = iter_24_1

		if iter_24_1.GetRoleSlotAndFormulaData(var_24_1) then
			table = var_24_1

			var_24_1.insert(var_24_0, var_7)
		end
	end

	return var_24_0
end

function var_0_1.IsPostTip(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.delegationSlotData) do
		if iter_25_1:CanStartDelegationTip() or iter_25_1:GetSlotRewardData() then
			return true
		end
	end

	return false
end

function var_0_1.GetCollectSlotData(arg_26_0, arg_26_1)
	if arg_26_0.collectPlaceSystem then
		local var_26_0 = arg_26_0.collectPlaceSystem

		return var_2.GetCollectSlotData(var_26_0, arg_26_1)
	end

	return
end

return var_0_1
