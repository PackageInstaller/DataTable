local SendMsgCommand = class("SendMsgCommand", pm.SimpleCommand)

function SendMsgCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(50102, {
		type = 1,
		content = arg_1_1:getBody()
	})

	return
end

return SendMsgCommand
