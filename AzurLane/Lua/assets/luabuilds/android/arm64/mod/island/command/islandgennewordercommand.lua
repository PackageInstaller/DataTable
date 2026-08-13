class = var_0_10000

local var_0_0 = "IslandGenNewOrderCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).slotId

	getProxy = var_1_0
	IslandProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetIsland(var_1_2)
	local var_1_4 = var_4.GetOrderAgency(var_1_3)
	local var_1_5 = var_4.GetSlot(var_1_4, var_1_1)

	pg = var_1_3

	local var_1_6 = var_1_3.ConnectionMgr.GetInstance()

	var_6.Send(var_1_6, 21024, {
		slotid = var_1_1
	}, 21025, function(arg_2_0)
		local var_2_2

		if arg_2_0.ret == 0 then
			local var_2_0 = var_1_5

			var_2_2.UpdateOrder(var_2_0, arg_2_0.slot)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.ISLAND_GEN_NEW_ORDER_DONE, {
				slotId = var_1_1
			})
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
