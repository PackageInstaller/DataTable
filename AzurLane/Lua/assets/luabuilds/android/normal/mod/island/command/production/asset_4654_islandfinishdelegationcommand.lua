class = var_0_10000

local var_0_0 = "IslandFinishDelegationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.END_DELEGATION = "IslandFinishDelegationCommand:END_DELEGATION"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().build_id
	local var_1_1 = var_2.area_id

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetBuildingAgency(var_1_3)
	local var_1_5 = var_5
	local var_1_6 = var_5.GetCharacterAgency(var_1_5)

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

	var_8.Send(var_1_7, 21503, {
		build_id = var_1_0,
		area_id = var_1_1
	}, 21504, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_1 = var_2_1.GetBuilding(var_2_0, var_1_0)

			if arg_2_0.return_num then
				local var_2_2 = arg_2_0.return_num

				if 0 < var_2_2 then
					var_2_10003 = var_2_1
					var_2_10003 = var_2_1.GetDelegationSlotData(var_2_10003, var_1_1)

					local var_2_3 = var_2.GetFormulaId(var_2_10003)

					pg = var_2_10003
					var_2_10003 = var_2_10003.island_formula[var_2_3]

					local var_2_4 = var_2_1:GetDelegationSlotData(var_1_1)
					local var_2_5 = var_4.GetSlotRoleData(var_2_4)
					local var_2_6 = var_4.GetReturnExtraNum(var_2_5, arg_2_0.return_num)
					local var_2_7 = var_2_10003.commission_cost
					local var_2_8 = {}

					ipairs = var_2_10007

					for iter_2_0, iter_2_1 in var_2_10007(var_2_7) do
						table = var_2_10012
						var_2_10012 = var_2_10012.insert

						local var_2_9 = var_2_8
						local var_2_10 = {}

						DROP_TYPE_ISLAND_ITEM = var_2_10015
						var_2_10.type = var_2_10015
						var_2_10.id = iter_2_1[1]
						var_2_10.number = iter_2_1[2] * arg_2_0.return_num + var_2_6

						var_2_10012(var_2_9, var_2_10)
					end

					IslandDropHelper = var_7

					local var_2_11 = var_7.AddItems({
						drop_list = var_2_8
					})
				end
			end

			var_2_10003 = var_2_1

			var_2_1.UpdateDeleationRoleDataBySlotId(var_2_10003, var_1_1, nil)

			local var_2_12

			if #arg_2_0.award > 0 then
				var_2_10003 = arg_2_0.award[1]
				var_2_12 = true

				var_2_1:UpdateDeleationRewardDataBySlotId(var_1_1, var_2_10003)
			end

			local var_2_13 = var_1_6
			local var_2_14 = var_2_10003.GetShipById(var_2_13, arg_2_0.ship_id)

			var_2_10003.AddExp(var_2_14, arg_2_0.add_exp)

			local var_2_15

			if arg_2_0.return_num ~= 0 then
				if arg_2_0.add_exp > 0 then
					var_2_15 = {
						addShipId = arg_2_0.ship_id,
						addExp = arg_2_0.add_exp
					}
				end

				var_2_10003:UpdateEnergy(arg_2_0.cur_energy)
				var_2_10003:UpdateEnergyBeginRecoverTime(arg_2_0.recover_time)
			end

			local var_2_16 = var_0

			var_5.DispatchEvent(var_2_16, var_0_1.END_DELEGATION, {
				build_id = var_1_0,
				ship_id = arg_2_0.ship_id,
				area_id = var_1_1,
				remainReward = var_2_12
			})

			local var_2_17 = arg_1_0
			local var_2_18 = var_5.sendNotification

			GAME = var_7

			var_2_18(var_2_17, var_7.ISLAND_FINISH_DELEGATION_DONE, {
				slotId = var_1_1,
				addShipExpData = var_2_15
			})
		else
			pg = var_2_1

			local var_2_19 = var_2_1.TipsMgr.GetInstance()
			local var_2_20 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_20(var_2_19, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
