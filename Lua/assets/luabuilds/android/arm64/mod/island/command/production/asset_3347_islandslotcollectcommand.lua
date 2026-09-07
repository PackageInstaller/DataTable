local IslandSlotCollectCommand = class("IslandSlotCollectCommand", pm.SimpleCommand)

IslandSlotCollectCommand.START_HAND_COLLECT_DONE = "IslandSlotCollectCommand:START_HAND_COLLECT_DONE"

function IslandSlotCollectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.build_id
	local var_1_2 = var_1_0.area_id
	local var_1_3 = getProxy(IslandProxy):GetIsland()
	local var_1_4 = var_1_3:GetBuildingAgency()
	local var_1_5 = var_1_0.type

	pg.ConnectionMgr.GetInstance():Send(21507, {
		build_id = var_1_0.build_id,
		area_id = var_1_0.area_id,
		type = var_1_0.type
	}, 21508, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4:GetBuilding(var_1_1)
			local var_2_1 = {
				id = var_1_2
			}

			if var_1_5 == 2 then
				var_2_1 = {
					id = var_1_2
				}
			end

			var_2_0:GetBuildingCollectData():UpdateCollectRefreshtTime(arg_2_0.refresh_time)
			var_2_0:GetBuildingCollectData():UpdateGetCollectNum(var_1_5)
			var_2_0:UpdateCollectDataBySlotId(var_2_1, var_1_5)
			self:sendNotification(GAME.ISLAND_DROPMAIN_AWARD, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
			var_1_3:DispatchEvent(IslandSlotCollectCommand.START_HAND_COLLECT_DONE, {
				build_id = var_1_1,
				area_id = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSlotCollectCommand
