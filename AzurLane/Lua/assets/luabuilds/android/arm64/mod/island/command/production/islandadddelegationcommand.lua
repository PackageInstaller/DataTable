class = var_0_10000

local var_0_0 = "IslandAddDelegationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

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
	IslandProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = var_7.GetIsland(var_1_4)

	getProxy = var_1_10008
	IslandProxy = var_1_10010

	local var_1_6 = var_1_10008(var_1_10010)
	local var_1_7 = var_8.GetIsland(var_1_6)
	local var_1_8 = var_8.GetInventoryAgency(var_1_7)
	local var_1_9 = var_1_5:GetBuildingAgency()

	pg = var_1_7

	local var_1_10 = var_1_7.ConnectionMgr.GetInstance()

	var_10.Send(var_1_10, 21537, {
		build_id = var_1_0,
		area_id = var_1_1,
		add_num = var_1_2
	}, 21538, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_9

			var_2_10004 = var_1.GetBuilding(var_2_0, var_1_0)

			local var_2_1 = var_1.GetDelegationSlotData(var_2_10004, var_1_1)
			local var_2_2 = var_2.GetSlotRoleData(var_2_1)

			var_3.AddCostList(var_2_2, arg_2_0.cost_time_list)
			var_3:AddExtraList(arg_2_0.times_extra)

			var_2_10004 = var_2:GetFormulaId()
			pg = var_2_1

			local var_2_3 = var_2_1.island_formula[var_2_10004].commission_cost

			ipairs = var_7

			for iter_2_0, iter_2_1 in var_7(var_2_3) do
				local var_2_4 = var_1_8

				var_12.RemoveItem(var_2_4, iter_2_1[1], (iter_2_1[2] + var_1_3) * var_1_2)
			end

			local var_2_5 = var_1_5
			local var_2_6 = var_7.GetCharacterAgency(var_2_5)
			local var_2_7 = var_7.GetShipById(var_2_6, var_3.ship_id)

			math = var_8

			local var_2_8 = var_8.floor
			local var_2_9 = var_5.stamina_cost

			IslandProductCostHelper = iter_2_1

			local var_2_10 = var_2_8(var_2_9 * (1 - iter_2_1.GetReducePercentInPlace(var_3.ship_id, var_1_0)))

			math = var_2_6

			local var_2_11 = var_2_6.max(var_2_10, 1)
			local var_2_12 = var_2_7:GetCurrentEnergy() - var_2_11 * var_1_2

			var_2_7:UpdateEnergy(var_2_12)
			var_2_7:UpdateEnergyBeginRecoverTime(var_3:GetFinishTime())

			local var_2_13 = arg_1_0
			local var_2_14 = var_10.sendNotification

			GAME = var_13

			var_2_14(var_2_13, var_13.ISLAND_FINISH_DELEGATION_DONE, {
				slotId = var_1_1
			})
		else
			pg = var_1

			local var_2_15 = var_1.TipsMgr.GetInstance()
			local var_2_16 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_16(var_2_15, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
