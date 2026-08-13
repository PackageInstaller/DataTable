class = var_0_10000

local var_0_0 = "Challenge2InfoRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getActivityByType

	ActivityConst = var_1_10008

	local var_1_4 = var_1_3(var_1_2, var_1_10008.ACTIVITY_TYPE_CHALLENGE)

	getProxy = var_1_10006
	ChallengeProxy = var_8

	local var_1_5 = var_1_10006(var_8)

	if not var_1_4 or var_1_4:isEnd() then
		return
	end

	pg = var_1_2

	local var_1_6 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_6, 24004, {
		activity_id = var_1_4.id
	}, 24005, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5

			var_2_3.updateSeasonChallenge(var_2_0, arg_2_0.current_challenge)

			ipairs = var_2_3

			for iter_2_0, iter_2_1 in var_2_3(arg_2_0.user_challenge) do
				local var_2_1 = var_1_5

				var_6.updateCurrentChallenge(var_2_1, iter_2_1)
			end

			if var_1_1 then
				var_1_1()
			end

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = iter_2_0

			var_2_3(var_2_2, iter_2_0.CHALLENGE2_INFO_DONE)
		else
			originalPrint = var_2_3

			var_2_3("reqquest challenge info fail, data.result: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
