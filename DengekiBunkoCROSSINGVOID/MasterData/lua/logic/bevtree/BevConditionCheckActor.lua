local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local BevConditionCheckActor = {}

function BevConditionCheckActor.ctor(node)
  local n = BevNode.ctor(node)
  n.actorPosition = 1
  n.run = BevConditionCheckActor.run
  return n
end

function BevConditionCheckActor.new()
  return BevConditionCheckActor.ctor({})
end

function BevConditionCheckActor.run(node)
  local matched = false
  local fightData = BevData.instance.fightActiveData
  for i = 1, #fightData.activeActorList do
    local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
    local actor = FH.getActorByUid(teamInfo, fightData.activeActorList[i])
    if actor and not actor.isAssist and actor.baseSeat == node.actorPosition then
      matched = true
      break
    end
  end
  if matched then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckActor
