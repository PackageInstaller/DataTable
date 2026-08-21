local var_0_0 = class("WorldMapReqCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(33106, {
		id = arg_1_1:getBody().mapId
	}, 33107, function(arg_2_0)
		if arg_2_0.result == 0 then
			if arg_2_0.is_reset == 1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_map_version"))
			end

			getProxy(WorldProxy):NetUpdateMap(arg_2_0.map)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_map_req_error_", arg_2_0.result))
		end

		arg_1_0:sendNotification(GAME.WORLD_MAP_REQ_DONE, {
			result = arg_2_0.result
		})

		return
	end)

	return
end

return var_0_0
