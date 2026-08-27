local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityComebackNewSystemData = class("ActivityComebackNewSystemData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function ActivityComebackNewSystemData:InitActivityComebackNewSystem(msg)
  self.id = msg.actId
  self._modules = msg.modules
  self._modulesCfg = ConfigData.activity_return_newSystem[msg.actId]
  self:UpdateActFrameDataSingleMsg(msg)
end

function ActivityComebackNewSystemData:GetComebackNewSystemId()
  return self.id
end

function ActivityComebackNewSystemData:GetComebackNewSystemModules()
  return self._modules
end

function ActivityComebackNewSystemData:GetComebackNewSystemModulesCfg()
  return self._modulesCfg
end

return ActivityComebackNewSystemData
