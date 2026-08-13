class = var_0_10000

local var_0_0 = "ExchangeShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).count

	getProxy = var_1_0
	BagProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getItemById

	ITEM_ID_SILVER_HOOK = var_1_10008

	local var_1_4 = var_1_3(var_1_2, var_1_10008)

	getProxy = var_1_10006
	BuildShipProxy = var_1_10008

	local var_1_5 = var_1_10006(var_1_10008)
	local var_1_6 = var_6.getSupportShipCost(var_1_5) * var_1_1

	getProxy = var_1_2
	BayProxy = var_1_10009

	local var_1_7 = var_1_2(var_1_10009)
	local var_1_8 = var_7.getShips(var_1_7)

	getProxy = var_1_10009
	PlayerProxy = var_1_10011

	local var_1_9 = var_1_10009(var_1_10011)
	local var_1_10 = var_9.getData(var_1_9)
	local var_1_11 = var_10.getMaxShipBag(var_1_10)
	local var_1_12 = var_7

	if var_1_11 < var_7.getShipCount(var_1_12) + var_1_1 then
		NoPosMsgBox = var_1_11
		i18n = var_1_10

		local var_1_13 = var_1_10("switch_to_shop_tip_noDockyard")

		openDockyardClear = var_1_12
		gotoChargeScene = var_15
		openDockyardIntensify = var_1_10016

		var_1_11(var_1_13, var_1_12, var_15, var_1_10016)

		return
	end

	if var_1_4 == nil or var_1_4.count < var_1_6 then
		pg = var_1_11

		local var_1_14 = var_1_11.TipsMgr.GetInstance()

		var_1_11 = var_1_11.ShowTips
		i18n = var_1_12

		var_1_11(var_1_14, var_1_12("word_materal_no_enough"))

		return
	end

	pg = var_1_11

	local var_1_15 = var_1_11.ConnectionMgr.GetInstance()

	var_11.Send(var_1_15, 16100, {
		cnt = var_1_1
	}, 16101, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.removeItemById

			ITEM_ID_SILVER_HOOK = var_2_10004

			var_2_1(var_2_0, var_2_10004, var_1_6)

			local var_2_2 = {}

			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.ship_list) do
				Ship = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)

				local var_2_3 = var_0

				var_8.addShip(var_2_3, var_2_10007)

				table = var_8

				var_8.insert(var_2_2, var_2_10007)
			end

			var_2_10004 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = iter_2_0

			var_2_4(var_2_10004, iter_2_0.SUPPORT_SHIP_DONE, {
				ships = var_2_2
			})
		else
			local var_2_6

			if arg_2_0.result == 30 then
				pg = var_2_6

				local var_2_5 = var_2_6.TipsMgr.GetInstance()

				var_2_6 = var_2_6.ShowTips
				i18n = var_2_10004

				var_2_6(var_2_5, var_2_10004("support_times_limited"))
			else
				pg = var_2_6

				local var_2_7 = var_2_6.TipsMgr.GetInstance()
				local var_2_8 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_8(var_2_7, var_2_10004("ship_exchange_erro", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
