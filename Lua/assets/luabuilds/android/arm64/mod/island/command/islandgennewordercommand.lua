local var_0_0 = class("IslandGenNewOrderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody().slotId
	local var_1_1 = getProxy(IslandProxy):GetIsland()
	local var_1_2 = var_1_1.GetOrderAgency(var_1_9000):GetSlot(var_1_0)

	pg.ConnectionMgr.GetInstance().Send(var_1_1, 21024, {
		slotid = var_1_0
	}, 21025, function(arg_2_0)
		if arg_2_0.ret == 0 then
			var_1_2:UpdateOrder(arg_2_0.slot)
			arg_1_0:sendNotification(GAME.ISLAND_GEN_NEW_ORDER_DONE, {
				slotId = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_0
