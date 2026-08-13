class = var_0_10000

local var_0_0 = "UseAddShipExpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = {}
	local var_1_2 = 0

	pairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_2.items) do
		if 0 < iter_1_1 then
			table = var_11

			var_11.insert(var_1_1, {
				id = iter_1_0,
				num = iter_1_1
			})

			Item = var_11

			local var_1_3 = var_11.getConfigData(iter_1_0).usage_arg

			tonumber = var_1_10012
			var_1_2 = var_1_2 + var_1_10012(var_1_3) * iter_1_1
		end
	end

	pg = var_6

	local var_1_4 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 22011, {
		ship_id = var_1_0,
		books = var_1_1
	}, 22012, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			BayProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getShipById(var_2_10004, var_1_0)

			var_2.addExp(var_2_0, var_1_2)

			local var_2_1 = var_1

			var_1.updateShip(var_2_1, var_2)

			getProxy = var_3
			BagProxy = var_2_1

			local var_2_2 = var_3(var_2_1)

			pairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(var_0.items) do
				if iter_2_1 > 0 then
					var_2_2:removeItemById(iter_2_0, iter_2_1)
				end
			end

			local var_2_3 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = iter_2_0

			var_2_10004(var_2_3, iter_2_0.USE_ADD_SHIPEXP_ITEM_DONE, {
				id = var_1_0
			})
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
