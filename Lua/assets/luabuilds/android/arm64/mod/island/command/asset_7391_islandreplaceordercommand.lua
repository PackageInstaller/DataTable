local IslandReplaceOrderCommand = class("IslandReplaceOrderCommand", pm.SimpleCommand)

function IslandReplaceOrderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().slotId
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(var_1_0)

	if not var_1_1:CanReplace() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_order_cant_replace"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21403, {
		slot_id = var_1_0
	}, 21404, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:Flush(arg_2_0.slot)
			self:sendNotification(GAME.ISLAND_REPLACE_ORDER_DONE, {
				slotId = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandReplaceOrderCommand
