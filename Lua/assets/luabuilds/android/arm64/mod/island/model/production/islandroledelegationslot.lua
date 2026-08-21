local var_0_0 = class("IslandRoleDelegationSlot", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.buildId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.part_list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.part_list) do
		table.insert(arg_1_0.part_list, iter_1_1)
	end

	arg_1_0.formula_dic = {}

	local var_1_0 = arg_1_2.formula_list or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		arg_1_0.formula_dic[iter_1_3.id] = iter_1_3.num
	end

	arg_1_0.isSelf = arg_1_3

	return
end

function var_0_0.AddAnimal(arg_2_0, arg_2_1)
	table.insert(arg_2_0.part_list, arg_2_1)

	return
end

function var_0_0.GetFormulaId(arg_3_0)
	if arg_3_0.islandRoleDelegationData then
		return arg_3_0.islandRoleDelegationData.formula_id or arg_3_0.islandRoleDelegationReward and arg_3_0.islandRoleDelegationReward.formula_id
	end
end

function var_0_0.AddFormulaNum(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.formula_dic[arg_4_1.formula_id] or 0

	arg_4_0.formula_dic[arg_4_1.formula_id] = var_4_0 + arg_4_1.num

	return
end

function var_0_0.GetFromulaTatalCount(arg_5_0, arg_5_1)
	return arg_5_0.formula_dic[arg_5_1] or 0
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.island_production_slot
end

function var_0_0.UpdateSlotRoleData(arg_7_0, arg_7_1)
	if arg_7_1 then
		if arg_7_0.islandRoleDelegationData then
			arg_7_0.islandRoleDelegationData:UpdateData(arg_7_1)
		else
			arg_7_0.islandRoleDelegationData = IslandRoleDelegationData.New(arg_7_1)
		end
	else
		arg_7_0.islandRoleDelegationData = nil
	end

	return
end

function var_0_0.UpdateSlotRewardData(arg_8_0, arg_8_1)
	if arg_8_1 then
		if arg_8_0.islandRoleDelegationReward then
			arg_8_0.islandRoleDelegationReward:UpdateData(arg_8_1)
		else
			arg_8_0.islandRoleDelegationReward = IslandRoleDelegationReward.New(arg_8_1)
		end
	else
		arg_8_0.islandRoleDelegationReward = nil
	end

	return
end

function var_0_0.GetSlotRoleData(arg_9_0)
	return arg_9_0.islandRoleDelegationData
end

function var_0_0.GetSlotRewardData(arg_10_0)
	return arg_10_0.islandRoleDelegationReward
end

function var_0_0.CanStartDelegation(arg_11_0)
	return arg_11_0.islandRoleDelegationData == nil and arg_11_0.islandRoleDelegationReward == nil
end

function var_0_0.CanStartDelegationTip(arg_12_0)
	return arg_12_0.islandRoleDelegationData == nil and arg_12_0.islandRoleDelegationReward == nil and not arg_12_0:CheckChildSlotIsInWork()
end

function var_0_0.CheckChildSlotIsInWork(arg_13_0)
	local var_13_9000
	local var_13_0 = getProxy(IslandProxy)
	local var_13_1 = var_13_0.GetIsland(var_13_9000):GetBuildingAgency():GetBuilding(arg_13_0.buildId)

	if var_13_0 then
		if pg.island_production_slot[arg_13_0.id].exclusion_slot == "" then
			local var_13_2 = {}

			if not {} then
				var_13_2 = pg.island_production_slot[arg_13_0.id].exclusion_slot
			end

			for iter_13_0, iter_13_1 in ipairs(var_13_2) do
				local var_13_3 = var_13_1:GetHandPlantSlotData(iter_13_1)

				if var_13_3 and var_13_3.state == 1 then
					return true
				end
			end

			return false
		end
	end
end

function var_0_0.Clear(arg_14_0)
	return
end

function var_0_0.UpdatePerSecond(arg_15_0)
	local var_15_9000

	if not arg_15_0.islandRoleDelegationData then
		return
	end

	if arg_15_0.islandRoleDelegationData:CheckDelegationIsEnd() then
		if arg_15_0.isSelf then
			pg.m02:sendNotification(GAME.ISLAND_FINISH_DELEGATION, {
				build_id = arg_15_0.buildId,
				area_id = arg_15_0.id
			})
			arg_15_0.islandRoleDelegationData:SetIsSend(true)
		else
			local var_15_0 = getProxy(IslandProxy)
			local var_15_1 = var_15_0.GetSharedIsland(var_15_9000)
			local var_15_2 = var_15_1:GetBuildingAgency():GetBuilding(arg_15_0.buildId)

			var_15_2.UpdateDeleationRewardDataBySlotId(var_15_0, arg_15_0.id, {
				formula_id = arg_15_0.islandRoleDelegationData.formula_id
			})
			var_15_2:UpdateDeleationRoleDataBySlotId(arg_15_0.id, nil)
			var_15_1:DispatchEvent(IslandFinishDelegationCommand.END_DELEGATION, {
				remainReward = true,
				build_id = arg_15_0.buildId,
				ship_id = arg_15_0.islandRoleDelegationData.ship_id,
				area_id = arg_15_0.id
			})
		end
	end

	return
end

function var_0_0.GetRoleDelegateFinishTime(arg_16_0)
	if arg_16_0.islandRoleDelegationReward then
		return 0
	end

	if arg_16_0.islandRoleDelegationData then
		return arg_16_0.islandRoleDelegationData:GetFinishTime()
	end

	return -1
end

function var_0_0.GetRoleShipData(arg_17_0)
	if arg_17_0.islandRoleDelegationData then
		return {
			ship_id = arg_17_0.islandRoleDelegationData.ship_id,
			area_id = arg_17_0.id
		}
	end

	return nil
end

function var_0_0.GetRoleSlotAndFormulaData(arg_18_0)
	if arg_18_0.islandRoleDelegationData then
		return {
			formula_id = arg_18_0.islandRoleDelegationData.formula_id,
			area_id = arg_18_0.id
		}
	end

	return nil
end

function var_0_0.GetPartList(arg_19_0)
	return arg_19_0.part_list or {}
end

return var_0_0
