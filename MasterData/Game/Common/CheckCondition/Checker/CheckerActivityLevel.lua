local CheckerActivityLevel = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local LockedDesId = {
  [ActivityFrameEnum.eActivityType.Carnival] = 7122,
  [ActivityFrameEnum.eActivityType.WhiteDay] = 7212,
  [ActivityFrameEnum.eActivityType.Hallowmas] = 8702,
  [ActivityFrameEnum.eActivityType.Season] = 9310,
  [ActivityFrameEnum.eActivityType.DeliverySimulator] = 58005
}
local JustShowLevel = {
  [ActivityFrameEnum.eActivityType.Carnival] = true,
  [ActivityFrameEnum.eActivityType.Hallowmas] = true,
  [ActivityFrameEnum.eActivityType.Season] = true
}

function CheckerActivityLevel.LengthCheck(param)
  return 2 <= #param
end

function CheckerActivityLevel.ParamsCheck(param)
  local activityFrameId = param[2]
  local level = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return false
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Carnival then
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    if carnivalCtrl == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local carnivalData = carnivalCtrl:GetCarnivalAct(actId)
    if carnivalData == nil then
      return false
    end
    local actlevel = carnivalData:GetCarnivalLevelExp()
    return level <= actlevel
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.WhiteDay then
    local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
    if whiteDayCtrl == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local whiteDayData = whiteDayCtrl:GetWhiteDayDataByActId(actId)
    if whiteDayData == nil then
      return false
    end
    local actlevel = whiteDayData:GetAWDFactoryLevel()
    return level <= actlevel
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Hallowmas then
    local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    if hallowmasCtrl == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local hallowmasData = hallowmasCtrl:GetHallowmasData(actId)
    if hallowmasData == nil then
      return false
    end
    local actlevel = hallowmasData:GetHallowmasLv()
    return level <= actlevel
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Season then
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonCtrl == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local seasonData = seasonCtrl:GetSeasonDataByActId(actId)
    if seasonData == nil then
      return false
    end
    local actlevel = seasonData:GetSeasonRewardCurLv()
    return level <= actlevel
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.DeliverySimulator then
    local dsCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
    if dsCtrl == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local dsnData = dsCtrl:GetActDataByActId(actId)
    if dsnData == nil then
      return false
    end
    local actlevel = dsnData:GetRewardBpLevel()
    return level <= actlevel
  end
  return false
end

function CheckerActivityLevel.GetUnlockInfo(param)
  local activityFrameId = param[2]
  local level = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return ""
  end
  local desId = LockedDesId[actFrameData:GetActivityFrameCat()]
  if desId == nil then
    return ""
  end
  if JustShowLevel[actFrameData:GetActivityFrameCat()] then
    return string.format(ConfigData:GetTipContent(desId), level)
  end
  local actName = actFrameData.name
  return string.format(ConfigData:GetTipContent(desId), actName, level)
end

return CheckerActivityLevel
