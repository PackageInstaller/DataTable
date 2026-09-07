local RefluxRequestDataCommand = class("RefluxRequestDataCommand", pm.SimpleCommand)

function RefluxRequestDataCommand:execute()
	pg.ConnectionMgr.GetInstance():Send(11751, {
		type = 0
	}, 11752, function(arg_2_0)
		getProxy(RefluxProxy):setData(arg_2_0)

		return
	end)

	return
end

return RefluxRequestDataCommand
