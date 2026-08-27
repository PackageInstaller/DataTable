local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIStandState = class("DormAIStandState", DormAIStateBase)

function DormAIStandState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
end

function DormAIStandState:GetStateName()
  return "stand"
end

function DormAIStandState:StartState()
  DormAIStateBase.LoadVowedFx(self)
  DormAIStateBase.SetVowedFxLoopTime(self, 0)
  self.charEntity:GetCharAStarComp():SetNavMeshCutEnabled(true)
  self.exeState = DormAIStateBase.AIExecuteState.Runnig
  self.charEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
end

function DormAIStandState:OnUpdate()
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  DormAIStateBase.UpdateVowedFx(self)
  if self.time >= self.duration then
    self:OnExit()
  end
end

function DormAIStandState:InterruptState(gotoNext)
  if gotoNext then
    self:OnExit()
    return
  end
end

function DormAIStandState:StartExitWait(action)
  self:OnExit(action)
end

function DormAIStandState:OnExit(action)
  DormAIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return DormAIStandState
