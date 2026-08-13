class = var_0_10000

local var_0_0 = "Challenge2ResetRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode
	local var_1_1 = arg_1_1
	local var_1_2 = arg_1_1.getBody(var_1_1).isInfiniteSeasonClear

	getProxy = var_1_1
	ActivityProxy = var_1_10005

	local var_1_3 = var_1_1(var_1_10005)
	local var_1_4 = var_4.getActivityByType

	ActivityConst = var_1_10007

	if var_1_4(var_1_3, var_1_10007.ACTIVITY_TYPE_CHALLENGE) then
		local var_1_5 = var_5

		if var_5.isEnd(var_1_5) then
			return
		end

		getProxy = var_1_3
		ChallengeProxy = var_1_5

		local var_1_6 = var_1_3(var_1_5)

		pg = var_1_5

		local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

		var_7.Send(var_1_7, 24011, {
			activity_id = var_5.id,
			mode = var_1_0
		}, 24012, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_1_6

				var_1.getUserChallengeInfoList(var_2_0)[var_1_0] = nil

				if var_1_2 == true then
					local var_2_1 = var_1_6
					local var_2_2 = var_2.setCurMode

					ChallengeProxy = var_2_10004

					var_2_2(var_2_1, var_2_10004.MODE_CASUAL)
				end

				local var_2_3 = arg_1_0
				local var_2_4 = var_2.sendNotification

				GAME = var_2_10004

				var_2_4(var_2_3, var_2_10004.CHALLENGE2_RESET_DONE)
			end

			return
		end)

		return
	end
end

return var_0_1
