local var_0_0 = class("IslandGetDelegationAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(IslandProxy):GetIsland()
	local var_1_4 = var_1_3:GetBuildingAgency()
	local var_1_5 = var_1_3:GetCharacterAgency()
	local var_1_6 = var_1_0.isPost

	pg.ConnectionMgr.GetInstance():Send(21505, {
		build_id = var_1_0.build_id,
		area_id = var_1_0.area_id,
		type = var_1_0.type
	}, 21506, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4:GetBuilding(var_0)

			if var_0 == IslandTechnologyAgency.PLACE_ID then
				var_1_3:GetTechnologyAgency():AddFinishCntByFormulatId((var_2_0:GetDelegationSlotData(var_0):GetFormulaId()))
			end

			local var_2_1 = var_2_0:GetShipAddExpData(var_0)

			var_2_0:UpdateDeleationRewardDataBySlotId(var_0, nil)

			if var_0 == 1 then
				local var_2_2 = var_2_0:GetDelegationSlotData(var_0):GetSlotRoleData()

				if var_2_2 then
					var_2_2:OnGetAwardMidway(arg_2_0.start_time, arg_2_0.rest_time_list, arg_2_0.get_times)
				end
			end

			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandGetDelegationAward(var_1_6 and 1 or 0, arg_2_0.drop_list))

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drop_list) do
				table.insert({}, iter_2_1)
			end

			;({
				id = 0,
				type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT
			}).count = arg_2_0.pt_award or 0

			table.insert({}, {
				id = 0,
				type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT
			})
			arg_1_0:sendNotification(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, {
				slotId = var_0,
				dropData = IslandDropHelper.AddItems({
					drop_list = {}
				}),
				callback = var_1_2,
				addShipExpData = var_2_1
			})

			if var_0 == 2 then
				var_1_3:DispatchEvent(IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE, {
					build_id = var_0,
					area_id = var_0
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
