local var_0_0 = class("IslandFinishTechImmdCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21522, {
		tech_id = var_1_0.techId
	}, 21523, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandTechImmd(var_0))
			getProxy(IslandProxy):GetIsland():GetTechnologyAgency():GetTechnology(var_0):AddFinishedCnt()
			arg_1_0:sendNotification(GAME.ISLAND_FINISH_TECH_IMMD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0),
				callback = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
