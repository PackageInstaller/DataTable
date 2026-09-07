local ExchangeShipCommand = class("ExchangeShipCommand", pm.SimpleCommand)

function ExchangeShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().count
	local var_1_1 = getProxy(BagProxy)
	local var_1_2 = var_1_1:getItemById(ITEM_ID_SILVER_HOOK)
	local var_1_3 = getProxy(BuildShipProxy):getSupportShipCost() * var_1_0
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = var_1_4:getShips()

	if getProxy(PlayerProxy):getData():getMaxShipBag() < var_1_4:getShipCount() + var_1_0 then
		NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

		return
	end

	if var_1_2 == nil or var_1_3 > var_1_2.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(16100, {
		cnt = var_1_0
	}, 16101, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:removeItemById(ITEM_ID_SILVER_HOOK, var_1_3)

			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
				local var_2_1 = Ship.New(iter_2_1)

				var_1_4:addShip(var_2_1)
				table.insert(var_2_0, var_2_1)
			end

			self:sendNotification(GAME.SUPPORT_SHIP_DONE, {
				ships = var_2_0
			})
		elseif arg_2_0.result == 30 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("support_times_limited"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_exchange_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return ExchangeShipCommand
