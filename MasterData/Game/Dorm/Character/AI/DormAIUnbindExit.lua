local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIUnbindExit = class("DormAIUnbindExit", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")

function DormAIUnbindExit:ctor(aiCtrl, actionCfg, exitAction)
  self.time = 0
end

function DormAIUnbindExit:GetStateName()
  return "unbindExit"
end

function DormAIUnbindExit:StartState()
  local wallId, worldPos, startPos = self.charEntity:GetBelongRoomEntity():GetRoomDoorPos()
  local success = self.charEntity:DoMoveAStar(startPos, function()
    local rot = DormUtil.GetDormWallRot(wallId, true)
    self.charEntity:StartSmoothRotate(rot, function()
      self.charEntity:DoMoveUnityPos(worldPos, function()
        self.charEntity:StartExChangeUnBindChar()
      end)
    end)
  end)
  return success
end

function DormAIUnbindExit:OnUpdate()
  if self.exeState == DormAIStateBase.AIExecuteState.End then
    return
  end
end

function DormAIUnbindExit:InterruptState(gotoNext)
  self.charEntity:DormForceStopMove()
  if gotoNext then
    self:OnExit()
    return
  end
end

function DormAIUnbindExit:StartExitWait(action)
  self.charEntity:DormForceStopMove()
  self:OnExit(action)
end

function DormAIUnbindExit:OnExit(action)
  self.charEntity:AnimatorStand()
  DormAIStateBase.OnExit(self)
  self:ExitByWaitAction(action)
end

return DormAIUnbindExit
