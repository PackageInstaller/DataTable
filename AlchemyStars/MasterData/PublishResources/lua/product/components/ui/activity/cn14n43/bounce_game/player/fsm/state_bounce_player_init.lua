_class("StateBouncePlayerInit", StateBouncePlayerBase)
StateBouncePlayerInit = StateBouncePlayerInit

function StateBouncePlayerInit:OnEnter(TT, ...)
  self:Init()
  self.player:ChgPlayerState(StateBouncePlayer.Walk)
end

function StateBouncePlayerInit:OnExit(TT)
end

function StateBouncePlayerInit:GetStateType()
  return StateBouncePlayer.Init
end
