require("s_maze_state_base")
_class("SMazeState_PlayerMove", SMazeStateBase)
SMazeState_PlayerMove = SMazeState_PlayerMove

function SMazeState_PlayerMove:OnEnter(actPoint, roomTrans)
  self._sourceNode = self._machine:GetCurNode()
  self._actPoint = actPoint
  self._actIdx = -1
  self._speed = Cfg.cfg_season_maze_client[self._manager:SeasonMazeID()].PlayerSpeed
  self._targetNode = nil
  self._bRoomTrans = roomTrans
  self._transfortTarget = nil
  if self._bRoomTrans then
    local targetId = self._sourceNode:TransRoomTargetID()
    self._transfortTarget = self._manager:MapManager():GetNode(targetId)
  end
  self._player = self._manager:Player()
  self._movement = SMazePathMovement:New(self._player, self._speed)
  self._camera = self._manager:SeasonMazeCameraManager():Camera()
  local controller = GameGlobal.UIStateManager():GetController("UISeasonMazeScene")
  self._roundTip = controller:GetRoundTip()
  self._subState = {
    Moving = 1,
    Choosing = 2,
    None = 3
  }
  self._arrowPool = {}
  self._lockKey = "SeasonMazeMoveLock"
  self:_OnArrive(self._sourceNode, true)
  if not self._bRoomTrans then
    self._roundTip:DoShow(self._camera, self._player:HeadPosition(), self._actPoint - self._actIdx)
  end
end

function SMazeState_PlayerMove:OnUpdate(dt)
  if self._isTransformEffect or self._bRoomTrans then
    return
  end
  if self._state == self._subState.Moving then
    self._player:PlayStepAudio(dt)
    self._movement:Update(dt)
    self._roundTip:UpdatePos(self._player:HeadPosition())
    self._player:RotateToPosition(self._movement:Target(), 0.2)
    if self._movement:BeFinished() then
      self._manager:SeasonMazeCameraManager():SeasonCamera():Focus(self._player:Position())
      self._manager:UnLock(self._lockKey)
      self:_OnArrive(self._targetNode)
      self._roundTip:ChangeRound(self._actPoint - self._actIdx)
      if self._state == self._subState.Moving then
        self._movement:Update(dt)
        self._roundTip:UpdatePos(self._player:HeadPosition())
      end
    end
  elseif self._state == self._subState.Choosing then
    self._roundTip:UpdatePos(self._player:HeadPosition())
  end
end

