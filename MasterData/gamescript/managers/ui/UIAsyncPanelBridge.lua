local UIAsyncPanelBridge = NewClass("UIAsyncPanelBridge")
local executeOrder = math.mininteger

function UIAsyncPanelBridge:ctor()
  self.panelInstance = nil
  self.___bridgeName = nil
  self:___InitBridge()
end

function UIAsyncPanelBridge:IsReady()
  return self.panelInstance ~= nil
end

function UIAsyncPanelBridge:___InitBridge()
  local this = self
  local mytable = setmetatable({
    __hanlderList = {}
  }, {
    __index = function(mytable, key)
      if this.panelInstance ~= nil then
        local func = this.panelInstance[key]
        if nil ~= func then
          return this.panelInstance[key]
        end
      else
        if this[key] then
          return this[key]
        end
        return function(mytable, ...)
          local arg = {
            ...
          }
          executeOrder = executeOrder + 1
          table.insert(mytable.__hanlderList, {
            handler = self:___CallGetter(key, arg),
            executeOrder = executeOrder
          })
        end
      end
    end,
    __newindex = function(mytable, key, val)
      if this.panelInstance ~= nil then
        this.panelInstance[key] = val
      else
        executeOrder = executeOrder + 1
        table.insert(mytable.__hanlderList, {
          handler = self:___CallSetter(key, arg),
          executeOrder = executeOrder
        })
      end
    end
  })
  self.bridge = mytable
end

function UIAsyncPanelBridge:___AddBridges(name, cls)
  self.___children = self.___children or {}
  self.___children[name] = (cls or UIAsyncPanelBridge)()
  self.___children[name].___bridgeName = name
  self[name] = self.___children[name].bridge
end

function UIAsyncPanelBridge:___CallAllBridges()
  if not self.panelInstance then
    return
  end
  local handlers = self:___GetHandlers()
  if self.___children then
    for _, v in pairs(self.___children) do
      v.panelInstance = self.panelInstance[v.___bridgeName]
      v:___GetHandlers(handlers)
    end
  end
  table.sort(handlers, function(a, b)
    return a.executeOrder < b.executeOrder
  end)
  for i = 1, #handlers do
    handlers[i].handler()
  end
end

function UIAsyncPanelBridge:___CallGetter(key, arg)
  return function()
    if self.panelInstance then
      local func = self.panelInstance[key]
      if nil ~= func and type(func) == "function" then
        func(self.panelInstance, unpack(arg))
      end
    end
  end
end

function UIAsyncPanelBridge:___CallSetter(key, val)
  return function()
    if self.panelInstance then
      self.panelInstance[key] = val
    end
  end
end

function UIAsyncPanelBridge:___GetHandlers(handlers)
  handlers = handlers or {}
  for i = 1, #self.bridge.__hanlderList do
    table.insert(handlers, self.bridge.__hanlderList[i])
  end
  self.bridge.__hanlderList = {}
  return handlers
end

function UIAsyncPanelBridge:___ClearHandlers()
  self.panelInstance = nil
  self.bridge.__hanlderList = {}
  if self.___children then
    for _, v in pairs(self.___children) do
      v:___ClearHandlers()
    end
  end
end

return UIAsyncPanelBridge
