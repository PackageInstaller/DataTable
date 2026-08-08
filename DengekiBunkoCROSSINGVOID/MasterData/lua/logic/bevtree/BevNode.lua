local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = {}
local Calculator = require("Logic/BevTree/Calculator")
local PB = require("Common/PbHelper")
local Combat = require("Logic/Combat")

function BevNode.ctor(node)
  node.parent = nil
  node.children = {}
  node.currentRunning = 0
  node.name = "BevNode"
  node.id = BevData.instance.nodeseq + 1
  BevData.instance.nodeseq = node.id
  node.dump = BevNode.dump
  node.addChild = BevNode.addChild
  node.root = BevNode.root
  node.compareValue = BevNode.compareValue
  node.getTeamId = BevNode.getTeamId
  node.eval = BevNode.eval
  node.getStaticActorId = BevNode.getStaticActorId
  node.findElementInArray = BevNode.findElementInArray
  node.reset = BevNode.reset
  node.isDeadCombatActor = BevNode.isDeadCombatActor
  return node
end

function BevNode.reset(node)
  for i = 1, #node.children do
    local childnode = node.children[i]
    childnode.reset(childnode)
  end
end

function BevNode.run(node)
  return BevConst.RunState.Finished
end

function BevNode.dump(node)
  print("BevTree", node.id .. " - " .. node.name)
  for i = 1, #node.children do
    local childnode = node.children[i]
    childnode.dump(childnode)
  end
end

function BevNode.addChild(parent, child)
  parent.children[#parent.children + 1] = child
  child.parent = parent
end

function BevNode.root(node)
  local p = node.parent
  if p ~= nil then
    return p.root(p)
  else
    return node
  end
end

function BevNode.findElementInArray(array, element)
  for i = 1, #array do
    local e = array[i]
    if e == element then
      return true
    end
  end
  return false
end

function BevNode.compareValue(op, lhs, rhs)
  if op == BevConst.CompareOperation.Equal then
    return lhs == rhs
  elseif op == BevConst.CompareOperation.NotEqual then
    return lhs ~= rhs
  elseif op == BevConst.CompareOperation.BiggerThan then
    return rhs < lhs
  elseif op == BevConst.CompareOperation.LessThan then
    return lhs < rhs
  elseif op == BevConst.CompareOperation.BiggerThanOrEqual then
    return rhs <= lhs
  elseif op == BevConst.CompareOperation.LessThanOrEqual then
    return lhs <= rhs
  end
end

function BevNode.getTeamId(fightData, teamPos)
  local activeTeam = BevData.instance.currentTeam
  local oppositeTeam = 2
  if activeTeam == 2 then
    oppositeTeam = 1
  end
  if teamPos == BevConst.AiTeamType.SelfTeam then
    return activeTeam
  else
    return oppositeTeam
  end
end

function BevNode.eval(varname)
  if varname:match("%D") == nil then
    return tonumber(varname)
  else
    return Calculator.calc(varname)
  end
end

function BevNode.getStaticActorId(teamId, position)
  for i = 1, #BevData.instance.teamIds do
    local teamId_ = BevData.instance.teamIds[i]
    if teamId_ == teamId then
      return BevData.instance.teamMembers[teamId][position]
    end
  end
  return 0
end

function BevNode.isDeadCombatActor(teamId, actorId)
  local actorConfig = PB.get("ActorConfig", actorId)
  if actorConfig.kind == 1 then
    local fightData = BevData.instance.fightActiveData
    local curHp = Combat.getActorDynamicAttrByActorId(fightData, teamId, actorId, PB.enum.AttrType.Hp)
    return curHp <= 0
  else
    return false
  end
end

return BevNode
