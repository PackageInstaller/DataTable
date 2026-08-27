local EventAngelaGiftController = class("EventAngelaGiftController", ControllerBase)
local base = ControllerBase
local EventAngelaGiftData = require("Game.EventAngelaGift.Data.EventAngelaGiftData")

function EventAngelaGiftController:OnInit()
  self._dataDic = {}
end

function EventAngelaGiftController:InitAngelaGift(actFrameData)
  if self._dataDic[actFrameData:GetActId()] ~= nil then
    return
  end
  local data = EventAngelaGiftData.New()
  self._dataDic[actFrameData:GetActId()] = data
  data:InitAngelaGiftData(actFrameData:GetActId())
end

function EventAngelaGiftController:GetTheLatestAngelaGiftData()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function EventAngelaGiftController:GetAngelaGiftDataByActId(actId)
  return self._dataDic[actId]
end

return EventAngelaGiftController
