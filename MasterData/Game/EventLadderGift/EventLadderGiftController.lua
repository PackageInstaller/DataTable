local EventLadderGiftController = class("EventLadderGiftController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local EventLadderGiftData = require("Game.EventLadderGift.Data.EventLadderGiftData")

function EventLadderGiftController:OnInit()
  self._dataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_laddergift)
end

function EventLadderGiftController:InitLadderGift(actFrameData)
  if self._dataDic[actFrameData:GetActId()] ~= nil then
    return
  end
  local data = EventLadderGiftData.New()
  self._dataDic[actFrameData:GetActId()] = data
  data:InitLadderGiftData(actFrameData:GetActId())
  self:ReqLadderGiftData(actFrameData:GetActivityFrameId())
end

function EventLadderGiftController:ReqLadderGiftData(actFrameId)
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    if msg.activityLadderGift ~= nil then
      self._dataDic[msg.activityLadderGift.actId]:UpdateLadderGiftMsg(msg.activityLadderGift)
    end
  end)
end

function EventLadderGiftController:GetTheLatestLadderGiftData()
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

function EventLadderGiftController:GetLadderGiftDataByActId(actId)
  return self._dataDic[actId]
end

function EventLadderGiftController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_laddergift)
end

return EventLadderGiftController
