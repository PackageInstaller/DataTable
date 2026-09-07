local IslandWildGatherCommand = class("IslandWildGatherCommand", pm.SimpleCommand)

function IslandWildGatherCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland()
	local var_1_2 = var_1_0.unitId

	pg.ConnectionMgr.GetInstance():Send(21524, {
		island_id = var_1_0.island_id,
		gather_id = var_1_0.gather_id
	}, 21525, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandWildGather(var_1_2))
			self:sendNotification(GAME.ISLAND_DROPMAIN_AWARD, {
				dropData = IslandDropHelper.AddItems({
					drop_list = arg_2_0.drop_list
				})
			})
			var_1_1:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandWildGatherCommand
