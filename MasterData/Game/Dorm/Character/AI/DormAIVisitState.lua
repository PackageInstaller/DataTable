local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIVisitState = class("DormAIVisitState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")

function DormAIVisitState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.isFail = false
end

function DormAIVisitState:GetStateName()
  return "visit"
end

function DormAIVisitState:BindVisitAction(action)
  self.__visitExitAction = action
end

function DormAIVisitState:StartState()
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  local wallId, worldPos, startPos = self.charEntity:GetBelongRoomEntity():GetRoomDoorPos()
  local success = self.charEntity:DoMoveAStar(startPos, function()
    local rot = DormUtil.GetDormWallRot(wallId, true)
    self.charEntity:StartSmoothRotate(rot, function()
      self.charEntity:DoMoveUnityPos(startPos, BindCallback(self, self.VisitOtherDormRoom))
    end)
  end)
  if success then
    self.charEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
  else
    self.charEntity:AnimatorStand()
    self.exeState = DormAIStateBase.AIExecuteState.Fail
  end
end

function DormAIVisitState:DirectExitRoom(action)
  local wallId, worldPos, startPos = self.charEntity:GetBelongRoomEntity():GetRoomDoorPos()
  local rot = DormUtil.GetDormWallRot(wallId, true)
  self.charEntity:StartSmoothRotate(rot, function()
    self.charEntity:DoMoveUnityPos(worldPos, BindCallback(self, self.VisitOtherDormRoom))
    if action then
      action()
    end
  end)
end

function DormAIVisitState:VisitOtherDormRoom()
  self.charEntity:SetMoveAniSpeed(0)
  self:OnExit(self.__visitExitAction)
end

function DormAIVisitState:OnUpdate()
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.time >= self.duration and self.exeState == DormAIStateBase.AIExecuteState.Fail then
    self:OnExit()
  end
end

function DormAIVisitState:InterruptState(gotoNext)
  self.charEntity:DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return
  end
end

function DormAIVisitState:StartExitWait(action)
  self.charEntity:DormForceStopMove()
  self:OnExit(action)
end

function DormAIVisitState:OnExit(action)
  self.charEntity:AnimatorStand()
  DormAIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return DormAIVisitState
