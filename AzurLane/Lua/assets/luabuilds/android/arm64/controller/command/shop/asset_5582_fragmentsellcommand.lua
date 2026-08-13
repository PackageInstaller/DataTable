class = var_0_10000

local var_0_0 = "FragmentSellCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	BagProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)
	local var_1_4 = var_4.getRawData(var_1_3)
	local var_1_5 = {}
	local var_1_6 = {}

	pairs = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10008(var_1_1) do
		if var_1_2:getItemCountById(iter_1_1.id) < iter_1_1.count then
			pg = var_14

			local var_1_7 = var_14.TipsMgr.GetInstance()
			local var_1_8 = var_14.ShowTips

			i18n = var_1_10017

			var_1_8(var_1_7, var_1_10017("common_no_x", iter_1_1:getConfig("name")))

			return
		end

		local var_1_9

		if not var_1_6[iter_1_1:getConfig("price")[1]] then
			var_1_9 = 0
		end

		local var_1_10 = var_1_9 + var_14[2] * iter_1_1.count

		var_1_6[var_14[1]] = var_1_10
		table = var_16

		var_16.insert(var_1_5, {
			id = iter_1_1.id,
			count = iter_1_1.count
		})
	end

	pg = var_8

	local var_1_11 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_11, 15008, {
		item_list = var_1_5
	}, 15009, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(var_1_1) do
				reducePlayerOwn = var_2_10006

				var_2_10006(iter_2_1)
			end

			var_2_0 = {}
			pairs = var_2

			for iter_2_2, iter_2_3 in var_2(var_1_6) do
				local var_2_1 = {}

				DROP_TYPE_RESOURCE = var_2_10008
				var_2_1.type = var_2_10008
				var_2_1.id = iter_2_2
				var_2_1.count = iter_2_3
				addPlayerOwn = var_2_10008

				var_2_10008(var_2_1)

				table = var_2_10008

				var_2_10008.insert(var_2_0, var_2_1)
			end

			iter_2_0 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = iter_2_2

			var_2_2(iter_2_0, iter_2_2.FRAG_SELL_DONE, {
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = iter_2_0

			var_2_4(var_2_3, iter_2_0("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
