local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIFntState = class("DormAIFntState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local FntStageType = {
  Initial = 0,
  MoveToInteract = 1,
  PlayStartAnimation = 2,
  LoopRunning = 3,
  PlayEndAnimation = 4,
  MoveToEmptyArea = 5,
  AllEnd = 6
}
local LogicInterval = 1
local failRetryCount = 3

function DormAIFntState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.__fntStateType = FntStageType.Initial
  self.__autoExit = false
  self.__noExitWalk = false
  self.__isOperationInteract = false
end

function DormAIFntState:GetStateName()
  return "fnt"
end

function DormAIFntState:StartState()
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  local point = self:RandOneInterPoint()
  if point == nil then
    self.exeState = DormAIStateBase.AIExecuteState.Fail
    return
  end
  self.interPoint = point.interPoint
  if not self.interPoint:GetPointActive() then
    self:OnExit()
    return
  end
  self.fntData = self.interPoint.fntData
  self.fntEntity = self.charEntity:GetBelongRoomEntity():GetFntByData(self.fntData)
  self.__interStartPos = point.pos
  self.__interDestPos = self.fntEntity.transform:TransformPoint(self.interPoint:GetInterOffsetCoord())
  if not self.charEntity:TargetPosPossible(self.__interStartPos) then
    local count = 0
    self.__retryTimerId = TimerManager:StartTimer(LogicInterval, function()
      count = count + 1
      if self.charEntity:TargetPosPossible(self.__interStartPos) then
        TimerManager:StopTimer(self.__retryTimerId)
        self:MoveToInterStartPoint()
        return
      end
      if count >= failRetryCount then
        self:OnExit()
      end
    end, nil, false, false, true)
    return
  end
  self:MoveToInterStartPoint()
end

function DormAIFntState:StateStateByInterPoint(interPoint, setPos)
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  self.interPoint = interPoint
  if not self.interPoint:GetPointActive() then
    self:OnExit()
    return
  end
  local fntEntity = self.charEntity:GetBelongRoomEntity():GetFntByData(interPoint.fntData)
  local offsetWorld = fntEntity.transform:TransformPoint(interPoint:GetInterStartCoord())
  self.fntData = self.interPoint.fntData
  self.fntEntity = fntEntity
  self.__interStartPos = offsetWorld
  self.__interDestPos = fntEntity.transform:TransformPoint(interPoint:GetInterOffsetCoord())
  if setPos then
    self.charEntity:SetUnityWorldPos(offsetWorld)
    local rot = Quaternion.Euler(0, self.interPoint:GetInterAngle() + self.fntData.r, 0)
    self.charEntity.transform.rotation = rot
  else
    self.charEntity:SetNavmeshCutActive(false)
    self.__isOperationInteract = true
    self.__interStartPosOrigin = self.__interStartPos
    self.__interStartPos = self.charEntity.transform.position
  end
  self:StartInteractFnt()
end

