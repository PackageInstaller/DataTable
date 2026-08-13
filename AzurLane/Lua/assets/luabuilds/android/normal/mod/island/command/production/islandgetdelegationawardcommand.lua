class = var_0_10000

local var_0_0 = "IslandGetDelegationAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.build_id
	local var_1_2 = var_2.area_id
	local var_1_3 = var_2.type
	local var_1_4 = var_2.callback

	getProxy = var_1_10008
	IslandProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)
	local var_1_6 = var_8.GetIsland(var_1_5)
	local var_1_7 = var_8.GetBuildingAgency(var_1_6)
	local var_1_8 = var_8:GetCharacterAgency()
	local var_1_9 = var_2.isPost

	pg = var_1_10012

	local var_1_10 = var_1_10012.ConnectionMgr.GetInstance()

	var_12.Send(var_1_10, 21505, {
		build_id = var_1_1,
		area_id = var_1_2,
		type = var_1_3
	}, 21506, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7

			var_2_1 = var_2_1.GetBuilding(var_2_0, var_1_1)

			local var_2_2 = var_1_1

			IslandTechnologyAgency = var_2_10003

			if var_2_2 == var_2_10003.PLACE_ID then
				var_2_10003 = var_2_1
				var_2_10003 = var_2_1.GetDelegationSlotData(var_2_10003, var_1_2)

				local var_2_3 = var_2.GetFormulaId(var_2_10003)
				local var_2_4 = var_0
				local var_2_5 = var_2_10003.GetTechnologyAgency(var_2_4)

				var_2_10003.AddFinishCntByFormulatId(var_2_5, var_2_3)
			end

			var_2_10003 = var_2_1

			local var_2_6 = var_2_1.GetShipAddExpData(var_2_10003, var_1_2)

			var_2_1:UpdateDeleationRewardDataBySlotId(var_1_2, nil)

			local var_2_7

			if var_1_3 == 1 then
				var_2_7 = var_2_1:GetDelegationSlotData(var_1_2)

				if var_2_10003.GetSlotRoleData(var_2_7) then
					var_4:OnGetAwardMidway(arg_2_0.start_time, arg_2_0.rest_time_list, arg_2_0.get_times)
				end
			end

			pg = var_2_10003

			local var_2_8 = var_2_10003.GameTrackerMgr.GetInstance()

			var_2_10003 = var_2_10003.Record
			GameTrackerBuilder = var_2_7

			var_2_10003(var_2_8, var_2_7.BuildIslandGetDelegationAward(var_1_9 and 1 or 0, arg_2_0.drop_list))

			var_2_10003 = {}
			ipairs = var_2_8

			for iter_2_0, iter_2_1 in var_2_8(arg_2_0.drop_list) do
				table = var_2_10009

				var_2_10009.insert(var_2_10003, iter_2_1)
			end

			table = var_4

			local var_2_9 = var_4.insert
			local var_2_10 = var_2_10003
			local var_2_11 = {
				id = 0
			}

			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = iter_2_0
			var_2_11.type = iter_2_0

			local var_2_12

			if not arg_2_0.pt_award then
				var_2_12 = 0
			end

			var_2_11.count = var_2_12

			var_2_9(var_2_10, var_2_11)

			IslandDropHelper = var_2_9

			local var_2_13 = var_2_9.AddItems({
				drop_list = var_2_10003
			})
			local var_2_14 = arg_1_0
			local var_2_15 = var_5.sendNotification

			GAME = var_2_12

			var_2_15(var_2_14, var_2_12.ISLAND_GET_DELEGATION_AWARD_DONE, {
				slotId = var_1_2,
				dropData = var_2_13,
				callback = var_1_4,
				addShipExpData = var_2_6
			})

			if var_1_3 == 2 then
				local var_2_16 = var_0
				local var_2_17 = var_5.DispatchEvent

				IslandBuildingAgency = var_7

				var_2_17(var_2_16, var_7.SLOT_RESET_DELEGATION_STATE_DONE, {
					build_id = var_1_1,
					area_id = var_1_2
				})
			end
		else
			pg = var_2_1

			local var_2_18 = var_2_1.TipsMgr.GetInstance()
			local var_2_19 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_19(var_2_18, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
