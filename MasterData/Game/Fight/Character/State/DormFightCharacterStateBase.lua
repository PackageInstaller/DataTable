local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = class("DormFightCharacterStateBase")

function DormFightCharacterStateBase:ctor()
  self._owner = nil
  self._layer = -1
  self._stateType = DormFightConst.StateEnum.Undefined
end

function DormFightCharacterStateBase:Init(owner, layer, stateType)
  self._owner = owner
  self._layer = layer
  self._stateType = stateType or self._stateType
  self:OnInit()
end

function DormFightCharacterStateBase:GetStateType()
  return self._stateType
end

function DormFightCharacterStateBase:GetLayer()
  return self._layer
end

function DormFightCharacterStateBase:CheckIsGrounded()
  return self._owner and self._owner:CheckIsGrounded() or false
end

function DormFightCharacterStateBase:CheckHitWall()
  return self._owner and self._owner:CheckHitWall() or false
end

function DormFightCharacterStateBase:TransferTo(stateType)
  if self._owner == nil then
    return
  end
  self._owner:TransferTo(self._layer, stateType)
end

function DormFightCharacterStateBase:OnInit()
end

function DormFightCharacterStateBase:OnEnter(prevState)
end

function DormFightCharacterStateBase:OnExit(nextState)
end

function DormFightCharacterStateBase:OnUpdate(deltaTime)
end

function DormFightCharacterStateBase:OnEvent(eventType, ...)
end

return DormFightCharacterStateBase
