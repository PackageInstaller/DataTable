local UIShopToolFunctions = {
  GetRemainTime = function(time)
    local day, hour, minute, second
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    second = math.floor(time % 60)
    local timestring = ""
    if 0 < day then
      timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
    elseif 0 < hour then
      timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute") .. second .. StringTable.Get("str_activity_common_second")
    elseif 0 < minute then
      timestring = minute .. StringTable.Get("str_activity_common_minute") .. second .. StringTable.Get("str_activity_common_second")
    elseif 0 < second then
      timestring = second .. StringTable.Get("str_activity_common_second")
    end
    return timestring
  end,
  GetPrice = function(rawPrice)
    rawPrice = tonumber(rawPrice)
    local price = rawPrice / 10
    local i, f = math.modf(price)
    if f <= 0 then
      price = i
    end
    return price
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
_enum("UIShopToolFunctions", UIShopToolFunctions)
local UIShopRechargeSortType = {
  Gift = 1,
  MonthCard = 2,
  Recharge = 3
}
_enum("UIShopRechargeSortType", UIShopRechargeSortType)
