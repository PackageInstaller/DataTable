local NotifyOfflineEnum = require("Game.NotifyOffline.NotifyOfflineEnum")
local NotifyOfflineFunc = {
  [NotifyOfflineType.FixedTime] = function(cfg, notifyOfflineFunc)
    local h = cfg.para1[1]
    local m = cfg.para1[2]
    local s = cfg.para1[3]
    local curTime = math.floor(PlayerDataCenter.timestamp)
    local date = TimeUtil:TimestampToDate(curTime)
    local isTimeOut = false
    if h < date.hour then
      isTimeOut = true
    elseif date.hour == h and m < date.min then
      isTimeOut = true
    elseif date.hour == h and date.min == m and s < date.sec then
      isTimeOut = true
    end
    date.hour = h
    date.min = m
    date.sec = s
    local nextTime = os.time(date)
    if isTimeOut then
      nextTime = nextTime + 86400
    end
    local isRepratDay = cfg.para2 ~= nil and cfg.para2 == 1
    notifyOfflineFunc(math.floor(nextTime - curTime), isRepratDay, cfg)
  end,
  [NotifyOfflineType.WarehouseCapcity] = function(cfg, notifyOfflineFunc)
    local itemId = cfg.para1
    local num, nextTime = PlayerDataCenter.allEffectorData:GetCurrentARGNum(itemId)
    local speed = PlayerDataCenter.allEffectorData:GetCurrentARGSpeed(itemId)
    local ceiling = PlayerDataCenter.allEffectorData:GetCurrentARGCeiling(itemId)
    if 0 < speed and num < ceiling then
      local delayTime = math.floor((ceiling - num - 1) / speed + nextTime)
      notifyOfflineFunc(delayTime, false, cfg)
    end
  end
}
return NotifyOfflineFunc
