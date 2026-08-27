local CheckerActLevelPass4Diff = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JudegeDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, diffId, needTime)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return false
    end
    return cardSetActData:JedgeIsCadrdSetDiffPassed(diffId, needTime)
  end
}
local GetDiffNameDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, diffId, needTime)
    local actId = actFrameData:GetActId()
    return LanguageUtil.GetLocaleText(ConfigData.activity_card_diff[actId][diffId].difficulty_name)
  end
}
local GetDiffPassTimesDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, diffId)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return 0
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return 0
    end
    return cardSetActData:GetCadrdSetDiffPassedTimes(diffId)
  end
}

function CheckerActLevelPass4Diff.LengthCheck(param)
  return 3 <= #param
end

function CheckerActLevelPass4Diff.ParamsCheck(param)
  local activityFrameId = param[2]
  local diffId = param[3]
  local needTime = param[4]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return false
  end
  local actCat = actFrameData:GetActivityFrameCat()
  local judjeFunc = JudegeDic[actCat]
  if judjeFunc ~= nil then
    return judjeFunc(actFrameData, diffId, needTime)
  end
  return false
end

function CheckerActLevelPass4Diff.GetUnlockInfo(param)
  local activityFrameId = param[2]
  local diffId = param[3]
  local needTime = param[4]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return ""
  end
  local diffName = ""
  local actCat = actFrameData:GetActivityFrameCat()
  local getDiffNameFunc = GetDiffNameDic[actCat]
  if getDiffNameFunc ~= nil then
    diffName = getDiffNameFunc(actFrameData, diffId, needTime)
  end
  local passTimes = GetDiffPassTimesDic[actCat] and GetDiffPassTimesDic[actCat](actFrameData, diffId) or 0
  local needTimeStr = tostring(needTime)
  return string.format(ConfigData:GetTipContent(2201), diffName, needTimeStr, tostring(passTimes), needTimeStr)
end

return CheckerActLevelPass4Diff
