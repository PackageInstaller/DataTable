_G._NOW0 = os.time
local CS_TIME_DELTA = 0
local newGetCurLanguage = Localization.GetCurLanguage

function Localization.GetCurLanguage()
  return newGetCurLanguage(true)
end

LanguageType = {
  zh = "zh",
  tw = "tw",
  us = "us",
  kr = "kr",
  jp = "jp",
  pt = "pt",
  es = "es",
  idn = "idn",
  th = "th"
}
local language = Localization.GetCurLanguage()
local toint = math.tointeger

function _G._now(unit)
  local t0 = _NOW0(unit)
  local t1 = t0 + CS_TIME_DELTA
  return t1
end

function _G._time(t)
  return os.date("*t", t)
end

function _G._utcTime(t)
  return os.date("!*t", t)
end

function _G._utc2Local(data)
  local now = os.time(data)
  local diff = os.difftime(_NOW0(), _NOW0(_utcTime(_NOW0())))
  local t = diff / 3600
  now = now + diff
  return os.date("%Y-%m-%d %H:%M:%S", now)
end

function _G._curTimeZone()
  return os.difftime(_NOW0(), _NOW0(_utcTime(_NOW0()))) / 3600
end

function _G.AdjustTimeCS(servertime)
  CS_TIME_DELTA = servertime - _NOW0()
end

function _G.SameDay(t1, t2)
  local d1 = _time(t1)
  local d2 = _time(t2)
  return d1.year == d2.year and d1.month == d2.month and d1.day == d2.day
end

function _G.SameWeek(t1, t2)
  local d1 = _time(t1)
  local d2 = _time(t2)
  local w1 = d1.wday
  local w2 = d2.wday
  if w1 == 0 then
    w1 = 7
  end
  if w2 == 0 then
    w2 = 7
  end
  d1 = _time(t1 - w1 * 86400)
  d2 = _time(t2 - w2 * 86400)
  return d1.year == d2.year and d1.month == d2.month and d1.day == d2.day
end

function _G.SameMonth(t1, t2)
  local d1 = _time(t1)
  local d2 = _time(t2)
  return d1.year == d2.year and d1.month == d2.month
end

function _G.Day0time(t)
  local l_GMT_zero_time = math.floor(t / 86400) * 86400
  local l_time_zone_diff = _curTimeZone() * 3600
  local l_zone_zero_time = l_GMT_zero_time - l_time_zone_diff
  if 86400 <= t - l_zone_zero_time then
    l_zone_zero_time = l_zone_zero_time + 86400
  end
  return l_zone_zero_time
end

function _G.TodayPastTimeSec(t)
  local t1 = t or _NOW0()
  local l_today_sec = t1 - Day0time(t1)
  return l_today_sec
end

function _G.Day24time(t)
  return math.ceil((t or _NOW0()) / 86400) * 86400
end

function _G.GetDayKeyNum(t)
  local now = t or _now()
  local d = _time(now)
  local dk = d.year * 10000 + d.month * 100 + d.day
  return dk
end

function _G.DaysBetweenTwoDate(t1, t2)
  local oldtime = _time(t1)
  local newtime = _time(t2)
  if oldtime.year == newtime.year then
    return newtime.yday - oldtime.yday
  elseif oldtime.year > newtime.year then
    return -DaysBetweenTwoDate(t2, t1)
  else
    local day = 0
    for i = oldtime.year, newtime.year do
      local isLeap = i % 4 == 0 and i % 100 ~= 0 and i % 400 == 0
      if i == oldtime.year then
        day = day + (isLeap and 365 or 366) - oldtime.yday
      elseif i ~= newtime.year then
        day = day + (isLeap and 365 or 366)
      else
        day = day + newtime.yday
      end
    end
    return day
  end
end

function _G.InDayTime(range, now)
  local t0 = Day0time(now) / 60000
  local s = t0 + range[1] * 600 + range[2]
  local e = t0 + range[3] * 600 + range[4]
  return t0 >= s and t0 <= e
end

function _G.DaysInclude(t1, t2, hour)
  return SameDay(t1 - hour * 60 * 60 * 1000, t2 - hour * 60 * 60 * 1000)
end

if language ~= LanguageType.us then
  function _G.TimeToDate(t, s)
    local d = _time(t)
    
    if not s or s == "sec" then
      return string.format("%04d-%02d-%02d %02d:%02d:%02d", d.year, d.month, d.day, d.hour, d.min, d.sec)
    elseif s == "day" then
      return string.format("%04d-%02d-%02d", d.year, d.month, d.day)
    elseif s == "hour" then
      return string.format("%04d-%02d-%02d %02d", d.year, d.month, d.day, d.hour)
    elseif s == "min" then
      return string.format("%04d-%02d-%02d %02d:%02d", d.year, d.month, d.day, d.hour, d.min)
    end
  end
  
  function _G.TimeToDateNoY(s)
    local d = _time(s)
    return string.format("%02d-%02d %02d:%02d", d.month, d.day, d.hour, d.min)
  end
