local WarChessSeasonAddtionData = class("WarChessSeasonAddtionData")

function WarChessSeasonAddtionData:SetSeasonScoreData(score, maxScore)
  self._score = score
  self._maxScore = maxScore
  MsgCenter:Broadcast(eMsgEventId.WCS_ExtraneouslyRefresh)
end

function WarChessSeasonAddtionData:SetSeasonScoreToken(itemId)
  self._tokenItemId = itemId
end

function WarChessSeasonAddtionData:SetSeasonCompleteFloor(floor)
  self._completeFloor = floor
end

function WarChessSeasonAddtionData:SetSeasonCompleteFloorTip(tip)
  self._completeFloorTip = tip
end

function WarChessSeasonAddtionData:SetSeasonHighesScore(score)
  self._highesScore = score
end

function WarChessSeasonAddtionData:SetSelectLevelTokenCallback(callback)
  self._selectLevelTokenCallback = callback
end

function WarChessSeasonAddtionData:SetSeasonRecommendPower(power)
  self._recommonPower = power
end

function WarChessSeasonAddtionData:SetSeasonSaveUIType(uiWindowType)
  self._saveUIWindowType = uiWindowType
end

function WarChessSeasonAddtionData:GetSeasonScoreToken()
  return self._tokenItemId
end

function WarChessSeasonAddtionData:GetSeasonScore()
  return self._score, self._maxScore
end

function WarChessSeasonAddtionData:GetSeasonCompleteFloor()
  return self._completeFloor
end

function WarChessSeasonAddtionData:GetSeasonCompleteFloorTip()
  return self._completeFloorTip
end

function WarChessSeasonAddtionData:IsSetSeasonCompleteFloor()
  return self._completeFloor ~= nil
end

function WarChessSeasonAddtionData:GetSeasonHighesScore()
  return self._highesScore or 0
end

function WarChessSeasonAddtionData:GetSelectLevelTokenCallback()
  return self._selectLevelTokenCallback
end

function WarChessSeasonAddtionData:GetSeasonRecommendPower()
  return self._recommonPower
end

function WarChessSeasonAddtionData:GetSeasonSaveUIType()
  return self._saveUIWindowType
end

return WarChessSeasonAddtionData
