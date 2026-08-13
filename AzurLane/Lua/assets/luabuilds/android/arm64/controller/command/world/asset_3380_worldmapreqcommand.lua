class = var_0_10000

local var_0_0 = "WorldMapReqCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 33106, {
		id = var_1_0.mapId
	}, 33107, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			if arg_2_0.is_reset == 1 then
				pg = var_2_0
				var_2_10003 = var_2_0.TipsMgr.GetInstance()
				var_2_0 = var_2_0.ShowTips
				i18n = var_2_10004

				var_2_0(var_2_10003, var_2_10004("world_map_version"))
			end

			getProxy = var_2_0
			WorldProxy = var_2_10003

			local var_2_1 = var_2_0(var_2_10003)

			var_2_0.NetUpdateMap(var_2_1, arg_2_0.map)
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_3(var_2_2, var_2_10004("world_map_req_error_", arg_2_0.result))
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_1.sendNotification

		GAME = var_2_10004

		var_2_5(var_2_4, var_2_10004.WORLD_MAP_REQ_DONE, {
			result = arg_2_0.result
		})

		return
	end)

	return
end

return var_0_1
