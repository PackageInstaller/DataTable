local this = class("conditionNode_5", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.refresh, self)
end

function this:onDestroy()
  this.super.onDestroy(self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.refresh, self)
end

function this.checkFunc(codData)
  return AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false) ~= nil
end

return this
