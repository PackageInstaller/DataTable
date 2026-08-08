local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local BevConditionCheckRage = {}

function BevConditionCheckRage.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckRage"
  n.targetTeam = BevConst.AiTeamType.SelfTeam
  n.compareOperation = 0
  n.valueRatio = ""
  n.run = BevConditionCheckRage.run
  return n
end

function BevConditionCheckRage.new()
  return BevConditionCheckRage.ctor({})
end

function BevConditionCheckRage.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local teamInfo = Combat.getTeamInfo(fightData, teamId)
  local max_sp = DEFINE.GetDefineParams(fightData.stageID).maxSp
  local energyVal = FH.getCurEnergy(teamInfo, fightData.dungeonType, fightData.sequenceActor)
  local teamSp = energyVal[2]
  local curSpValRatio = teamSp / max_sp * 100
  local value = node.eval(node.valueRatio)
  local result = node.compareValue(node.compareOperation, curSpValRatio, value)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckRage
