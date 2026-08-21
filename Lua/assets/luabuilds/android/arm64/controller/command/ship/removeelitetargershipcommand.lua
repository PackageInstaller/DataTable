local var_0_0 = class("RemoveEliteTargerShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(13111, {
		ship_id = var_1_0.shipId
	}, 13112, function(arg_2_0)
		getProxy(ChapterProxy):setEliteCache(arg_2_0.fleet_list)
		arg_1_0:sendNotification(GAME.REMOVE_ELITE_TARGET_SHIP_DONE, {
			shipId = var_0
		})
		existCall(var_1_1)

		return
	end)

	return
end

return var_0_0
