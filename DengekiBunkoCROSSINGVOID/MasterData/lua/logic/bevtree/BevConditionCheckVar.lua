local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevConditionCheckVar = {}

function BevConditionCheckVar.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckVar"
  n.varname = ""
  n.compareOperation = BevConst.CompareOperation.Equal
  n.expression = ""
  n.run = BevConditionCheckVar.run
  return n
end

function BevConditionCheckVar.new()
  return BevConditionCheckVar.ctor({})
end

function BevConditionCheckVar.run(node)
  local lhs = node.eval(node.varname)
  local rhs = node.eval(node.expression)
  print("BevTree", "compare " .. node.varname .. " value - " .. lhs .. " with " .. rhs)
  local result = node.compareValue(node.compareOperation, lhs, rhs)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckVar
