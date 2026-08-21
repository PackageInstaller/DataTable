local var_0_0 = class("IslandShipAttrLimitUnlockCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	if not getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21603, {
		ship_id = var_1_0
	}, 21604, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_0:SetUnlockExtraAttLimit()
			arg_1_0:sendNotification(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipAttrLimit(Clone(var_0), var_0))
		end

		return
	end)

	return
end

return var_0_0
