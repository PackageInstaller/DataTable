local IslandReconnectCommand = class("IslandReconnectCommand", pm.SimpleCommand)

function IslandReconnectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().islandId

	pg.ConnectionMgr.GetInstance():Send(21230, {
		island_id = var_1_0
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
					id = var_1_0
				})
			end
		end

		return
	end)

	return
end

return IslandReconnectCommand
