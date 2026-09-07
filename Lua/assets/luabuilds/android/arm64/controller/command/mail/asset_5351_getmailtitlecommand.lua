local GetMailTitleCommand = class("GetMailTitleCommand", pm.SimpleCommand)

function GetMailTitleCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(30014, {
		id_list = var_1_0.mailList
	}, 30015, function(arg_2_0)
		var_1_1(arg_2_0.mail_title_list)

		return
	end)

	return
end

return GetMailTitleCommand
