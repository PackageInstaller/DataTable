module("framework.time.TimelyDatabase", package.seeall)

local var_0_0 = {}

var_0_0.Daily = 1
var_0_0.Weekly = 2
var_0_0.Long = 3
var_0_0.DailyRefresh = 4

function var_0_0.init()
	var_0_0._allData = {}
	var_0_0._allData[var_0_0.Daily] = {}
	var_0_0._allData[var_0_0.Weekly] = {}
	var_0_0._allData[var_0_0.Long] = {}
	var_0_0._allData[var_0_0.DailyRefresh] = {}

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, var_0_0._checkRefreshTime)
	ClockMgr.instance:addListener(ClockMgr.TickDay, var_0_0._checkDay)
	ClockMgr.instance:addListener(ClockMgr.TickWeek, var_0_0._checkWeek)
end

function var_0_0.store(arg_2_0, arg_2_1, arg_2_2)
	var_0_0._allData[arg_2_2][arg_2_0] = arg_2_1
end

function var_0_0.fetch(arg_3_0, arg_3_1)
	return var_0_0._allData[arg_3_1][arg_3_0]
end

function var_0_0._checkRefreshTime()
	var_0_0._allData[var_0_0.DailyRefresh] = {}
end

function var_0_0._checkDay()
	var_0_0._allData[var_0_0.Daily] = {}
end

function var_0_0._checkWeek()
	var_0_0._allData[var_0_0.Weekly] = {}
end

function var_0_0.clear()
	var_0_0._allData[var_0_0.DailyRefresh] = {}
	var_0_0._allData[var_0_0.Daily] = {}
	var_0_0._allData[var_0_0.Weekly] = {}
	var_0_0._allData[var_0_0.Long] = {}
end

return var_0_0
