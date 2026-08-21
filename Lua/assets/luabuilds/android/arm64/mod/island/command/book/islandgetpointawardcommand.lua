local var_0_0 = class("IslandGetPointAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21347, {
		lv = arg_1_1:getBody().id
	}, 21348, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetBookAgency():AddPointAwardGotId(var_0)
			arg_1_0:sendNotification(GAME.ISLAND_GET_POINT_AWARD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
