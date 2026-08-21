local UIN31SecondAnniversaryToolFunctions = {
  GetRemainTime = function(time)
    local day, hour, minute
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    local timestring = ""
    if 0 < day then
      timestring = day .. StringTable.Get("str_activity_common_day")
      if 0 < hour then
        timestring = timestring .. hour .. StringTable.Get("str_activity_common_hour")
      end
    elseif 0 < hour then
      timestring = hour .. StringTable.Get("str_activity_common_hour")
      if 0 < minute then
        timestring = timestring .. minute .. StringTable.Get("str_activity_common_minute")
      end
    elseif 0 < minute then
      timestring = minute .. StringTable.Get("str_activity_common_minute")
    else
      timestring = StringTable.Get("str_activity_common_less_minute")
    end
    return timestring
  end,
  GetSignRemainTime = function(time)
    local hour, minute
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    hour = hour < 0 and 0 or hour
    minute = minute < 0 and 0 or minute
    if hour < 10 then
      hour = "0" .. hour
    end
    if minute < 10 then
      minute = "0" .. minute
    end
    return hour .. ":" .. minute
  end,
  GetLocalDBInt = function(key, defaultValue)
    local loginModule = GameGlobal.GetModule(LoginModule)
    return LocalDB.GetInt(key .. loginModule:GetRoleShowID(), defaultValue)
  end,
  SetLocalDBInt = function(key, value)
    local loginModule = GameGlobal.GetModule(LoginModule)
    return LocalDB.SetInt(key .. loginModule:GetRoleShowID(), value)
  end
}
_enum("UIN31SecondAnniversaryToolFunctions", UIN31SecondAnniversaryToolFunctions)
