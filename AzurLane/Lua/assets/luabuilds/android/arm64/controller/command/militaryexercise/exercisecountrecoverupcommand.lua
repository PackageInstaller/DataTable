local var_0_0 = class("ExerciseCountRecoverUpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(MilitaryExerciseProxy)
	local var_1_1 = var_1_0:getSeasonInfo()

	var_1_1:updateResetTime((function()
		local var_2_0 = 16 * SeasonInfo.RECOVER_UP_SIX_HOUR

		if pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").hour == 0 then
			var_2_0 = 16 * SeasonInfo.RECOVER_UP_TWELVE_HOUR
		end

		return var_2_0
	end)() + pg.TimeMgr.GetInstance():GetServerTime())
	var_1_1:updateExerciseCount(SeasonInfo.RECOVER_UP_COUNT)
	var_1_0:updateSeasonInfo(var_1_1)

	var_1_0.waiting = false

	return
end

return var_0_0
