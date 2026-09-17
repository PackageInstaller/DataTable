local helper = class("redDotHelper")
local tag = "redDotHelper"

function helper:ctor()
  self._allNodes = {}
  self._dirtyNodes = {}
  self._tempDirtyNodes = {}
  self._splitChar = "/"
  self._rootNode = require("core.ui.manager.redDot.redDotNode").new()
  self._rootNode:init(self, "Root", "Root")
  self._redDotObjs = {}
  self._innerCallBack = handler(self, self.setRedDotInsActive)
  self._redDotPaths = nil
end

function helper:initialize(config)
  self._redDotPaths = config
  self:preloadNodeData()
end

function helper:removeAllDataListener(path)
  local node = self:getNode(path)
  node:removeAllDataListener()
end

function helper:getNode(path)
  if path == nil or path == "" then
    error("路径不合法，不能为空")
  end
  local tempNode = self._allNodes[path]
  if tempNode then
    return tempNode
  end
  local curNode = self._rootNode
  local subPath = ""
  local pos = 0
  for st, sp in function()
    return string.find(path, self._splitChar, pos, true)
  end, nil, nil do
    subPath = string.sub(path, 0, st - 1)
    curNode = curNode:getOrAddChild(subPath)
    self._allNodes[subPath] = curNode
    pos = sp + 1
  end
  curNode = curNode:getOrAddChild(path)
  self._allNodes[path] = curNode
  return curNode
end

function helper:getValue(path)
  local node = self:getNode(path)
  if not node then
    return 0
  end
  return node:getNodeValue()
end

function helper:removeNode(path)
  local tempNode = self._allNodes[path]
  if not tempNode then
    return false
  end
  self._allNodes[path] = nil
  local parentNode = tempNode:getParentNode()
  parentNode:removeChild(path)
end

function helper:resetAllNodeValue()
  for i, v in pairs(self._allNodes) do
    v:resetValue()
  end
end

function helper:removeAllNodeAndListener()
  for i, v in pairs(self._allNodes) do
    v:removeAllDataListener()
  end
  self._rootNode:removeAllChild()
  self._allNodes = {}
end

function helper:markDirtyNode(node)
  if node:getNodePath() == self._rootNode:getNodePath() then
    return
  end
  if node == nil then
    return
  end
  local needAdd = true
  for i, v in ipairs(self._dirtyNodes) do
    if v:getNodePath() == node:getNodePath() then
      needAdd = false
      break
    end
  end
  if needAdd then
    table.insert(self._dirtyNodes, node)
  end
end

function helper:update()
  if #self._dirtyNodes == 0 then
    return
  end
  self._tempDirtyNodes = {}
  for i, v in ipairs(self._dirtyNodes) do
    table.insert(self._tempDirtyNodes, v)
  end
  self._dirtyNodes = {}
  for i, v in ipairs(self._tempDirtyNodes) do
    v:updateNodeValue()
  end
end

function helper:setRedDotInsActive(path, value)
  local status = 0 < value
  local objList = self._redDotObjs[path]
  for i, v in ipairs(objList) do
    if not L_Util.isNull(v) then
      v.gameObject:SetActive(status)
    else
      errorf(path .. "不存在，请检查")
    end
  end
end

function helper:preloadNodeData()
  if self._redDotPaths then
    for i, v in pairs(self._redDotPaths.RedDotPaths) do
      self:getNode(v)
    end
  end
end

function helper:startRedDotTimer()
  if self._timer then
    self._timer:destroy()
  end
  self._timer = Timer.new(handler(self, self.update), 0.3, -1, false)
  self._timer:start()
end

function helper:stopRedDotTimer()
  if self._timer then
    self._timer:destroy()
  end
end

function helper:addInsListener(path, redDotIns)
  if not redDotIns then
    errorf("托管key：" .. path .. "  红点是空的")
    return
  end
  local objList = self._redDotObjs[path] or {}
  for i, v in ipairs(objList) do
    if v == redDotIns then
      errorf("托管key：" .. path .. "  重复添加相同的红点实例")
      return
    end
  end
  table.insert(objList, redDotIns)
  self._redDotObjs[path] = objList
  self:setRedDotInsActive(path, self:getValue(path))
  self:addDataListener(path, self._innerCallBack)
end

function helper:removeInsListener(path, redDotIns)
  if not redDotIns then
    error("托管key：" .. path .. "  红点是空的")
    return
  end
  local objList = self._redDotObjs[path] or {}
  for i, v in ipairs(objList) do
    if v == redDotIns then
      table.remove(objList, i)
      break
    end
  end
  self._redDotObjs[path] = objList
  self:removeDataListener(path, self._innerCallBack)
end

function helper:changeValue(path, newValue)
  local node = self:getNode(path)
  node:changeNodeValue(newValue)
end

function helper:addDataListener(path, callback)
  if callback == nil then
    return
  end
  local node = self:getNode(path)
  node:addDataListener(callback)
  return node
end

function helper:removeDataListener(path, callback)
  if not callback then
    return
  end
  local node = self:getNode(path)
  node:removeDataListener(callback)
end

return helper
