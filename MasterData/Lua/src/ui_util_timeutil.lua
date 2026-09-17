local util = {}
util.TimeFormat = {
  YMD_HMS = 1,
  YMD_HM = 2,
  YMD = 3,
  MD_HM = 4,
  MD = 5
}
util.DAY_WHOLE = 86400
util.DAY = 43200
util.HOUR = 3600
util.MINUTE = 60
local SecondInfo = {}

function util.getSecondInfo(second)
  table.clear(SecondInfo)
  local day = math.floor(second / util.DAY_WHOLE)
  second = second % util.DAY_WHOLE
  local hour = math.floor(second / util.HOUR)
  second = second % util.HOUR
  local minute = math.floor(second / util.MINUTE)
  local second = second % util.MINUTE
  SecondInfo.day = day
  SecondInfo.hour = hour
  SecondInfo.minute = minute
  SecondInfo.second = second
  return SecondInfo
end

function util.getDateInfo(time)
  local serverOffset = util.getServerTimeZone() * util.HOUR
  return os.date("!*t", time + serverOffset)
end

function util.getDateInfoLocal(time)
  local serverOffset = util.getServerTimeZone() * util.HOUR
  return os.date("!*t", time + serverOffset)
end

util.secondToStringShowType = {NORMAL = 1, TWO_UNIT = 2}

function util.secondToString(second, showType)
  showType = showType or util.secondToStringShowType.NORMAL
  local info = util.getSecondInfo(second)
  if showType == util.secondToStringShowType.NORMAL then
    if info.day > 0 then
      return string.format("%dd %02d:%02d:%02d", info.day, info.hour, info.minute, info.second)
    elseif 0 < info.hour then
      return string.format("%d:%02d:%02d", info.hour, info.minute, info.second)
    end
    return string.format("%02d:%02d", info.minute, info.second)
  elseif showType == util.secondToStringShowType.TWO_UNIT then
    if info.day > 0 then
      return L_WordsTpl:getValue("ui_common_time_01", {
        [0] = info.day,
        [1] = info.hour
      })
    elseif 0 < info.hour then
      return L_WordsTpl:getValue("ui_common_time_02", {
        [0] = info.hour,
        [1] = info.minute
      })
    elseif 0 < info.minute then
      return L_WordsTpl:getValue("ui_common_time_03", {
        [0] = info.minute,
        [1] = info.second
      })
    else
      return L_WordsTpl:getValue("ui_common_time_04", {
        [0] = info.second
      })
    end
  end
end

function util.getTimeLimit(second)
  local day = math.floor(second / 86400)
  return day
end

function util.getTimeLimitStr(second)
  local day = util.getTimeLimit(second)
  if day == 0 then
    return "<1"
  else
    return tostring(day)
  end
end

function util.getServerTime()
  return math.ceil(C_TimeUtility.NowServer)
end

function util.getServerTimeWithFloor()
  return math.floor(C_TimeUtility.NowServer)
end

function util.getServerTimeOfDate(timestamp)
  return math.ceil(C_TimeUtility.TimestampOfDate(timestamp))
end

function util.getServerTimeOfDateTime(timestamp)
  print("getServerTimeOfDateTime")
  print(timestamp)
  return C_TimeUtility.DateTimeOfDate(timestamp)
end

function util.getServerTimeOfToday()
  return math.ceil(C_TimeUtility.TimestampOfToday())
end

function util.parseConfigDatetime(cfgDt)
  return math.ceil(C_TimeUtility.TimeStringToTimestamp(cfgDt, "yyyyMMdd-HHmmss"))
end

function util.getServerTimeZone()
  return C_TimeUtility.TimeZoneId
end

function util.getDisplayTime(t, format)
  t = t or util.getServerTime()
  format = format or util.TimeFormat.YMD_HMS
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local adjustedTime = t + serverOffset
  if format == util.TimeFormat.YMD_HMS then
    return os.date("!%Y-%m-%d %H:%M:%S", math.ceil(adjustedTime))
  elseif format == util.TimeFormat.YMD_HM then
    return os.date("!%Y-%m-%d %H:%M", math.ceil(adjustedTime))
  elseif format == util.TimeFormat.YMD then
    return os.date("!%Y-%m-%d", math.ceil(adjustedTime))
  elseif format == util.TimeFormat.MD_HM then
    return os.date("!%m-%d %H:%M", math.ceil(adjustedTime))
  elseif format == util.TimeFormat.MD then
    return os.date("!%m-%d", math.ceil(adjustedTime))
  end
end

function util.getDisplayTimeCustom(t, format_str)
  t = t or util.getServerTime()
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local adjustedTime = t + serverOffset
  return os.date(format_str, math.ceil(adjustedTime))
end

function util.getDisplayTimeLocal(t, format)
  t = t or util.getServerTime()
  format = format or util.TimeFormat.YMD_HMS
  if format == util.TimeFormat.YMD_HMS then
    return os.date("%Y-%m-%d %H:%M:%S", math.ceil(t))
  elseif format == util.TimeFormat.YMD_HM then
    return os.date("%Y-%m-%d %H:%M", math.ceil(t))
  elseif format == util.TimeFormat.YMD then
    return os.date("%Y-%m-%d", math.ceil(t))
  elseif format == util.TimeFormat.MD_HM then
    return os.date("%m-%d %H:%M", math.ceil(t))
  elseif format == util.TimeFormat.MD then
    return os.date("%m-%d", math.ceil(t))
  end
end

function util.getLeftTimeDisplay(endTime)
  if endTime == nil or endTime == 0 then
    return
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  if 86400 <= leftTime then
    return L_WordsTpl:getValue("ui_timeUtil_03", {
      [0] = util.getDisplayTime(endTime, util.TimeFormat.YMD_HM)
    })
  elseif 3600 <= leftTime then
    local hrs = math.floor(leftTime / 3600)
    return nil, L_WordsTpl:getValue("ui_timeUtil_01", {
      [0] = hrs
    })
  elseif 60 <= leftTime then
    local mins = math.floor(leftTime / 60)
    return nil, L_WordsTpl:getValue("ui_timeUtil_02", {
      [0] = mins
    })
  else
    return nil, L_WordsTpl:getValue("residual_code_timeutil_01")
  end
end

function util.getLeftTimeString(endTime, hideSecond)
  if endTime == nil then
    return
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  local info = util.getSecondInfo(leftTime)
  if 86400 <= leftTime then
    if hideSecond then
      return L_WordsTpl:getValue("ui_timeUtil_04", {
        [0] = info.day,
        [1] = info.hour,
        [2] = info.minute
      })
    end
    return L_WordsTpl:getValue("ui_timeUtil_05", {
      [0] = info.day,
      [1] = info.hour
    })
  elseif 3600 <= leftTime then
    return L_WordsTpl:getValue("ui_timeUtil_06", {
      [0] = info.hour,
      [1] = info.minute
    })
  else
    if hideSecond then
      if 60 <= leftTime then
        return L_WordsTpl:getValue("ui_timeUtil_10", {
          [0] = info.minute
        })
      end
      return L_WordsTpl:getValue("ui_timeUtil_12")
    end
    return L_WordsTpl:getValue("ui_timeUtil_07", {
      [0] = info.minute,
      [1] = math.floor(info.second)
    })
  end
end

function util.getLeftTimeString2(endTime)
  if endTime == nil then
    return
  end
  local now = util.getServerTime()
  local leftTime = math.ceil(endTime - now)
  local info = util.getSecondInfo(leftTime)
  util.getLeftTimeString2StrList = util.getLeftTimeString2StrList or {
    [1] = "ui_timeUtil_08",
    [2] = "ui_timeUtil_09",
    [3] = "ui_timeUtil_10",
    [4] = "ui_timeUtil_11"
  }
  util.getLeftTimeString2TimeList = util.getLeftTimeString2TimeList or {}
  util.getLeftTimeString2StrIndexList = util.getLeftTimeString2StrIndexList or {}
  table.clear(util.getLeftTimeString2TimeList)
  table.clear(util.getLeftTimeString2StrIndexList)
  if info.day > 0 then
    table.insert(util.getLeftTimeString2TimeList, info.day)
    table.insert(util.getLeftTimeString2StrIndexList, 1)
  end
  if 0 < info.hour then
    table.insert(util.getLeftTimeString2TimeList, info.hour)
    table.insert(util.getLeftTimeString2StrIndexList, 2)
  end
  if 0 < info.minute then
    table.insert(util.getLeftTimeString2TimeList, info.minute)
    table.insert(util.getLeftTimeString2StrIndexList, 3)
  end
  if 0 < info.second then
    table.insert(util.getLeftTimeString2TimeList, info.second)
    table.insert(util.getLeftTimeString2StrIndexList, 4)
  end
  local paramsNum = #util.getLeftTimeString2TimeList
  if 2 <= paramsNum then
    return L_WordsTpl:getValue(util.getLeftTimeString2StrList[util.getLeftTimeString2StrIndexList[1]], {
      [0] = util.getLeftTimeString2TimeList[1]
    }) .. L_WordsTpl:getValue(util.getLeftTimeString2StrList[util.getLeftTimeString2StrIndexList[2]], {
      [0] = util.getLeftTimeString2TimeList[2]
    })
  elseif paramsNum == 1 then
    return L_WordsTpl:getValue(util.getLeftTimeString2StrList[util.getLeftTimeString2StrIndexList[1]], {
      [0] = util.getLeftTimeString2TimeList[1]
    })
  elseif paramsNum == 0 then
    return L_WordsTpl:getValue("ui_timeUtil_11", {
      [0] = "0"
    })
  end
