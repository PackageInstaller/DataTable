_class("HomelandTraceManager", Object)
HomelandTraceManager = HomelandTraceManager
local TraceEnum = {Task = 1, Other = 2}
_enum("TraceEnum", TraceEnum)

function HomelandTraceManager:Constructor()
end

function HomelandTraceManager:Init(homelandClient)
  self._homelandClient = homelandClient
  self._interactPointManager = self._homelandClient:InteractPointManager()
  self._charCtrl = self._homelandClient:CharacterManager():MainCharacterController()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._homelandTraceManagerHelper = HomelandTraceManagerHelper:New(self)
  self._minimapManager = self._homelandClient:GetMinimapManager()
  self._traceItems = {}
end

function HomelandTraceManager:Dispose()
  for i = #self._traceItems, 1, -1 do
    self._traceItems[i]:Dispose()
    table.remove(self._traceItems, i)
  end
  self._traceItems = {}
  if self._taskTraceItem then
    self._taskTraceItem:Dispose()
    self._taskTraceItem = nil
  end
  if self._otherTraceItem then
    self._otherTraceItem:Dispose()
    self._otherTraceItem = nil
  end
end

function HomelandTraceManager:OnModeChanged(mode)
  self._clientMode = mode
  if self._clientMode ~= HomelandMode.Normal then
    if self._taskTraceItem then
      self._lastTaskTraceId = self._taskTraceItem:GetTraceId()
      self:DisposeTrace(self._lastTaskTraceId)
      self._taskTraceItem = nil
    end
    if self._otherTraceItem then
      self._lastotherTraceId = self._otherTraceItem:GetTraceId()
      self:DisposeTrace(self._lastotherTraceId)
      self._otherTraceItem = nil
    end
  else
    if self._lastTaskTraceId then
      self._lastTaskTraceId = nil
    end
    if self._lastotherTraceId then
      self._lastotherTraceId = nil
    end
  end
end

function HomelandTraceManager:Update(deltaTimeMS)
  if self._taskTraceItem then
    self._taskTraceItem:Update(deltaTimeMS)
  end
  if self._otherTraceItem then
    self._otherTraceItem:Update(deltaTimeMS)
  end
end

function HomelandTraceManager:GetMinimapManager()
end

function HomelandTraceManager:GetInteractPointManager()
  return self._interactPointManager
end

function HomelandTraceManager:GetHomelandClient()
  return self._homelandClient
end

function HomelandTraceManager:GetCharactorController()
  return self._charCtrl
end

function HomelandTraceManager:StartTrace(traceId, type, position, taskItem)
  if not type then
    local config = self._homelandTraceManagerHelper:GetTraceInfo(traceId)
    Log.assert(config ~= nil, "StartTrace error traceid ", traceId)
    type = config.TraceType
  end
  if not traceId then
    return
  end
  Log.debug("HomelandTraceManager:StartTrace" .. traceId)
  self._traceCore = GameGlobal.TaskManager():StartTask(self.HomelandTraceCoro, self, traceId, type, position, taskItem)
end

function HomelandTraceManager:HomelandTraceCoro(TT, traceId, type, position, taskItem)
  if not self._homelandModule then
    return
  end
  local res = self._homelandModule:HandleHomelandTraceReq(TT, type, traceId)
  if res:GetSucc() then
    if type == TraceEnum.Task then
      if self._taskTraceItem and self._taskTraceItem:GetTraceId() ~= traceId then
        self:DisposeTrace(self._taskTraceItem:GetTraceId())
      end
    elseif self._otherTraceItem and self._otherTraceItem:GetTraceId() ~= traceId then
      self:DisposeTrace(self._otherTraceItem:GetTraceId())
    end
    if not self:CheckHadTraceItem(traceId) then
      local traceItem
      if type == TraceEnum.Task then
        self._taskTraceId = traceId
        if taskItem then
          self._taskItem = taskItem
        end
        traceItem = HomeTraceItem:New(self._taskTraceId, self._taskItem, self, position)
        self._taskTraceItem = traceItem
      else
        self._otherTraceId = traceId
        traceItem = HomeTraceItem:New(self._otherTraceId, nil, self, position)
        self._otherTraceItem = traceItem
      end
      traceItem:StartRun()
      table.insert(self._traceItems, traceItem)
    elseif type == TraceEnum.Task then
      if self._taskTraceItem then
        self._taskTraceItem:Emphasize()
      end
    elseif self._otherTraceItem then
      self._otherTraceItem:Emphasize()
    end
    return
  end
end

function HomelandTraceManager:DisposeTrace(traceId, type)
  if not traceId then
    return
  end
  if self._traceCore then
    GameGlobal.TaskManager():KillTask(self._traceCore)
    self._traceCore = nil
  end
  if type then
    for i = #self._traceItems, 1, -1 do
      if self._traceItems[i]:GetTraceType() == type and self._traceItems[i]:GetTraceId() == traceId then
        self._traceItems[i]:Dispose()
        table.remove(self._traceItems, i)
      end
    end
  else
    for i = #self._traceItems, 1, -1 do
      if self._traceItems[i]:GetTraceId() == traceId then
        self._traceItems[i]:Dispose()
        table.remove(self._traceItems, i)
      end
    end
  end
end

function HomelandTraceManager:GetHomelandTraceManagerHelper()
  return self._homelandTraceManagerHelper
end

function HomelandTraceManager:CheckHadTraceItem(traceId)
  for index, value in ipairs(self._traceItems) do
    if value:GetTraceId() == traceId then
      return true
    end
  end
  return false
end

function HomelandTraceManager:SetTraceItemShowIcons(traceId, bSHow)
  if traceId then
    for index, value in pairs(self._traceItems) do
      if value:GetTraceId() == traceId then
        value:ShowTraceIcons(bSHow)
      end
    end
  end
end
