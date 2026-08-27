local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityComebackData = class("ActivityComebackData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local emptyString = ""
local ActivityComebackWindowIdDic = {
  [1] = UIWindowTypeID.ActivityComeback,
  [2] = UIWindowTypeID.ActivityComebackLite
}
local ActivityComebackEntryTextIdDic = {
  [1] = TipContent.ComebackEntryText,
  [2] = TipContent.ComebackLiteEntryText
}

function ActivityComebackData:InitActivityComeback(msg)
  self._id = msg.actId
  self._avgId = msg.avgId
  self._comebackCfg = ConfigData.activity_user_return[self._id]
  self:UpdateActFrameDataSingleMsg(msg)
end

function ActivityComebackData:GetComebackId()
  return self._id
end

function ActivityComebackData:GetComebackAvgId()
  return self._avgId
end

function ActivityComebackData:GetComebackCfg()
  return self._comebackCfg
end

function ActivityComebackData:GetComebackWindowId()
  local mainWindowId = self._comebackCfg.window_id
  if ActivityComebackWindowIdDic[mainWindowId] ~= nil then
    return ActivityComebackWindowIdDic[mainWindowId]
  else
    error("Dont Have WindowId, ComeBack ActId = " .. mainWindowId)
  end
end

function ActivityComebackData:GetComebackEntryText()
  local entryTextId = self._comebackCfg.text_id
  if ActivityComebackEntryTextIdDic[entryTextId] ~= nil then
    return ConfigData:GetTipContent(ActivityComebackEntryTextIdDic[entryTextId])
  else
    error("Dont Have EntryTextId, ComeBack ActId = " .. entryTextId)
    return emptyString
  end
end

return ActivityComebackData
