local BevConst = require("Logic/BevTree/BevConst")
local Combat = require("Logic/Combat")
local BevNode = require("Logic/BevTree/BevNode")
local BevConditionCheckActorHasBuff = {}
local FH = require("Logic/HelpLogic")
local PB = require("Common/PbHelper")

function BevConditionCheckActorHasBuff.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckActorHasBuff"
  n.targetTeam = BevConst.AiTeamType.SelfTeam
  n.target = BevConst.AiConditionTarget.AllActors
  n.keyType = BevConst.AiBuffKey.Id
  n.buffKeyExp = ""
  n.run = BevConditionCheckActorHasBuff.run
  return n
end

function BevConditionCheckActorHasBuff.new()
  return BevConditionCheckActorHasBuff.ctor({})
end

function BevConditionCheckActorHasBuff.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local buffList = Combat.getActorBuffList(fightData, teamId, node.target)
  if buffList == nil then
    return BevConst.RunState.Failed
  end
  local buffKey = node.eval(node.buffKeyExp)
  local foundBuff
  for i = 1, #buffList do
    local buff = buffList[i]
    if buff.state ~= PB.enum.BuffFightState.Delete then
      local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
      if node.keyType == BevConst.AiBuffKey.Id then
        if buffData.id == buffKey then
          foundBuff = buff
          break
        end
      elseif node.keyType == BevConst.AiBuffKey.Type then
        if buffData.type == buffKey then
          foundBuff = buff
          break
        end
      elseif node.keyType == BevConst.AiBuffKey.Category and table.has(buffData.categoryList, buffKey) then
        foundBuff = buff
        break
      end
    end
  end
  if foundBuff ~= nil then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckActorHasBuff
