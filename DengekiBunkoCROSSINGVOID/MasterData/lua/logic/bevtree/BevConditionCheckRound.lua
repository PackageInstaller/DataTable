local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevConditionCheckRound = {}

function BevConditionCheckRound.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckRound"
  n.compareOperation = 0
  n.valueExp = ""
  n.run = BevConditionCheckRound.run
  return n
end

function BevConditionCheckRound.new()
  return BevConditionCheckRound.ctor({})
end

function BevConditionCheckRound.run(node)
  local fightData = BevData.instance.fightActiveData
  local value = node.eval(node.valueExp)
  local result = node.compareValue(node.compareOperation, fightData.gameRound, value)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckRound
