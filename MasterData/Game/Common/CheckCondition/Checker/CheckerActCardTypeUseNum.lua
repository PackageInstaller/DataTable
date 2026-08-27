local CheckerActCardTypeUseNum = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JudegeDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, num)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return false
    end
    return cardSetActData:JedgeIsCadrdSetUsedDiffCard(num)
  end
}
local GetUseNumDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return 0
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return 0
    end
    return cardSetActData:GetCadrdSetUsedDiffCard()
  end
}

function CheckerActCardTypeUseNum.LengthCheck(param)
  return 2 <= #param
end

function CheckerActCardTypeUseNum.ParamsCheck(param)
  local activityFrameId = param[2]
  local num = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return false
  end
  local actCat = actFrameData:GetActivityFrameCat()
  local judjeFunc = JudegeDic[actCat]
  if judjeFunc ~= nil then
    return judjeFunc(actFrameData, num)
  end
  return false
end

function CheckerActCardTypeUseNum.GetUnlockInfo(param)
  local activityFrameId = param[2]
  local num = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return ""
  end
  local actCat = actFrameData:GetActivityFrameCat()
  local usedNum = GetUseNumDic[actCat] and GetUseNumDic[actCat](actFrameData) or 0
  return string.format(ConfigData:GetTipContent(2202), tostring(num), tostring(usedNum), tostring(num))
end

return CheckerActCardTypeUseNum
