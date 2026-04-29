_class("StateBouncePlayerWalk", StateBouncePlayerBase)
StateBouncePlayerWalk = StateBouncePlayerWalk

function StateBouncePlayerWalk:OnEnter(TT, ...)
  self:Init()
  self:PlayAnim()
  if BounceDebug.ShowObjRect then
    self:ShowDebugRect()
  end
end

function StateBouncePlayerWalk:OnExit(TT)
end

function StateBouncePlayerWalk:OnJump()
  self.playerData.curSpeed = self.playerData.baseJumpSpeed
  self.player:ChgPlayerState(StateBouncePlayer.Jump)
end

function StateBouncePlayerWalk:GetStateType()
  return StateBouncePlayer.Walk
end
