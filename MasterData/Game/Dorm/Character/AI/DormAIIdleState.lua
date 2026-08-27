local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIIdleState = class("DormAIIdleState", DormAIStateBase)

function DormAIIdleState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

function DormAIIdleState:GetStateName()
  return "idle"
end

function DormAIIdleState:StartState()
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  DormAIStateBase.LoadVowedFx(self)
  DormAIStateBase.SetVowedFxLoopTime(self, 0)
  self:StartNewMove()
end

function DormAIIdleState:StartNewMove()
  if self.time >= self.duration then
    self:OnExit()
    return
  end
  local ok, pos = self.charEntity:GetRandomOnePoint()
  if not ok then
    self.charEntity:AnimatorStand()
    self.exeState = DormAIStateBase.AIExecuteState.Fail
    return
  end
  local success = self.charEntity:DoMoveAStar(pos, self.__onCompleteOneMove, ConfigData.buildinConfig.DormMoveFailTimeout, true, true)
  if success then
    if self.__moveCount <= 0 then
      self.charEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
    end
    self.__moveCount = self.__moveCount + 1
  end
end

function DormAIIdleState:CompleteOneMove(success)
  if self.time >= self.duration then
    self.charEntity:DormForceStopMove()
    self:OnExit()
    return
  end
  self:StartNewMove()
end

function DormAIIdleState:StartRandToRoomOnePoint()
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  self.__moveCount = 0
  local ok, pos = self.charEntity:GetRandomOnePoint()
  if not ok then
    self:OnExit()
    return
  end
  self.duration = 0
  local success = self.charEntity:DoMoveAStar(pos, self.__onCompleteOneMove, ConfigData.buildinConfig.DormMoveFailTimeout, true, true)
end

function DormAIIdleState:OnUpdate()
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  DormAIStateBase.UpdateVowedFx(self)
  if self.exeState == DormAIStateBase.AIExecuteState.Fail then
    self:OnExit()
  end
end

function DormAIIdleState:InterruptState(gotoNext)
  TimerManager:StopTimer(self.__nextTimer)
  self.charEntity:DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return
  end
end

function DormAIIdleState:StartExitWait(action)
  self.charEntity:DormForceStopMove()
  self:OnExit(action)
end

function DormAIIdleState:OnExit(action)
  TimerManager:StopTimer(self.__nextTimer)
  self.charEntity:AnimatorStand()
  DormAIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return DormAIIdleState
