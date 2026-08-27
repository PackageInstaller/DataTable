local AIStateBase = require("Game.Dorm.Character.AI.Base.AIStateBase")
local LittleManAIStandState = class("LittleManAIStandState", AIStateBase)

function LittleManAIStandState:ctor(littleManCtrl, actionCfg, exitAction)
  self.time = 0
  self.littleManCtrl = littleManCtrl
  self.actionCfg = actionCfg
  self.littleMan = littleManCtrl.littleMan
end

function LittleManAIStandState:GetStateName()
  return "littleman_stand"
end

function LittleManAIStandState:StartState()
  self.littleMan:Stand()
  self.exeState = AIStateBase.AIExecuteState.Runnig
end

function LittleManAIStandState:OnUpdate()
  if self.exeState == AIStateBase.AIExecuteState.End then
    return
  end
  self.time = self.time + Time.deltaTime
  if self.time >= self.duration then
    self:OnExit()
  end
end

function LittleManAIStandState:InterruptState(gotoNext)
  if gotoNext then
    self:OnExit()
    return
  end
end

function LittleManAIStandState:StartExitWait(action)
  self:OnExit(action)
end

function LittleManAIStandState:OnExit(action)
  AIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return LittleManAIStandState
