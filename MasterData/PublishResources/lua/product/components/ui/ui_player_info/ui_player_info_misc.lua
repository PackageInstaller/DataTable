local UIPlayerInfoToolFunctions = {
  GetRemainTime = function(time)
    local day, hour, minute
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    local timestring = ""
    if 0 < day then
      timestring = day .. StringTable.Get("str_player_info_limited_time_day")
      if 0 < hour then
        timestring = timestring .. hour .. StringTable.Get("str_player_info_limited_time_hour")
      end
      return timestring
    end
    if 0 < hour then
      timestring = hour .. StringTable.Get("str_player_info_limited_time_hour")
      if 0 < minute then
        timestring = timestring .. minute .. StringTable.Get("str_player_info_limited_time_minute")
      end
      return timestring
    end
    if 0 < minute then
      timestring = minute .. StringTable.Get("str_player_info_limited_time_minute")
    else
      timestring = StringTable.Get("str_player_info_limited_time_lessminute")
    end
    return timestring
  end
}
_enum("UIPlayerInfoToolFunctions", UIPlayerInfoToolFunctions)
local HeadTagType = {
  None = -1,
  All = 0,
  Q = 1,
  Pet = 2,
  Factio = 3
}
_enum("HeadTagType", HeadTagType)
