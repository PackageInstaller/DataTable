class = var_0_10000

local var_0_0 = "SellItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().items
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	BagProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	pairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_0) do
		local var_1_3 = var_1_2

		if var_1_2.getItemCountById(var_1_3, iter_1_1.id) < iter_1_1.count then
			local var_1_4 = var_1_2:RawGetItemById(iter_1_1.id)

			pg = var_1_3

			local var_1_5 = var_1_3.TipsMgr.GetInstance()
			local var_1_6 = var_13.ShowTips

			i18n = var_1_10016

			var_1_6(var_1_5, var_1_10016("common_no_x", var_1_4:getConfig("name")))

			if var_1_1 then
				var_1_1(false)
			end

			return
		end
	end

	pg = var_6

	local var_1_7 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_7, 15008, {
		item_list = var_1_0
	}, 15009, function(arg_2_0)
		if arg_2_0.result == 0 then
			pairs = var_1

			for iter_2_0, iter_2_1 in var_1(var_1_0) do
				reducePlayerOwn = var_2_10006
				Drop = var_2_10008
				var_2_10008 = var_2_10008.Create

				local var_2_0 = {}

				DROP_TYPE_ITEM = var_2_10011
				var_2_0[1] = var_2_10011
				var_2_0[2] = iter_2_1.id
				var_2_0[3] = iter_2_1.count

				var_2_10006(var_2_10008(var_2_0))
			end

			local var_2_1 = {}

			iter_2_0 = var_1_2

			local var_2_2 = var_2.GetSellingPrice(iter_2_0, var_1_0)

			pairs = var_3

			for iter_2_2, iter_2_3 in var_3(var_2_2) do
				Drop = var_2_10008

				if var_2_10008.Create(iter_2_3).count > 0 then
					addPlayerOwn = var_9

					var_9(var_2_10008)

					table = var_9

					var_9.insert(var_2_1, var_2_10008)
				end
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = iter_2_2

			var_2_4(var_2_3, iter_2_2.SELL_ITEM_DONE, {
				awards = var_2_1
			})

			if var_1_1 then
				var_1_1(var_2_1)
			end
		else
			if var_1_1 then
				var_1_1(nil)
			end

			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = iter_2_0

			var_2_6(var_2_5, iter_2_0("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
