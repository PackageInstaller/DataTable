local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local HallFairyAIMoveState = class("HallFairyAIMoveState", AIStateBase)

function HallFairyAIMoveState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.fairyEntity = self.aiCtrl.hallFairyEntity
  self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

function HallFairyAIMoveState:GetStateName()
  return "move"
end

function HallFairyAIMoveState:StartState()
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  self:StartNewMove()
end

function HallFairyAIMoveState:StartNewMove()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  local ok, pos = self.fairyEntity:GetRandomOnePoint()
  if not ok then
    self.fairyEntity:AnimatorStand()
    self.exeState = AIStateBase.AIExecuteState.Fail
    return
  end
  local success = self.fairyEntity:DoMoveAStar(pos, self.__onCompleteOneMove, ConfigData.buildinConfig.DormMoveFailTimeout, true, true)
  if success then
    if self.__moveCount <= 0 then
      self.fairyEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
    end
    self.__moveCount = self.__moveCount + 1
  end
end

function HallFairyAIMoveState:CompleteOneMove(success)
  if self.time >= self.duration then
    self.fairyEntity:DormForceStopMove()
    self:OnExit()
    return
  end
  self:StartNewMove()
end

function HallFairyAIMoveState:StartRandToRoomOnePoint()
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  local ok, pos = self.fairyEntity:GetRandomOnePoint()
  if not ok then
    self:OnExit()
    return
  end
  self.duration = 0
  local success = self.fairyEntity:DoMoveAStar(pos, self.__onCompleteOneMove, ConfigData.buildinConfig.DormMoveFailTimeout, true, true)
end

function HallFairyAIMoveState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  self.time = self.time + Time.deltaTime
  if self.exeState == AIStateBase.AIExecuteState.Fail then
    self:OnExit()
  end
end

function HallFairyAIMoveState:InterruptState(gotoNext)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return
  end
end

function HallFairyAIMoveState:StartExitWait(action)
  self.fairyEntity:DormForceStopMove()
  self:OnExit(action)
end

function HallFairyAIMoveState:OnExit(action)
  TimerManager:StopTimer(self.__nextTimer)
  self.fairyEntity:AnimatorStand()
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return HallFairyAIMoveState
