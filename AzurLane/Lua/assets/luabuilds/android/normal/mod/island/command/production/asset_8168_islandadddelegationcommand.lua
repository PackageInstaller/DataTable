class = var_0_10000

local var_0_0 = "IslandAddDelegationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.END_DELEGATION = "IslandAddDelegationCommand:END_DELEGATION"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().build_id
	local var_1_1 = var_2.area_id
	local var_1_2 = var_2.add_num
	local var_1_3

	if not var_2.extraCost then
		var_1_3 = 0
	end

	getProxy = var_1_10007
	IslandProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)
	local var_1_5 = var_7.GetIsland(var_1_4)

	getProxy = var_1_4
	IslandProxy = var_1_10009

	local var_1_6 = var_1_4(var_1_10009)
	local var_1_7 = var_8.GetIsland(var_1_6)
	local var_1_8 = var_8.GetInventoryAgency(var_1_7)
	local var_1_9 = var_1_5
	local var_1_10 = var_1_5.GetBuildingAgency(var_1_9)

	pg = var_1_9

	local var_1_11 = var_1_9.ConnectionMgr.GetInstance()

	var_10.Send(var_1_11, 21537, {
		build_id = var_1_0,
		area_id = var_1_1,
		add_num = var_1_2
	}, 21538, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_10

			var_2_10003 = var_1.GetBuilding(var_2_0, var_1_0)

			local var_2_1 = var_1.GetDelegationSlotData(var_2_10003, var_1_1)
			local var_2_2 = var_2.GetSlotRoleData(var_2_1)

			var_2_10003.AddCostList(var_2_2, arg_2_0.cost_time_list)
			var_2_10003:AddExtraList(arg_2_0.times_extra)

			local var_2_3 = var_2
			local var_2_4 = var_2.GetFormulaId(var_2_3)

			pg = var_2_3

			local var_2_5 = var_2_3.island_formula[var_2_4].commission_cost

			ipairs = var_2_10007

			for iter_2_0, iter_2_1 in var_2_10007(var_2_5) do
				local var_2_6 = var_1_8

				var_12.RemoveItem(var_2_6, iter_2_1[1], (iter_2_1[2] + var_1_3) * var_1_2)
			end

			local var_2_7 = var_1_5
			local var_2_8 = var_7.GetCharacterAgency(var_2_7)
			local var_2_9 = var_7.GetShipById(var_2_8, var_2_10003.ship_id)

			math = var_2_8

			local var_2_10 = var_2_8.floor
			local var_2_11 = var_5.stamina_cost

			IslandProductCostHelper = iter_2_0

			local var_2_12 = var_2_10(var_2_11 * (1 - iter_2_0.GetReducePercentInPlace(var_2_10003.ship_id, var_1_0)))

			math = var_9

			local var_2_13 = var_9.max(var_2_12, 1)
			local var_2_14 = var_2_9:GetCurrentEnergy() - var_2_13 * var_1_2

			var_2_9:UpdateEnergy(var_2_14)
			var_2_9:UpdateEnergyBeginRecoverTime(var_2_10003:GetFinishTime())

			local var_2_15 = arg_1_0
			local var_2_16 = var_10.sendNotification

			GAME = var_12

			var_2_16(var_2_15, var_12.ISLAND_FINISH_DELEGATION_DONE, {
				slotId = var_1_1
			})
		else
			pg = var_1

			local var_2_17 = var_1.TipsMgr.GetInstance()
			local var_2_18 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_18(var_2_17, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
