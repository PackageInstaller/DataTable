local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local BevConditionCheckAliveActors = {}

function BevConditionCheckAliveActors.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckAliveActors"
  n.team = 0
  n.compareOperation = 0
  n.valueExp = ""
  n.run = BevConditionCheckAliveActors.run
  return n
end

function BevConditionCheckAliveActors.new()
  return BevConditionCheckAliveActors.ctor({})
end

function BevConditionCheckAliveActors.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.team)
  local aliveActors = Combat.getAliveActors(fightData, teamId, function(actor)
    return not actor.isAssist
  end)
  local value = node.eval(node.valueExp)
  local result = node.compareValue(node.compareOperation, #aliveActors, value)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckAliveActors
