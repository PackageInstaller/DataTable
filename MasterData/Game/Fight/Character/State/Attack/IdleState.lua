local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackIdleState = class("AttackIdleState", DormFightCharacterStateBase)

function AttackIdleState:OnEnter(prevState)
end

function AttackIdleState:OnEvent(eventType, arg1)
  if eventType == DormFightConst.EventEnum.Hit then
    self._owner:Hit(arg1)
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_Hit)
  elseif eventType == DormFightConst.EventEnum.KnockOut then
    self._owner:KnockOut(arg1)
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_KnockOut)
  elseif eventType == DormFightConst.EventEnum.Attack then
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_Attack)
  end
end

return AttackIdleState
