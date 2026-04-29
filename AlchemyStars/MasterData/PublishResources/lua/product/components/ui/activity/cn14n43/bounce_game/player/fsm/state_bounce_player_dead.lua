_class("StateBouncePlayerDead", StateBouncePlayerBase)
StateBouncePlayerDead = StateBouncePlayerDead

function StateBouncePlayerDead:OnEnter(TT, ...)
  self:Init()
  self:PlayAnim()
  if BounceDebug.ShowObjRect then
    self:ShowDebugRect()
  end
end

function StateBouncePlayerDead:OnExit(TT)
end

function StateBouncePlayerDead:GetStateType()
  return StateBouncePlayer.Dead
end

function StateBouncePlayerDead:OnUpdate(deltaTimeMS)
  self.player:HandleMove(deltaTimeMS)
end
