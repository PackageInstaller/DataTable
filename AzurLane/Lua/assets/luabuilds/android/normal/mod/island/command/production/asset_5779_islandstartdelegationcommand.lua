class = var_0_10000

local var_0_0 = "IslandStartDelegationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.START_DELEGATION = "IslandStartDelegationCommand:START_DELEGATION"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().build_id
	local var_1_1 = var_2.area_id
	local var_1_2 = var_2.ship_id
	local var_1_3 = var_2.formula_id
	local var_1_4 = var_2.num

	getProxy = var_1_10008
	IslandProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)
	local var_1_6 = var_8.GetIsland(var_1_5)
	local var_1_7 = var_8.GetBuildingAgency(var_1_6)

	getProxy = var_1_6
	IslandProxy = var_1_10011

	local var_1_8 = var_1_6(var_1_10011)
	local var_1_9 = var_10.GetIsland(var_1_8)
	local var_1_10 = var_10.GetInventoryAgency(var_1_9)
	local var_1_11

	if not var_2.extraCost then
		var_1_11 = 0
	end

	pg = var_1_10012

	local var_1_12 = var_1_10012.ConnectionMgr.GetInstance()

	var_12.Send(var_1_12, 21501, {
		build_id = var_1_0,
		area_id = var_1_1,
		ship_id = var_1_2,
		formula_id = var_1_3,
		num = var_1_4
	}, 21502, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7

			var_2_10003 = var_1.GetBuilding(var_2_0, var_1_0)

			var_1.UpdateDeleationRoleDataBySlotId(var_2_10003, arg_2_0.ship_appoint.id, arg_2_0.ship_appoint)

			var_2_10003 = var_0
			var_2_10003 = var_2.GetCharacterAgency(var_2_10003)

			local var_2_1 = var_2.GetShipById(var_2_10003, var_1_2)

			var_2.UpdateEnergy(var_2_1, arg_2_0.ship_power)

			local var_2_2 = var_1:GetDelegationSlotData(arg_2_0.ship_appoint.id)
			local var_2_3 = var_2_10003.GetRoleDelegateFinishTime(var_2_2)
			local var_2_4 = var_2

			var_2.UpdateEnergyBeginRecoverTime(var_2_4, var_2_3)

			local var_2_5 = var_1_0

			IslandTechnologyAgency = var_2_4

			if var_2_5 == var_2_4.PLACE_ID then
				IslandShip = var_2_5

				if not var_2_5.STATE_DELEGATION then
					IslandShip = var_2_5
					var_2_5 = var_2_5.STATE_TECHNOLOGY
				end

				var_2:UpdateState(var_2_5, var_1_0)

				local var_2_6 = var_2_10003
				local var_2_7 = var_2_10003.GetFormulaId(var_2_6)

				pg = var_2_6

				local var_2_8 = var_2_6.island_formula[var_2_7].commission_cost

				ipairs = var_9

				for iter_2_0, iter_2_1 in var_9(var_2_8) do
					local var_2_9 = var_1_10

					var_14.RemoveItem(var_2_9, iter_2_1[1], (iter_2_1[2] + var_1_11) * var_1_4)
				end

				local var_2_10 = var_0

				var_9.DispatchEvent(var_2_10, var_0_1.START_DELEGATION, {
					build_id = var_1_0,
					ship_id = var_1_2,
					area_id = var_1_1,
					formula_id = var_1_3
				})

				local var_2_11 = arg_1_0
				local var_2_12 = var_9.sendNotification

				GAME = var_11

				var_2_12(var_2_11, var_11.ISLAND_START_DELEGATION_DONE, {
					slotId = var_1_1
				})

				pg = var_2_12

				local var_2_13 = var_2_12.GameTrackerMgr.GetInstance()
				local var_2_14 = var_9.Record

				GameTrackerBuilder = var_11

				var_2_14(var_2_13, var_11.BuildIslandStartDelegation(var_1_2, var_1_0, var_1_1, var_1_3, var_1_4))

				local var_2_15 = var_0_1.GetLocalKeyForLastData(var_1_1)

				PackIntToString = var_10

				local var_2_16 = var_10(var_1_2, var_1_3)

				PlayerPrefs = var_11

				var_11.SetString(var_2_15, var_2_16)

				if false then
					pg = var_1

					local var_2_17 = var_1.TipsMgr.GetInstance()
					local var_2_18 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_2_18(var_2_17, var_2_10003[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

function var_0_1.GetLocalKeyForLastData(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getData(var_3_0).id
	local var_3_2 = "LAST_DELEGATE"

	tostring = var_1_10003

	return var_3_2 .. var_1_10003(arg_3_0) .. "_" .. var_3_1
end

return var_0_1
