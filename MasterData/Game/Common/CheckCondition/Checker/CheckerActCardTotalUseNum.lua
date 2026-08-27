local CheckerActCardTypeUseNum = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JudegeDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, cardId, needTime)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return false
    end
    return cardSetActData:JedgeIsCadrdSetUseCard4CertainTimes(cardId, needTime)
  end
}
local GetUseNumDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, cardId)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return false
    end
    return cardSetActData:GetCadrdSetUseCard4CertainTimes(cardId)
  end
}

function CheckerActCardTypeUseNum.LengthCheck(param)
  return 3 <= #param
end

function CheckerActCardTypeUseNum.ParamsCheck(param)
  local activityFrameId = param[2]
  local cardId = param[3]
  local needTime = param[4]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return false
  end
  local actCat = actFrameData:GetActivityFrameCat()
  local judjeFunc = JudegeDic[actCat]
  if judjeFunc ~= nil then
    return judjeFunc(actFrameData, cardId, needTime)
  end
  return false
end

function CheckerActCardTypeUseNum.GetUnlockInfo(param)
  local activityFrameId = param[2]
  local cardId = param[3]
  local needTime = param[4]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return ""
  end
  local actId = actFrameData:GetActId()
  local CardSetCardData = require("Game.CardSet.Data.CardSetCardData")
  local cardData = CardSetCardData.CreateCardDataByIdAndData(actId, cardId)
  local name = cardData:GetCardSetCardName()
  local actCat = actFrameData:GetActivityFrameCat()
  local usedNum = GetUseNumDic[actCat] and GetUseNumDic[actCat](actFrameData, cardId) or 0
  return string.format(ConfigData:GetTipContent(2203), tostring(needTime), name, tostring(usedNum), tostring(needTime))
end

return CheckerActCardTypeUseNum
