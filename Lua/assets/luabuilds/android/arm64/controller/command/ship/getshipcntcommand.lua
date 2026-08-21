local var_0_0 = class("GetShipCntCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg.ConnectionMgr.GetInstance():Send(11800, {
		type = 0
	}, 11801, function(arg_2_0)
		var_1_0(arg_2_0.ship_count)

		return
	end)

	return
end

return var_0_0
