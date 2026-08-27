local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local HallFairyAIThinkState = class("HallFairyAIThinkState", AIStateBase)

function HallFairyAIThinkState:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
  self.fairyEntity = self.aiCtrl.hallFairyEntity
end

function HallFairyAIThinkState:GetStateName()
  return "stand"
end

function HallFairyAIThinkState:StartState()
  self.fairyEntity:GetCharAStarComp():SetNavMeshCutEnabled(true)
  self.exeState = AIStateBase.AIExecuteState.Runnig
  self.fairyEntity:AnimatorCrossFade(self.actionCfg.action_name, self.actionCfg.trans_time)
  self.fairyEntity:ShowRandomEmoji(self.actionCfg.emoji)
end

function HallFairyAIThinkState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.time >= self.duration then
    self:OnExit()
  end
end

function HallFairyAIThinkState:InterruptState(gotoNext)
  if gotoNext then
    self:OnExit()
    return
  end
end

function HallFairyAIThinkState:StartExitWait(action)
  self.fairyEntity:HideEmoji()
  self:OnExit(action)
end

function HallFairyAIThinkState:OnExit(action)
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return HallFairyAIThinkState
