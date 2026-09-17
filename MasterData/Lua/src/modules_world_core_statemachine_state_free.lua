local this = class("state_free", require(L_R.world.core .. "stateMachine.baseState"))

function this:ctor(...)
  self.super.ctor(self, ...)
end

return this
