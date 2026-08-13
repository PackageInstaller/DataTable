class = var_0_10000

local var_0_0 = "IslandGetDelegationAwardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.build_id
	local var_1_2 = var_2.area_id
	local var_1_3 = var_2.type
	local var_1_4 = var_2.callback

	getProxy = var_1_10008
	IslandProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.GetIsland(var_1_5)
	local var_1_7 = var_8.GetBuildingAgency(var_1_6)
	local var_1_8 = var_8
	local var_1_9 = var_8.GetCharacterAgency(var_1_8)
	local var_1_10 = var_2.isPost

	pg = var_1_8

	local var_1_11 = var_1_8.ConnectionMgr.GetInstance()

	var_12.Send(var_1_11, 21505, {
		build_id = var_1_1,
		area_id = var_1_2,
		type = var_1_3
	}, 21506, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7

			var_2_1 = var_2_1.GetBuilding(var_2_0, var_1_1)

			local var_2_2 = var_1_1

			IslandTechnologyAgency = var_2_0

			if var_2_2 == var_2_0.PLACE_ID then
				var_2_10004 = var_2_1
				var_2_10004 = var_2_1.GetDelegationSlotData(var_2_10004, var_1_2)

				local var_2_3 = var_2.GetFormulaId(var_2_10004)
				local var_2_4 = var_0
				local var_2_5 = var_3.GetTechnologyAgency(var_2_4)

				var_3.AddFinishCntByFormulatId(var_2_5, var_2_3)
			end

			var_2_10004 = var_2_1

			local var_2_6 = var_2_1.GetShipAddExpData(var_2_10004, var_1_2)

			var_2_1:UpdateDeleationRewardDataBySlotId(var_1_2, nil)

			local var_2_7

			if var_1_3 == 1 then
				var_2_7 = var_2_1:GetDelegationSlotData(var_1_2)

				if var_3.GetSlotRoleData(var_2_7) then
					var_2_10004:OnGetAwardMidway(arg_2_0.start_time, arg_2_0.rest_time_list, arg_2_0.get_times)
				end
			end

			pg = var_3

			local var_2_8 = var_3.GameTrackerMgr.GetInstance()
			local var_2_9 = var_3.Record

			GameTrackerBuilder = var_2_7

			var_2_9(var_2_8, var_2_7.BuildIslandGetDelegationAward(var_1_10 and 1 or 0, arg_2_0.drop_list))

			local var_2_10 = {}

			ipairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(arg_2_0.drop_list) do
				table = var_9

				var_9.insert(var_2_10, iter_2_1)
			end

			table = var_2_10004
			var_2_10004 = var_2_10004.insert

			local var_2_11 = var_2_10
			local var_2_12 = {
				id = 0
			}

			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = iter_2_1
			var_2_12.type = iter_2_1

			local var_2_13

			if not arg_2_0.pt_award then
				var_2_13 = 0
			end

			var_2_12.count = var_2_13

			var_2_10004(var_2_11, var_2_12)

			IslandDropHelper = var_2_10004
			var_2_10004 = var_2_10004.AddItems({
				drop_list = var_2_10
			})

			local var_2_14 = arg_1_0
			local var_2_15 = var_5.sendNotification

			GAME = var_2_13

			var_2_15(var_2_14, var_2_13.ISLAND_GET_DELEGATION_AWARD_DONE, {
				slotId = var_1_2,
				dropData = var_2_10004,
				callback = var_1_4,
				addShipExpData = var_2_6
			})

			if var_1_3 == 2 then
				local var_2_16 = var_0
				local var_2_17 = var_5.DispatchEvent

				IslandBuildingAgency = var_8

				var_2_17(var_2_16, var_8.SLOT_RESET_DELEGATION_STATE_DONE, {
					build_id = var_1_1,
					area_id = var_1_2
				})
			end
		else
			pg = var_2_1

			local var_2_18 = var_2_1.TipsMgr.GetInstance()
			local var_2_19 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_19(var_2_18, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
