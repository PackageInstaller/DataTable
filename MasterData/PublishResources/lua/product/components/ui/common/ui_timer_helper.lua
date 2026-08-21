_class("UITimerHelper", Singleton)
UITimerHelper = UITimerHelper

function UITimerHelper:Constructor()
end

function UITimerHelper.GetTimeFormatByString(timeStr)
  if timeStr == nil then
    Log.exception("UISideEnterItem_FixedTime.CheckOpen() time = nil", debug.traceback())
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local formatTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  return formatTime
end

function UITimerHelper.GetCurTime()
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return curTime
end

function UITimerHelper.CheckTimeUnLock(cfgTime, compareTime)
  compareTime = compareTime or UITimerHelper.GetCurTime()
  return cfgTime < compareTime
end

function UITimerHelper.GetTimeString(seconds, dayStr, hourStr, minusStr, lessOneMinusStr)
  if seconds < 0 then
    seconds = 0
  end
  dayStr = dayStr or "str_activity_day"
  hourStr = hourStr or "str_activity_hour"
  minusStr = minusStr or "str_activity_minus"
  lessOneMinusStr = lessOneMinusStr or "str_activity_less_one_minus"
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get(dayStr, day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get(hourStr, hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get(hourStr, hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get(minusStr, minus)
    end
  else
    timeStr = StringTable.Get(lessOneMinusStr)
  end
  return timeStr
end