else
  function _G.TimeToDate(t, s)
    local d = _time(t)
    
    if not s or s == "sec" then
      return string.format("%04d/%02d/%02d %02d:%02d:%02d", d.year, d.month, d.day, d.hour, d.min, d.sec)
    elseif s == "day" then
      return string.format("%04d/%02d/%02d", d.year, d.month, d.day)
    elseif s == "hour" then
      return string.format("%04d/%02d/%02d %02d", d.year, d.month, d.day, d.hour)
    elseif s == "min" then
      return string.format("%04d/%02d/%02d %02d:%02d", d.year, d.month, d.day, d.hour, d.min)
    end
  end
  
  function _G.TimeToDateNoY(s)
    local d = _time(s)
    return string.format("%02d/%02d %02d:%02d", d.month, d.day, d.hour, d.min)
  end
end

function _G.ToDay(sec)
  local day = sec / 86400 - sec / 86400 % 1
  local hour = sec / 86400 % 1 * 60 * 24 * 1
  return string.format(StringTable.Get("str_common_days"), day) .. ToHour(hour)
end

function _G.ToHour(seconds)
  local hour = seconds / 3600 - seconds / 3600 % 1
  local min = seconds / 3600 % 1 * 60 * 60 * 1
  return hour .. ":" .. ToMinutes(min)
end

function _G.ToMinutes(seconds)
  local minutes = seconds / 60 - seconds / 60 % 1
  seconds = seconds / 60 % 1 * 60 - seconds / 60 % 1 * 60 % 1
  if seconds <= 9 then
    seconds = "0" .. seconds
  end
  if minutes <= 9 then
    minutes = "0" .. minutes
  end
  return minutes .. ":" .. seconds
end

function _G.ToTiming(seconds)
  if 86400 < seconds then
    return ToDay(seconds)
  elseif 3600 < seconds then
    return ToHour(seconds)
  elseif 60 < seconds then
    return ToMinutes(seconds)
  else
    return "" .. seconds
  end
end

if language ~= LanguageType.us then
  function _G.ToTimingFormat2(seconds)
    if 3600 < seconds then
      local format
      
      local hour = seconds / 3600 - seconds / 3600 % 1
      local min = seconds / 3600 % 1 * 60 * 60
      local minutes = min / 60 - min / 60 % 1
      seconds = min / 60 % 1 * 60 - min / 60 % 1 * 60 % 1
      format = StringTable.Get("str_common_hhmmss", toint(hour), toint(minutes), toint(seconds))
      return format
    elseif 60 < seconds then
      local format
      local minutes = seconds / 60 - seconds / 60 % 1
      seconds = seconds / 60 % 1 * 60 - seconds / 60 % 1 * 60 % 1
      format = StringTable.Get("str_common_mmss", toint(minutes), toint(seconds))
      return format
    else
      local format = StringTable.Get("str_common_ss", seconds)
      return format
    end
  end
else
  function _G.ToTimingFormat2(seconds)
    if 3600 < seconds then
      local format
      
      local hour = seconds / 3600 - seconds / 3600 % 1
      local min = seconds / 3600 % 1 * 60 * 60
      local minutes = min / 60 - min / 60 % 1
      seconds = min / 60 % 1 * 60 - min / 60 % 1 * 60 % 1
      format = toint(hour) .. ":" .. toint(minutes) .. ":" .. toint(seconds)
      return format
    elseif 60 < seconds then
      local format
      local minutes = seconds / 60 - seconds / 60 % 1
      seconds = seconds / 60 % 1 * 60 - seconds / 60 % 1 * 60 % 1
      format = toint(minutes) .. ":" .. toint(seconds)
      return format
    else
      local format = seconds
      return format
    end
  end
end

