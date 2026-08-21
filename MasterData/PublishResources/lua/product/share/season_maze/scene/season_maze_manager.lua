_class("SeasonMazeManager", Object)
SeasonMazeManager = SeasonMazeManager

function SeasonMazeManager:Constructor(mazeID)
  self._seasonMazeID = mazeID
  self._module = GameGlobal.GetModule(SeasonMazeModule)
  self._factory = SMazeFactory:New(self)
  self._seasonMazeRelicManager = SMazeRelicManager:New(self)
  self._seasonMazeCoverManager = SeasonMazeCoverManager:New()
  self._seasonMazeSceneManager = SeasonMazeSceneManager:New()
  self._seasonMazeCameraManager = SeasonMazeCameraManager:New()
  self._seasonMazeInputManager = SeasonMazeInputManager:New(self)
  self._seasonMazeAudioManager = SeasonMazeAudioManager:New()
  self._mazeMapManager = SMazeMapManager:New(self)
  self._stateMachine = SMazeStateMachine:New(self)
  self._seasonMazePlayer = SeasonMazePlayer:New(self)
  self._seasonEftPlayer = SMazeEffectPlayer:New(self)
end

function SeasonMazeManager:Init()
  self._seasonMazeRelicManager:Init(self._seasonMazeID)
  self._seasonMazeCoverManager:OnInit()
  self._seasonMazeSceneManager:OnInit()
  self._mazeMapManager:OnInit(self._seasonMazeSceneManager)
  self._seasonMazeCameraManager:OnInit(self._seasonMazeID)
  self._seasonMazeInputManager:OnInit()
  self._seasonMazeAudioManager:OnInit()
  self._seasonMazePlayer:OnInit(self._seasonMazeID)
  self._stateMachine:Init()
end

function SeasonMazeManager:GetCurState()
  return self._stateMachine:CurState()
end

function SeasonMazeManager:Update(dt)
  self._seasonMazeCoverManager:Update(dt)
  self._seasonMazeSceneManager:Update(dt)
  self._seasonMazeCameraManager:Update(dt)
  self._seasonMazeInputManager:Update(dt)
  self._seasonMazeAudioManager:Update(dt)
  self._mazeMapManager:Update(dt)
  self._stateMachine:Update(dt)
  self._seasonMazePlayer:Update(dt)
  self._seasonEftPlayer:Update(dt)
end

function SeasonMazeManager:Dispose()
  self._seasonEftPlayer:Dispose()
  self._seasonMazePlayer:Dispose(true)
  self._stateMachine:Dispose()
  self._mazeMapManager:Dispose()
  self._seasonMazeAudioManager:Dispose()
  self._seasonMazeInputManager:Dispose()
  self._seasonMazeCameraManager:Dispose()
  self._seasonMazeSceneManager:Dispose()
  self._seasonMazeCoverManager:Dispose()
  self._seasonMazeRelicManager:Dispose()
  self._factory:Dispose()
  self._seasonMazeID = nil
end

function SeasonMazeManager:GetCurState()
  return self._stateMachine:CurState()
end

function SeasonMazeManager:SeasonMazeCoverManager()
  return self._seasonMazeCoverManager
end

function SeasonMazeManager:SeasonMazeSceneManager()
  return self._seasonMazeSceneManager
end

function SeasonMazeManager:SeasonMazeCameraManager()
  return self._seasonMazeCameraManager
end

function SeasonMazeManager:SeasonMazeInputManager()
  return self._seasonMazeInputManager
end

function SeasonMazeManager:SeasonMazeAudioManager()
  return self._seasonMazeAudioManager
end

function SeasonMazeManager:MapManager()
  return self._mazeMapManager
end

function SeasonMazeManager:Factory()
  return self._factory
end

function SeasonMazeManager:Player()
  return self._seasonMazePlayer
end

function SeasonMazeManager:GetSeasonID()
  return self._seasonID
end

function SeasonMazeManager:OnClickArrow(go)
  local state = self._stateMachine:CurState()
  if state:StateID() == SMazeStateID.PlayerMove then
    state:OnChooseFork(go)
  else
    Log.error("严重错误 当前不是移动状态 不可选择岔路:", state:StateID())
  end
