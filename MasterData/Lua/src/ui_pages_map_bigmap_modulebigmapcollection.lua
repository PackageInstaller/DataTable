local this = class("moduleBigMapCollection", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {collectionId = nil}
end

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
end

function this:setCollectionId(id)
  self._collectionId = id
  self:setModuleState(true)
end

function this:setModuleState(active)
end

function this:getModuleState()
  return self._moduleActive == true
end

function this:initPage()
  self:initInfoModule()
end

function this:initInfoModule()
end

function this:onEvent_refreshCollection()
  self:initInfoModule()
end

return this
