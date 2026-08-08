local BevData = require("Logic/BevTree/BevData")
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local Combat = {}

function Combat.IsTimeOpen(openTime)
  local isOpen = false
  if openTime == nil or openTime == "" then
    isOpen = true
  else
    openTime = CS.GameTime.ServerTimeStrToUtc(openTime)
    local now = CS.GameTime.serverUtc
    if openTime <= now then
      isOpen = true
    end
  end
  return isOpen
end

function Combat.GetSkillRealCost(actor, card, scard, link, cost_mp, cost_sp)
  if cost_sp == 0 then
    local mp_change = FH.getCostChangeByBuff(actor, card, scard, link, "mp")
    cost_mp = math.max(0, cost_mp + mp_change)
  end
  if cost_mp == 0 then
    local sp_change = FH.getCostChangeByBuff(actor, card, scard, link, "sp")
    cost_sp = math.max(0, cost_sp + sp_change)
  end
  return cost_mp, cost_sp
end

function Combat.getAliveActors(fightData, team, predicate)
  local result = {}
  local teamList = fightData.teamList
  for i = 1, #teamList do
    if teamList[i].team == team then
      local playerList = teamList[i].playerList
      for j = 1, #playerList do
        for k = 1, #playerList[j].actorList do
          local actor = playerList[j].actorList[k]
          local actorID = actor.actorInfo.id
          if actorID ~= 0 and predicate(actor) then
            local hp = actor.dynamicAttrs[PB.enum.AttrType.Hp].value
            if 0 < hp then
              table.insert(result, actor)
            end
          end
        end
      end
    end
  end
  return result
end

function Combat.getActiveActors(fightData, predicate)
  local result = {}
  for i = 1, #fightData.activeActorList do
    local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
    local actor = FH.getActorByUid(teamInfo, fightData.activeActorList[i])
    local actorID = actor.actorInfo.id
    if actorID ~= 0 then
      local hp = actor.dynamicAttrs[PB.enum.AttrType.Hp].value
      if 0 < hp and predicate(actor) then
        table.insert(result, actor)
      end
    end
  end
  return result
end

function Combat.getActorDynamicAttrByActorId(fightData, team, targetActorId, attrIndex)
  local teamList = fightData.teamList
  local aliveCount = 0
  for i = 1, #teamList do
    if teamList[i].team == team then
      local list = teamList[i].playerList
      for j = 1, #list do
        local actorList = list[j].actorList
        for ai = 1, #actorList do
          local actor = actorList[ai]
          local actorID = actorList[ai].actorInfo.id
          local isAssist = actorList[ai].isAssist
          if actorID ~= 0 and actorID == targetActorId and isAssist ~= true then
            local attrValue = actor.dynamicAttrs[attrIndex].value
            return attrValue
          end
        end
      end
    end
  end
  return 0
end

function Combat.getActorDynamicAttr(fightData, team, staticPosition, attrIndex)
  local actor = Combat.getActorInfo(fightData, team, staticPosition)
  if actor then
    local attrValue = actor.dynamicAttrs[attrIndex].value
    return attrValue
  else
    return 0
  end
end

function Combat.getActorStaticAttr(fightData, team, staticPosition, attrIndex)
  local actor = Combat.getActorInfo(fightData, team, staticPosition, true)
  if actor then
    local attrValue = actor.actorInfo.attrs[attrIndex].value
    return attrValue
  else
    return 0
  end
end

function Combat.getActorInfo(fightData, team, staticPosition, noMatterIsAlive)
  local teamList = fightData.teamList
  local aliveCount = 0
  for i = 1, #teamList do
    if teamList[i].team == team then
      local list = teamList[i].playerList
      for j = 1, #list do
        local actorList = list[j].actorList
        for ai = 1, #actorList do
          local actor = actorList[ai]
          local actorID = actorList[ai].actorInfo.id
          if actorID ~= 0 and actor.baseSeat == staticPosition then
            if noMatterIsAlive then
              return actor
            else
              local hp = actor.dynamicAttrs[PB.enum.AttrType.Hp].value
              if 0 < hp then
                return actor
              else
                return nil
              end
            end
          end
        end
      end
    end
  end
  return nil
end

function Combat.getActorBuffList(fightData, team, staticPosition)
  local actor = Combat.getActorInfo(fightData, team, staticPosition)
  if actor then
    return actor.buffList
  else
    return nil
  end
end

function Combat.getTeamInfo(fightData, team)
  local teamList = fightData.teamList
  for i = 1, #teamList do
    if teamList[i].team == team then
      return teamList[i]
    end
  end
  return nil
end

function Combat.GetCardsInfoOfActor(cards)
  local result = {}
  for k, card in pairs(cards) do
    local cardsOfActor = result[card.actorRuntimeID] or {
      sCard = {},
      commonCard = {},
      linkCard = {}
    }
    local typeName = fif(card.sCard, "sCard", fif(card.linkID > 0, "linkCard", "commonCard"))
    local cardsInType = cardsOfActor[typeName]
    if cardsInType then
      table.insert(cardsInType, card)
    else
      cardsOfActor[typeName] = {card}
    end
    result[card.actorRuntimeID] = cardsOfActor
  end
  return result
end

return Combat
