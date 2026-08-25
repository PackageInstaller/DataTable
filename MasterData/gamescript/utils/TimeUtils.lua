local TimeUtils = {}
local ServerTime = 0
local ResetClockTime = 0
local DelayTime = 0
local ServerTimeZone
local SECOND_PER_HOUR = 3600
local TZ
local CommonDefine = require("World.Enums.CommonDefine")
local TimeParseType = CommonDefine.TimeParseType
local A_HOUR_SECOND = 3600
TimeUtils.OneDaySeconds = 86400

function TimeUtils.SetServerTime(ts, delayTime, tz)
  local isFirstSetTime = 0 == ServerTime and 0 ~= ts
  ServerTime = ts
  DelayTime = delayTime
  TZ = tz
  ResetClockTime = TimeUtils.GetRealTime()
  if isFirstSetTime then
    EventMgr.Instance.FirstSetTime:Dispatch()
  end
end

function TimeUtils.SetServerTimeZone(serverTimeZone)
  Logger.Info("ServerTimeZone", serverTimeZone)
  ServerTimeZone = serverTimeZone or 0
end

function TimeUtils.ResetServerTime()
  TimeUtils.SetServerTime(0, 0, 0)
end

function TimeUtils.GetServerTimeZone()
  return ServerTimeZone or 0
end

function TimeUtils.GetClientTimeZone()
  local timestamp = os.time()
  local utc = os.date("!*t", timestamp)
  local clientZone = os.difftime(timestamp, os.time(utc)) / 3600
  local nowTimeTable = os.date("*t", timestamp)
  if nowTimeTable.isdst then
    clientZone = clientZone + 1
  end
  do return math.floor end
  return math.floor, clientZone
end

function TimeUtils.GetRealTime()
  do return end
  return CS.Framework.TimeUtil.GetRealtimeSinceStartup, nil
end

function TimeUtils.GetServerTime()
  local serverTime = ServerTime
  if 0 == serverTime then
    serverTime = os.time()
  end
  do return math.floor end
  return math.floor, serverTime + TimeUtils.GetRealTime() - ResetClockTime + DelayTime, DelayTime
end

function TimeUtils.GetRawServerTime()
  local serverTime = ServerTime
  if 0 == serverTime then
    return 0
  end
  do return math.floor end
  return math.floor, serverTime + TimeUtils.GetRealTime() - ResetClockTime + DelayTime, DelayTime
end

function TimeUtils.GetDeltaTime()
  if not ResetClockTime or 0 == ResetClockTime then
    ResetClockTime = TimeUtils.GetRealTime()
    return 0
  end
  local t = TimeUtils.GetRealTime()
  return t - ResetClockTime
end

function TimeUtils.GetServerDate(serverTime)
  local utcTime = serverTime + TimeUtils.GetServerTimeZone() * A_HOUR_SECOND
  local date = os.date("!*t", utcTime)
  return date
end

function TimeUtils.GetTimeFromServerDate(date)
  local clientZone = TimeUtils.GetClientTimeZone()
  local serverZone = TimeUtils.GetServerTimeZone()
  date.hour = math.floor(date.hour - serverZone + clientZone)
  local time = os.time(date)
  return time
end

function TimeUtils.GetNextClockTime(serverTime, hour, min)
  serverTime = serverTime or TimeUtils.GetServerTime()
  local utcDate = TimeUtils.GetServerDate(serverTime)
  local newDate = {
    year = utcDate.year,
    month = utcDate.month,
    day = utcDate.day,
    hour = hour,
    minute = min or 0,
    second = 0,
    min = min or 0,
    sec = 0,
    isdst = false
  }
  local newTime = TimeUtils.GetTimeFromServerDate(newDate)
  if serverTime > newTime then
    newTime = newTime + TimeUtils.OneDaySeconds
  end
  return newTime
end

function TimeUtils.ConvertTime(timestamp)
  local d = math.floor(timestamp / 3600 / 24)
  local h = math.floor(timestamp / 3600 % 24)
  local m = math.floor(timestamp % 3600 / 60)
  local s = math.floor(timestamp % 60)
  return d, h, m, s
end

function TimeUtils.ConvertTimeCeil(timestamp)
  local d = math.floor(timestamp / 3600 / 24)
  local h = math.ceil(timestamp / 3600 % 24)
  local m = math.ceil(timestamp % 3600 / 60)
  local s = math.ceil(timestamp % 60)
  return d, h, m, s
end

function TimeUtils.GetTimestampYmdHMS(timestamp)
  local y, m, d, h, M = tonumber(os.date("%Y", timestamp)), tonumber(os.date("%m", timestamp)), tonumber(os.date("%d", timestamp)), tonumber(os.date("%H", timestamp)), tonumber(os.date("%M", timestamp))
  return y, m, d, h, M
end

function TimeUtils.format(countDown, type)
  if type == TimeParseType.hms then
    local h, m, s = math.floor(countDown / 3600), math.floor(countDown % 3600 / 60), math.floor(countDown % 60)
    do return string.format, "%02d:%02d:%02d", h, m end
    return string.format, "%02d:%02d:%02d", h, m, s, nil, nil, nil
  elseif type == TimeParseType.ms then
    local m, s = math.floor(countDown / 60), math.floor(countDown % 60)
    do return string.format, "%02d:%02d", m end
    return string.format, "%02d:%02d", m, s, m, s, nil, nil, nil
  elseif type == TimeParseType.hm then
    local h, m = math.floor(countDown / 3600), math.floor(countDown % 3600 / 60)
    do return string.format, "%02d:%02d", h end
    return string.format, "%02d:%02d", h, m, m, s, nil, nil, nil
  elseif type == TimeParseType.dhms then
    local d, h, m, s = TimeUtils.ConvertTime(countDown)
    do return string.format, "%02d%s %02d:%02d:%02d", d, LT.Text("Day"), h, m end
    return string.format, "%02d%s %02d:%02d:%02d", d, LT.Text("Day"), h, m, s
  elseif type == TimeParseType.dhmsEx then
    local d, h, m, s = TimeUtils.ConvertTime(countDown)
    if d > 0 then
      do return string.format, "%02d%s %02d:%02d:%02d", d, LT.Text("Day"), h, m end
      return string.format, "%02d%s %02d:%02d:%02d", d, LT.Text("Day"), h, m, s
    else
      do return string.format, "%02d:%02d:%02d", h, m end
      return string.format, "%02d:%02d:%02d", h, m, s, m, s
    end
  end
end

function TimeUtils.format2(countDown)
  local d, h, m, s = TimeUtils.ConvertTime(countDown)
  if d > 0 then
    do return string.format, "%d%s%d%s%d%s", d, LT.Text("Day"), h, LT.Text("Hour"), m, LT.Text("Minute") end
    return string.format, "%d%s%d%s%d%s", d, LT.Text("Day"), h, LT.Text("Hour"), m, LT.Text("Minute")
  elseif h > 0 then
    do return string.format, "%d%s%d%s", h, LT.Text("Hour"), m, LT.Text("Minute") end
    return string.format, "%d%s%d%s", h, LT.Text("Hour"), m, LT.Text("Minute")
  elseif m > 0 then
    do return string.format, "%d%s%s%s", m, LT.Text("Minute"), s, LT.Text("Second") end
    return string.format, "%d%s%s%s", m, LT.Text("Minute"), s, LT.Text("Second")
  else
    do return string.format, "%s%s", s, LT.Text("Second") end
    return string.format, "%s%s", s, LT.Text("Second")
  end
end

function TimeUtils.format2Hour(countDown)
  local d, h, m, s = TimeUtils.ConvertTime(countDown)
  if d > 0 then
    do return string.format, "%d%s%d%s", d, LT.Text("Day"), h, LT.Text("Hour") end
    return string.format, "%d%s%d%s", d, LT.Text("Day"), h, LT.Text("Hour")
  elseif h > 0 then
    do return string.format, "%d%s%d%s", h, LT.Text("Hour"), m, LT.Text("Minute") end
    return string.format, "%d%s%d%s", h, LT.Text("Hour"), m, LT.Text("Minute")
  elseif m > 0 then
    do return string.format, "%d%s", m, LT.Text("Minute") end
    return string.format, "%d%s", m, LT.Text("Minute")
  else
    do return string.format, "%s%s", s, LT.Text("Second") end
    return string.format, "%s%s", s, LT.Text("Second")
  end
end

function TimeUtils.SecToHourMin(sec)
  local h, m = math.floor(sec / 3600), math.ceil(sec % 3600 / 60)
  if 60 == m then
    m = 0
    h = h + 1
  end
  return h, m
end

function TimeUtils.SecsToDays(sec)
  do return math.floor end
  return math.floor, sec / TimeUtils.OneDaySeconds
end

function TimeUtils.GetShortCountDownDisplayFormat(countDown)
  local days, hours = TimeUtils.ShopItemFormat(countDown)
  if days >= 1 then
    do return LT.Textf, "ShortDaysDisplay" end
    return LT.Textf, "ShortDaysDisplay", days
  else
    do return LT.Textf, "ShortHourDisplay" end
    return LT.Textf, "ShortHourDisplay", hours
  end
end

function TimeUtils.ActivityCountDownFormat(countDown)
  local d, h, m, _ = TimeUtils.ConvertTime(countDown)
  local LT = require("System.LangTable")
  if countDown > 0 and d <= 0 then
    do return LT.Textf, "ActivityTimeCountdown_2", h end
    return LT.Textf, "ActivityTimeCountdown_2", h, m
  end
  do return LT.Textf, "ActivityTimeCountdown", d end
  return LT.Textf, "ActivityTimeCountdown", d, h
end

function TimeUtils.ActivityExchangeCountDownFormat(countDown)
  local d, h, m, _ = TimeUtils.ConvertTime(countDown)
  local LT = require("System.LangTable")
  if countDown > 0 and d <= 0 then
    do return LT.Textf, "ActivityShopIsEnd_2", h end
    return LT.Textf, "ActivityShopIsEnd_2", h, m
  end
  do return LT.Textf, "ActivityShopIsEnd_1", d end
  return LT.Textf, "ActivityShopIsEnd_1", d, h
end

function TimeUtils.UnlockedCountDownFormat(countDown)
  local d, h, _, _ = TimeUtils.ConvertTime(countDown)
  if countDown > 0 and d <= 0 and h <= 0 then
    h = 1
  end
  local LT = require("System.LangTable")
  do return LT.Textf, "StageUnlockCountdownText", d end
  return LT.Textf, "StageUnlockCountdownText", d, h
end

TimeUtils.TimeExactType = {
  Second = 1,
  Minute = 2,
  Hour = 3,
  Day = 4,
  MinuteShort = 5,
  HourAndMinute = 6
}

function TimeUtils.TimestampToString(timestamp, exactType)
  local formatStr = "%Y.%m.%d %H:%M:%S"
  if exactType == TimeUtils.TimeExactType.Minute then
    formatStr = "%Y.%m.%d %H:%M"
  elseif exactType == TimeUtils.TimeExactType.Hour then
    formatStr = "%Y.%m.%d %H"
  elseif exactType == TimeUtils.TimeExactType.Day then
    formatStr = "%Y.%m.%d"
  elseif exactType == TimeUtils.TimeExactType.MinuteShort then
    formatStr = "%Y%m%d %H:%M"
  elseif exactType == TimeUtils.TimeExactType.HourAndMinute then
    formatStr = "%H:%M"
  end
  do return os.date, formatStr end
  return os.date, formatStr, timestamp
end

function TimeUtils.ServerTimestampToString(timestamp, exactType)
  local formatStr = "%Y.%m.%d %H:%M:%S"
  if exactType == TimeUtils.TimeExactType.Minute then
    formatStr = "%Y.%m.%d %H:%M"
  elseif exactType == TimeUtils.TimeExactType.Hour then
    formatStr = "%Y.%m.%d %H"
  elseif exactType == TimeUtils.TimeExactType.Day then
    formatStr = "%Y.%m.%d"
  elseif exactType == TimeUtils.TimeExactType.MinuteShort then
    formatStr = "%Y%m%d %H:%M"
  end
  formatStr = "!" .. formatStr
  do return os.date, formatStr end
  return os.date, formatStr, timestamp + (TZ or 0) * 3600
end

function TimeUtils.GetSocialTime(timeStamp)
  if not timeStamp then
    return nil
  end
  timeStamp = timeStamp or 0
  timeStamp = math.floor(timeStamp)
  local curTime = math.floor(TimeUtils.GetServerTime())
  local countDown = curTime - timeStamp
  if countDown < 0 then
    return nil
  end
  local curYear = string.tonumber(os.date("%Y.%m", curTime))
  local tarYear = string.tonumber(os.date("%Y.%m", timeStamp))
  local curMonth = string.tonumber(os.date("%m.%d", curTime))
  local tarMonth = string.tonumber(os.date("%m.%d", timeStamp))
  local year = curYear - tarYear
  local sameYear = math.floor(curYear) == math.floor(tarYear)
  local month = curMonth - tarMonth + (sameYear and 0 or math.ceil(year) * 12)
  local day = countDown / 3600 / 24
  local hour = countDown / 3600 % 24
  local minute = countDown % 3600 / 60
  return day, hour, minute, year, month