function DormAIFntState:RandOneInterPoint()
  local roomData = self.charEntity.roomData
  local pointRandList = {}
  for _, interPoint in pairs(roomData.interpoint) do
    if interPoint:GetPointActive() and interPoint:GetInterPointType() == self.actionCfg.interact_point_type then
      local fntEntity = self.charEntity:GetBelongRoomEntity():GetFntByData(interPoint.fntData)
      local offsetWorld = fntEntity.transform:TransformPoint(interPoint:GetInterStartCoord())
      if self.charEntity:TargetPosPossible(offsetWorld) then
        local point = {pos = offsetWorld, interPoint = interPoint}
        table.insert(pointRandList, point)
      end
    end
  end
  if #pointRandList == 0 then
    return nil
  end
  local interPoint = pointRandList[math.random(#pointRandList)]
  return interPoint
end

function DormAIFntState:MoveToInterStartPoint()
  if not self.interPoint:GetPointActive() then
    self:OnExit()
    return
  end
  local success = self.charEntity:DoMoveAStar(self.__interStartPos, BindCallback(self, self.StartInteractFnt), 0, true)
  if success then
    self.__fntStateType = FntStageType.MoveToInteract
    self.interPoint:BindInterPoint(self.charEntity)
  else
    self.exeState = DormAIStateBase.AIExecuteState.Fail
  end
end

function DormAIFntState:StartInteractFnt()
  self.interPoint:BindInterPoint(self.charEntity)
  self.__fntStateType = FntStageType.PlayStartAnimation
  self.aiCtrl:BroadcastForDormAI(DormEnum.CharacterAIEventId.StartFntInteract)
  self.time = 0
  local rot = Quaternion.Euler(0, self.interPoint:GetInterAngle() + self.fntData.r, 0)
  local animator = self.charEntity.animator
  if not IsNull(animator) then
    animator:SetFloat(AnimationConst.DormKey_IsReverse, self.interPoint:GetReverseValue())
  end
  self.charEntity:StartSmoothRotate(rot, function()
    self.charEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
    local curveId = self.interPoint:GetInterMoveCurveId()
    if 0 < curveId then
      self.charEntity:DoMoveInteractCurve(curveId, self.actionCfg.interact_action_type, self.__interDestPos)
    else
      self.charEntity.transform.position = self.__interDestPos
    end
    if 0 < self.interPoint:GetInterAnimType() then
      local fntEntity = self.charEntity:GetBelongRoomEntity():GetFntByData(self.fntData)
      if fntEntity ~= nil then
        local audioId = self.interPoint:GetInterAudioId()
        fntEntity:PlayFntAudio(audioId)
        fntEntity:CallFntCommonAnim()
        local bindTrans = fntEntity:GetFntBindTrans(self.interPoint:GetInterBindPath())
        local contraint = self.charEntity:DormAddParentConstraint()
        local source = contraint:GetSource(0)
        source.sourceTransform = bindTrans
        contraint:SetSource(0, source)
      end
    end
    self.charEntity:StartCheckAnimator(self.actionCfg.final_action, function()
      self.__fntStateType = FntStageType.LoopRunning
      if self.__autoExit then
        self.__autoExit = false
        if self.__interStartPos == nil or not DormUtil.IsPositionOnNavmesh(self.__interStartPos) then
          self.time = 0
          self.duration = LogicInterval
          self.__noExitWalk = false
          self:__CallWaitExitAction(false)
          return
        end
        self:ExitFntState()
      end
    end)
  end)
end

function DormAIFntState:OnUpdate()
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
  if self.__fntStateType == FntStageType.PlayEndAnimation or self.__fntStateType == FntStageType.MoveToEmptyArea then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.time >= self.duration then
    if self.exeState == DormAIStateBase.AIExecuteState.Fail then
      self:OnExit()
    elseif self.__interStartPos == nil then
      self.time = 0
      error("dorm interact start pos is null")
    elseif DormUtil.IsPositionOnNavmesh(self.__interStartPos) then
      self:ExitFntState()
    else
      self.time = 0
      self.duration = LogicInterval
    end
  end
end

function DormAIFntState:ExitFntState()
  self.__fntStateType = FntStageType.PlayEndAnimation
  if not string.IsNullOrEmpty(self.actionCfg.exit_trigger) then
    self.charEntity:AnimatorTrigger(self.actionCfg.exit_trigger)
  end
  local curveId = self.interPoint:GetInterExitCurveId()
  if 0 < curveId then
    self.charEntity:DoMoveInteractCurve(curveId, self.actionCfg.interact_action_type, self.__interStartPos)
  else
    self.charEntity.transform.position = self.__interStartPos
  end
  self.charEntity:StartCheckAnimator(DormEnum.DormAnimatorNormalName, function()
    if self.__noExitWalk then
      self:OnExit()
    else
      self:ExitFntToEmptyArea()
    end
  end)
end

function DormAIFntState:ExitFntToEmptyArea()
  self.aiCtrl:BroadcastForDormAI(DormEnum.CharacterAIEventId.ExitFntInteract)
  self.__fntStateType = FntStageType.MoveToEmptyArea
  self.exeState = DormAIStateBase.AIExecuteState.End
  local ok, pos = self.charEntity:GetRandomBFSPoint()
  if not ok then
    self:OnExit()
    return
  end
  local success = self.charEntity:DoMoveAStar(pos, function(success)
    if not success then
      self.charEntity:DormForceStopMove()
    end
    self:OnExit()
  end, ConfigData.buildinConfig.DormMoveFailTimeout, true)
  if not success then
    self:OnExit()
    return
  end
end

function DormAIFntState:UnBindFntInterPoint()
  if self.interPoint == nil then
    return
  end
  if self.interPoint:GetBindCharacter() == self.charEntity then
    self.interPoint:UnBindInterPoint()
    if self.interPoint:GetInterAnimType() > 0 then
      self.charEntity:DormRemoveParentConstraint()
      self.charEntity:SetLocalRotation(Quaternion.identity)
    end
    if self.fntEntity ~= nil then
      self.fntEntity:OnDormFntInterExit()
    end
  end
end

function DormAIFntState:InterruptState(gotoNext)
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
  TimerManager:StopTimer(self.__retryTimerId)
  self:UnBindFntInterPoint()
  self.charEntity:DormForceStopMove()
  self.charEntity:StopCheckAnimator()
  if gotoNext then
    if DormUtil.IsPositionOnNavmesh(self.__interStartPos) then
      self.charEntity:SetUnityWorldPos(self.__interStartPos)
    else
      local newActivePos = DormUtil.FindNearestActivePoint(self.__interStartPos)
      self.charEntity:SetUnityWorldPos(newActivePos)
    end
    self.charEntity:AnimatorStand()
    self:ExitFntToEmptyArea()
    return
  end
  self.charEntity.transform:SetLocalY(0)
end

function DormAIStateBase:StartExitWait(action, noExitWalk)
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    if action ~= nil then
      action(false)
    end
    return
  end
  TimerManager:StopTimer(self.__retryTimerId)
  self.__waitExitAction = action
  self.__noExitWalk = noExitWalk or false
  if self.__fntStateType == FntStageType.PlayStartAnimation then
    self.__autoExit = true
  elseif self.__fntStateType == FntStageType.LoopRunning then
    if self.__interStartPos == nil or not DormUtil.IsPositionOnNavmesh(self.__interStartPos) then
      if self.__isOperationInteract then
        if DormUtil.IsPositionOnNavmesh(self.__interStartPosOrigin) then
          self.__interStartPos = self.__interStartPosOrigin
          self.__interStartPosOrigin = nil
          self.__isOperationInteract = false
        else
          local newPos = DormUtil.FindNearestActivePoint(self.__interStartPos)
          if Vector3.Distance(self.__interStartPos, newPos) <= 0.3 then
            self.__interStartPos = newPos
            self.__isOperationInteract = false
          else
            self.__noExitWalk = false
            self:__CallWaitExitAction(false)
            return
          end
        end
      end
    end
    self:ExitFntState()
  elseif self.__fntStateType == FntStageType.PlayEndAnimation then
  else
    self.charEntity:DormForceStopMove()
    self:OnExit()
  end
end

function DormAIFntState:EnableExitState()
  if self.interPoint ~= nil and self.interPoint:GetInterAnimType() > 0 then
    return false
  end
  if (self.__fntStateType == FntStageType.PlayStartAnimation or self.__fntStateType == FntStageType.LoopRunning) and (self.__interStartPos == nil or not DormUtil.IsPositionOnNavmesh(self.__interStartPos)) then
    return false
  end
  return true
end

function DormAIFntState:__CallWaitExitAction(success)
  if self.__waitExitAction == nil then
    return
  end
  local waitExitAction = self.__waitExitAction
  self.__waitExitAction = nil
  waitExitAction(success)
end

function DormAIFntState:OnExit()
  TimerManager:StopTimer(self.__retryTimerId)
  TimerManager:StopTimer(self.__fixPosTimer)
  self.__fntStateType = FntStageType.AllEnd
  self.exeState = DormAIStateBase.AIExecuteState.End
  self:UnBindFntInterPoint()
  DormAIStateBase.OnExit(self)
  self:ExitByWaitAction(self.__waitExitAction)
end

return DormAIFntState
