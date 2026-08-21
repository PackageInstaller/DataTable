local var_0_0 = class("DeleteCollectionMailCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(MailProxy)

	if getProxy(MailProxy):getCollecitonMail(var_1_0) == nil then
		print("邮件不存在: " .. var_1_0)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(30008, {
		mail_id = var_1_0
	}, 30009, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:removeCollectionMail(var_1_0)
			arg_1_0:sendNotification(GAME.DELETE_COLLECTION_MAIL_DONE, var_1_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
