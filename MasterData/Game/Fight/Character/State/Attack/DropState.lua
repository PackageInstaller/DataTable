local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackDropState = class("AttackDropState", DormFightCharacterStateBase)

function AttackDropState:OnUpdate(deltaTime)
  if self:CheckIsGrounded() then
    self:TransferTo(DormFightConst.StateEnum.AttackLayer_Idle)
  end
end

return AttackDropState
