local var_0_0 = class("IslandReconnectCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21230, {
		island_id = arg_1_1:getBody().islandId
	}, 21231, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			if _IslandCore and _IslandCore:GetView().player and _IslandCore:GetView().player._tf then
				local var_2_0, var_2_1 = _IslandCore:GetView().player:LastGroundedPosition()

				getProxy(IslandProxy):RecordTempPlayerPosition(_IslandCore:GetController().mapId, var_2_0, var_2_1)
			end

			if _IslandCore then
				pg.NewGuideMgr.GetInstance():Stop()
				pg.m02:sendNotification(GAME.ISLAND_ON_RECONNECT, {
					reconnect = true,
					id = var_0
				})
			end
		end

		return
	end)

	return
end

return var_0_0
