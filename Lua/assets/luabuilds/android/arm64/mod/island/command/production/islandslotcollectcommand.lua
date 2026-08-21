local var_0_0 = class("IslandSlotCollectCommand", pm.SimpleCommand)

var_0_0.START_HAND_COLLECT_DONE = "IslandSlotCollectCommand:START_HAND_COLLECT_DONE"

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland()
	local var_1_2 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21507, {
		build_id = var_1_0.build_id,
		area_id = var_1_0.area_id,
		type = var_1_0.type
	}, 21508, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2:GetBuilding(var_0)
			local var_2_1 = {
				id = var_0
			}

			if var_0 == 2 then
				var_2_1 = {
					id = var_0
				}
			end

			var_2_0:GetBuildingCollectData():UpdateCollectRefreshtTime(arg_2_0.refresh_time)
			var_2_0:GetBuildingCollectData():UpdateGetCollectNum(var_0)
			var_2_0:UpdateCollectDataBySlotId(var_2_1, var_0)
			arg_1_0:sendNotification(GAME.ISLAND_DROPMAIN_AWARD, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
			var_1_1:DispatchEvent(var_0_0.START_HAND_COLLECT_DONE, {
				build_id = var_0,
				area_id = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
