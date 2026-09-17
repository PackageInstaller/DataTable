local node = class("redDotNode")
local tag = "redDotNode"

function node:ctor()
  self._manager = nil
  self._childrenNode = nil
  self._nodePath = ""
  self._nodeValue = 0
  self._parentNode = nil
  self._changeCallBack = setmetatable({}, {
    __add = function(callback, newCallBack)
      table.insert(callback, newCallBack)
      return callback
    end,
    __sub = function(callback, subCallBack)
      for i, v in ipairs(callback) do
        if v == subCallBack then
          table.remove(callback, i)
          break
        end
      end
      return callback
    end
  })
  self._changeCallBacks = {}
end

function node:getNodePath()
  return self._nodePath
end

function node:getNodeValue()
  return self._nodeValue
end

function node:init(manager, path, parentNode)
  self._manager = manager
  self._nodePath = path
  self._nodeValue = 0
  self._parentNode = parentNode
end

function node:getParentNode()
  return self._parentNode
end

function node:getOrAddChild(path)
  local child = self:getChild(path)
  child = child or self:addChild(path)
  return child
end

function node:addChild(path)
  self._childrenNode = self._childrenNode or {}
  if self:getChild(path) then
    error("子节点添加失败，不允许重复添加：" .. path)
  end
  local newNode = node.new()
  newNode:init(self._manager, path, self)
  self._childrenNode[path] = newNode
  return newNode
end

function node:getChild(path)
  self._childrenNode = self._childrenNode or {}
  return self._childrenNode[path]
end

function node:removeChild(path)
  if self._childrenNode == nil or table.count(self._childrenNode) == 0 then
    return false
  end
  local child = self:getChild(path)
  if child then
    self._manager:markDirtyNode(self)
    self._childrenNode[path] = nil
    return true
  end
  return false
end

function node:removeAllChild()
  if self._childrenNode == nil or table.count(self._childrenNode) == 0 then
    return false
  end
  self._childrenNode = nil
  self._manager:markDirtyNode(self)
end

function node:addDataListener(callback)
  self._changeCallBack = self._changeCallBack + callback
end

function node:removeDataListener(callback)
  self._changeCallBack = self._changeCallBack - callback
end

function node:removeAllDataListener()
  self._changeCallBack = nil
end

function node:changeNodeValue(newValue)
  if self._childrenNode ~= nil and table.count(self._childrenNode) then
    error("不允许直接改变非叶子节点的值：" .. self._nodePath)
  end
  self:internalChaneValue(newValue)
end

function node:updateNodeValue()
  local sum = 0
  if self._childrenNode ~= nil and table.count(self._childrenNode) then
    for i, v in pairs(self._childrenNode) do
      sum = sum + v:getNodeValue()
    end
  end
  self:internalChaneValue(sum)
end

function node:internalChaneValue(value)
  if self._nodeValue == value then
    return
  end
  self._nodeValue = value
  self._changeCallBack = self._changeCallBack or {}
  for i, v in ipairs(self._changeCallBack) do
    if v then
      v(self._nodePath, value)
    end
  end
  self._manager:markDirtyNode(self._parentNode)
end

function node:resetValue()
  self._nodeValue = 0
end

return node
