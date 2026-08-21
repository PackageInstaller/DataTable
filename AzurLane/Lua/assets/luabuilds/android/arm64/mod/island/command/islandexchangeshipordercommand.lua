local var_0_0 = class("IslandExchangeShipOrderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.delegateId
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	if not var_1_3:GetDelegateSlot(var_1_0.delegateId) then
		return
	end

	if not var_1_3:GetShipOrderSlot(var_1_0.id) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21431, {
		slot_id = var_1_0.id,
		appoint_id = var_1_0.delegateId
	}, 21432, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_0:GetOrder():IsAnyLoadUp() then
				var_0:IncreaseFinishCnt()
			end

			var_0:FillDelegate(var_0)
			var_1_3:RemoveDelegateSlot(var_1_2)
			var_1_3:AddDelegateSlot((IslandShipOrderDelegateSlot.New(arg_2_0.appoint)))
			arg_1_0:sendNotification(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, {
				id = var_1_1,
				delegateId = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
