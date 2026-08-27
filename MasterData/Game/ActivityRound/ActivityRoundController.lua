local ActivityRoundController = class("ActivityRoundController", ControllerBase)
local base = ControllerBase
local ActivityRoundData = require("Game.ActivityRound.ActivityRoundData")

function ActivityRoundController:OnInit()
  self._data = {}
end

function ActivityRoundController:AddRoundList(msg)
  for _, singleMsg in ipairs(msg) do
    self:AddActivityRound(singleMsg)
  end
end

function ActivityRoundController:AddActivityRound(msg)
  if self._data[msg.actId] == nil then
    self._data[msg.actId] = ActivityRoundData.New()
  end
  self._data[msg.actId]:InitRoundData(msg)
end

function ActivityRoundController:UpdateActivityRound(msg)
  local data = self._data[msg.actId]
  if data == nil then
    return
  end
  data:UpdateRoundData(msg)
end

function ActivityRoundController:RemoveActivityRound(id)
  self._data[id] = nil
end

function ActivityRoundController:GetActivityRound(id)
  return self._data[id]
end

function ActivityRoundController:HasActivityRound()
  return table.count(self._data) > 0
end

return ActivityRoundController
