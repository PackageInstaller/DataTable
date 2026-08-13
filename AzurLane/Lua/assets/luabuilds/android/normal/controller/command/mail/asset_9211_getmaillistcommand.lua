class = var_0_10000

local var_0_0 = "GetMailListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().cmd
	local var_1_1 = var_2.callback

	switch = var_1_10005

	local var_1_2, var_1_3, var_1_4 = var_1_10005(var_1_0, {
		new = function()
			local var_2_0 = 1

			getProxy = var_2_10001
			MailProxy = var_2_10002

			local var_2_1 = var_2_10001(var_2_10002)
			local var_2_2 = var_1.GetNewIndex(var_2_1)
		end,
		next = function()
			local var_3_0 = 1

			getProxy = var_2_10001
			MailProxy = var_2_10002

			local var_3_1 = var_2_10001(var_2_10002)
			local var_3_2 = var_1.GetNextIndex(var_3_1)
		end,
		important = function()
			return 2, 0, 0
		end,
		rare = function()
			return 3, 0, 0
		end
	})

	if var_1_4 < var_1_3 then
		warning = var_8

		var_8("without mail can require")

		return
	end

	pg = var_8

	local var_1_5 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 30002, {
		type = var_1_2,
		index_begin = var_1_3,
		index_end = var_1_4
	}, 30003, function(arg_6_0)
		underscore = var_2_10001

		local var_6_0 = var_2_10001.map(arg_6_0.mail_list, function(arg_7_0)
			Mail = var_3_10001

			return var_3_10001.New(arg_7_0)
		end)

		switch = var_2

		var_2(var_1_0, {
			new = function()
				getProxy = var_3_10000
				MailProxy = var_3_10001

				local var_8_0 = var_3_10000(var_3_10001)

				var_0.AddNewMails(var_8_0, var_6_0)

				return
			end,
			next = function()
				getProxy = var_3_10000
				MailProxy = var_3_10001

				local var_9_0 = var_3_10000(var_3_10001)

				var_0.AddNextMails(var_9_0, var_6_0)

				return
			end,
			important = function()
				getProxy = var_3_10000
				MailProxy = var_3_10001

				local var_10_0 = var_3_10000(var_3_10001)

				var_0.SetImportantMails(var_10_0, var_6_0)

				return
			end,
			rare = function()
				getProxy = var_3_10000
				MailProxy = var_3_10001

				local var_11_0 = var_3_10000(var_3_10001)

				var_0.SetRareMails(var_11_0, var_6_0)

				return
			end
		})

		existCall = var_2

		var_2(var_1_1)

		local var_6_1 = arg_1_0
		local var_6_2 = var_2.sendNotification

		GAME = var_4

		var_6_2(var_6_1, var_4.GET_MAIL_LIST_DONE)

		return
	end)

	return
end

return var_0_1
