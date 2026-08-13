class = var_0_10000

local var_0_0 = "GetSeasonInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 18001, {
		type = 0
	}, 18002, function(arg_2_0)
		SeasonInfo = var_2_10001

		local var_2_0 = var_2_10001.New(arg_2_0)

		getProxy = var_2
		MilitaryExerciseProxy = var_2_10003

		local var_2_1 = var_2(var_2_10003)

		if var_2.getData(var_2_1) then
			var_2_1 = var_2

			var_2.updateSeasonInfo(var_2_1, var_2_0)
		else
			var_2_1 = var_2

			var_2.addSeasonInfo(var_2_1, var_2_0)
		end

		getProxy = var_3
		PlayerProxy = var_2_1

		local var_2_2 = var_3(var_2_1)
		local var_2_3 = var_3.getData(var_2_2)

		var_4.updateScoreAndRank(var_2_3, var_2_0.score, var_2_0.rank)
		var_3:updatePlayer(var_4)

		local var_2_4 = arg_1_0
		local var_2_5 = var_5.sendNotification

		GAME = var_7

		var_2_5(var_2_4, var_7.GET_SEASON_INFO_DONE, var_2_0)

		return
	end)

	return
end

return var_0_1
