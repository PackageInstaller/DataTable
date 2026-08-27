local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementDropState = class("MovementDropState", DormFightCharacterStateBase)

function MovementDropState:OnUpdate(deltaTime)
  if self:CheckIsGrounded() then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Idle)
  end
end

return MovementDropState
