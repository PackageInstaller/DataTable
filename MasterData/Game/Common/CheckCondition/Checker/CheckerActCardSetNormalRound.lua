local CheckerActCardSetNormalRound = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JudegeDic = {
  [ActivityFrameEnum.eActivityType.CardSet] = function(actFrameData, round)
    local cardSet = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSet == nil then
      return false
    end
    local actId = actFrameData:GetActId()
    local cardSetActData = cardSet:GetCdStActData(actId)
    if cardSetActData == nil then
      return false
    end
    return cardSetActData:IsCardSetNormalRoundComplete(round)
  end
}

function CheckerActCardSetNormalRound.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerActCardSetNormalRound.ParamsCheck(param)
  local activityFrameId = param[2]
  local round = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityFrameId)
  if actFrameData == nil then
    return false
  end
  local actCat = actFrameData:GetActivityFrameCat()
  local judjeFunc = JudegeDic[actCat]
  if judjeFunc ~= nil then
    return judjeFunc(actFrameData, round)
  end
  return false
end

function CheckerActCardSetNormalRound.GetUnlockInfo(param)
  local round = param[3]
  return string.format(ConfigData:GetTipContent(2216), round)
end

return CheckerActCardSetNormalRound
