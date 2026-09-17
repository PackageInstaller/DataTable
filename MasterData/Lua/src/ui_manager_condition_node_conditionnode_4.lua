local this = class("conditionNode_4", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.refresh, self)
end

function this:onDestroy()
  this.super.onDestroy(self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
end

function this.checkFunc(codData)
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(codData[2])
end

return this
