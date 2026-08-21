local var_0_0 = class("IslandUpdateAchvCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21052, {
		event_list = arg_1_1:getBody().records
	})

	return
end

return var_0_0
