local BuildPoolRegularExchangeCommand = class("BuildPoolRegularExchangeCommand", pm.SimpleCommand)

function BuildPoolRegularExchangeCommand:execute(arg_1_1)
	if getProxy(BuildShipProxy):getRegularExchangeCount() < pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID].exchange_request then
		pg.TipsMgr.GetInstance():ShowTips("unenough")

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12047, {
		ship_tid = arg_1_1:getBody().id
	}, 12048, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(BuildShipProxy):changeRegularExchangeCount(-pg.ship_data_create_exchange[REGULAR_BUILD_POOL_EXCHANGE_ID].exchange_request)
			self:sendNotification(GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return BuildPoolRegularExchangeCommand
