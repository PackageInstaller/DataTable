local TimerManager = require("Managers.TimerManager")
local Logger = require("Utility.Logger")
local WorldStageNetMsgComp = System.NewComponent("WorldStageNetMsgComp")

function WorldStageNetMsgComp:ctor(stageComp)
  self.stageComp = stageComp
  self.msgQueue = {}
  self.protoHandlers = {
    OnGearDelete = System.fn(self, self.OnGearDelete),
    OnTriggerGearData = System.fn(self, self.OnTriggerGearData),
    OnTriggerBattle = System.fn(self, self.OnTriggerBattle),
    OnSyncView = System.fn(self, self.OnSyncView),
    OnDestructionGear = System.fn(self, self.OnDestructionGear),
    OnNewGearData = System.fn(self, self.OnNewGearData),
    OnSyncWorldDataByReconnect = System.fn(self, self.OnSyncWorldDataByReconnect),
    OnSyncWorldTaskFinish = System.fn(self, self.OnSyncWorldTaskFinish),
    OnSyncWorldTaskUnlock = System.fn(self, self.OnSyncWorldTaskUnlock),
    OnSyncWorldStats = System.fn(self, self.OnSyncWorldStats),
    OnSyncRailWayWorld = System.fn(self, self.OnSyncRailWayWorld),
    OnSyncRelic = System.fn(self, self.OnSyncRelic),
    OnChaosRelic = System.fn(self, self.OnChaosRelic),
    OnSyncGearInfo = System.fn(self, self.OnSyncGearInfo),
    OnSyncWorldPlayerPos = System.fn(self, self.OnSyncWorldPlayerPos),
    OnReviveChoose = System.fn(self, self.OnReviveChoose),
    OnSyncWorldAchivementData = System.fn(self, self.OnSyncWorldAchivementData),
    OnSyncWorldTaskData = System.fn(self, self.OnSyncWorldTaskData)
  }
end

function WorldStageNetMsgComp:OnBind(binder)
  self.binder = binder
  for protoName, _ in pairs(self.protoHandlers) do
    binder:BindResponse(self, "World", protoName, System.bind(self.OnProtoReceived, self, protoName))
  end
end

function WorldStageNetMsgComp:OnProtoReceived(protoName, protoData)
  local handler = self.protoHandlers[protoName]
  if handler then
    handler(protoData)
  end
end

function WorldStageNetMsgComp:PushMsg(protoName, protoData)
  table.insert(self.msgQueue, {
    protoName = protoName,
    protoData = protoData,
    timestamp = TimerManager.totalTime
  })
  Logger.Info("[WorldStageNetMsgComp] PushMsg", protoName, "queue size:", #self.msgQueue)
end

function WorldStageNetMsgComp:PopMsg(protoName)
  if 0 == #self.msgQueue then
    return nil
  end
  if protoName then
    for i, msg in ipairs(self.msgQueue) do
      if msg.protoName == protoName then
        table.remove(self.msgQueue, i)
        Logger.Info("[WorldStageNetMsgComp] PopMsg", protoName, "queue size:", #self.msgQueue)
        return msg
      end
    end
    return nil
  else
    local msg = table.remove(self.msgQueue, 1)
    Logger.Info("[WorldStageNetMsgComp] PopMsg", msg.protoName, "queue size:", #self.msgQueue)
    return msg
  end
end

function WorldStageNetMsgComp:IsRewardTriggerMsg(msg)
  local protoData = msg and msg.protoData
  local data = protoData and protoData.data
  return msg and msg.protoName == "OnTriggerGearData" and data and data.items ~= nil
end

function WorldStageNetMsgComp:RemoveMsgByGearUid(gearUid)
  local removedCount = 0
  for i = #self.msgQueue, 1, -1 do
    local msg = self.msgQueue[i]
    if msg.protoData and msg.protoData.uid == gearUid and not self:IsRewardTriggerMsg(msg) then
      table.remove(self.msgQueue, i)
      removedCount = removedCount + 1
    end
  end
  if removedCount > 0 then
    Logger.Info("[WorldStageNetMsgComp] RemoveMsgByGearUid", gearUid, "removed:", removedCount, "queue size:", #self.msgQueue)
  end
end

function WorldStageNetMsgComp:GetQueueSize()
  return #self.msgQueue
end

function WorldStageNetMsgComp:ClearQueue()
  self.msgQueue = {}
  Logger.Info("[WorldStageNetMsgComp] ClearQueue")
end

function WorldStageNetMsgComp:OnGearDelete(data)
  for _, uid in ipairs(data) do
    self:RemoveMsgByGearUid(uid)
  end
  self:PushMsg("OnGearDelete", data)
end

function WorldStageNetMsgComp:OnTriggerGearData(data)
  self:PushMsg("OnTriggerGearData", data)
end

function WorldStageNetMsgComp:OnTriggerBattle(data)
  self:PushMsg("OnTriggerBattle", data)
end

function WorldStageNetMsgComp:OnSyncView(data)
  self:PushMsg("OnSyncView", data)
end

function WorldStageNetMsgComp:OnDestructionGear(data)
  self:PushMsg("OnDestructionGear", data)
end

function WorldStageNetMsgComp:OnNewGearData(data)
  self:PushMsg("OnNewGearData", data)
end

function WorldStageNetMsgComp:OnSyncWorldDataByReconnect(data)
  self:PushMsg("OnSyncWorldDataByReconnect", data)
end

function WorldStageNetMsgComp:OnSyncWorldTaskFinish(data)
  self:PushMsg("OnSyncWorldTaskFinish", data)
end

function WorldStageNetMsgComp:OnSyncWorldTaskUnlock(data)
  self:PushMsg("OnSyncWorldTaskUnlock", data)
end

function WorldStageNetMsgComp:OnSyncWorldStats(data)
  self:PushMsg("OnSyncWorldStats", data)
end

function WorldStageNetMsgComp:OnSyncRailWayWorld(data)
  self:PushMsg("OnSyncRailWayWorld", data)
end

function WorldStageNetMsgComp:OnSyncRelic(data)
  self:PushMsg("OnSyncRelic", data)
end

function WorldStageNetMsgComp:OnChaosRelic(data)
  self:PushMsg("OnChaosRelic", data)
end

function WorldStageNetMsgComp:OnSyncGearInfo(data)
  self:PushMsg("OnSyncGearInfo", data)
end

function WorldStageNetMsgComp:OnSyncWorldPlayerPos(data)
  self:PushMsg("OnSyncWorldPlayerPos", data)
end

function WorldStageNetMsgComp:OnReviveChoose(data)
  self:PushMsg("OnReviveChoose", data)
end

function WorldStageNetMsgComp:OnSyncWorldAchivementData(data)
  self:PushMsg("OnSyncWorldAchivementData", data)
end

function WorldStageNetMsgComp:OnSyncWorldTaskData(data)
  self:PushMsg("OnSyncWorldTaskData", data)
end

return WorldStageNetMsgComp
