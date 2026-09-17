local this = class("homeDormManager", G_EventManagerBase)
this.event = {}

function this:ctor()
  this.super.ctor(self)
end

function this:enter()
end

function this:exit()
end

function this:unlockEntity(id, bAnim)
end

return this