end

function util.getLeftTimeFormatString(endTime)
  if endTime == nil then
    return
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  local info = util.getSecondInfo(leftTime)
  local res = string.empty
  if info.day > 0 then
    res = L_WordsTpl:getValue("ui_timeUtil_05", {
      [0] = info.day,
      [1] = info.hour
    })
  elseif info.day < 1 and 1 <= info.minute then
    res = L_WordsTpl:getValue("ui_timeUtil_06", {
      [0] = info.hour,
      [1] = info.minute
    })
  elseif 1 > info.minute then
    res = L_WordsTpl:getValue("ui_timeUtil_07", {
      [0] = info.minute,
      [1] = info.second
    })
  end
  return res
end

function util.tryGetLeftTimeFormatString(endTime, duration)
  if endTime == nil then
    return false, ""
  end
  if duration == nil or duration < 0 then
    duration = 1
  end
  local ret, info = util.isChangeTime(endTime, duration)
  local final_res = util.isChangeTimeString(ret, info)
  local final_str = string.empty
  if final_res then
    final_str = util.getLeftTimeFormatString(endTime)
  end
  return final_res, final_str
end

function util.tryGetLeftTimeFormatTable(endTime, duration)
  if endTime == nil then
    return false, ""
  end
  if duration == nil or duration < 0 then
    duration = 1
  end
  local ret, info = util.isChangeTime(endTime, duration)
  local final_res = util.isChangeTimeString(ret, info)
  local final_str = string.empty
  if final_res then
    final_str = util.getLeftTimeFormatString(endTime)
  end
  return {res = final_res, str = final_str}
end

function util.isChangeTime(endTime, duration)
  if endTime == nil then
    return 0, {}
  end
  if duration == nil or duration < 0 then
    duration = 1
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  local beforeLeftTime = leftTime - duration
  local beforeInfo = util.getSecondInfo(beforeLeftTime)
  local info = util.getSecondInfo(leftTime)
  local ret = 0
  if beforeInfo.day ~= info.day then
    ret = 1
  elseif beforeInfo.hour ~= info.hour then
    ret = 2
  elseif beforeInfo.minute ~= info.minute then
    ret = 3
  elseif beforeInfo.second ~= info.second then
    ret = 4
  end
  return ret, info
end

function util.isChangeTimeString(changeType, info)
  local ret = false
  if changeType == nil or changeType == 0 or info == nil then
    return ret
  end
  if 0 < info.day then
    if changeType == 1 or changeType == 2 then
      ret = true
    end
  elseif info.day < 1 and 1 <= info.minute then
    if changeType == 2 or changeType == 3 then
      ret = true
    end
  elseif 1 > info.minute and (changeType == 3 or changeType == 4) then
    ret = true
  end
  return ret
end

function util.getLeftTimeStringShort(endTime)
  if endTime == nil then
    return
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  local info = util.getSecondInfo(leftTime)
  if 86400 <= leftTime then
    return L_WordsTpl:getValue("ui_timeUtil_08", {
      [0] = info.day
    })
  elseif 3600 <= leftTime then
    return L_WordsTpl:getValue("ui_timeUtil_09", {
      [0] = info.hour
    })
  else
    return L_WordsTpl:getValue("ui_timeUtil_10", {
      [0] = info.minute
    })
  end
end

function util.getLeftTime(endTime)
  if endTime == nil then
    return
  end
  local now = util.getServerTime()
  local leftTime = endTime - now
  local info = util.getSecondInfo(leftTime)
  return string.format("%.2d:%.2d:%.2d", info.hour, info.minute, info.second)
end

local GetLangStringParams = {}

