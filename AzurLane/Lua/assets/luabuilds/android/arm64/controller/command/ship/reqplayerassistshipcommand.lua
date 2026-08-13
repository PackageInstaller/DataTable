class = var_0_10000

local var_0_0 = "ReqPlayerAssistCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().playerIds
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.type

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 12301, {
		type = var_1_2,
		id_list = var_1_0
	}, 12302, function(arg_2_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1
		local var_2_2 = var_1_2

		Player = var_2_10004

		if var_2_2 == var_2_10004.ASSISTS_TYPE_SHAM then
			var_2_1 = var_2_0.playerAssists
		else
			var_2_2 = var_1_2
			Player = var_4

			if var_2_2 == var_4.ASSISTS_TYPE_GUILD then
				var_2_1 = var_2_0.playerGuildAssists
			end
		end

		ipairs = var_2_2

		for iter_2_0, iter_2_1 in var_2_2(arg_2_0.ship_list) do
			local var_2_3 = {
				playerId = var_1_0[iter_2_0]
			}

			pg = var_9

			local var_2_4 = var_9.TimeMgr.GetInstance()

			var_2_3.timeStamp = var_9.GetServerTime(var_2_4)

			if iter_2_1 then
				pg = var_9

				if var_9.ship_data_statistics[iter_2_1.template_id] then
					Ship = var_9
					var_2_3.ship = var_9.New(iter_2_1)
				end
			end

			var_2_1[var_2_3.playerId] = var_2_3
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
