local TimeCfgUtils = {}

function TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp(hour, startTs)
  hour = hour or 9
  local now = startTs or TimeUtils.GetServerTime()
  local date = os.date("*t", now)
  local localRefreshTime = TimeCfgUtils.ServerRefreshTime_2_Local(hour, startTs)
  local futureDay = localRefreshTime > date.hour and 0 or 1
  do return TimeUtils.GetFutureTime, futureDay, localRefreshTime end
  return TimeUtils.GetFutureTime, futureDay, localRefreshTime, startTs
end

function TimeCfgUtils.ServerRefreshTime_2_Local(hour, startTs)
  hour = hour or 9
  local serverRefreshTime = hour
  local timestamp = startTs or TimeUtils.GetServerTime()
  local utc = os.date("!*t", timestamp)
  local client_zone = os.difftime(timestamp, os.time(utc)) / 3600
  local now_time_table = os.date("*t", timestamp)
  if now_time_table.isdst then
    client_zone = client_zone + 1
  end
  local utrRefreshTime = serverRefreshTime - TimeUtils.GetServerTimeZone()
  local localRefreshTime = utrRefreshTime + client_zone
  if localRefreshTime < 0 then
    localRefreshTime = localRefreshTime + 24
  end
  do return math.floor end
  return math.floor, localRefreshTime
end

function TimeCfgUtils.GetNextMonday()
  local deltaTime = 0
  local currTime = TimeUtils.GetServerTime()
  local currDate = TimeUtils.GetServerDate(currTime)
  local Sunday = 1
  local Monday = 2
  local dayOfWeek = currDate.wday
  local currHour = currDate.hour
  local serverRefreshHour = DT.GetConstant("Server_Refresh_Time")
  local HourToSecond = 3600
  local curDayPassTime = currHour * HourToSecond + currDate.min * 60 + currDate.sec
  if dayOfWeek == Sunday then
    deltaTime = 24 * HourToSecond - curDayPassTime + serverRefreshHour * HourToSecond
  elseif dayOfWeek == Monday and currHour < serverRefreshHour then
    deltaTime = serverRefreshHour * HourToSecond - curDayPassTime
  else
    deltaTime = (9 - dayOfWeek) * 24 * HourToSecond - curDayPassTime + serverRefreshHour * HourToSecond
  end
  return deltaTime
end

function TimeCfgUtils.GetNextMonthFirstDay()
  local curServerTime = TimeUtils.GetServerTime()
  local curServerDate = TimeUtils.GetServerDate(curServerTime)
  local serverRefreshHour = DT.GetConstant("Server_Refresh_Time")
  local nextMonth = curServerDate.month + 1
  local nextYear = curServerDate.year
  if nextMonth > 12 then
    nextMonth = 1
    nextYear = nextYear + 1
  end
  local nextMonthFirstRefreshDate = {
    year = nextYear,
    month = nextMonth,
    day = 1,
    hour = serverRefreshHour,
    minute = 0,
    second = 0,
    min = 0,
    sec = 0,
    isdst = false
  }
  do return TimeUtils.GetTimeFromServerDate end
  return TimeUtils.GetTimeFromServerDate, nextMonthFirstRefreshDate
end

function TimeCfgUtils.GetNextDailyRefreshTimeStamp()
  do return end
  return TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp, nil
end

return TimeCfgUtils
