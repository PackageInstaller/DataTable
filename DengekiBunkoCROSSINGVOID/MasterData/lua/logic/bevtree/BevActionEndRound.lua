local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevActionEndRound = {}

function BevActionEndRound.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionEndRound"
  n.run = BevActionEndRound.run
  return n
end

function BevActionEndRound.new()
  return BevActionEndRound.ctor({})
end

function BevActionEndRound.run(node)
  return BevConst.RunState.Finished
end

return BevActionEndRound
