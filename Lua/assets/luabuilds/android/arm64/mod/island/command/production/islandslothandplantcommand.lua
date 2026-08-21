local var_0_0 = class("IslandSlotHandPlantCommand", pm.SimpleCommand)

var_0_0.START_HANDPLANT_DONE = "IslandSlotHandPlantCommand:START_HANDPLANT_DONE"

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = pg.island_production_slot[var_1_0.slot_list[1]].place
	local var_1_2 = var_1_0.formula_id
	local var_1_3 = #var_1_0.slot_list
	local var_1_4 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	if not (function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			local var_2_0 = var_1_4:GetItemById(iter_2_1[1])

			if var_2_0:GetCount() < iter_2_1[2] * var_1_3 then
				return false
			end
		end

		return true
	end)(pg.island_formula[var_1_0.formula_id].cost) then
		pg.TipsMgr.GetInstance():ShowTips("种子数量不够")

		return
	end

	local var_1_5 = getProxy(IslandProxy)
	local var_1_6 = var_1_5.GetIsland(var_1_9000)
	local var_1_7 = var_1_5.GetIsland(var_1_9000):GetBuildingAgency()

	pg.ConnectionMgr.GetInstance().Send(var_1_5, 21509, {
		build_id = pg.island_production_slot[var_1_0.slot_list[1]].place,
		slot_list = var_1_0.slot_list,
		formula_id = var_1_0.formula_id
	}, 21510, function(arg_3_0)
		if arg_3_0.result == 0 then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0.hand_list) do
				var_1_7:GetBuilding(var_1_1):UpdateHandPlantDataBySlotId(iter_3_1)

				for iter_3_2, iter_3_3 in ipairs(var_0.cost) do
					var_1_4:RemoveItem(iter_3_3[1], iter_3_3[2])
				end

				var_1_6:DispatchEvent(var_0_0.START_HANDPLANT_DONE, {
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

return var_0_0
