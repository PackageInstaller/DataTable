local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local PB = require("Common/PbHelper")
local BevConditionCheckSkillMp = {}

function BevConditionCheckSkillMp.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevConditionCheckSkillMp"
  n.skillType = 0
  n.compareOperation = 0
  n.costValueExp = ""
  n.run = BevConditionCheckSkillMp.run
  return n
end

function BevConditionCheckSkillMp.new()
  return BevConditionCheckSkillMp.ctor({})
end

function BevConditionCheckSkillMp.run(node)
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local skillCost = 0
  local attacker = FH.getActorByUid(teamInfo, fightData.sequenceActor)
  if attacker then
    if node.skillType == BevConst.SkillType.Skill1 then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 1, 0)
      if actorCombo then
        skillCost = Combat.GetSkillRealCost(attacker, 1, 0, 0, actorCombo.costMp, actorCombo.costSp)
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.Skill2 then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 2, 0)
      if actorCombo then
        skillCost = Combat.GetSkillRealCost(attacker, 2, 0, 0, actorCombo.costMp, actorCombo.costSp)
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.SkillSuper then
      local actorCombo = PB.get("ActorCombo", attacker.actorInfo.id, 0, 1)
      if actorCombo then
        skillCost = actorCombo.costSp
      else
        error("BevTree", "Cannot getActorCombo info by actorId: " .. attacker.actorInfo.id)
      end
    elseif node.skillType == BevConst.SkillType.SkillAssist then
      local attackerAssist
      for k, v in pairs(fightData.activeActorList) do
        if v ~= fightData.sequenceActor then
          attackerAssist = FH.getActorByUid(teamInfo, v)
          break
        end
      end
      if attackerAssist then
        local actorCombo = PB.get("ActorCombo", attackerAssist.actorInfo.id, 1, 0)
        if actorCombo then
          skillCost = Combat.GetSkillRealCost(attackerAssist, 1, 0, 0, actorCombo.costMp, actorCombo.costSp)
        else
          error("BevTree", "Cannot getActorCombo info by actorId: " .. attackerAssist.actorInfo.id)
        end
      end
    elseif node.skillType == BevConst.SkillType.SkillLink then
      local cardsInfoOfActor = Combat.GetCardsInfoOfActor(teamInfo.cardsInHand)
      local cards = cardsInfoOfActor[attacker.uniqueID]
      local linkCards = cards.linkCard
      if 0 < #linkCards then
        local actorLink = PB.get("ActorLink", linkCards[1].linkID)
        if Combat.IsTimeOpen(actorLink.openTime) then
          if actorLink then
            skillCost = Combat.GetSkillRealCost(attacker, 0, 0, linkCards[1].linkID, actorLink.costMp, actorLink.costSp)
          else
            error("BevTree", "Cannot getActorLink info by actorId: " .. attacker.actorInfo.id)
          end
        end
      end
    end
  end
  local value = node.eval(node.costValueExp)
  local result = node.compareValue(node.compareOperation, skillCost, value)
  if result then
    return BevConst.RunState.Finished
  else
    return BevConst.RunState.Failed
  end
end

return BevConditionCheckSkillMp
