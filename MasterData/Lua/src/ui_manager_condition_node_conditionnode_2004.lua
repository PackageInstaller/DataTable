local this = class("conditionNode_2004", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.refresh, self)
end

function this:onDestroy()
  this.super.onDestroy(self)
  L_GameStore:unListenCallFunc(L_GameStore.event.enterGame, self.refresh, self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.refresh, self)
end

function this.checkFunc(condition)
  return L_PlayerStore:getLv() >= condition[2]
end

function this.descFunc(key, codData)
  return L_Lang:get(key, {
    playerlevel = codData[2]
  })
end

return this
