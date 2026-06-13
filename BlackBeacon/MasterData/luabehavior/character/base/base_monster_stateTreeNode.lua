local stNodeBase = {}
stNodeBase.__index = stNodeBase

function stNodeBase.insertFun(node, funName, newFun)
  node.tool.insert(node, funName, newFun)
end

function stNodeBase.removeFun(node, funName, newFun)
  node.tool.remove(node, funName, newFun)
end

function stNodeBase.new(base, name, monster)
  local result = setmetatable({}, base)
  result.base = base
  result.type = "state"
  result.name = name
  result.monster = monster
  result.tree = monster.tree
  result.children = {}
  result.parent = nil
  result.nextSibling = nil
  return result
end

function stNodeBase.__call(...)
  local nodes = {
    ...
  }
  local self = table.remove(nodes, 1)
  self.children = nodes
  for i, node in ipairs(nodes) do
    node.parent = self
    node.nextSibling = nodes[i + 1]
  end
  return self
end

function stNodeBase.isReady()
  return true
end

function stNodeBase.start()
end

function stNodeBase.tick()
end

function stNodeBase.tickTrans()
  return nil
end

function stNodeBase.finish()
end

function stNodeBase.finTrans()
  return nil
end

function stNodeBase.chooseChild(state)
  local children = state.children
  if not _G.next(children) then
    return nil
  end
  for _, child in ipairs(children) do
    if child:isReady() then
      return child
    end
  end
  return nil
end

function stNodeBase.chooseChildAction(state)
  return state.tree:chooseChildAction(state)
end

function stNodeBase.isInTree(state)
  local node = state
  local monster = state.monster
  local i = 1
  while true do
    if not node.parent then
      if node.name == "root" then
        return true
      else
        return false
      end
    end
    node = node.parent
    i = i + 1
  end
end

function stNodeBase.isRunning(state)
  local tree = state.monster.tree
  local states = tree.states
  for _, _state in ipairs(states) do
    if _state == state then
      return true
    end
  end
  return false
end

return stNodeBase
