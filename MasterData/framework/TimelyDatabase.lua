-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/time/TimelyDatabase.lua

module("framework.time.TimelyDatabase", package.seeall)

local TimelyDatabase = {}

TimelyDatabase.Daily = 1
TimelyDatabase.Weekly = 2
TimelyDatabase.Long = 3
TimelyDatabase.DailyRefresh = 4

function TimelyDatabase.init()
	TimelyDatabase._allData = {}
	TimelyDatabase._allData[TimelyDatabase.Daily] = {}
	TimelyDatabase._allData[TimelyDatabase.Weekly] = {}
	TimelyDatabase._allData[TimelyDatabase.Long] = {}
	TimelyDatabase._allData[TimelyDatabase.DailyRefresh] = {}

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, TimelyDatabase._checkRefreshTime)
	ClockMgr.instance:addListener(ClockMgr.TickDay, TimelyDatabase._checkDay)
	ClockMgr.instance:addListener(ClockMgr.TickWeek, TimelyDatabase._checkWeek)
end

function TimelyDatabase.store(key, value, life)
	local dict = TimelyDatabase._allData[life]

	dict[key] = value
end

function TimelyDatabase.fetch(key, life)
	local dict = TimelyDatabase._allData[life]

	return dict[key]
end

function TimelyDatabase._checkRefreshTime()
	TimelyDatabase._allData[TimelyDatabase.DailyRefresh] = {}
end

function TimelyDatabase._checkDay()
	TimelyDatabase._allData[TimelyDatabase.Daily] = {}
end

function TimelyDatabase._checkWeek()
	TimelyDatabase._allData[TimelyDatabase.Weekly] = {}
end

function TimelyDatabase.clear()
	TimelyDatabase._allData[TimelyDatabase.DailyRefresh] = {}
	TimelyDatabase._allData[TimelyDatabase.Daily] = {}
	TimelyDatabase._allData[TimelyDatabase.Weekly] = {}
	TimelyDatabase._allData[TimelyDatabase.Long] = {}
end

return TimelyDatabase
