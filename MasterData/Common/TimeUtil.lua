local TimeUtil = {}

function TimeUtil:GetDayPassTime()
  if self.dayPassTime == nil then
    local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleDailyBouns, 0)
    self.dayPassTime = not counterElem and 5 or self:TimestampToDate(counterElem.nextExpiredTm).hour
  end
  return self.dayPassTime
end

function TimeUtil:GetLocalTimeZone()
  if self.localTimeZone == nil then
    local now = os.time()
    self.localTimeZone = os.difftime(now, os.time(os.date("!*t", now))) / 3600
  end
  return self.localTimeZone
end

function TimeUtil:CompareIsCorssDay(time1, time2)
  if math.abs(time1 - time2) >= CommonUtil.DaySeconds then
    return true
  end
  local timeBig, timeSmall
  if time2 < time1 then
    timeBig = time1
    timeSmall = time2
  else
    timeBig = time2
    timeSmall = time1
  end
  local hourTime = TimeUtil:GetDayPassTime() * 3600
  local dateBig = TimeUtil:TimestampToDate(timeBig - hourTime, false, false)
  local dateSmall = TimeUtil:TimestampToDate(timeSmall - hourTime, false, false)
  if dateBig.day ~= dateSmall.day then
    return true
  end
  return false
end

function TimeUtil:TimestampToTime(t, isMillisecond, isNotNeedS, isForceNeedH)
  if isMillisecond then
    t = t // 1000
  end
  local s = math.floor(t % 60)
  local m = math.floor(t / 60 % 60)
  local h = math.floor(t / 3600)
  return self:HMS2FormatedStr(h, m, s, isNotNeedS, isForceNeedH)
end

function TimeUtil:TimestampToTimeInter(t, isMillisecond, calculateDay)
  if isMillisecond then
    t = t // 1000
  end
  local s = math.floor(t % 60)
  local m = math.floor(t / 60 % 60)
  local h = math.floor(t / 3600)
  local d = 0
  if calculateDay then
    d = h // 24
    h = math.floor(h % 24)
  end
  return d, h, m, s
end

function TimeUtil:TimestampToDate(t, isMillisecond, isUsingLocalTimeZone)
  if t < 0 then
    error("timestamp error")
    return os.date("*t", 0)
  end
  if isMillisecond then
    t = t // 1000
  end
  local dataTable
  if isUsingLocalTimeZone then
    dataTable = os.date("*t", t)
  else
    dataTable = os.date("!*t", t + PlayerDataCenter.timezone_offset * 3600)
  end
  return dataTable
end

function TimeUtil:TimestampToDateString(t, isMillisecond, isUsingLocalTimeZone, formatString)
  if isMillisecond then
    t = t // 1000
  end
  formatString = formatString or "%m/%d %H:%M"
  local dateString
  if isUsingLocalTimeZone then
    dateString = os.date(formatString, t)
  else
    dateString = os.date(formatString, tonumber(t) + PlayerDataCenter.timezone_offset * 3600)
  end
  return dateString
end

function TimeUtil:DateToTimestamp(dataTable, isUsingLocalTimeZone)
  local ts = 0
  if isUsingLocalTimeZone then
    ts = os.time(dataTable)
  else
    ts = os.time(dataTable) - (PlayerDataCenter.timezone_offset - self:GetLocalTimeZone()) * 3600
  end
  return ts
end

function TimeUtil:TimpApplyLogicOffset(t)
  t = t - 3600 * self:GetDayPassTime()
  return t
end

function TimeUtil:TimeStringToTimeStamp(dateStr, isUsingLocalTimeZone)
  local _, _, y, m, d, _hour, _min, _sec = string.find(dateStr, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
  local timestamp
  if isUsingLocalTimeZone then
    timestamp = os.time({
      year = y,
      month = m,
      day = d,
      hour = _hour,
      min = _min,
      sec = _sec
    })
  else
    timestamp = os.time({
      year = y,
      month = m,
      day = d,
      hour = _hour,
      min = _min,
      sec = _sec,
      isdst = false
    }) - (PlayerDataCenter.timezone_offset - self:GetLocalTimeZone()) * 3600
  end
  return timestamp
end

function TimeUtil:HMS2FormatedStr(h, m, s, isNotNeedS, isForceNeedH)
  local content = ""
  if 0 < h or isForceNeedH then
    if isNotNeedS then
      content = string.format("%02d:%02d", h, m)
    else
      content = string.format("%02d:%02d:%02d", h, m, s)
    end
  elseif isNotNeedS then
    content = string.format("%02d:%02d", 0, m)
  else
    content = string.format("%02d:%02d", m, s)
  end
  return content
end

function TimeUtil.TimeStampMinusOffset(ts)
  return ts - PlayerDataCenter.timezone_offset_timestamp
end

function TimeUtil.GetLoginType(heroId, skinId)
  local loginType
  if skinId == 0 then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg ~= nil then
      skinId = heroCfg.default_skin
    end
  end
  local curHour = TimeUtil:TimestampToDate(os.time(), nil, true).hour
  local live2dConfig
  if skinId ~= 0 then
    live2dConfig = ConfigData.skin_live2d[skinId]
  else
    live2dConfig = ConfigData.skin_live2d[heroId]
    warn("has heroId l2d!!!")
  end
  if live2dConfig ~= nil and live2dConfig.login_time_range ~= nil and live2dConfig.login_time_range[curHour + 1] ~= nil and #live2dConfig.login_time_range == 24 then
    loginType = live2dConfig.login_time_range[curHour + 1]
    return loginType
  else
    local loginRange = {
      0,
      6,
      12,
      18
    }
    if curHour >= loginRange[1] and curHour < loginRange[2] then
      loginType = eVoiceType.MIDNIGHT
    elseif curHour >= loginRange[2] and curHour < loginRange[3] then
      loginType = eVoiceType.MORNING
    elseif curHour >= loginRange[3] and curHour < loginRange[4] then
      loginType = eVoiceType.AFTERNOON
    else
      loginType = eVoiceType.EVENING
    end
    return loginType
  end
end

return TimeUtil
