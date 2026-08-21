local var_0_0 = class("GetExchangeShipsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(16100, {
		time = arg_1_1:getBody().time
	}, 16101, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_id_list) do
			table.insert({}, {
				isFetched = false,
				id = iter_2_1
			})
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.fetched_index_list) do
			({})[iter_2_3].isFetched = true
		end

		getProxy(BuildShipProxy):updateExchangeList(arg_2_0.flag_ship_flash_time, arg_2_0.flash_time, {})
		arg_1_0:sendNotification(GAME.GET_EXCHANGE_SHIPS_DONE)

		return
	end)

	return
end

return var_0_0
