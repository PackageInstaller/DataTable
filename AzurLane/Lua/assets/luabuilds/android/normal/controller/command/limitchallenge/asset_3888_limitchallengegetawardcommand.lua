class = var_0_10000

local var_0_0 = "LimitChallengeGetAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = {
		challengeids = var_1_0.challengeIDList
	}

	pg = var_4

	local var_1_2 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 24022, var_1_1, 24023, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			LimitChallengeProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(var_1_0.challengeIDList) do
				var_2_0:setAwarded(iter_2_1)
			end

			PlayerConst = var_2

			local var_2_1 = var_2.addTranDrop(arg_2_0.drop_list)

			pg = var_2_10003

			local var_2_2 = var_2_10003.m02

			var_2_10003 = var_2_10003.sendNotification
			LimitChallengeConst = iter_2_0

			var_2_10003(var_2_2, iter_2_0.GET_CHALLENGE_AWARD_DONE, {
				awards = var_2_1
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
