_class("StateBouncePlayerDown", StateBouncePlayerBase)
StateBouncePlayerDown = StateBouncePlayerDown

function StateBouncePlayerDown:OnEnter(TT, ...)
  self:Init()
  self:PlayAnim()
  if BounceDebug.ShowObjRect then
    self:ShowDebugRect()
  end
  self.viewBehavior = self.player:GetBehavior(BouncePlayerBeHaviorView:Name())
end

function StateBouncePlayerDown:OnExit(TT)
end

function StateBouncePlayerDown:OnJump()
  local duration = self.bounceData.durationMs
  if self.playerData:ChecAirkAttackCD(duration, true) then
    self.playerData.curSpeed = self.playerData.airJumpSpeed
    self.player:ChgPlayerState(StateBouncePlayer.JumpAttack)
  end
end

function StateBouncePlayerDown:OnAttack()
  if self.playerData.curSpeed > self.playerData.accDownSpeed then
    self.playerData.curSpeed = self.playerData.accDownSpeed
  end
  self.player:ChgPlayerState(StateBouncePlayer.AccDown)
end

function StateBouncePlayerDown:OnUpdate(deltaTimeMS)
  self.player:HandleMove(deltaTimeMS, true)
end

function StateBouncePlayerDown:GetStateType()
  return StateBouncePlayer.Down
end
