local this = class("cellDayUnlock", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventStore = L_GameEventStore

function this.bind()
  return {
    uid = -1,
    txtDay = "",
    activeLock = false,
    activeComplete = false,
    reddot = false
  }
end

function this.methods()
  return {}
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:open()
end

function this:close()
end

return this
