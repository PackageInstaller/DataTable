local AcceptLoveLetterMailCommand = class("AcceptLoveLetterMailCommand", pm.SimpleCommand)

function AcceptLoveLetterMailCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0)

	if not var_1_1 or var_1_1:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_1_0)

			var_2_0.data1 = 1

			getProxy(ActivityProxy):updateActivity(var_2_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("spring_present_tips3"))
			pg.m02:sendNotification(GAME.ACCEPT_LOVE_LETTER_MAIL_DONE)
		elseif arg_2_0.result == 22 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spring_present_tips2"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return AcceptLoveLetterMailCommand
