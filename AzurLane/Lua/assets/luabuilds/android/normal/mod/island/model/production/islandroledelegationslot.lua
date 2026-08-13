class = var_0_10000

local var_0_0 = "IslandRoleDelegationSlot"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.buildId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.part_list = {}
	ipairs = var_4

	for iter_1_0, iter_1_1 in var_4(arg_1_2.part_list) do
		table = var_1_10009

		var_1_10009.insert(arg_1_0.part_list, iter_1_1)
	end

	arg_1_0.formula_dic = {}
	ipairs = var_4

	local var_1_0

	if not arg_1_2.formula_list then
		var_1_0 = {}
	end

	for iter_1_2, iter_1_3 in var_4(var_1_0) do
		arg_1_0.formula_dic[iter_1_3.id] = iter_1_3.num
	end

	arg_1_0.isSelf = arg_1_3

	return
end

function var_0_1.AddAnimal(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.part_list, arg_2_1)

	return
end

function var_0_1.GetFormulaId(arg_3_0)
	local var_3_0

	if (not arg_3_0.islandRoleDelegationData or not arg_3_0.islandRoleDelegationData.formula_id) and arg_3_0.islandRoleDelegationReward then
		var_3_0 = arg_3_0.islandRoleDelegationReward.formula_id
	end

	return var_3_0
end

function var_0_1.AddFormulaNum(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.formula_dic[arg_4_1.formula_id] then
		var_4_0 = 0
	end

	arg_4_0.formula_dic[arg_4_1.formula_id] = var_4_0 + arg_4_1.num

	return
end

function var_0_1.GetFromulaTatalCount(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.formula_dic[arg_5_1] then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.island_production_slot
end

function var_0_1.UpdateSlotRoleData(arg_7_0, arg_7_1)
	if arg_7_1 then
		if arg_7_0.islandRoleDelegationData then
			local var_7_0 = arg_7_0.islandRoleDelegationData

			var_2.UpdateData(var_7_0, arg_7_1)
		else
			IslandRoleDelegationData = var_2
			arg_7_0.islandRoleDelegationData = var_2.New(arg_7_1)
		end
	else
		arg_7_0.islandRoleDelegationData = nil
	end

	return
end

function var_0_1.UpdateSlotRewardData(arg_8_0, arg_8_1)
	if arg_8_1 then
		if arg_8_0.islandRoleDelegationReward then
			local var_8_0 = arg_8_0.islandRoleDelegationReward

			var_2.UpdateData(var_8_0, arg_8_1)
		else
			IslandRoleDelegationReward = var_2
			arg_8_0.islandRoleDelegationReward = var_2.New(arg_8_1)
		end
	else
		arg_8_0.islandRoleDelegationReward = nil
	end

	return
end

function var_0_1.GetSlotRoleData(arg_9_0)
	return arg_9_0.islandRoleDelegationData
end

function var_0_1.GetSlotRewardData(arg_10_0)
	return arg_10_0.islandRoleDelegationReward
end

function var_0_1.CanStartDelegation(arg_11_0)
	return arg_11_0.islandRoleDelegationData == nil and arg_11_0.islandRoleDelegationReward == nil
end

function var_0_1.CanStartDelegationTip(arg_12_0)
	return arg_12_0.islandRoleDelegationData == nil and arg_12_0.islandRoleDelegationReward == nil and not arg_12_0:CheckChildSlotIsInWork()
end

function var_0_1.CheckChildSlotIsInWork(arg_13_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)
	local var_13_1 = var_1.GetIsland(var_13_0)
	local var_13_2 = var_1.GetBuildingAgency(var_13_1)

	if var_2.GetBuilding(var_13_2, arg_13_0.buildId) then
		pg = var_13_2

		local var_13_3

		if var_13_2.island_production_slot[arg_13_0.id].exclusion_slot ~= "" or not {} then
			var_13_3 = var_4.exclusion_slot
		end

		ipairs = var_1_10006

		for iter_13_0, iter_13_1 in var_1_10006(var_13_3) do
			if var_3:GetHandPlantSlotData(iter_13_1) and var_11.state == 1 then
				return true
			end
		end
	end

	return false
end

function var_0_1.Clear(arg_14_0)
	return
end

function var_0_1.UpdatePerSecond(arg_15_0)
	if not arg_15_0.islandRoleDelegationData then
		return
	end

	local var_15_0 = arg_15_0.islandRoleDelegationData

	if var_1.CheckDelegationIsEnd(var_15_0) then
		local var_15_1

		if arg_15_0.isSelf then
			pg = var_15_1
			var_15_0 = var_15_1.m02
			var_15_1 = var_15_1.sendNotification
			GAME = var_1_10003

			var_15_1(var_15_0, var_1_10003.ISLAND_FINISH_DELEGATION, {
				build_id = arg_15_0.buildId,
				area_id = arg_15_0.id
			})

			var_15_0 = arg_15_0.islandRoleDelegationData

			var_15_1.SetIsSend(var_15_0, true)
		else
			getProxy = var_15_1
			IslandProxy = var_15_0

			local var_15_2 = var_15_1(var_15_0)
			local var_15_3 = var_1.GetSharedIsland(var_15_2)
			local var_15_4 = var_1.GetBuildingAgency(var_15_3)
			local var_15_5 = var_2.GetBuilding(var_15_4, arg_15_0.buildId)
			local var_15_6 = arg_15_0.islandRoleDelegationData.formula_id
			local var_15_7 = arg_15_0.islandRoleDelegationData.ship_id

			var_15_5:UpdateDeleationRewardDataBySlotId(arg_15_0.id, {
				formula_id = var_15_6
			})
			var_15_5:UpdateDeleationRoleDataBySlotId(arg_15_0.id, nil)

			local var_15_8 = var_1
			local var_15_9 = var_1.DispatchEvent

			IslandFinishDelegationCommand = var_8

			var_15_9(var_15_8, var_8.END_DELEGATION, {
				remainReward = true,
				build_id = arg_15_0.buildId,
				ship_id = var_15_7,
				area_id = arg_15_0.id
			})
		end
	end

	return
end

function var_0_1.GetRoleDelegateFinishTime(arg_16_0)
	if arg_16_0.islandRoleDelegationReward then
		return 0
	end

	if arg_16_0.islandRoleDelegationData then
		local var_16_0 = arg_16_0.islandRoleDelegationData

		return var_1.GetFinishTime(var_16_0)
	end

	return -1
end

function var_0_1.GetRoleShipData(arg_17_0)
	if arg_17_0.islandRoleDelegationData then
		return {
			ship_id = arg_17_0.islandRoleDelegationData.ship_id,
			area_id = arg_17_0.id
		}
	end

	return nil
end

function var_0_1.GetRoleSlotAndFormulaData(arg_18_0)
	if arg_18_0.islandRoleDelegationData then
		return {
			formula_id = arg_18_0.islandRoleDelegationData.formula_id,
			area_id = arg_18_0.id
		}
	end

	return nil
end

function var_0_1.GetPartList(arg_19_0)
	local var_19_0

	if not arg_19_0.part_list then
		var_19_0 = {}
	end

	return var_19_0
end

return var_0_1
