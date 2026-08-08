local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = require("Logic/BevTree/BevNode")
local BevActionSetBackgroundEffect = {}

function BevActionSetBackgroundEffect.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionSetBackgroundEffect"
  n.effectName = ""
  n.run = BevActionSetBackgroundEffect.run
  return n
end

function BevActionSetBackgroundEffect.new()
  return BevActionSetBackgroundEffect.ctor({})
end

function BevActionSetBackgroundEffect.run(node)
  info("BevTree", "BevActionSetBackgroundEffect running..")
  BevData.instance.backgroundEffectName = node.effectName
  return BevConst.RunState.Finished
end

return BevActionSetBackgroundEffect
