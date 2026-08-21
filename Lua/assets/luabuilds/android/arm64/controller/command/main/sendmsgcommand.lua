local var_0_0 = class("SendMsgCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(50102, {
		type = 1,
		content = arg_1_1:getBody()
	})

	return
end

return var_0_0
