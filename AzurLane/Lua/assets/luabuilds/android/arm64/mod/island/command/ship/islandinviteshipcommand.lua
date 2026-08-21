local var_0_0 = class("IslandInviteShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	pg.ConnectionMgr.GetInstance():Send(21609, {
		ship_id = arg_1_1:getBody().id
	}, 21610, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_0:RemoveInvite(var_0)

			local var_2_0 = IslandShip.New(arg_2_0.ship)

			var_1_0:AddShip(var_2_0)
			arg_1_0:sendNotification(GAME.ISLAND_INVITE_SHIP_DONE, {
				ship = var_2_0
			})
			IslandBookHelper.OnAddNewShip(var_2_0.id)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.UNLOCK_SHIP)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandUnlockShip(var_0))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