end

function TimeUtils.ParseCfgStrTime(str)
  do return string.gsub, str, "/" end
  return string.gsub, str, "/", "-"
end

function TimeUtils.ParseStrTime(str)
  if not str then
    return
  end
  local year, month, day, hour, min, sec
  if str:find(":") then
    year, month, day, hour, min, sec = str:match("([%d]+)-([%d]+)-([%d]+) ([%d]+):([%d]+):([%d]+)")
  else
    year, month, day = str:match("([%d]+)-([%d]+)-([%d]+)")
    hour = 0
    min = 0
    sec = 0
  end
  if not (year and month and day and hour and min) or not sec then
    return nil
  end
  local t = {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour),
    min = tonumber(min),
    sec = tonumber(sec),
    isdst = false
  }
  return t
end

function TimeUtils.UtcTime(t, tz)
  tz = tz or 0
  return os.time(t) - tz * SECOND_PER_HOUR
end

function TimeUtils.HourToSecond(hour)
  if not hour or type(hour) ~= "number" then
    return
  end
  return hour * SECOND_PER_HOUR
end

function TimeUtils.GetFutureTime(day, hour, timeStamp)
  local time = TimeUtils.GetServerTime()
  local now = timeStamp or math.floor(time)
  local future = now + day * TimeUtils.OneDaySeconds
  local date = os.date("*t", math.floor(future))
  do return os.time end
  return os.time, {
    year = date.year,
    month = date.month,
    day = date.day,
    hour = hour,
    minute = 0,
    second = 0,
    min = 0,
    sec = 0,
    isdst = false
  }, date.day
end

function TimeUtils.GetDaySeconds(day)
  if not day then
    return 0
  end
  return day * TimeUtils.OneDaySeconds
end

function TimeUtils.GetDayHourMin(seconds)
  local day = math.floor(seconds / 86400)
  local hour = math.floor(seconds % 86400 / 3600)
  local min = math.floor(seconds % 3600 / 60)
  return day, hour, min
end

function TimeUtils.GetWeekDay(time)
  local day = os.date("%w", time)
  do return tonumber end
  return tonumber, day
end

function TimeUtils.GetSecondToNextDayClock(hour, min)
  local curTS = TimeUtils.GetServerTime()
  local nextClockTs = TimeUtils.GetNextClockTime(curTS, hour, min)
  return nextClockTs - curTS
end

function TimeUtils.ShopItemFormat(countDown)
  local days = math.floor(countDown / 86400)
  local hours = math.floor(countDown % 86400 / 3600)
  local Minutes = math.floor(countDown % 86400 % 3600 / 60)
  if hours >= 24 then
    hours = 0
    days = days + 1
  end
  return days, hours, Minutes
end

function TimeUtils.format_date(fmt, timestamp)
  fmt = fmt or "*t"
  timestamp = timestamp or TimeUtils.GetServerTime()
  local cur_time = TimeUtils.GetFixedTimestamp(timestamp)
  do return os.date, fmt end
  return os.date, fmt, cur_time
end

function TimeUtils.GetFixedTimestamp(timestamp)
  return timestamp
end

function TimeUtils.WeekBossRefresh(countDown)
  do return TimeUtils.ShopItemFormat end
  return TimeUtils.ShopItemFormat, countDown
end

function TimeUtils.DailyChallengeRefresh(countDown)
  do return TimeUtils.ShopItemFormat end
  return TimeUtils.ShopItemFormat, countDown
end

function TimeUtils.PVPSeasonEnd(countDown)
  do return TimeUtils.ShopItemFormat end
  return TimeUtils.ShopItemFormat, countDown
end

function TimeUtils.PVPTaskEnd(countDown)
  do return TimeUtils.ShopItemFormat end
  return TimeUtils.ShopItemFormat, countDown
end

function TimeUtils.SecToDayHour(secs)
  do return TimeUtils.ShopItemFormat end
  return TimeUtils.ShopItemFormat, secs
end

return TimeUtils
