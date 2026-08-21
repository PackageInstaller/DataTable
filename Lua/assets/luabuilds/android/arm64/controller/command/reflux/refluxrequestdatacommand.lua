local var_0_0 = class("RefluxRequestDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0)
	pg.ConnectionMgr.GetInstance():Send(11751, {
		type = 0
	}, 11752, function(arg_2_0)
		getProxy(RefluxProxy):setData(arg_2_0)

		return
	end)

	return
end

return var_0_0