function _G.ToTimingFormat(seconds)
  if 3600 < seconds then
    local format
    local hour = seconds / 3600 - seconds / 3600 % 1
    local min = seconds / 3600 % 1 * 60 * 60
    if math.floor(hour / 10) == 0 then
      format = "0" .. hour .. ":"
    else
      format = hour .. ":"
    end
    local minutes = min / 60 - min / 60 % 1
    seconds = min / 60 % 1 * 60 - min / 60 % 1 * 60 % 1
    if math.floor(minutes / 10) == 0 then
      format = format .. "0" .. minutes .. ":"
    else
      format = format .. minutes .. ":"
    end
    if math.floor(seconds / 10) == 0 then
      format = format .. "0" .. seconds
    else
      format = format .. seconds
    end
    return format
  elseif 60 < seconds then
    local format
    local minutes = seconds / 60 - seconds / 60 % 1
    seconds = seconds / 60 % 1 * 60 - seconds / 60 % 1 * 60 % 1
    if math.floor(minutes / 10) == 0 then
      format = "0" .. minutes .. ":"
    else
      format = minutes .. ":"
    end
    if math.floor(seconds / 10) == 0 then
      format = format .. "0" .. seconds
    else
      format = format .. seconds
    end
    return format
  else
    local format
    if math.floor(seconds / 10) == 0 then
      format = "0" .. seconds
    else
      format = seconds
    end
    return "00:" .. format
  end
end

function _G.ToTimingFormat3(seconds)
  if 3600 < seconds then
    local format
    local hour = seconds / 3600 - seconds / 3600 % 1
    local min = seconds / 3600 % 1 * 60 * 60
    if math.floor(hour / 10) == 0 then
      format = "0" .. hour .. ":"
    else
      format = hour .. ":"
    end
    local minutes = min / 60 - min / 60 % 1
    seconds = min / 60 % 1 * 60 - min / 60 % 1 * 60 % 1
    if math.floor(minutes / 10) == 0 then
      format = format .. "0" .. minutes .. ":"
    else
      format = format .. minutes .. ":"
    end
    if math.floor(seconds / 10) == 0 then
      format = format .. "0" .. seconds
    else
      format = format .. seconds
    end
    return format
  elseif 60 < seconds then
    local format
    local minutes = seconds / 60 - seconds / 60 % 1
    seconds = seconds / 60 % 1 * 60 - seconds / 60 % 1 * 60 % 1
    if math.floor(minutes / 10) == 0 then
      format = "00:0" .. minutes .. ":"
    else
      format = "00:" .. minutes .. ":"
    end
    if math.floor(seconds / 10) == 0 then
      format = format .. "0" .. seconds
    else
      format = format .. seconds
    end
    return format
  else
    local format
    if math.floor(seconds / 10) == 0 then
      format = "0" .. seconds
    else
      format = seconds
    end
    return "00:00:" .. format
  end
end

function _G.ToTimingFormat4(miliSeconds)
  local tenMiliSeconds = math.floor(miliSeconds % 1000 / 10)
  local seconds = math.floor(miliSeconds / 1000)
  local minutes = math.floor(seconds / 60)
  local hours = math.floor(minutes / 60)
  return string.format("%02d:%02d:%02d:%02d", hours % 100, minutes % 60, seconds % 60, tenMiliSeconds)
end

function _G.TimeToDate2(t, s)
  local d = _time(t)
  if not s or s == "sec" then
    return string.format("%04d-%02d-%02d %02d-%02d-%06.3f", d.year, d.month, d.day, d.hour, d.min, d.sec)
  elseif s == "day" then
    return string.format("%04d-%02d-%02d", d.year, d.month, d.day)
  elseif s == "hour" then
    return string.format("%04d-%02d-%02d %02d", d.year, d.month, d.day, d.hour)
  elseif s == "min" then
    return string.format("%04d-%02d-%02d %02d-%02d", d.year, d.month, d.day, d.hour, d.min)
  end
end

function _G.TimeToDate3(t, s)
  local d = _time(t)
  if not s or s == "sec" then
    return string.format("%04d/%02d/%02d %02d/%02d/%06.3f", d.year, d.month, d.day, d.hour, d.min, d.sec)
  elseif s == "day" then
    return string.format("%04d/%02d/%02d", d.year, d.month, d.day)
  elseif s == "hour" then
    return string.format("%04d/%02d/%02d %02d", d.year, d.month, d.day, d.hour)
  elseif s == "min" then
    return string.format("%04d/%02d/%02d %02d:%02d", d.year, d.month, d.day, d.hour, d.min)
  end
end

function _G.TimeToDate4(t, s)
  local d = _time(t)
  if not s or s == "sec" then
    return string.format("%04d.%02d.%02d %02d.%02d.%06.3f", d.year, d.month, d.day, d.hour, d.min, d.sec)
  elseif s == "day" then
    return string.format("%04d.%02d.%02d", d.year, d.month, d.day)
  elseif s == "hour" then
    return string.format("%04d.%02d.%02d %02d", d.year, d.month, d.day, d.hour)
  elseif s == "min" then
    return string.format("%04d.%02d.%02d %02d:%02d", d.year, d.month, d.day, d.hour, d.min)
  end
end
