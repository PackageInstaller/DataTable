local var_0_0 = class("IslandWildGatherCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1.GetIsland(var_1_9000)
	local var_1_3 = var_1_0.unitId

	pg.ConnectionMgr.GetInstance().Send(var_1_1, 21524, {
		island_id = var_1_0.island_id,
		gather_id = var_1_0.gather_id
	}, 21525, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandWildGather(var_1_3))
			arg_1_0:sendNotification(GAME.ISLAND_DROPMAIN_AWARD, {
				dropData = IslandDropHelper.AddItems({
					drop_list = arg_2_0.drop_list
				})
			})
			var_1_2:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_1_3
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
