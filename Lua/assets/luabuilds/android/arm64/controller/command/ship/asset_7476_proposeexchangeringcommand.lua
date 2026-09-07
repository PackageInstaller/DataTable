local ProposeExchangeRingCommand = class("ProposeExchangeRingCommand", pm.SimpleCommand)

function ProposeExchangeRingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BagProxy)
	local var_1_2 = pg.gameset.vow_prop_conversion.description

	if var_1_1:getItemCountById(pg.gameset.vow_prop_conversion.description[1]) < 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(15010, {
		id = 0
	}, 15011, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:removeItemById(var_1_2[1], 1)
			var_1_1:addItemById(var_1_2[2], 1)
			self:sendNotification(GAME.PROPOSE_EXCHANGE_RING_DONE, {
				items = {
					Drop.New({
						count = 1,
						type = DROP_TYPE_ITEM,
						id = var_1_2[2]
					})
				}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ProposeExchangeRingCommand
