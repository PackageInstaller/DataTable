local var_0_0 = class("GuildSendMsgCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(60007, {
		chat = arg_1_1:getBody()
	})

	return
end

return var_0_0
