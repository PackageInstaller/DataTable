class = var_0_10000

local var_0_0 = "ProposeExchangeRingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	BagProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	pg = var_1_0

	local var_1_3 = var_1_0.gameset.vow_prop_conversion.description
	local var_1_5

	if var_1_2:getItemCountById(var_1_3[1]) < 1 then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10009

		var_1_5(var_1_4, var_1_10009("common_no_item_1"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_6.Send(var_1_6, 15010, {
		id = 0
	}, 15011, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_3.removeItemById(var_2_0, var_1_3[1], 1)

			local var_2_1 = var_1_2

			var_2_3.addItemById(var_2_1, var_1_3[2], 1)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10004
			var_2_10004 = var_2_10004.PROPOSE_EXCHANGE_RING_DONE

			local var_2_4 = {}
			local var_2_5 = {}

			Drop = var_2_10007

			local var_2_6 = var_2_10007.New
			local var_2_7 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10010
			var_2_7.type = var_2_10010
			var_2_7.id = var_1_3[2]
			var_2_5[1] = var_2_6(var_2_7)
			var_2_4.items = var_2_5

			var_2_3(var_2_2, var_2_10004, var_2_4)
		else
			pg = var_2_3

			local var_2_8 = var_2_3.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_9(var_2_8, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
