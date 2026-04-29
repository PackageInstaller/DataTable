require("trigger_base")
require("trigger_owner")
_class("BuffHandlerBase", ITriggerOwner)
BuffHandlerBase = BuffHandlerBase

function BuffHandlerBase:Constructor(buffInstance, triggerCfg, logicCfg)
  self._buffInstance = buffInstance
  local world = buffInstance:World()
  self._world = world
  local triggerSvc = world:GetService("Trigger")
  local bufflogicSvc = world:GetService("BuffLogic")
  self._trigger = triggerSvc:CreateTrigger(self, triggerCfg, world)
  self._logic = bufflogicSvc:CreateBuffLogic(buffInstance, logicCfg)
  self:Attach()
end

function BuffHandlerBase:Attach()
  local svc = self._buffInstance:World():GetService("Trigger")
  svc:Attach(self._trigger)
end

function BuffHandlerBase:Detach()
  local svc = self._buffInstance:World():GetService("Trigger")
  svc:Detach(self._trigger)
end

function BuffHandlerBase:SetActive(active)
  self._trigger:SetActive(active)
end

function BuffHandlerBase:DoOverlap(logicParam, context)
  if self._logic and logicParam then
    for i, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff logic overlap ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffOverlap",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      local buffResult = logic:DoOverlap(logicParam[i], context)
      if buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), NTBuffLoad:New(), buffResult)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Overlap")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
    end
  end
end

function BuffHandlerBase:GetTrigger()
  return self._trigger
end

function BuffHandlerBase:GetTriggerType()
  return self._trigger:GetTriggerType()
end

function BuffHandlerBase:GetNotifyType()
  return self._trigger:GetNotifyType()
end

function BuffHandlerBase:GetOwnerEntity()
  return self._buffInstance:Entity()
end

function BuffHandlerBase:GetWorld()
  return self._buffInstance:World()
end

function BuffHandlerBase:PrintBuffHandlerLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

_class("BuffLoadHandler", BuffHandlerBase)
BuffLoadHandler = BuffLoadHandler

function BuffLoadHandler:Constructor()
end

function BuffLoadHandler:OnTrigger(notify, triggers)
  if self._logic then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:BeginTriggerLogic("加载逻辑")
    detailLogger:RecordBuffInstance(self._buffInstance, self:GetOwnerEntity():GetID())
    for index, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff load trigger logic ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffLoad",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      detailLogger:RecordTriggerLogic(index, logic)
      detailLogger:RecordBuffLogic(logic)
      local buffResult = logic:DoLogic(notify, triggers, index)
      if buffResult and type(buffResult) == "table" then
        detailLogger:RecordBuffResult(buffResult)
      end
      if notify and buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), notify, buffResult, triggers)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Load")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
      detailLogger:EndRecordTriggerLogic()
    end
    detailLogger:EndTriggerLogic()
  end
end

_class("BuffUnloadHandler", BuffHandlerBase)
BuffUnloadHandler = BuffUnloadHandler

function BuffUnloadHandler:Constructor()
end

function BuffUnloadHandler:OnTrigger(notify, triggers)
  if self._logic then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:BeginTriggerLogic("卸载逻辑")
    detailLogger:RecordBuffInstance(self._buffInstance, self:GetOwnerEntity():GetID())
    for index, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff unload trigger logic ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffUnload",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      detailLogger:RecordTriggerLogic(index, logic)
      detailLogger:RecordBuffLogic(logic)
      local buffResult = logic:DoLogic(notify, triggers)
      if buffResult and type(buffResult) == "table" then
        detailLogger:RecordBuffResult(buffResult)
      end
      if notify and buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), notify, buffResult, triggers)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Unload")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
      detailLogger:EndRecordTriggerLogic()
    end
    detailLogger:EndTriggerLogic()
  end
  self._buffInstance:Unload(notify, true)
end

_class("BuffActiveHandler", BuffHandlerBase)
BuffActiveHandler = BuffActiveHandler

function BuffActiveHandler:Constructor()
end

function BuffActiveHandler:OnTrigger(notify, triggers)
  self._buffInstance:SetActive(true)
  if self._logic then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:BeginTriggerLogic("激活逻辑")
    detailLogger:RecordBuffInstance(self._buffInstance, self:GetOwnerEntity():GetID())
    for index, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff active trigger logic ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffActive",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      detailLogger:RecordTriggerLogic(index, logic)
      detailLogger:RecordBuffLogic(logic)
      local buffResult = logic:DoLogic(notify, triggers)
      if buffResult and type(buffResult) == "table" then
        detailLogger:RecordBuffResult(buffResult)
      end
      if notify and buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), notify, buffResult, triggers)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Active")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
      detailLogger:EndRecordTriggerLogic()
    end
    detailLogger:EndTriggerLogic()
  end
end

_class("BuffDeactiveHandler", BuffHandlerBase)
BuffDeactiveHandler = BuffDeactiveHandler

function BuffDeactiveHandler:Constructor()
end

function BuffDeactiveHandler:OnTrigger(notify, triggers)
  self._buffInstance:SetActive(false)
  if self._logic then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:BeginTriggerLogic("失活逻辑")
    detailLogger:RecordBuffInstance(self._buffInstance, self:GetOwnerEntity():GetID())
    for index, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff deactive trigger logic ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffDeactive",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      detailLogger:RecordTriggerLogic(index, logic)
      detailLogger:RecordBuffLogic(logic)
      local buffResult = logic:DoLogic(notify, triggers)
      if buffResult and type(buffResult) == "table" then
        detailLogger:RecordBuffResult(buffResult)
      end
      if notify and buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), notify, buffResult, triggers)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Deactive")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
      detailLogger:EndRecordTriggerLogic()
    end
    detailLogger:EndTriggerLogic()
  end
end

_class("BuffExecuteHandler", BuffHandlerBase)
BuffExecuteHandler = BuffExecuteHandler

function BuffExecuteHandler:OnTrigger(notify, triggers)
  if self._logic then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:BeginTriggerLogic("执行逻辑")
    detailLogger:RecordBuffInstance(self._buffInstance, self:GetOwnerEntity():GetID())
    for index, logic in ipairs(self._logic) do
      self:PrintBuffHandlerLog("buff exec trigger logic ---- ", logic:GetLogicName())
      local logger = self._world:GetSyncLogger()
      logger:Trace({
        key = "buffExec",
        buffID = self._buffInstance:BuffID(),
        entityID = self:GetOwnerEntity():GetID(),
        logic = logic:GetLogicName()
      })
      detailLogger:RecordTriggerLogic(index, logic)
      detailLogger:RecordBuffLogic(logic)
      local buffResult = logic:DoLogic(notify, triggers)
      if buffResult and type(buffResult) == "table" then
        detailLogger:RecordBuffResult(buffResult)
      end
      if notify and buffResult then
        local res = DataBuffLogicResult:New(self:GetOwnerEntity():GetID(), self._buffInstance:BuffSeq(), logic:GetLogicName(), notify, buffResult, triggers)
        res:SetBuffID(self._buffInstance:BuffID())
        res:SetLogicType("Exec")
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
      detailLogger:EndRecordTriggerLogic()
    end
    detailLogger:EndTriggerLogic()
  end
end
