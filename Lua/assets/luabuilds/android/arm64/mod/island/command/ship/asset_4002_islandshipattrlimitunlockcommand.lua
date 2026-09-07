local IslandShipAttrLimitUnlockCommand = class("IslandShipAttrLimitUnlockCommand", pm.SimpleCommand)

function IslandShipAttrLimitUnlockCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1:GetIsland():GetCharacterAgency():GetShipById(var_1_0)

	if not var_1_1 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21603, {
		ship_id = var_1_0
	}, 21604, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:SetUnlockExtraAttLimit()
			self:sendNotification(GAME.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK_DONE)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandShipAttrLimit(Clone(var_1_2), var_1_2))
		end

		return
	end)

	return
end

return IslandShipAttrLimitUnlockCommand
