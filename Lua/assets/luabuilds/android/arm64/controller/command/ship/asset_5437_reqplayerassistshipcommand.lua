local ReqPlayerAssistCommand = class("ReqPlayerAssistCommand", pm.SimpleCommand)

function ReqPlayerAssistCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.playerIds
	local var_1_2 = var_1_0.callback
	local var_1_3 = var_1_0.type

	pg.ConnectionMgr.GetInstance():Send(12301, {
		type = var_1_0.type,
		id_list = var_1_0.playerIds
	}, 12302, function(arg_2_0)
		local var_2_0 = getProxy(PlayerProxy)
		local var_2_1

		if var_1_3 == Player.ASSISTS_TYPE_SHAM then
			var_2_1 = var_2_0.playerAssists
		elseif var_1_3 == Player.ASSISTS_TYPE_GUILD then
			var_2_1 = var_2_0.playerGuildAssists
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
			local var_2_2 = {
				playerId = var_1_1[iter_2_0]
			}

			var_2_2.timeStamp = pg.TimeMgr.GetInstance():GetServerTime()

			if iter_2_1 and pg.ship_data_statistics[iter_2_1.template_id] then
				var_2_2.ship = Ship.New(iter_2_1)
			end

			var_2_1[var_2_2.playerId] = var_2_2
		end

		if var_1_2 then
			var_1_2()
		end

		return
	end)

	return
end

return ReqPlayerAssistCommand
