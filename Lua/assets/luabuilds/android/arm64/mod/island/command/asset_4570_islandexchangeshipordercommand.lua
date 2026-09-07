local IslandExchangeShipOrderCommand = class("IslandExchangeShipOrderCommand", pm.SimpleCommand)

function IslandExchangeShipOrderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.delegateId
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetOrderAgency()
	local var_1_4 = var_1_3:GetDelegateSlot(var_1_0.delegateId)

	if not var_1_4 then
		return
	end

	local var_1_5 = var_1_3:GetShipOrderSlot(var_1_0.id)

	if not var_1_5 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21431, {
		slot_id = var_1_0.id,
		appoint_id = var_1_0.delegateId
	}, 21432, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_5:GetOrder():IsAnyLoadUp() then
				var_1_5:IncreaseFinishCnt()
			end

			var_1_5:FillDelegate(var_1_4)
			var_1_3:RemoveDelegateSlot(var_1_2)
			var_1_3:AddDelegateSlot((IslandShipOrderDelegateSlot.New(arg_2_0.appoint)))
			self:sendNotification(GAME.ISLAND_EXCHANGE_SHIP_ORDER_DONE, {
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

return IslandExchangeShipOrderCommand
