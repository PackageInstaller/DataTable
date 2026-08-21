local var_0_0 = class("GetMailListCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2, var_1_3, var_1_4 = switch(var_1_0.cmd, {
		new = function()
			local var_2_1 = getProxy(MailProxy):GetNewIndex()
		end,
		next = function()
			local var_3_1 = getProxy(MailProxy):GetNextIndex()
		end,
		important = function()
			return 2, 0, 0
		end,
		rare = function()
			return 3, 0, 0
		end
	})

	if var_1_4 < var_1_3 then
		warning("without mail can require")

		return
	end

	pg.ConnectionMgr.GetInstance():Send(30002, {
		type = var_1_2,
		index_begin = var_1_3,
		index_end = var_1_4
	}, 30003, function(arg_6_0)
		local var_6_0 = underscore.map(arg_6_0.mail_list, function(arg_7_0)
			return Mail.New(arg_7_0)
		end)

		switch(var_0, {
			new = function()
				getProxy(MailProxy):AddNewMails(var_6_0)

				return
			end,
			next = function()
				getProxy(MailProxy):AddNextMails(var_6_0)

				return
			end,
			important = function()
				getProxy(MailProxy):SetImportantMails(var_6_0)

				return
			end,
			rare = function()
				getProxy(MailProxy):SetRareMails(var_6_0)

				return
			end
		})
		existCall(var_1_1)
		arg_1_0:sendNotification(GAME.GET_MAIL_LIST_DONE)

		return
	end)

	return
end

return var_0_0
