class = var_0_10000

local var_0_0 = "IslandAutomaticCollectionCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type - 1
	local var_1_1 = var_2.ship_list
	local var_1_2 = var_2.gatherData

	getProxy = var_1_10007
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10007(var_1_10008)
	local var_1_4 = var_7.GetIsland(var_1_3)
	local var_1_5 = var_7.GetBuildingAgency(var_1_4)

	getProxy = var_1_4
	IslandProxy = var_1_10010

	local var_1_6 = var_1_4(var_1_10010)
	local var_1_7 = var_9.GetIsland(var_1_6)
	local var_1_8 = var_9.GetInventoryAgency(var_1_7)

	local function var_1_9(arg_2_0)
		pairs = var_2_10001

		local var_2_0

		if not var_1_2 then
			var_2_0 = {}
		end

		for iter_2_0, iter_2_1 in var_2_10001(var_2_0) do
			if iter_2_1.id == arg_2_0 then
				return iter_2_1.pos
			end
		end

		return nil
	end

	pg = var_1_10011

	local var_1_10 = var_1_10011.ConnectionMgr.GetInstance()

	var_11.Send(var_1_10, 21539, {
		type = var_1_0,
		ship_list = var_1_1
	}, 21540, function(arg_3_0)
		local var_3_11

		if arg_3_0.result == 0 then
			ipairs = var_3_11

			local var_3_0

			if not arg_3_0.ship_list then
				var_3_0 = {}
			end

			for iter_3_0, iter_3_1 in var_3_11(var_3_0) do
				local var_3_1 = var_0
				local var_3_2 = var_6.GetCharacterAgency(var_3_1)
				local var_3_3 = var_6.GetShipById(var_3_2, iter_3_1.ship_id)

				var_6.UpdateEnergy(var_3_3, iter_3_1.cur_power)
				var_6:UpdateEnergyBeginRecoverTime(iter_3_1.recover_time)
				var_6:AddExp(iter_3_1.add_exp)
			end

			ipairs = var_3_11

			local var_3_4

			if not arg_3_0.gather_list then
				var_3_4 = {}
			end

			for iter_3_2, iter_3_3 in var_3_11(var_3_4) do
				if var_1_9(iter_3_3) then
					local var_3_5 = var_0
					local var_3_6 = var_7.DispatchEvent

					IslandGatherCollectAgency = var_2_10009

					var_3_6(var_3_5, var_2_10009.RemoveGatherUnit, {
						unitId = var_6
					})
				end
			end

			ipairs = var_3_11

			local var_3_7

			if not arg_3_0.build_refresh then
				var_3_7 = {}
			end

			for iter_3_4, iter_3_5 in var_3_11(var_3_7) do
				local var_3_8 = var_1_5
				local var_3_9 = var_6.GetBuilding(var_3_8, iter_3_5.build_id)
				local var_3_10 = var_6.GetBuildingCollectData(var_3_9)

				var_7.SetAllTakeColelct(var_3_10)
				var_7:UpdateCollectRefreshtTime(iter_3_5.refresh_time)

				pairs = var_8

				for iter_3_6, iter_3_7 in var_8(var_7:GetCollectSlotDatasDic()) do
					var_6:UpdateCollectDataBySlotId({
						id = iter_3_7.id
					}, 1)
				end
			end

			IslandDropHelper = var_3_11
			var_3_11 = var_3_11.AddItems(arg_3_0)
			var_2_10003 = arg_1_0

			local var_3_12 = var_2.sendNotification

			GAME = iter_3_4

			var_3_12(var_2_10003, iter_3_4.ISLAND_TAKE_AUTO_COLLECTION_DONE, {
				dropData = var_3_11,
				selectType = var_0
			})

			var_2_10003 = var_1_8

			var_2.RemoveItem(var_2_10003, 1, arg_3_0.cost_gold)
		else
			pg = var_3_11

			local var_3_13 = var_3_11.TipsMgr.GetInstance()
			local var_3_14 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_3_14(var_3_13, var_2_10003[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
