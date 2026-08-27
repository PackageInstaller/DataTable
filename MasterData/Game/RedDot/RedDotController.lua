local RedDotController = {}
local Messenger = require("Framework.Common.Messenger")
local RedDotNode = require("Game.RedDot.RedDotNode")

function RedDotController:InitRedDotData()
  self:Reset()
end

function RedDotController:Reset()
  self.__dot_message = Messenger.New()
  self.__rootNode = RedDotNode.New()
end

function RedDotController:AddListener(nodePath, action)
  self.__dot_message:AddListener(nodePath, action)
end

function RedDotController:RemoveListener(nodePath, action)
  self.__dot_message:RemoveListener(nodePath, action)
end

function RedDotController:Broadcast(nodePath, ...)
  self.__dot_message:Broadcast(nodePath, ...)
end

function RedDotController:AddRedDotNode(...)
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:AddChild(nodeId)
    curNode = newNode
  end
  return curNode
end

function RedDotController:AddRedDotNodeWithPath(nodePath, ...)
  local curNode = self.__rootNode
  local n = select("#", ...)
  for i = 1, n do
    local nodeId = select(i, ...)
    local newNode
    if i == n then
      newNode = curNode:AddChildWithPath(nodeId, nodePath)
    else
      newNode = curNode:AddChild(nodeId)
    end
    curNode = newNode
  end
  return curNode
end

function RedDotController:GetRedDotNode(...)
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:GetChild(nodeId)
    if newNode == nil then
      return false, nil
    end
    curNode = newNode
  end
  return true, curNode
end

function RedDotController:RemoveRedDotNode(...)
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:GetChild(nodeId)
    if newNode == nil then
      return false, nil
    end
    curNode = newNode
  end
  return curNode:RemoveFromParent(), curNode
end

function RedDotController:SetRedDotCount(count, ...)
  local ok, node = self:GetRedDotNode(...)
  if not ok then
    local nodeIdList = {
      ...
    }
    error("can not find RedDotNode:" .. string.join(nodeIdList, "."))
    return
  end
  node:SetRedDotCount(count)
end

function RedDotController:OffsetRedDotCount(count, ...)
  local ok, node = self:GetRedDotNode(...)
  if not ok then
    local nodeIdList = {
      ...
    }
    error("can not find RedDotNode:" .. string.join(nodeIdList, "."))
    return
  end
  node:OffsetRedDotCount(count)
end

function RedDotController:SetRedDotCallback(action, ...)
  local ok, node = self:GetRedDotNode(...)
  if not ok then
    local nodeIdList = {
      ...
    }
    error("can not find RedDotNode:" .. string.join(nodeIdList, "."))
    return
  end
  node:SetRedDotCallback(action)
end

return RedDotController
