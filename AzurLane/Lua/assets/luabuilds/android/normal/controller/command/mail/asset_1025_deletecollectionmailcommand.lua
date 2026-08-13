class = var_0_10000

local var_0_0 = "DeleteCollectionMailCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	MailProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if var_3.getCollecitonMail(var_1_2, var_1_1) == nil then
		print = var_1_2

		var_1_2("邮件不存在: " .. var_1_1)

		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 30008, {
		mail_id = var_1_1
	}, 30009, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.removeCollectionMail(var_2_0, var_1_1)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.DELETE_COLLECTION_MAIL_DONE, var_1_1)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
