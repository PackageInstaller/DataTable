_class("StateBounceBattle", StateBounceBase)
StateBounceBattle = StateBounceBattle

function StateBounceBattle:OnEnter(TT, ...)
  self:Init()
end

function StateBounceBattle:OnExit(TT)
end

function StateBounceBattle:OnUpdate(deltaTimeMS)
  self.bounceData.durationMs = self.bounceData.durationMs + deltaTimeMS
  for k, v in pairs(self.monsterGenerator) do
    v:OnUpdate(deltaTimeMS)
  end
  self.objMgr:OnUpdate(deltaTimeMS)
end

function StateBounceBattle:OnJump()
  self:GetPlayer():OnJump()
end

function StateBounceBattle:OnAttack()
  self:GetPlayer():OnAttack()
end
