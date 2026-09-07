local IslandGetDelegationAwardCommand = class("IslandGetDelegationAwardCommand", pm.SimpleCommand)

function IslandGetDelegationAwardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.build_id
	local var_1_3 = var_1_0.area_id
	local var_1_4 = var_1_0.type
	local var_1_5 = var_1_0.callback
	local var_1_6 = getProxy(IslandProxy):GetIsland()
	local var_1_7 = var_1_6:GetBuildingAgency()
	local var_1_8 = var_1_6:GetCharacterAgency()
	local var_1_9 = var_1_0.isPost

	pg.ConnectionMgr.GetInstance():Send(21505, {
		build_id = var_1_0.build_id,
		area_id = var_1_0.area_id,
		type = var_1_0.type
	}, 21506, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7:GetBuilding(var_1_2)

			if var_1_2 == IslandTechnologyAgency.PLACE_ID then
				var_1_6:GetTechnologyAgency():AddFinishCntByFormulatId((var_2_0:GetDelegationSlotData(var_1_3):GetFormulaId()))
			end

			local var_2_1 = var_2_0:GetShipAddExpData(var_1_3)

			var_2_0:UpdateDeleationRewardDataBySlotId(var_1_3, nil)

			if var_1_4 == 1 then
				local var_2_2 = var_2_0:GetDelegationSlotData(var_1_3):GetSlotRoleData()

				if var_2_2 then
					var_2_2:OnGetAwardMidway(arg_2_0.start_time, arg_2_0.rest_time_list, arg_2_0.get_times)
				end
			end

			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandGetDelegationAward(var_1_9 and 1 or 0, arg_2_0.drop_list))

			local var_2_3 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drop_list) do
				table.insert(var_2_3, iter_2_1)
			end

			local var_2_4 = {
				id = 0,
				type = VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT
			}

			var_2_4.count = arg_2_0.pt_award or 0

			table.insert(var_2_3, var_2_4)
			self:sendNotification(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, {
				slotId = var_1_3,
				dropData = IslandDropHelper.AddItems({
					drop_list = var_2_3
				}),
				callback = var_1_5,
				addShipExpData = var_2_1
			})

			if var_1_4 == 2 then
				var_1_6:DispatchEvent(IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE, {
					build_id = var_1_2,
					area_id = var_1_3
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandGetDelegationAwardCommand
