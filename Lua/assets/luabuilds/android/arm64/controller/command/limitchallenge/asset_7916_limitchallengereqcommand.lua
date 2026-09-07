local LimitChallengeReqCommand = class("LimitChallengeReqCommand", pm.SimpleCommand)

function LimitChallengeReqCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(24020, {
		type = 1
	}, 24021, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(LimitChallengeProxy)

			var_2_0:setTimeDataFromServer(arg_2_0.times)
			var_2_0:setAwardedDataFromServer(arg_2_0.awards)
			var_2_0:setCurMonthPassedIDList(arg_2_0.pass_ids)
			self:sendNotification(LimitChallengeConst.REQ_CHALLENGE_INFO_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return LimitChallengeReqCommand
