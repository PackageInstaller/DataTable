local DormAIStateBase = class("DormAIStateBase")
DormAIStateBase.AIExecuteState = {
  Init = 0,
  Runnig = 1,
  Fail = 2,
  End = 4
}

function DormAIStateBase:ctor(aiCtrl, actionCfg, exitAction)
  self.duration = 0
  self.exeState = DormAIStateBase.AIExecuteState.Init
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.charEntity = aiCtrl.charEntity
  self.exitAction = exitAction
  self.roomCtrl = self.charEntity.roomCharCtrl
  self.vowedFxLoopTime = 0
end

function DormAIStateBase:SetStateDuration(duration)
  self.duration = duration
end

function DormAIStateBase:StartState()
end

function DormAIStateBase:InterruptState(gotoNext)
end

function DormAIStateBase:StartExitWait(action, ...)
end

function DormAIStateBase:EnableExitState()
  return true
end

function DormAIStateBase:GetStateName()
  return ""
end

function DormAIStateBase:OnExit()
  self.exeState = DormAIStateBase.AIExecuteState.End
end

function DormAIStateBase:ExitByWaitAction(action)
  local autoNext = true
  if action ~= nil then
    autoNext = false
  end
  if self.exitAction ~= nil then
    self.exitAction(self, autoNext)
  end
  if action ~= nil then
    action(true)
  end
end

function DormAIStateBase:OnUpdate()
end

function DormAIStateBase:LoadVowedFx()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  local prefab = dormCtrl.comRes.vowedRoleHeadFxPrefab
  self.charEntity:AddVowedFx(prefab)
end

function DormAIStateBase:UpdateVowedFx()
  self.vowedFxLoopTime = self.vowedFxLoopTime + Time.deltaTime
  if self.vowedFxLoopTime >= ConfigData.game_config.dormVowedLoopTime then
    self.charEntity:ShowVowedFx(true)
    self.vowedFxLoopTime = 0
  end
end

function DormAIStateBase:SetVowedFxLoopTime(time)
  self.vowedFxLoopTime = time
end

return DormAIStateBase
