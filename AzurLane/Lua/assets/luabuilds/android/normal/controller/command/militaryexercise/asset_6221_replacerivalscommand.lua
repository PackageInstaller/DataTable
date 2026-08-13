class = var_0_10000

local var_0_0 = "ReplaceRivalsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	MilitaryExerciseProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.getSeasonInfo(var_1_0)
	local var_1_2 = var_3.getconsumeGem(var_1_1)
	local var_1_3 = var_3
	local var_1_4 = var_3.getFlashCount(var_1_3)

	MAX_REPLACE_RIVAL_COUNT = var_1_3

	if var_1_3 <= var_1_4 then
		pg = var_1_4

		local var_1_5 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10007

		var_1_4(var_1_5, var_1_10007("common_refresh_count_insufficient"))

		return
	end

	pg = var_1_4

	local var_1_6 = var_1_4.ConnectionMgr.GetInstance()

	var_5.Send(var_1_6, 18003, {
		type = 0
	}, 18004, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.target_list) do
				Rival = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)
				table = var_8

				var_8.insert(var_2_0, var_2_10007)
			end

			var_2_10003 = var_0

			var_2.updateRivals(var_2_10003, var_2_0)

			var_2_10003 = var_0
			var_0 = var_2.getSeasonInfo(var_2_10003)
			var_2_10003 = var_0

			var_2.increaseFlashCount(var_2_10003)

			var_2_10003 = var_0

			var_2.updateSeasonInfo(var_2_10003, var_0)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.REPLACE_RIVALS_DONE, var_2_0)
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