function SMazeState_PlayerMove:TransformPosEffect(cb)
  local tls = {}
  local lock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():Lock("SMazeState_PlayerMove:TransformPosEffect")
  end, "锁屏")
  table.insert(tls, lock)
  local para = EZTL_Parallel:New({
    EZTL_Sequence:New({
      EZTL_Wait:New(100, "等0.1秒"),
      EZTL_Callback:New(function()
        self._player:GetModelGameObject():SetActive(false)
      end, "隐藏")
    }),
    EZTL_Callback:New(function()
      local pos = self._player:Position()
      self._player:PlayEffect("TransStartPoint", pos)
    end, "加载资源"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransStartPoint", 0.7)
    end, "黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para)
  local callback = EZTL_Callback:New(function()
    if cb then
      cb()
    end
  end, "传送")
  table.insert(tls, callback)
  local para2 = EZTL_Parallel:New({
    EZTL_Callback:New(function()
      local pos = self._player:Position()
      self._player:PlayEffect("TransEndPoint", pos)
    end, "显示特效"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransEndPoint", 0.7)
    end, "取消黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para2)
  local unlock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():UnLock("SMazeState_PlayerMove:TransformPosEffect")
  end, "解锁")
  table.insert(tls, unlock)
  local seq = EZTL_Sequence:New(tls)
  self._manager:PlayEZTL(seq)
end

function SMazeState_PlayerMove:_OnArrive(node, onEnter)
  if node:IsTransfortPoint() or self._bRoomTrans then
    self._isTransformEffect = true
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    node:SetState(SMazeNodeState.UnReachable, false)
    self:TransformPosEffect(function()
      self._player:GetModelGameObject():SetActive(true)
      self._player:PlayAnimation(SeasonMazePlayerAnimation.Move)
      local target = self._transfortTarget
      self._transfortTarget = nil
      self._targetNode = target
      self._player:SetPos(target:Position())
      self._player:MoveFollowerImmidiately()
      if not self._bRoomTrans then
        self._roundTip:UpdatePos(self._player:HeadPosition())
      end
      self._manager:SeasonMazeCameraManager():SeasonCamera():Focus(target:Position())
      self._manager:SeasonMazeCameraManager():SeasonCamera():ChangePos(target:Position())
      node:SetState(SMazeNodeState.UnReachable, false)
      if self._bRoomTrans then
        if self._bRoomTrans then
          self._roundTip:DoHide()
        end
        self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
        self._manager:MapManager():RefreshLinkState(self._targetNode:ID(), SMazeNodeState.StayTemp)
        self._machine:SetCurNode(self._targetNode)
        self._machine:ChangeStateTo(SMazeState_ArriveRoom, self._sourceNode, self._targetNode)
        return
      end
      self:_OnArrive(target, false)
      self._isTransformEffect = false
    end)
    return
  end
  self._actIdx = self._actIdx + 1
  self._roundTip:ChangeRound(self._actPoint - self._actIdx)
  if node:Room():Type() == SeasonMazeRoomType.SMRT_Camp then
    self:_Log("到达营地 剩余行动力:", self._actPoint - self._actIdx)
    self._machine:SetCurNode(node)
    node:OnCross()
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    self._manager:MapManager():RefreshLinkState(node:ID(), SMazeNodeState.StayTemp)
    self._roundTip:DoHide()
    self._state = self._subState.None
    self._player:SetPos(node:Position())
    self._machine:ChangeStateTo(SMazeState_ArriveRoom, self._sourceNode, node)
    return
  elseif node:ForceSettle() and self:GetNodeState(node) < SeasonMazePointStateType.SMPST_Choose then
    self:_Log("到达强制结算的路点 剩余行动力:", self._actPoint - self._actIdx)
    self._machine:SetCurNode(node)
    node:OnCross()
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    self._manager:MapManager():RefreshLinkState(node:ID(), SMazeNodeState.StayTemp)
    self._roundTip:DoHide()
    self._state = self._subState.None
    self._player:SetPos(node:Position())
    self._machine:ChangeStateTo(SMazeState_ArriveRoom, self._sourceNode, node)
    return
  end
  if self._actIdx >= self._actPoint then
    self._machine:SetCurNode(self._targetNode)
    self._targetNode:OnCross()
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    self._manager:MapManager():RefreshLinkState(self._targetNode:ID(), SMazeNodeState.StayTemp)
    self._roundTip:DoHide()
    self._state = self._subState.None
    self._player:SetPos(self._targetNode:Position())
    self._machine:ChangeStateTo(SMazeState_ArriveRoom, self._sourceNode, self._targetNode)
    return
  end
  local nexts = node:NextPoints()
  if 1 < #nexts then
    if onEnter then
    else
      node:OnCross()
    end
    self:_SetFork(node)
    self._choosingNode = node
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    self._state = self._subState.Choosing
  else
    if #nexts == 1 then
      if onEnter then
        self._player:PlayAnimation(SeasonMazePlayerAnimation.Move)
        node:SetState(SMazeNodeState.UnReachable)
      else
        node:OnCross()
        self._machine:SetCurNode(node)
        self._manager:MapManager():RefreshLinkState(node:ID(), SMazeNodeState.UnReachable)
      end
      local next = nexts[1]
      if node:TransportID() then
        local transfortNode = self._manager:MapManager():GetTransportPointByID(node:TransportID())
        local points = {
          transfortNode:Position()
        }
        self._targetNode = transfortNode
        self._transfortTarget = next
        self._movement:Start(points)
        self._state = self._subState.Moving
        self._manager:SeasonMazeCameraManager():SeasonCamera():SwitchMode(SeasonCameraMode.Follow)
        self._manager:Lock(self._lockKey)
      else
        local points = {}
        local dumpPoints = node:GetDumpLinePoint()
        for k, dumpNode in pairs(dumpPoints) do
          table.insert(points, dumpNode:Position())
        end
        table.insert(points, next:Position())
        self._targetNode = next
        self._movement:Start(points)
        self._state = self._subState.Moving
        self._manager:SeasonMazeCameraManager():SeasonCamera():SwitchMode(SeasonCameraMode.Follow)
        self._manager:Lock(self._lockKey)
      end
    else
    end
  end
end

function SMazeState_PlayerMove:_SetFork(node)
  self._arrow2Node = {}
  local targets = node:NextPoints()
  for _, target in pairs(targets) do
    local arrow = self:_CreateArrow(node, target)
    local anim = arrow:GetComponent(typeof(UnityEngine.Animation))
    anim:Play("pfb_Scene_arrows_in")
    anim:PlayQueued("pfb_Scene_arrows_loop")
    self._arrow2Node[arrow] = target
  end
end

function SMazeState_PlayerMove:_CreateArrow(source, target)
  local go
  local count = #self._arrowPool
  if count == 0 then
    go = self:LoadPrefab("pfb_Scene_arrows")
  else
    go = self._arrowPool[count]
    self._arrowPool[count] = nil
    go:SetActive(true)
  end
  go.layer = SMazeSceneLayer.Arrow
  local tr = go.transform
  local defaultRot = Quaternion.Euler(-43.6, 2.7, -2.4)
  local pos = source:Position()
  local tar = target:Position()
  local p0 = tar
  local v = Vector3.up
  local n = Vector3.up * defaultRot
  local a = pos
  local t = (n.x * (a.x - p0.x) + n.y * (a.y - p0.y) + n.z * (a.z - p0.z)) / (n.x * v.x + n.y * v.y + n.z * v.z)
  local tt = p0 + v * t
  tr.rotation = Quaternion.LookRotation(tt - pos, n)
  tr.position = pos
  return go
end

function SMazeState_PlayerMove:OnChooseFork(arrow)
  if not self._state == self._subState.Choosing then
    return
  end
  self:StartTask(self._ReqChooseFork, self, arrow)
end

function SMazeState_PlayerMove:_ReqChooseFork(TT, arrow)
  local next = self._arrow2Node[arrow]
  if not next then
    self:_LogError("无法确定选择的目标")
    return
  end
  self:_Log("选择岔路:", next:ID())
  local cpt = self._manager:GetMazeComponent()
  local res = AsyncRequestRes:New()
  self._manager:Lock("SMazeState_PlayerMove.HandleSeasonMazeGoPoint")
  cpt:HandleSeasonMazeGoPoint(TT, res, next:ID(), true)
  self._manager:UnLock("SMazeState_PlayerMove.HandleSeasonMazeGoPoint")
  if res:GetSucc() then
    for key, _ in pairs(self._arrow2Node) do
      local anim = key:GetComponent(typeof(UnityEngine.Animation))
      if key == arrow then
        anim:Play("pfb_Scene_arrows_touch_out")
      else
        anim:Play("pfb_Scene_arrows_out")
      end
    end
    self._manager:Lock("SMazeState_PlayerMove.WaitArrowAnim")
    YIELD(TT, 300)
    self._manager:UnLock("SMazeState_PlayerMove.WaitArrowAnim")
    self._targetNode = next
    local points = {
      self._targetNode:Position()
    }
    self._movement:Start(points)
    self._player:PlayAnimation(SeasonMazePlayerAnimation.Move)
    self._state = self._subState.Moving
    self._manager:SeasonMazeCameraManager():SeasonCamera():SwitchMode(SeasonCameraMode.Follow)
    self._manager:MapManager():RefreshLinkState(next:ID(), SMazeNodeState.Reachable)
    self._manager:Lock(self._lockKey)
    self._choosingNode = nil
    for go, _ in pairs(self._arrow2Node) do
      go:SetActive(false)
      self._arrowPool[#self._arrowPool + 1] = go
    end
    self._arrow2Node = nil
  else
    self:_LogError("选择岔路失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end
