local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local BevActionPlayRandomSkill = {}

function BevActionPlayRandomSkill.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionPlayRandomSkill"
  n.canUseSuperSkill = true
  n.canUseLink = true
  n.canUseAssistSkill = true
  n.canUseSkill2 = true
  n.canUseSkill1 = true
  n.returnFailIfFailToPlayDueToLock = false
  n.run = BevActionPlayRandomSkill.run
  return n
end

function BevActionPlayRandomSkill.new()
  return BevActionPlayRandomSkill.ctor({})
end

function BevActionPlayRandomSkill.run(node)
  info("BevTree", "BevActionPlayRandomSkill running..")
  BevData.instance.cardsPlayed = {}
  BevData.instance.skillType = 0
  BevData.instance.superSkillType = 0
  BevData.instance.linkId = 0
  local cardPlaySucceed = false
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local cardsInfoOfActor = Combat.GetCardsInfoOfActor(teamInfo.cardsInHand)
  local energyVal = FH.getCurEnergy(teamInfo, fightData.dungeonType, fightData.sequenceActor)
  local teamMp = energyVal[1]
  local teamSp = energyVal[2]
  local hasLockedActors = false
  local validActors = Combat.getActiveActors(fightData, function(actor)
    if actor.lock then
      hasLockedActors = true
    end
    return not actor.lock
  end)
  local candidateCardsInfo = {}
  for _, validActor in pairs(validActors) do
    local cards = cardsInfoOfActor[validActor.uniqueID]
    if node.canUseSkill1 and not validActor.isAssist then
      local cards = cards.commonCard
      if 0 < #cards and 0 < cards[1].useCount then
        local actorCombo = PB.get("ActorCombo", cards[1].actorID, 1, 0)
        if actorCombo then
          local real_mp = Combat.GetSkillRealCost(validActor, 1, 0, 0, actorCombo.costMp, actorCombo.costSp)
          if teamMp >= real_mp then
            table.insert(candidateCardsInfo, {
              card = cards[1],
              skillType = 1,
              linkId = 0,
              superSkillType = 0
            })
          end
        end
      end
    end
    if node.canUseSkill2 and not validActor.isAssist then
      local cards = cards.commonCard
      if 0 < #cards and 0 < cards[1].useCount then
        local actorCombo = PB.get("ActorCombo", cards[1].actorID, 2, 0)
        if actorCombo then
          local real_mp = Combat.GetSkillRealCost(validActor, 2, 0, 0, actorCombo.costMp, actorCombo.costSp)
          if teamMp >= real_mp then
            table.insert(candidateCardsInfo, {
              card = cards[1],
              skillType = 2,
              linkId = 0,
              superSkillType = 0
            })
          end
        end
      end
    end
    if node.canUseSuperSkill and not validActor.isAssist then
      local cards = cards.sCard
      if 0 < #cards and 0 < cards[1].useCount then
        local actorCombo = PB.get("ActorCombo", cards[1].actorID, 0, 1)
        if actorCombo and teamSp >= actorCombo.costSp then
          table.insert(candidateCardsInfo, {
            card = cards[1],
            skillType = 0,
            linkId = 0,
            superSkillType = 1
          })
        end
      end
    end
    if node.canUseAssistSkill and validActor.isAssist then
      local cards = cards.commonCard
      if 0 < #cards and 0 < cards[1].useCount then
        local actorCombo = PB.get("ActorCombo", cards[1].actorID, 1, 0)
        if actorCombo then
          local real_mp = Combat.GetSkillRealCost(validActor, 1, 0, 0, actorCombo.costMp, actorCombo.costSp)
          if teamMp >= real_mp then
            table.insert(candidateCardsInfo, {
              card = cards[1],
              skillType = 1,
              linkId = 0,
              superSkillType = 0
            })
          end
        end
      end
    end
    if node.canUseLink and not validActor.isAssist then
      local cards = cards.linkCard
      if 0 < #cards and 0 < cards[1].useCount then
        local actorLink = PB.get("ActorLink", cards[1].linkID)
        if actorLink and Combat.IsTimeOpen(actorLink.openTime) then
          local real_mp, real_sp = Combat.GetSkillRealCost(validActor, 0, 0, cards[1].linkID, actorLink.costMp, actorLink.costSp)
          if teamMp >= real_mp and teamSp >= real_sp then
            table.insert(candidateCardsInfo, {
              card = cards[1],
              skillType = 0,
              linkId = cards[1].linkID,
              superSkillType = 0
            })
          end
        end
      end
    end
  end
  if 0 < #candidateCardsInfo then
    local playCardInfo = candidateCardsInfo[FH.getTeamRandom(BevData.instance.currentTeam, 1, #candidateCardsInfo)]
    table.insert(BevData.instance.cardsPlayed, playCardInfo.card)
    BevData.instance.skillType = playCardInfo.skillType
    BevData.instance.linkId = playCardInfo.linkId
    BevData.instance.superSkillType = playCardInfo.superSkillType
    cardPlaySucceed = true
  end
  if cardPlaySucceed then
    return BevConst.RunState.Finished
  elseif hasLockedActors then
    info("BevTree", "BevActionPlayRandomSkill failed to cast any skill due to the actors are locked!")
    if node.returnFailIfFailToPlayDueToLock then
      return BevConst.RunState.Failed
    else
      return BevConst.RunState.Finished
    end
  else
    warning("BevTree", "BevActionPlayRandomSkill failed to cast any skill!")
    return BevConst.RunState.Failed
  end
end

return BevActionPlayRandomSkill
