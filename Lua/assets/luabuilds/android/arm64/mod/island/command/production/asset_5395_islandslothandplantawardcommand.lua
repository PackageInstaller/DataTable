local IslandSlotHandPlantAwardCommand = class("IslandSlotHandPlantAwardCommand", pm.SimpleCommand)

IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE = "IslandSlotHandPlantCommand:START_HANDPLANT_AWARD_DONE"

function IslandSlotHandPlantAwardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().slot_list
	local var_1_1 = pg.island_production_slot[var_1_0[1]].place
	local var_1_2 = getProxy(IslandProxy):GetIsland()
	local var_1_3 = var_1_2:GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21511, {
		build_id = pg.island_production_slot[var_1_0[1]].place,
		area_ids = var_1_0
	}, 21512, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drop_list) do
				table.insert(var_2_0, iter_2_1)
			end

			self:sendNotification(GAME.ISLAND_DROPMAIN_AWARD, {
				dropData = IslandDropHelper.AddItems({
					drop_list = var_2_0
				})
			})

			local var_2_1 = var_1_3:GetBuilding(var_1_1)

			for iter_2_2, iter_2_3 in ipairs(var_1_0) do
				var_2_1:UpdateHandPlantDataBySlotId({
					formula_id = 0,
					end_time = 0,
					state = 0,
					id = iter_2_3
				})
				var_1_2:DispatchEvent(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, {
					build_id = var_1_1,
					area_id = iter_2_3
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSlotHandPlantAwardCommand
