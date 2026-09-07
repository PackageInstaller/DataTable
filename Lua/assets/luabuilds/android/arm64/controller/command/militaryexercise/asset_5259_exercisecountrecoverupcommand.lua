local ExerciseCountRecoverUpCommand = class("ExerciseCountRecoverUpCommand", pm.SimpleCommand)

function ExerciseCountRecoverUpCommand:execute(arg_1_1)
	local var_1_0 = getProxy(MilitaryExerciseProxy)
	local var_1_1 = var_1_0:getSeasonInfo()

	var_1_1:updateResetTime((function()
		return (pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").hour == 0 or nil) and 16 * SeasonInfo.RECOVER_UP_TWELVE_HOUR
	end)() + pg.TimeMgr.GetInstance():GetServerTime())
	var_1_1:updateExerciseCount(SeasonInfo.RECOVER_UP_COUNT)
	var_1_0:updateSeasonInfo(var_1_1)

	var_1_0.waiting = false

	return
end

return ExerciseCountRecoverUpCommand
