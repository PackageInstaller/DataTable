require("state_bounce_player_base")
_class("StateBouncePlayerAttack", StateBouncePlayerBase)
StateBouncePlayerAttack = StateBouncePlayerAttack

function StateBouncePlayerAttack:OnEnter(TT, ...)
  self:Init()
  local duration = self:PlayAnim()
  if BounceDebug.ShowObjRect then
    self:ShowDebugRect()
  end
  YIELD(TT, duration)
  self.player:ChgPlayerState(StateBouncePlayer.Walk)
end

function StateBouncePlayerAttack:OnExit(TT)
end

function StateBouncePlayerAttack:GetStateType()
  return StateBouncePlayer.Attack
end
