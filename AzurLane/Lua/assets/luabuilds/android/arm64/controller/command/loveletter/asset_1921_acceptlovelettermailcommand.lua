class = var_0_10000

local var_0_0 = "AcceptLoveLetterMailCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).activity_id

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getActivityById(var_1_2, var_1_1) or var_4:isEnd() then
		pg = var_1_10005

		local var_1_3 = var_1_10005.TipsMgr.GetInstance()

		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10008

		var_1_10005(var_1_3, var_1_10008("challenge_end_tip"))

		return
	end

	pg = var_1_10005

	local var_1_4 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 11202, {
		cmd = 1,
		activity_id = var_1_1
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.getActivityById(var_2_0, var_1_1)

			var_2_1.data1 = 1
			getProxy = var_2
			ActivityProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.updateActivity(var_2_10004, var_2_1)

			pg = var_2
			var_2_10004 = var_2.TipsMgr.GetInstance()

			local var_2_2 = var_2.ShowTips

			i18n = var_5

			var_2_2(var_2_10004, var_5("spring_present_tips3"))

			pg = var_2_2
			var_2_10004 = var_2_2.m02

			local var_2_3 = var_2.sendNotification

			GAME = var_5

			var_2_3(var_2_10004, var_5.ACCEPT_LOVE_LETTER_MAIL_DONE)
		else
			local var_2_5

			if arg_2_0.result == 22 then
				pg = var_2_5

				local var_2_4 = var_2_5.TipsMgr.GetInstance()

				var_2_5 = var_2_5.ShowTips
				i18n = var_2_10004

				var_2_5(var_2_4, var_2_10004("spring_present_tips2"))
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
