local base = require("Game.ActivityFrame.ActivityBase")
local ActivityShortTheatreData = class("ActivityShortTheatreData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.ShortTheatre

function ActivityShortTheatreData:ctor()
end

function ActivityShortTheatreData:InitShortTheatreData(actId)
  self:SetActFrameDataByType(CurActType, actId)
end

function ActivityShortTheatreData:InitNetWrorkData(msg)
  self._netWorkData = msg
end

function ActivityShortTheatreData:UpdateNetWorkData(msg)
  self._netWorkData = msg
end

function ActivityShortTheatreData:GetID()
  if self.actInfo == nil then
    return nil
  end
  return self.actInfo.id
end

function ActivityShortTheatreData:GetActivityFrameId()
  return base:GetActFrameId()
end

function ActivityShortTheatreData:GetActOpenTime()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo.startTime
end

function ActivityShortTheatreData:GetActEndTime()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo.endTime
end

function ActivityShortTheatreData:GetActSign()
  if self._netWorkData == nil then
    return nil
  end
  return self._netWorkData.sign
end

function ActivityShortTheatreData:GetActCurStage()
  if self._netWorkData == nil then
    return nil
  end
  local actId = self:GetActId()
  return self._netWorkData
end

function ActivityShortTheatreData:GetActivityReddotNode()
  if self.actInfo == nil then
    return nil
  end
  return self.actInfo:GetActivityReddotNode()
end

return ActivityShortTheatreData