function util.secondToLangString(second)
  local info = util.getSecondInfo(second)
  table.clear(GetLangStringParams)
  if 86400 <= second then
    GetLangStringParams[0] = info.day
    GetLangStringParams[1] = info.hour
    return L_WordsTpl:getValue("ui_timeUtil_05", GetLangStringParams)
  elseif 3600 <= second then
    GetLangStringParams[0] = info.hour
    GetLangStringParams[1] = info.minute
    return L_WordsTpl:getValue("ui_timeUtil_06", GetLangStringParams)
  elseif 60 <= second then
    GetLangStringParams[0] = info.minute
    GetLangStringParams[1] = math.floor(info.second)
    return L_WordsTpl:getValue("ui_timeUtil_07", GetLangStringParams)
  else
    GetLangStringParams[0] = math.floor(info.second)
    return L_WordsTpl:getValue("ui_timeUtil_11", GetLangStringParams)
  end
end

function util.isSameDay(time1, time2)
  local time_clock = 0
  if L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int) then
    time_clock = tonumber(L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))
  end
  return C_TimeUtility.IsSameDay(time1 - time_clock * 3600, time2 - time_clock * 3600)
end

function util.isSameWeek(time1, time2)
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local time_clock = 0
  if L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int) then
    time_clock = tonumber(L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))
  end
  local dateA = os.date("!*t", time1 + serverOffset - 86400 - time_clock * 3600)
  local dateB = os.date("!*t", time2 + serverOffset - 86400 - time_clock * 3600)
  local diff = (time1 - time2) / 86400
  local wdayA = dateA.wday
  local wdayB = dateB.wday
  if diff < 0 and -7 < diff and wdayA <= wdayB or 0 <= diff and diff < 7 and wdayA >= wdayB then
    return true
  end
  return false
end

function util.isSameMonth(time1, time2)
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local time_clock = 0
  if L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int) then
    time_clock = tonumber(L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))
  end
  local dateA = os.date("!*t", time1 + serverOffset - time_clock * 3600)
  local dateB = os.date("!*t", time2 + serverOffset - time_clock * 3600)
  return dateA.month == dateB.month
end

function util.getLeftDayAndHour(endTime)
  local now = util.getServerTime()
  local leftTime = endTime - now
  if leftTime <= 0 then
    return nil, nil, leftTime
  end
  if 86400 <= leftTime then
    local day = math.floor(leftTime / 86400)
    return true, day, leftTime
  elseif 3600 <= leftTime then
    local hrs = math.floor(leftTime / 3600)
    return false, hrs, leftTime
  else
    return false, 1, leftTime
  end
end

function util.getOfflineTimeDisplay(onlineTime, offlineTime)
  if 0 <= onlineTime - offlineTime then
    return L_WordsTpl:getValue("ui_timeMessage_02")
  else
    local now = util.getServerTime()
    local offlineTimeDif = now - offlineTime
    local day = math.floor(offlineTimeDif / util.DAY_WHOLE)
    local remainingSec = offlineTimeDif % util.DAY_WHOLE
    local hour = math.floor(remainingSec / util.HOUR)
    local minute = math.floor(remainingSec % util.HOUR / util.MINUTE)
    if day < 1 then
      if hour < 1 then
        return L_GameUtil.fillColor(L_WordsTpl:getValue("ui_timeMessage_03", {
          [0] = minute
        }), "#30303080")
      else
        return L_GameUtil.fillColor(L_WordsTpl:getValue("ui_timeMessage_04", {
          [0] = hour
        }), "#30303080")
      end
    elseif 1 <= day then
      return L_GameUtil.fillColor(L_WordsTpl:getValue("ui_timeMessage_05", {
        [0] = day
      }), "#30303080")
    end
  end
end

function util.getChatDisplayTime(t)
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local nowTime = util.getServerTime()
  if C_TimeUtility.IsSameDay(t, nowTime) then
    return os.date("!%H:%M", math.ceil(t + serverOffset))
  else
    return os.date("!%Y-%m-%d %H:%M", math.ceil(t + serverOffset))
  end
end

function util.getDaysToSecond(day)
  if day < 0 then
    return 0
  end
  return util.DAY * day
end

function util.getHourToSecond(hour)
  if hour < 0 then
    return 0
  end
  return util.HOUR * hour
end

function util.getMinuteSecond(minute)
  if minute < 0 then
    return 0
  end
  return util.MINUTE * minute
end

