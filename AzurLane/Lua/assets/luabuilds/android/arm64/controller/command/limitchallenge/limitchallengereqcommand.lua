class = var_0_10000

local var_0_0 = "LimitChallengeReqCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = {
		type = 1
	}

	pg = var_1_0

	local var_1_3 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 24020, var_1_2, 24021, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			LimitChallengeProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.setTimeDataFromServer(var_2_10004, arg_2_0.times)

			var_2_10004 = var_1

			var_1.setAwardedDataFromServer(var_2_10004, arg_2_0.awards)

			var_2_10004 = var_1

			var_1.setCurMonthPassedIDList(var_2_10004, arg_2_0.pass_ids)

			var_2_10004 = arg_1_0

			local var_2_0 = var_2.sendNotification

			LimitChallengeConst = var_5

			var_2_0(var_2_10004, var_5.REQ_CHALLENGE_INFO_DONE)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_2(var_2_1, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