end

function SeasonMazeManager:OnClickRoom(go)
  Log.info("点击路点:", go.name)
  local node = self._mazeMapManager:GetRoomByGameObject(go)
  if not node then
    local transpointNode = self._mazeMapManager:GetTransportPointByGameObject(go)
    if transpointNode then
      return self:OnClickTransportPointNode(transpointNode)
    else
      Log.error("找不到房间对象")
      return
    end
  end
  if not self._selectBomb then
    if node:Reachable() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeClickRoom, node:Room():Type(), node:Room():ID(), node:Position())
    end
    return
  end
  if node:Room():Type() == SeasonMazeRoomType.SMRT_PVE then
    local battleRoom = node:Room()
    if battleRoom:IsDestroyedByBomb() then
      Log.info("战斗房已经被炸掉了:", node:ID())
    else
      Log.info("选择炸弹目标:", node:ID())
      local canReach = true
      if canReach then
        SMazeAdaptor.OnUseBombSelect(node)
      else
        Log.info("选择的是不可到达的战斗房 不处理:", node:ID())
      end
    end
  else
    Log.info("选择的不是战斗房 不处理:", node:ID())
  end
end

function SeasonMazeManager:OnClickTransportPointNode(node)
  if node:ReachableForTranspoint() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeClickTransportPoint, node:Position())
  end
end

function SeasonMazeManager:GetMazeComponent()
  return self._module:CurSeasonObj():GetMazeComponent()
end

function SeasonMazeManager:GetAttrsDeltaByReason(reason)
  return self._module:GetAttrsByReason(reason)
end

function SeasonMazeManager:Lock(name)
  if string.isnullorempty(name) then
    Log.error("Lock key is nil:", debug.traceback())
    return
  end
  Log.info("[SMazeClient] 锁定:", name)
  self._seasonMazeInputManager:LockInput(name)
end

function SeasonMazeManager:UnLock(name)
  if string.isnullorempty(name) then
    Log.error("UnLock key is nil:", debug.traceback())
    return
  end
  Log.info("[SMazeClient] 解锁:", name)
  self._seasonMazeInputManager:UnlockInput(name)
end

function SeasonMazeManager:SeasonMazeID()
  return self._seasonMazeID
end

function SeasonMazeManager:StartSelectBombTarget()
  self._selectBomb = true
  local nodes = self._mazeMapManager:GetNodes(function(node)
    return node:Room():Type() == SeasonMazeRoomType.SMRT_PVE and node:Reachable()
  end)
  for _, node in ipairs(nodes) do
    node:SetHighLight(true)
  end
end

function SeasonMazeManager:SelectBombTarget(target)
  local nodes = self._mazeMapManager:GetNodes(function(node)
    return node:Room():Type() == SeasonMazeRoomType.SMRT_PVE and node:Reachable()
  end)
  for _, node in ipairs(nodes) do
    if node:ID() ~= target:ID() then
      node:SetHighLight(false)
    else
      node:PlayHighLightForce()
    end
  end
end

function SeasonMazeManager:CancelSelectBombTarget()
  self._selectBomb = false
  local nodes = self._mazeMapManager:GetNodes(function(p)
    local node = p
    return node:Room():Type() == SeasonMazeRoomType.SMRT_PVE and node:Reachable()
  end)
  for _, node in ipairs(nodes) do
    node:SetHighLight(false)
  end
end

function SeasonMazeManager:PlayToast(assets)
  local controller = GameGlobal.UIStateManager():GetController("UISeasonMazeScene")
  controller:GetToastTimeline(assets)
end

function SeasonMazeManager:PlayEZTL(tl)
  if tl and self._seasonEftPlayer then
    self._seasonEftPlayer:Play(tl)
  end
end

function SeasonMazeManager:GetCurNode()
  return self._stateMachine:GetCurNode()
end

function SeasonMazeManager:RelicManager()
  return self._seasonMazeRelicManager
end

function SeasonMazeManager:PlayGetGold(TT, goldCount)
  local pos = self:Player():Position()
  self:Player():PlayEffectWithParent("GetGold", self:Player():AgentTansform())
end
