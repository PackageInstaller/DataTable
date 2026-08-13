class = var_0_10000

local var_0_0 = "IslandSlotHandPlantCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.START_HANDPLANT_DONE = "IslandSlotHandPlantCommand:START_HANDPLANT_DONE"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().slot_list[1]

	pg = var_1_10005

	local var_1_1 = var_1_10005.island_production_slot[var_1_0].place
	local var_1_2 = var_2.formula_id

	pg = var_1_10007

	local var_1_3 = var_1_10007.island_formula[var_1_2]
	local var_1_4 = #var_3

	getProxy = var_1_10009
	IslandProxy = var_1_10011

	local var_1_5 = var_1_10009(var_1_10011)
	local var_1_6 = var_9.GetIsland(var_1_5)
	local var_1_7 = var_9.GetInventoryAgency(var_1_6)
	local var_1_8

	if not (function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0) do
			local var_2_0 = iter_2_1[1]
			local var_2_1 = iter_2_1[2]
			local var_2_2 = var_1_7
			local var_2_3 = var_8.GetItemById(var_2_2, var_2_0)

			if var_8.GetCount(var_2_3) < var_2_1 * var_1_4 then
				return false
			end
		end

		return true
	end)(var_1_3.cost) then
		pg = var_11
		var_1_8 = var_11.TipsMgr.GetInstance()

		var_11.ShowTips(var_1_8, "种子数量不够")

		return
	end

	getProxy = var_11
	IslandProxy = var_1_8

	local var_1_9 = var_11(var_1_8)
	local var_1_10 = var_11.GetIsland(var_1_9)
	local var_1_11 = var_11.GetBuildingAgency(var_1_10)

	pg = var_1_9

	local var_1_12 = var_1_9.ConnectionMgr.GetInstance()

	var_13.Send(var_1_12, 21509, {
		build_id = var_1_1,
		slot_list = var_3,
		formula_id = var_1_2
	}, 21510, function(arg_3_0)
		if arg_3_0.result == 0 then
			ipairs = var_1

			for iter_3_0, iter_3_1 in var_1(arg_3_0.hand_list) do
				local var_3_0 = var_1_11
				local var_3_1 = var_6.GetBuilding(var_3_0, var_1_1)

				var_6.UpdateHandPlantDataBySlotId(var_3_1, iter_3_1)

				local var_3_2 = var_1_3.cost

				ipairs = var_3_0

				for iter_3_2, iter_3_3 in var_3_0(var_3_2) do
					local var_3_3 = var_1_7

					var_13.RemoveItem(var_3_3, iter_3_3[1], iter_3_3[2])
				end

				local var_3_4 = var_0

				var_8.DispatchEvent(var_3_4, var_0_1.START_HANDPLANT_DONE, {
					build_id = var_1_1,
					area_id = iter_3_1.id,
					formula_id = var_1_2
				})
			end
		else
			pg = var_1

			local var_3_5 = var_1.TipsMgr.GetInstance()
			local var_3_6 = var_1.ShowTips

			ERROR_MESSAGE = iter_3_0

			var_3_6(var_3_5, iter_3_0[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
