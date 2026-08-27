local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementBornState = class("MovementBornState", DormFightCharacterStateBase)

function MovementBornState:OnUpdate(deltaTime)
  if self:CheckIsGrounded() then
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Idle)
  else
    self:TransferTo(DormFightConst.StateEnum.MovementLayer_Drop)
  end
end

return MovementBornState
