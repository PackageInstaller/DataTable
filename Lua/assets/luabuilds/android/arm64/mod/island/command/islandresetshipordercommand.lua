local var_0_0 = class("IslandResetShipOrderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	pg.ConnectionMgr.GetInstance():Send(21429, {
		slot_id = 0
	}, 21430, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:UpdateNextManualReloadDelegateTime(arg_2_0.next_time)

			local var_2_0 = arg_2_0.appoint_list or {}

			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				local var_2_1 = IslandShipOrderDelegateSlot.New(iter_2_1)

				;({})[var_2_1.id] = var_2_1
			end

			var_1_1:AddDelegateSlotList({})

			for iter_2_2, iter_2_3 in pairs((var_1_1:GetShipSlotList())) do
				if iter_2_3:IsEmpty() then
					iter_2_3:Reset()
				end
			end

			arg_1_0:sendNotification(GAME.ISLAND_RESET_SHIP_ORDER_DONE)
		end

		return
	end)

	return
end

return var_0_0
