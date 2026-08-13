class = var_0_10000

local var_0_0 = "ExchangeShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().count

	getProxy = var_1_10004
	BagProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getItemById

	ITEM_ID_SILVER_HOOK = var_1_10007

	local var_1_3 = var_1_2(var_1_1, var_1_10007)

	getProxy = var_1_1
	BuildShipProxy = var_1_10007

	local var_1_4 = var_1_1(var_1_10007)
	local var_1_5 = var_6.getSupportShipCost(var_1_4) * var_1_0

	getProxy = var_1_4
	BayProxy = var_1_10008

	local var_1_6 = var_1_4(var_1_10008)
	local var_1_7 = var_7.getShips(var_1_6)

	getProxy = var_1_6
	PlayerProxy = var_1_10010

	local var_1_8 = var_1_6(var_1_10010)
	local var_1_9 = var_9.getData(var_1_8)
	local var_1_10 = var_10.getMaxShipBag(var_1_9)
	local var_1_11 = var_7

	if var_1_10 < var_7.getShipCount(var_1_11) + var_1_0 then
		NoPosMsgBox = var_1_10
		i18n = var_12

		local var_1_12 = var_12("switch_to_shop_tip_noDockyard")

		openDockyardClear = var_1_11
		gotoChargeScene = var_1_10014
		openDockyardIntensify = var_1_10015

		var_1_10(var_1_12, var_1_11, var_1_10014, var_1_10015)

		return
	end

	if var_1_3 == nil or var_1_3.count < var_1_5 then
		pg = var_1_10

		local var_1_13 = var_1_10.TipsMgr.GetInstance()

		var_1_10 = var_1_10.ShowTips
		i18n = var_1_11

		var_1_10(var_1_13, var_1_11("word_materal_no_enough"))

		return
	end

	pg = var_1_10

	local var_1_14 = var_1_10.ConnectionMgr.GetInstance()

	var_11.Send(var_1_14, 16100, {
		cnt = var_1_0
	}, 16101, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.removeItemById

			ITEM_ID_SILVER_HOOK = var_2_10003

			var_2_1(var_2_0, var_2_10003, var_1_5)

			local var_2_2 = {}

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(arg_2_0.ship_list) do
				Ship = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)

				local var_2_3 = var_0

				var_8.addShip(var_2_3, var_2_10007)

				table = var_8

				var_8.insert(var_2_2, var_2_10007)
			end

			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_4

			var_2_4(var_2_10003, var_4.SUPPORT_SHIP_DONE, {
				ships = var_2_2
			})
		else
			local var_2_6

			if arg_2_0.result == 30 then
				pg = var_2_6

				local var_2_5 = var_2_6.TipsMgr.GetInstance()

				var_2_6 = var_2_6.ShowTips
				i18n = var_2_10003

				var_2_6(var_2_5, var_2_10003("support_times_limited"))
			else
				pg = var_2_6

				local var_2_7 = var_2_6.TipsMgr.GetInstance()
				local var_2_8 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_8(var_2_7, var_2_10003("ship_exchange_erro", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
