_class("GameFsmStateNode", StateNode)
GameFsmStateNode = GameFsmStateNode

function GameFsmStateNode:Constructor()
  self._finish = 0
  self._logTransition = true
end

function GameFsmStateNode:InitializeNode(cfg, context)
  self.super.InitializeNode(self, cfg, context)
  self._cfg = cfg
  self._entityId = context.GenInfo.EntityID
  self._callback = GameHelper:GetInstance():CreateCallback(self.OnFinish, self)
  local world = context.World
  self._world = world
  local runPos = world:GetRunningPosition()
  if runPos == WorldRunPostion.AtClient then
    self._eventDispatcher = GameGlobal.EventDispatcher()
  else
    local serverWorld = world
    self._eventDispatcher = serverWorld:EventDispatcher()
  end
end

function GameFsmStateNode:Destroy()
  self._eventDispatcher:RemoveCallbackListener(self._cfg.Event, self._callback)
  GameFsmStateNode.super.Destroy(self)
end

function GameFsmStateNode:_LogFsmDebug(stType)
  if self._world and self._world:IsDevelopEnv() and self._entityId == 0 then
    Log.info("[GameFsm] NodeName = ", string.format("%02d.<%s> %s", self._cfg.StateID, stType, self._cfg.Name))
  end
end

function GameFsmStateNode:_DetailMatchLoggerFsmEnter()
  if self._world and self._world:IsDevelopEnv() and self._entityId == 0 then
    local detailLogger = self._world:GetDetailMatchLogger()
    if detailLogger then
      detailLogger:GameFsmNodeEnter(self._cfg.StateID, self._cfg.Name)
    end
  end
end

function GameFsmStateNode:_DetailMatchLoggerFsmExit()
  if self._world and self._world:IsDevelopEnv() and self._entityId == 0 then
    local detailLogger = self._world:GetDetailMatchLogger()
    if detailLogger then
      detailLogger:GameFsmNodeExit(self._cfg.StateID, self._cfg.Name)
    end
  end
end

function GameFsmStateNode:Enter()
  if self._cfg.Event then
    if self._logTransition then
      self:_LogFsmDebug("Enter ")
      self:_DetailMatchLoggerFsmEnter()
    end
    self._eventDispatcher:AddCallbackListener(self._cfg.Event, self._callback)
    if self._entityId == 0 then
      self._eventDispatcher:Dispatch(GameEventType.RefreshMainState, self._cfg.StateID, self._cfg.Name)
    end
  end
  self.super.Enter(self)
  self._finish = 0
  self._eventDispatcher:Dispatch(self._cfg.Enter, self._entityId)
end

function GameFsmStateNode:Exit()
  self._finish = 0
  self.super.Exit(self)
  self._eventDispatcher:RemoveCallbackListener(self._cfg.Event, self._callback)
  if self._logTransition then
    self:_LogFsmDebug("Exit  ")
    self:_DetailMatchLoggerFsmExit()
  end
end

function GameFsmStateNode:CheckTransitions()
  if self._finish == 0 then
    return self.mStateID
  end
  for i, s in ipairs(self._cfg.NextState) do
    if self._finish == i then
      return s
    end
  end
end

function GameFsmStateNode:OnFinish(...)
  local args = {
    ...
  }
  if self._entityId == 0 or self._entityId == args[2] then
    self._finish = args[1]
  end
end
