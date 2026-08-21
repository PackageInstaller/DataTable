local var_0_0 = class("IslandSendRoleDressCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21615, {
		ship_id = var_1_0.ship_id,
		dress_id = var_1_0.dress_id
	}, 21616, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandBindDress(var_0, var_0))

			local var_2_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

			var_2_0:ReduceDressItem(var_0, 1)
			var_2_0:GetShipById(var_0):SetDressIdOwned(var_0)
			arg_1_0:sendNotification(GAME.ISLAND_SEND_ROLE_DRESS_DONE, {
				dress_id = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
