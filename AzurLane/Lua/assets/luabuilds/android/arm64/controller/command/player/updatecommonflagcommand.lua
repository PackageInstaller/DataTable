local var_0_0 = class("UpdateCommonFlagCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11019, {
		flag_id = arg_1_1:getBody().flagID
	}, 11020, function(arg_2_0)
		local var_2_0 = getProxy(PlayerProxy)

		if var_2_0 then
			local var_2_1 = var_2_0:getData()

			var_2_1:UpdateCommonFlag(var_0)
			var_2_0:updatePlayer(var_2_1)
		end

		return
	end)

	return
end

return var_0_0
