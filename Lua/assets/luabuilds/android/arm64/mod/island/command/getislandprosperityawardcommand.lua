local var_0_0 = class("GetIslandProsperityAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().level

	if not getProxy(IslandProxy):GetIsland():CanGetProsperityAwards(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21010, {
		level = var_1_0
	}, 21011, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy(IslandProxy):GetIsland():ReceiveProsperityAwards(var_1_0)
			arg_1_0:sendNotification(GAME.ISLAND_PROSPERITY_AWARD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_0
