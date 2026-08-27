local EventDrawLotteryController = class("EventDrawLotteryController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local EventDrawLotteryData = require("Game.EventDrawLottery.Data.EventDrawLotteryData")

function EventDrawLotteryController:OnInit()
  self._dataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_drawlottery_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_drawlottery_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_drawlottery_task_group)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function EventDrawLotteryController:InitEventDrawLottery(msgs)
  for i, msg in ipairs(msgs) do
    self:AddEventDrawLottery(msg)
  end
end

function EventDrawLotteryController:AddEventDrawLottery(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = EventDrawLotteryData.New()
  self._dataDic[msg.actId] = data
  data:InitDrawLotteryData(msg)
end

function EventDrawLotteryController:UpdateEventDrawLottery(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateDrawLotteryMsg(msg)
end

function EventDrawLotteryController:RemoveEventDrawLottery(actId)
  self._dataDic[actId] = nil
end

function EventDrawLotteryController:IsHaveEventDrawLottery()
  return table.count(self._dataDic) > 0
end

function EventDrawLotteryController:GetEventDrawLotteryData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function EventDrawLotteryController:GetEventDrawLotteryDataByActId(actId)
  return self._dataDic[actId]
end

function EventDrawLotteryController:GetEventDrawLotteryDataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function EventDrawLotteryController:__TaskProcessUpdate(taskData)
  for _, data in pairs(self._dataDic) do
    data:RefreshTaskGroupRedDot()
  end
end

function EventDrawLotteryController:__ItemUpdate()
  for _, data in pairs(self._dataDic) do
    data:RefreshBPRedDot()
  end
end

function EventDrawLotteryController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_drawlottery_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_drawlottery_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_drawlottery_task_group)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

return EventDrawLotteryController
