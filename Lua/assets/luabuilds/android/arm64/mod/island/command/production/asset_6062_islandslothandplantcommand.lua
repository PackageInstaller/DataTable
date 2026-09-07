local IslandSlotHandPlantCommand = class("IslandSlotHandPlantCommand", pm.SimpleCommand)

IslandSlotHandPlantCommand.START_HANDPLANT_DONE = "IslandSlotHandPlantCommand:START_HANDPLANT_DONE"

function IslandSlotHandPlantCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = pg.island_production_slot[var_1_0.slot_list[1]].place
	local var_1_2 = var_1_0.formula_id
	local var_1_3 = pg.island_formula[var_1_0.formula_id]
	local var_1_4 = #var_1_0.slot_list
	local var_1_5 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	if not (function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			if var_1_5:GetItemById(iter_2_1[1]):GetCount() < iter_2_1[2] * var_1_4 then
				return false
			end
		end

		return true
	end)(pg.island_formula[var_1_0.formula_id].cost) then
		pg.TipsMgr.GetInstance():ShowTips("种子数量不够")

		return
	end

	local var_1_6 = getProxy(IslandProxy):GetIsland()
	local var_1_7 = var_1_6:GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21509, {
		build_id = pg.island_production_slot[var_1_0.slot_list[1]].place,
		slot_list = var_1_0.slot_list,
		formula_id = var_1_0.formula_id
	}, 21510, function(arg_3_0)
		if arg_3_0.result == 0 then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0.hand_list) do
				var_1_7:GetBuilding(var_1_1):UpdateHandPlantDataBySlotId(iter_3_1)

				for iter_3_2, iter_3_3 in ipairs(var_1_3.cost) do
					var_1_5:RemoveItem(iter_3_3[1], iter_3_3[2])
				end

				var_1_6:DispatchEvent(IslandSlotHandPlantCommand.START_HANDPLANT_DONE, {
					build_id = var_1_1,
					area_id = iter_3_1.id,
					formula_id = var_1_2
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return IslandSlotHandPlantCommand
