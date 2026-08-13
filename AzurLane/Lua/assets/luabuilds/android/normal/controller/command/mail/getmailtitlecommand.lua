class = var_0_10000

local var_0_0 = "GetMailTitleCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.mailList

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 30014, {
		id_list = var_1_1
	}, 30015, function(arg_2_0)
		var_1_0(arg_2_0.mail_title_list)

		return
	end)

	return
end

return var_0_1
