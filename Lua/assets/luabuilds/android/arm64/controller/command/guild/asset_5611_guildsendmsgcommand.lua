local GuildSendMsgCommand = class("GuildSendMsgCommand", pm.SimpleCommand)

function GuildSendMsgCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(60007, {
		chat = arg_1_1:getBody()
	})

	return
end

return GuildSendMsgCommand
