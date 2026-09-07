local IslandRefreshShipOrderCommand = class("IslandRefreshShipOrderCommand", pm.SimpleCommand)

function IslandRefreshShipOrderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipOrderSlot(var_1_0)

	if not var_1_1 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21429, {
		slot_id = var_1_0
	}, 21430, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:Init(arg_2_0.slot, true)
			self:sendNotification(GAME.ISLAND_REFRESH_SHIP_ORDER_DONE, {
				id = var_1_0
			})
		end

		return
	end)

	return
end

return IslandRefreshShipOrderCommand
