local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevSelector = {}

function BevSelector.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevSelector"
  n.currentRunning = 0
  n.run = BevSelector.run
  n.reset = BevSelector.reset
  return n
end

function BevSelector.reset(node)
  node.currentRunning = 0
  BevNode.reset(node)
end

function BevSelector.new()
  return BevSelector.ctor({})
end

function BevSelector.run(node)
  if #node.children == 0 then
    return BevConst.RunState.Finished
  end
  if node.currentRunning == 0 and #node.children > 0 then
    node.currentRunning = 1
  end
  local currentindex = node.currentRunning
  for i = currentindex, #node.children do
    node.currentRunning = i
    local childnode = node.children[i]
    local ret = childnode.run(childnode)
    if ret == BevConst.RunState.Finished then
      node.currentRunning = 0
      return BevConst.RunState.Finished
    elseif ret == BevConst.RunState.Running then
      return BevConst.RunState.Running
    elseif ret == BevConst.RunState.Failed and node.currentRunning == #node.children then
      node.currentRunning = 0
      return BevConst.RunState.Failed
    end
  end
  return 0
end

return BevSelector
