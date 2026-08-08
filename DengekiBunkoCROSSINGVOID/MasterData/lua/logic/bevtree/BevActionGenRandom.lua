local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local FH = require("Logic/HelpLogic")
local BevActionGenRandom = {}

function BevActionGenRandom.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionGenRandom"
  n.varname = ""
  n.rangeLower = ""
  n.rangeUpper = ""
  n.run = BevActionGenRandom.run
  return n
end

function BevActionGenRandom.new()
  return BevActionGenRandom.ctor({})
end

function BevActionGenRandom.run(node)
  local lower = node.eval(node.rangeLower)
  local upper = node.eval(node.rangeUpper)
  local guess = FH.getTeamRandom(BevData.instance.currentTeam, lower, upper)
  local vars = BevData.instance.vars[BevData.instance.currentTeam]
  vars[node.varname] = tostring(guess)
  return BevConst.RunState.Finished
end

return BevActionGenRandom
