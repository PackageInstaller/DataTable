class = var_0_10000

local var_0_0 = "ExerciseCountRecoverUpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local function var_1_0()
		pg = var_2_10000

		local var_2_0 = var_2_10000.TimeMgr.GetInstance()
		local var_2_1 = var_0.STimeDescS

		pg = var_2_10002

		local var_2_2 = var_2_10002.TimeMgr.GetInstance()
		local var_2_3 = var_2_1(var_2_0, var_2.GetServerTime(var_2_2), "*t")

		SeasonInfo = var_2_0

		local var_2_4 = 16 * var_2_0.RECOVER_UP_SIX_HOUR

		if var_2_3.hour == 0 then
			SeasonInfo = var_2
			var_2_4 = 16 * var_2.RECOVER_UP_TWELVE_HOUR
		end

		return var_2_4
	end

	getProxy = var_1_10003
	MilitaryExerciseProxy = var_1_10004

	local var_1_1 = var_1_10003(var_1_10004)
	local var_1_2 = var_3.getSeasonInfo(var_1_1)
	local var_1_3 = var_4.updateResetTime
	local var_1_4 = var_1_0()

	pg = var_1_10008

	local var_1_5 = var_1_10008.TimeMgr.GetInstance()

	var_1_3(var_1_2, var_1_4 + var_8.GetServerTime(var_1_5))

	local var_1_6 = var_4
	local var_1_7 = var_4.updateExerciseCount

	SeasonInfo = var_7

	var_1_7(var_1_6, var_7.RECOVER_UP_COUNT)
	var_3:updateSeasonInfo(var_4)

	var_3.waiting = false

	return
end

return var_0_1
