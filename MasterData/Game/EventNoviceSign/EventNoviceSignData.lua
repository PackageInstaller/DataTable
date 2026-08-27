local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local EventNoviceSignData = class("EventNoviceSignData", ActivityBase)
local base = ActivityBase
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local eSignType = {Novice = 1, Festival = 2}

function EventNoviceSignData:InitNoviceSignData(data)
  self:SetActFrameDataByType(ActivityFrameEnum.eActivityType.SevenDayLogin, data.id)
  self.id = data.id
  self.cfg = ConfigData.sign_activity[self.id]
  self.awardCfg = ConfigData.sign_activity_award[self.id]
  self:UpdateNoviceSignData(data)
  self:UpdateActFrameDataSingleMsg(data)
end

function EventNoviceSignData:UpdateNoviceSignData(data)
  self.times = data.times
  self.nextExpiredTm = data.nextExpiredTm
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actInfo = activityFrameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.SevenDayLogin, self.id)
  local reddot = actInfo ~= nil and actInfo:GetActivityReddotNode() or nil
  if reddot ~= nil then
    reddot:SetRedDotCount(self:IsAllowReceive() and 1 or 0)
  end
  if not self.cfg.forbid_hide_after_completion and self.times >= table.count(self.awardCfg) then
    activityFrameCtrl:HideActivityByExtraLogic(ActivityFrameEnum.eActivityType.SevenDayLogin, self.id)
  end
end

function EventNoviceSignData:GetReceiveState(day)
  if day <= self.times then
    return TaskEnum.eTaskState.Picked
  end
  if day == self.times + 1 and self:IsAllowReceive() then
    return TaskEnum.eTaskState.Completed
  end
  return TaskEnum.eTaskState.InProgress
end

function EventNoviceSignData:GetEvtSignPickRewardBgColor()
  local colorList = self.cfg.BtnIsCompleted_Color
  if #colorList == 3 then
    return Color.New(colorList[1] / 255, colorList[2] / 255, colorList[3] / 255)
  end
  return nil
end

function EventNoviceSignData:IsAllowReceive()
  return self.nextExpiredTm < PlayerDataCenter.timestamp and self.times < table.count(self.awardCfg)
end

function EventNoviceSignData:GetEventSignTimes()
  return self.times
end

function EventNoviceSignData:SetPoped()
  self.popTime = PlayerDataCenter.timestamp
end

function EventNoviceSignData:IsCanPop()
  if self.cfg ~= nil and self.cfg.forbid_popup then
    return false
  end
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  if activityFrameCtrl ~= nil then
    local actData = activityFrameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.SevenDayLogin, self.id)
    if actData == nil or not actData:GetCouldShowActivity() then
      return false
    end
  end
  if not self:IsAllowReceive() then
    return false
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
  if self.popTime ~= nil then
    local isTody = timePassCtrl:GetIsLogicToday(self.popTime)
    if PlayerDataCenter.timestamp < self.popTime or isTody then
      return false
    end
  end
  return true
end

function EventNoviceSignData:GetSignRewardList()
  local list = {}
  for k, v in pairs(self.awardCfg) do
    table.insert(list, v)
  end
  table.sort(list, function(a, b)
    return a.day < b.day
  end)
  return list
end

function EventNoviceSignData:GetSignCfg()
  return self.cfg
end

function EventNoviceSignData:IsFestivalSign()
  return self.cfg.sign_type == eSignType.Festival
end

return EventNoviceSignData
