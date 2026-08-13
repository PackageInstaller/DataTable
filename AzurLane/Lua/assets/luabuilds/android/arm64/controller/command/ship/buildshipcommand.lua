class = var_0_10000

local var_0_0 = "BuildShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().buildId
	local var_1_1

	if not var_2.count then
		var_1_1 = 1
	end

	local var_1_2 = var_2.isTicket

	BuildShip = var_1_10006

	local var_1_3, var_1_4, var_1_5 = var_1_10006.canBuildShipByBuildId(var_1_0, var_1_1, var_1_2)

	if not var_1_3 then
		if var_1_5 then
			GoShoppingMsgBox = var_9
			i18n = var_1_10011

			local var_1_6 = var_1_10011("switch_to_shop_tip_1")

			ChargeScene = var_1_10012

			var_9(var_1_6, var_1_10012.TYPE_ITEM, var_1_5)
		else
			pg = var_9

			local var_1_7 = var_9.TipsMgr.GetInstance()

			var_9.ShowTips(var_1_7, var_1_4)
		end

		return
	end

	pg = var_9

	local var_1_8 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_8, 12002, {
		id = var_1_0,
		count = var_1_1,
		costtype = var_1_2 and 1 or 0
	}, 12003, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.TrackerMgr.GetInstance()

			var_2_1 = var_2_1.Tracking
			TRACKING_BUILD_SHIP = var_2_10004

			var_2_1(var_2_0, var_2_10004, var_1_1)

			pg = var_2_1
			var_2_1 = var_2_1.ship_data_create_material[var_1_0]

			if var_1_2 then
				getProxy = var_2
				ActivityProxy = var_2_10004

				local var_2_2 = var_2(var_2_10004)

				var_3.data1 = var_2.getBuildFreeActivityByBuildId(var_2_2, var_1_0).data1 - var_1_1

				var_2:updateActivity(var_3)
			else
				getProxy = var_2
				BagProxy = var_2_10004

				local var_2_3 = var_2(var_2_10004)

				var_2.removeItemById(var_2_3, var_2_1.use_item, var_2_1.number_1 * var_1_1)

				getProxy = var_3
				PlayerProxy = var_2_3

				local var_2_4 = var_3(var_2_3)
				local var_2_5 = var_3.getData(var_2_4)

				var_2_10004.consume(var_2_5, {
					gold = var_2_1.use_gold * var_1_1
				})
				var_3:updatePlayer(var_2_10004)
			end

			getProxy = var_2
			BuildShipProxy = var_2_10004

			local var_2_6 = var_2(var_2_10004)
			local var_2_7 = var_2_1.exchange_count

			if 0 < var_2_7 then
				var_2_6:changeRegularExchangeCount(var_1_1 * var_2_1.exchange_count)
			end

			ipairs = var_2_7

			for iter_2_0, iter_2_1 in var_2_7(arg_2_0.build_info) do
				BuildShip = var_2_10008
				var_2_10008 = var_2_10008.New(iter_2_1)

				var_2_6:addBuildShip(var_2_10008)
			end

			local var_2_8 = arg_1_0
			local var_2_9 = var_3.sendNotification

			GAME = iter_2_0

			var_2_9(var_2_8, iter_2_0.BUILD_SHIP_DONE)

			pg = var_2_9

			local var_2_10 = var_2_9.TipsMgr.GetInstance()
			local var_2_11 = var_3.ShowTips

			i18n = var_6

			var_2_11(var_2_10, var_6("ship_buildShipMediator_startBuild"))
		else
			pg = var_2_1

			local var_2_12 = var_2_1.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_13(var_2_12, var_2_10004("ship_buildShip_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
