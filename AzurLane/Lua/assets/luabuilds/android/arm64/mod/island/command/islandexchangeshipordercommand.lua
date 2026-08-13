class = var_0_10000

local var_0_0 = "IslandExchangeShipOrderCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.delegateId

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetOrderAgency(var_1_3)

	if not var_5.GetDelegateSlot(var_1_4, var_1_1) then
		return
	end

	if not var_5:GetShipOrderSlot(var_1_0) then
		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 21431, {
		slot_id = var_1_0,
		appoint_id = var_1_1
	}, 21432, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_2_4.GetOrder(var_2_0)

			if var_2_4.IsAnyLoadUp(var_2_1) then
				local var_2_2 = var_0

				var_2_4.IncreaseFinishCnt(var_2_2)
			end

			local var_2_3 = var_0

			var_2_4.FillDelegate(var_2_3, var_0)

			IslandShipOrderDelegateSlot = var_2_4
			var_2_4 = var_2_4.New(arg_2_0.appoint)
			var_2_10004 = var_0

			var_2.RemoveDelegateSlot(var_2_10004, var_1_1)

			var_2_10004 = var_0

			var_2.AddDelegateSlot(var_2_10004, var_2_4)

			var_2_10004 = arg_1_0

			local var_2_5 = var_2.sendNotification

			GAME = var_5

			var_2_5(var_2_10004, var_5.ISLAND_EXCHANGE_SHIP_ORDER_DONE, {
				id = var_1_0,
				delegateId = var_1_1
			})
		else
			pg = var_2_4

			local var_2_6 = var_2_4.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
