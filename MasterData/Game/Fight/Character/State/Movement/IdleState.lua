local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementIdleState = class("MovementIdleState", DormFightCharacterStateBase)

function MovementIdleState:OnEnter(prevState)
  local animatorCtrl = self._owner:GetFeature(DormFightConst.FeatureEnum.AnimatorController)
  if animatorCtrl ~= nil then
    animatorCtrl:PlayIdleAnimation()
  end
end

function MovementIdleState:OnEvent(eventType, arg1)
  if eventType == DormFightConst.EventEnum.Move then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Move)
  elseif eventType == DormFightConst.EventEnum.Run then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Run)
  elseif eventType == DormFightConst.EventEnum.KnockOut then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_KnockOut)
  end
end

return MovementIdleState
