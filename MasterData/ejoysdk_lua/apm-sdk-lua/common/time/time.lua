local secondsPerMinute = 60
local secondsPerHour = 3600
local secondsPerDay = 24 * secondsPerHour
local secondsPerWeek = 7 * secondsPerDay
local daysPer400Years = 146097
local daysPer100Years = 36524
local daysPer4Years = 1461
local unixBase = (718685 + math.floor(492.25) - math.floor(19.69) + math.floor(4.9225)) * secondsPerDay
local daysBefore = {
  0,
  31,
  59,
  90,
  120,
  151,
  181,
  212,
  243,
  273,
  304,
  334,
  365
}
local February = 2
local March = 3

local function absTimestamp(ts)
  return ts + unixBase
end

local function isLeap(year)
  return 0 == year % 4 and (0 ~= year % 100 or 0 == year % 400)
end

local function absWeekday(abs)
  local sec = (abs + 1 * secondsPerDay) % secondsPerWeek
  return math.floor(sec / secondsPerDay) + 1
end

local function absDate(abs)
  local day = math.floor(abs / secondsPerDay)
  local n, y
  n = math.floor(day / daysPer400Years)
  y = 400 * n
  day = day - daysPer400Years * n
  n = math.floor(day / daysPer100Years)
  n = n - math.floor(n / 4)
  y = y + 100 * n
  day = day - daysPer100Years * n
  n = math.floor(day / daysPer4Years)
  y = y + 4 * n
  day = day - daysPer4Years * n
  n = math.floor(day / 365)
  n = n - math.floor(n / 4)
  y = y + n
  day = day - 365 * n
  local year = y + 1
  local yday = day + 1
  if isLeap(year) then
    if day > 59 then
      day = day - 1
    elseif 59 == day then
      return year, February, 29, yday
    end
  end
  local month = math.floor(day / 31) + 1
  local monthDayEnd = daysBefore[month + 1]
  local monthDayBegin
  if day >= monthDayEnd then
    month = month + 1
    monthDayBegin = monthDayEnd
  else
    monthDayBegin = daysBefore[month]
  end
  day = day - monthDayBegin + 1
  return year, month, day, yday
end

local function absDayFromDate(t)
  local y = assert(t.year, "year") - 1
  local day = y * 365 + math.floor(y / 4) - math.floor(y / 100) + math.floor(y / 400)
  if t.yday then
    day = day + t.yday - 1
  else
    local m = assert(t.month, "month")
    local d = assert(t.day, "day")
    day = day + daysBefore[m]
    if isLeap(t.year) and m >= March then
      day = day + 1
    end
    day = day + d - 1
  end
  return day
end

local M = {}
M.TZ = 8

function M.time(t)
  local day = absDayFromDate(t)
  local timestamp = day * secondsPerDay
  if t.hour then
    timestamp = timestamp + t.hour * secondsPerHour + t.min * secondsPerMinute + t.sec
  end
  return timestamp - unixBase
end

function M.utctime(t, tz)
  tz = tz or M.TZ
  return M.time(t) - tz * secondsPerHour
end

function M.date(sec, t)
  assert(sec)
  local abs = absTimestamp(sec)
  t = t or {}
  t.year, t.month, t.day, t.yday = absDate(abs)
  t.wday = absWeekday(abs)
  local seconds = abs % secondsPerDay
  t.hour = math.floor(seconds / secondsPerHour)
  seconds = seconds - t.hour * secondsPerHour
  t.min = math.floor(seconds / secondsPerMinute)
  t.sec = seconds - t.min * secondsPerMinute
  return t
end

function M.localdate(sec, tz, t)
  tz = tz or M.TZ
  do return M.date, sec + tz * secondsPerHour end
  return M.date, sec + tz * secondsPerHour, t
end

local tmp = {}

function M.format(sec, utc)
  if utc then
    M.date(sec, tmp)
  else
    M.localdate(sec, nil, tmp)
  end
  do return string.format, "%4d-%02d-%02d %02d:%02d:%02d", tmp.year, tmp.month, tmp.day, tmp.hour, tmp.min end
  return string.format, "%4d-%02d-%02d %02d:%02d:%02d", tmp.year, tmp.month, tmp.day, tmp.hour, tmp.min, tmp.sec
end

function M.parse(str)
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
    sec = tonumber(sec)
  }
  return t
end

return M
