local BuildShipCommand = class("BuildShipCommand", pm.SimpleCommand)

function BuildShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.buildId
	local var_1_2 = var_1_0.count or 1
	local var_1_3 = var_1_0.isTicket
	local var_1_4, var_1_5, var_1_6 = BuildShip.canBuildShipByBuildId(var_1_1, var_1_2, var_1_0.isTicket)

	if not var_1_4 then
		if var_1_6 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_1"), ChargeScene.TYPE_ITEM, var_1_6)
		else
			pg.TipsMgr.GetInstance():ShowTips(var_1_5)
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12002, {
		id = var_1_1,
		count = var_1_2,
		costtype = var_1_3 and 1 or 0
	}, 12003, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_BUILD_SHIP, var_1_2)

			local var_2_0 = pg.ship_data_create_material[var_1_1]

			if var_1_3 then
				local var_2_1 = getProxy(ActivityProxy)
				local var_2_2 = var_2_1:getBuildFreeActivityByBuildId(var_1_1)

				var_2_2.data1 = var_2_2.data1 - var_1_2

				var_2_1:updateActivity(var_2_2)
			else
				getProxy(BagProxy):removeItemById(var_2_0.use_item, var_2_0.number_1 * var_1_2)

				local var_2_3 = getProxy(PlayerProxy)
				local var_2_4 = var_2_3:getData()

				var_2_4:consume({
					gold = var_2_0.use_gold * var_1_2
				})
				var_2_3:updatePlayer(var_2_4)
			end

			local var_2_5 = getProxy(BuildShipProxy)

			if var_2_0.exchange_count > 0 then
				var_2_5:changeRegularExchangeCount(var_1_2 * var_2_0.exchange_count)
			end

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.build_info) do
				var_2_5:addBuildShip((BuildShip.New(iter_2_1)))
			end

			self:sendNotification(GAME.BUILD_SHIP_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_buildShipMediator_startBuild"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_buildShip_error", arg_2_0.result))
		end

		return
	end)

	return
end

return BuildShipCommand