function util.getDateTimeInfor(param)
  local second = param % 100
  local minute = param / 100 % 100
  local hour = param / 10000
  return hour, minute, second
end

function util.getNextDayTime(hour, curTime)
  if curTime == nil then
    curTime = util.getServerTime()
  end
  local dateTime = util.getDateInfo(curTime)
  if hour <= dateTime.hour then
    dateTime.day = dateTime.day + 1
  end
  dateTime.hour = hour
  dateTime.min = 0
  dateTime.sec = 0
  return os.time(dateTime) + util.getLocalTimeZoneDiffOffset()
end

function util.getNextDayRefreshTime()
  local dateTime = util.getDateInfo(util.getServerTime())
  local refreshHour = L_GameTpl:getGameConstTpl():getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int)
  if refreshHour <= dateTime.hour then
    dateTime.day = dateTime.day + 1
  end
  dateTime.hour = refreshHour
  dateTime.min = 0
  dateTime.sec = 0
  return os.time(dateTime) + util.getLocalTimeZoneDiffOffset()
end

function util.getNextDateTime(nextDayOfWeek, hour, minute, second)
  local timestamp = util.getServerTime()
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local currentDayOfWeek = tonumber(os.date("!%w", timestamp + serverOffset))
  local daysUntilNextDayOfWeek = (nextDayOfWeek - currentDayOfWeek + 7) % 7
  local nextDateTimestamp = timestamp + 86400 * daysUntilNextDayOfWeek
  local nextDateTime = util.getDateInfo(nextDateTimestamp)
  nextDateTime.hour = hour or 0
  nextDateTime.min = minute or 0
  nextDateTime.sec = second or 0
  if timestamp > os.time(nextDateTime) + util.getLocalTimeZoneDiffOffset() then
    nextDateTime.day = nextDateTime.day + 7
  end
  return nextDateTime
end

function util.getLeftWeekRefreshTime(hideSecond)
  local refreshWeekday = 1
  if L_GameTpl:getGameConstTpl():getData("WEEKLY_REFRESH_TIME", L_Const.GameTplType.int) then
    refreshWeekday = tonumber(L_GameTpl:getGameConstTpl():getData("WEEKLY_REFRESH_TIME", L_Const.GameTplType.int))
  end
  local timestamp = util.getServerTime()
  local dataTime = C_TimeUtility.TimestampToDateTime(timestamp)
  local remindDays = (refreshWeekday - CS.System.Convert.ToInt32(dataTime.DayOfWeek) + 7) % 7
  local nextDate = C_TimeUtility.TimestampOfNDaysGameDatetime(remindDays)
  if remindDays == 0 and timestamp >= nextDate then
    nextDate = C_TimeUtility.TimestampOfNDaysGameDatetime(7)
  end
  return util.getLeftTimeString(nextDate, hideSecond)
end

function util.getLeftDayRefreshTime()
  local now = util.getServerTime()
  local nextDate = C_TimeUtility.TimestampOfNDaysGameDatetime(0)
  if now >= nextDate then
    nextDate = C_TimeUtility.TimestampOfNDaysGameDatetime(1)
  end
  return util.getLeftTimeString(nextDate)
end

function util.getDateTimeStamp(timeDate)
  local date = string.split(timeDate, "-")
  local yearInfo = date[1]
  local dayInfo = date[2]
  local year = tostring(string.sub(yearInfo, 1, 4))
  local month = tostring(string.sub(yearInfo, 5, 6))
  local day = tostring(string.sub(yearInfo, 7, 8))
  local hour = tostring(string.sub(dayInfo, 1, 2))
  local min = tostring(string.sub(dayInfo, 3, 4))
  local sec = tostring(string.sub(dayInfo, 5, 6))
  local timeStamp = os.time({
    day = day,
    month = month,
    year = year,
    hour = hour,
    min = min,
    sec = sec
  })
  return timeStamp + util.getLocalTimeZoneDiffOffset()
end

function util.getCurWeekDay(timeStamp)
  timeStamp = timeStamp or util.getServerTime()
  local serverOffset = util.getServerTimeZone() * util.HOUR
  local weekdayNumber = os.date("!%w", math.ceil(timeStamp + serverOffset))
  return tonumber(weekdayNumber)
end

function util.getLocalTimeZoneDiffOffset()
  local now = os.time()
  local diff_time = os.difftime(now, os.time(os.date("!*t", now)))
  return diff_time - util.getServerTimeZone() * util.HOUR
end

return util
