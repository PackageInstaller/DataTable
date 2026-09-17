local this = class("moduleProductAccessoryQueue", G_UIModuleBase)

function this.bind()
  return {
    list_queue = {
      moduleName = "pages/product/cellProductAccessoryQueue"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  self:refreshQueue()
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshQueue, self)
end

function this:close()
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshQueue, self)
end

function this:initModule(guid)
  self._guid = guid
  self:refreshQueue()
end

function this:refreshQueue()
  if not self.isBind or not self._guid then
    return
  end
  local queueData = L_ProductManager:getProduceQueueForBuilding(self._guid)
  self.bind.list_queue:clear()
  self.bind.list_queue:insert_array(queueData)
end

return this
