class = var_0_10000

local var_0_0 = "WorldPortReqCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 33401, {
		map_id = var_1_0.mapId
	}, 33402, function(arg_2_0)
		local var_2_0 = arg_2_0.port.port_id

		if (0 < var_2_0 and 0 or 1) == 0 then
			getProxy = var_2
			WorldProxy = var_2_10004

			local var_2_1 = var_2(var_2_10004)

			var_2.NetUpdateMapPort(var_2_1, var_1_0.mapId, arg_2_0.port)

			nowWorld = var_2

			local var_2_2 = var_2()
			local var_2_3 = var_2.GetAtlas(var_2_2)

			var_2.UpdatePortMark(var_2_3, arg_2_0.port.port_id, nil, false)
		else
			pg = var_2

			local var_2_4 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_2_4, "port req error.")
		end

		local var_2_5 = arg_1_0
		local var_2_6 = var_2.sendNotification

		GAME = var_2_10005

		var_2_6(var_2_5, var_2_10005.WORLD_PORT_REQ_DONE)

		return
	end)

	return
end

return var_0_1
