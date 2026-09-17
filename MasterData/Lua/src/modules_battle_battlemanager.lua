local this = class("battleManager", G_EventManagerBase)
this.event = {
  battleEnter = "battleEnter",
  battleStart = "battleStart",
  exitBattle = "exitBattle",
  tmpPauseInput = "tmpPauseInput"
}

function this:ctor()
  this.super.ctor(self)
end

function this:sendBattleEvent(eventName, ...)
  self:sendEvent(eventName, ...)
end

function this:dispose()
end

return this
