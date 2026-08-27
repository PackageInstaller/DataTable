local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local HallFairyAIStandState = class("HallFairyAIStandState", AIStateBase)

function HallFairyAIStandState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.fairyEntity = self.aiCtrl.hallFairyEntity
end

function HallFairyAIStandState:GetStateName()
  return "stand"
end

function HallFairyAIStandState:StartState()
  self.fairyEntity:GetCharAStarComp():SetNavMeshCutEnabled(true)
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.fairyEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
end

function HallFairyAIStandState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.time >= self.duration then
    self:OnExit()
  end
end

function HallFairyAIStandState:InterruptState(gotoNext)
  if gotoNext then
    self:OnExit()
    return
  end
end

function HallFairyAIStandState:StartExitWait(action)
  self:OnExit(action)
end

function HallFairyAIStandState:OnExit(action)
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return HallFairyAIStandState
