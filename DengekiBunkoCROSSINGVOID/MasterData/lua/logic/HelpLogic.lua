local PB = require("Common/PbHelper")
local DEFINE = require("Logic/Define")
local MYRANDOM = require("Internal/random")
local HP_INDEX = PB.enum.AttrType.Hp
local ATTR_MAX = PB.enum.AttrType.Max
local TLog = require("Common/TlogUtil")
local TS = require("Logic/Statistic")
local fight_random
local team_random = {}
local FightHelp = {}
local IdentityCategory2TeamSeat = {
  [PB.enum.IdentityCategory.Team1Seat1] = {1, 1},
  [PB.enum.IdentityCategory.Team1Seat2] = {1, 2},
  [PB.enum.IdentityCategory.Team1Seat3] = {1, 3},
  [PB.enum.IdentityCategory.Team2Seat1] = {2, 1},
  [PB.enum.IdentityCategory.Team2Seat2] = {2, 2},
  [PB.enum.IdentityCategory.Team2Seat3] = {2, 3}
}

function FightHelp.initGlobalSeed()
  if fight_random == nil then
    fight_random = MYRANDOM:new(0)
    team_random[1] = MYRANDOM:new(0)
    team_random[2] = MYRANDOM:new(0)
  end
end

function FightHelp.setGlobalSeed(seedFight, seed1, seed2)
  fight_random:setSeed(seedFight)
  team_random[1]:setSeed(seed1)
  team_random[2]:setSeed(seed2)
end

function FightHelp.getGlobalSeed(activeData)
  activeData.fightSeed = fight_random:getSeed()
  activeData.team1Seed = team_random[1]:getSeed()
  activeData.team2Seed = team_random[2]:getSeed()
end

function FightHelp.compareValue(source, target, operator)
  if operator == PB.enum.Operation.LessThan then
    return source < target
  elseif operator == PB.enum.Operation.LessThanOrEqualTo then
    return source <= target
  elseif operator == PB.enum.Operation.GreaterThan then
    return target < source
  elseif operator == PB.enum.Operation.GreaterThanOrEqualTo then
    return target <= source
  elseif operator == PB.enum.Operation.EqualTo then
    return source == target
  elseif operator == PB.enum.Operation.NotEqualTo then
    return source ~= target
  end
  return false
end

function FightHelp.getBuffData(id, owner)
  return PB.get("BuffData", id, owner)
end

function FightHelp.getComboNum(actorID, scard)
  local count = 0
  local rows = PB.all("ActorCombo")
  for i = 1, #rows do
    if rows[i].actorId == actorID then
      if scard then
        if rows[i].sCount ~= 0 then
          count = count + 1
        end
      elseif rows[i].sCount == 0 then
        count = count + 1
      end
    end
  end
  return count
end

function FightHelp.getCardPlace(actorID, index, sIndex)
  local result = 0
  local combo_info = PB.get("ActorCombo", actorID, index, sIndex)
  if combo_info ~= nil then
    result = combo_info.placeIndex
  end
  return result
end

function FightHelp.getAutoSettingKey(linkIndex, actorID, cardIndex, scardIndex)
  local index = "empty"
  if linkIndex ~= 0 then
    index = tostring(linkIndex)
  else
    index = actorID .. "," .. cardIndex .. "," .. scardIndex
    local combo_info = PB.get("ActorCombo", actorID, cardIndex, scardIndex)
    if combo_info ~= nil and 0 < combo_info.placeIndex then
      if scardIndex == 0 then
        index = actorID .. "," .. combo_info.placeIndex .. "," .. scardIndex
      end
      if cardIndex == 0 then
        index = actorID .. "," .. cardIndex .. "," .. combo_info.placeIndex - 2
      end
    end
  end
  return index
end

function FightHelp.getActorClose(actorID, skin)
  local result = 0
  local skinInfo = PB.get("ActorSkin", skin)
  if skinInfo ~= nil then
    for i = 1, #skinInfo.actorIds do
      if skinInfo.actorIds[i] == actorID then
        if #skinInfo.paletteIndexs == #skinInfo.actorIds then
          result = skinInfo.paletteIndexs[i]
          break
        end
        warning("GamePlay", "error data " .. actorID .. "  " .. skin)
        break
      end
    end
  end
  return result
end

function FightHelp.isGameOver(activeData)
  if activeData.winTeam ~= nil and activeData.winTeam ~= 0 then
    return true
  end
  return false
end

function FightHelp.isMultiPlayerMode(activeData)
  if activeData.playerCount ~= nil and activeData.playerCount > 1 then
    return true
  end
  return false
end

function FightHelp.isInfiniteCard(dungeonType, team)
  if team == 2 and (FightHelp.isDungeonPVE(dungeonType) or dungeonType == PB.enum.DungeonType.None or dungeonType == PB.enum.DungeonType.TeamPve) then
    return true
  end
  return false
end

function FightHelp.isNetMode(dungeonType)
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.TeamPve or dungeonType == PB.enum.DungeonType.FriendPvp or dungeonType == PB.enum.DungeonType.RD then
    return true
  end
  return false
end

function FightHelp.isDungeonPVE(dungeonType)
  if dungeonType == PB.enum.DungeonType.Story or dungeonType == PB.enum.DungeonType.Normal or dungeonType == PB.enum.DungeonType.Tower or dungeonType == PB.enum.DungeonType.TowerNew or dungeonType == PB.enum.DungeonType.WeekActivity or dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Challenge or dungeonType == PB.enum.DungeonType.Gold or dungeonType == PB.enum.DungeonType.RacePVP or dungeonType == PB.enum.DungeonType.TeamPve or dungeonType == PB.enum.DungeonType.Maze or dungeonType == PB.enum.DungeonType.Triggered or dungeonType == PB.enum.DungeonType.SemiFixed or dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild or dungeonType == PB.enum.DungeonType.MaidCafe then
    return true
  end
  return false
end

function FightHelp.isDungeonSelfMonster(dungeonType)
  if dungeonType == PB.enum.DungeonType.Story or dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Challenge then
    return true
  end
  return false
end

function FightHelp.checkGameOver(fightData, checkTeamInfo, targetTeamInfo, gameround)
  local function Param2WinType(param)
    local winTypeIndex = table.find(param, function(_, v)
      return v ~= 0
    end)
    if winTypeIndex then
      return param[winTypeIndex], param[winTypeIndex + 1] or 0, param[winTypeIndex + 2] or 0, winTypeIndex + 2
    end
  end
  
  if FightHelp.isGameOver(fightData) then
    return
  end
  if checkTeamInfo == nil or targetTeamInfo == nil then
    return
  end
  local winType, p2, p3, winTypeIndex = Param2WinType(checkTeamInfo.winParam)
  local tarWinType, tarP2, tarP3, tarWinTypeIndex = Param2WinType(targetTeamInfo.winParam)
  winType = winType or PB.enum.WinType.KillAll
  tarWinType = tarWinType or PB.enum.WinType.KillAll
  local winTeam = 0
  if winType == PB.enum.WinType.DeadAllInRound and checkTeamInfo.statistic.aliveCount == 0 then
    winTeam = checkTeamInfo.team
  elseif tarWinType == PB.enum.WinType.DeadAllInRound and targetTeamInfo.statistic.aliveCount == 0 then
    winTeam = targetTeamInfo.team
  elseif (winType == PB.enum.WinType.KillAll or winType == PB.enum.WinType.KillALLInRound or winType == PB.enum.WinType.NoDeadAll or winType == PB.enum.WinType.NoDeadAllInRound) and targetTeamInfo.statistic.aliveCount == 0 then
    winTeam = checkTeamInfo.team
  elseif tarWinType == PB.enum.WinType.KillAll and checkTeamInfo.statistic.aliveCount == 0 then
    winTeam = targetTeamInfo.team
  end
  if winTeam == 0 and (winType == PB.enum.WinType.KillSingle or winType == PB.enum.WinType.KillSingleInRound or winType == PB.enum.WinType.NoDeadSingle) then
    for i = 1, #targetTeamInfo.statistic.deadInfo do
      local deadInfo = targetTeamInfo.statistic.deadInfo[i]
      if deadInfo.seat == p2 then
        winTeam = checkTeamInfo.team
        break
      end
    end
  end
  if winTeam == 0 and (winType == PB.enum.WinType.KillALLInRound or winType == PB.enum.WinType.KillSingleInRound or winType == PB.enum.WinType.DeadAllInRound) and gameround > p3 then
    winTeam = targetTeamInfo.team
  end
  if winTeam == 0 and (winType == PB.enum.WinType.NoDeadAll or winType == PB.enum.WinType.NoDeadSingle or winType == PB.enum.WinType.NoDeadAnyInRound) and 0 < #checkTeamInfo.statistic.deadInfo then
    winTeam = targetTeamInfo.team
  end
  if winTeam == 0 and (winType == PB.enum.WinType.NoDeadAllInRound or winType == PB.enum.WinType.NoDeadSingleInRound or winType == PB.enum.WinType.NoDeadAnyInRound) and gameround > p3 then
    winTeam = checkTeamInfo.team
  end
  if winTeam == 0 and winType == PB.enum.WinType.NoDeadSingleInRound then
    for i = 1, #checkTeamInfo.statistic.deadInfo do
      local deadInfo = checkTeamInfo.statistic.deadInfo[i]
      if deadInfo.seat == p2 then
        winTeam = targetTeamInfo.team
        break
      end
    end
  end
  if winTeam ~= 0 and winTypeIndex then
    for i = winTypeIndex, 1, -1 do
      checkTeamInfo.winParam[i] = 0
    end
    local nextWinTypeIndex = table.find(checkTeamInfo.winParam, function(_, v)
      return v ~= 0
    end)
    if nextWinTypeIndex then
      winTeam = 0
    end
  end
  fightData.winTeam = winTeam
  return winTeam
end

function FightHelp.getActorSCardCount(actor)
  local result = 0
  local count = FightHelp.getComboNum(actor.actorInfo.id, true)
  for i = 1, count do
    if isActorHaveSCard(actor, i) then
      result = result + 1
    end
  end
  return result
end

function isActorHaveSCard(actor, sIndex)
  local skillInfo = PB.get("ActorCombo", actor.actorInfo.id, 0, sIndex)
  if skillInfo == nil then
    return false
  end
  if #skillInfo.skillList == 0 then
    return false
  end
  for k = 1, #skillInfo.skillList do
    local find_id = skillInfo.skillList[k]
    local findOne = false
    for j = 1, #actor.actorInfo.skills do
      if actor.actorInfo.skills[j].id == find_id then
        findOne = true
        break
      end
    end
    if findOne == false then
      return false
    end
  end
  return true
end

function FightHelp.getTeamInfo(teamList, team)
  for i = 1, #teamList do
    if teamList[i].team == team then
      return teamList[i]
    end
  end
  return nil
end

function FightHelp.getMainActor(teamList, owner, permitNil)
  if not owner.isAssist then
    return owner
  end
  local main_seat = owner.baseSeat
  if main_seat > DEFINE.ACTOR_NUM then
    main_seat = main_seat - DEFINE.ACTOR_NUM
  else
    main_seat = main_seat - DEFINE.HALF_ACTOR_NUM
  end
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team == owner.team and actor.baseSeat == main_seat then
      return actor
    end
  end
  if not permitNil then
    warning("GamePlay", "Not Find Actor " .. owner.uniqueID)
  end
  return owner
end

function FightHelp.getTeamActorsByKind(teamList, team, kind, isAll)
  local result = {}
  if kind == PB.enum.KindForAppendSpecialAttrInfo.Main or kind == PB.enum.KindForAppendSpecialAttrInfo.Main1 then
    result = FightHelp.getTeamActorsByAssist(teamList, team, false)
  elseif kind == PB.enum.KindForAppendSpecialAttrInfo.Sub then
    result = FightHelp.getTeamActorsByAssist(teamList, team, true)
  elseif kind == PB.enum.KindForAppendSpecialAttrInfo.MainAndSub or kind == PB.enum.KindForAppendSpecialAttrInfo.MainAndSub1 then
    result = FightHelp.getTeamActors(teamList, team)
  elseif kind == PB.enum.KindForAppendSpecialAttrInfo.Weapon then
    result = FightHelp.getTeamWeapons(teamList, team)
  else
    warning("GamePlay", "getTeamActorsByKind kind " .. tostring(kind) .. " is illegal ")
  end
  if 0 < #result and isAll == false then
    local val = FightHelp.getRandom(1, #result)
    result = {
      result[val]
    }
  end
  return result
end

function FightHelp.getTeamActorsByAssist(teamList, team, isAssist)
  local result = {}
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team == team and actor.isAssist == isAssist then
      table.insert(result, actor)
    end
  end
  return result
end

function FightHelp.getTeamActorsBySeat(teamList, team, seat)
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    local dynamic_seat = actor.seat
    if actor.team == team and dynamic_seat == seat then
      return actor
    end
  end
  return nil
end

function FightHelp.getActorByUid(teamInfo, uid, permitNil)
  for j = 1, #teamInfo.playerList do
    local actorList = teamInfo.playerList[j].actorList
    for k = 1, #actorList do
      if actorList[k].uniqueID == uid then
        return actorList[k]
      end
    end
  end
  if not permitNil then
    warning("GamePlay", "Not Find Actor " .. uid)
  end
  return nil
end

function FightHelp.getTeamLinkActorTable(teamInfo, linkID, uid)
  local link_info = teamInfo.linkInfoList
  for i = 1, #link_info do
    if link_info[i].linkID == linkID then
      local result = link_info[i].uidList
      for j = 1, #result do
        if result[j] == uid then
          return result
        end
      end
    end
  end
  return {}
end

function FightHelp.getTeamWeapons(teamList, team)
  local result = {}
  for _, roundTeamInfo in pairs(teamList) do
    if team == nil or roundTeamInfo.team == team then
      for _, roundPlayerInfo in pairs(roundTeamInfo.playerList) do
        for _, roundActorInfo in pairs(roundPlayerInfo.actorList) do
          if DEFINE.IsWeapon(roundActorInfo) then
            table.insert(result, roundActorInfo)
          end
        end
      end
    end
  end
  return result
end

function FightHelp.getTeamSubWeapons(teamList, team)
  local result = {}
  for _, roundTeamInfo in pairs(teamList) do
    if team == nil or roundTeamInfo.team == team then
      for _, roundPlayerInfo in pairs(roundTeamInfo.playerList) do
        for _, roundActorInfo in pairs(roundPlayerInfo.actorList) do
          if not DEFINE.IsWeapon(roundActorInfo) and roundActorInfo.isAssist and roundActorInfo.actorInfo.uniqueWeaponId and roundActorInfo.actorInfo.uniqueWeaponId > 0 then
            table.insert(result, roundActorInfo)
          end
        end
      end
    end
  end
  return result
end

function FightHelp.getTeamActors(teamList, team)
  local result = {}
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team == team then
      table.insert(result, actor)
    end
  end
  return result
end

function FightHelp.refreshSequence(activeData)
  local delList = {}
  for i = 1, #activeData.teamList do
    local teamInfo = activeData.teamList[i]
    for j = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[j].actorList
      for k = 1, #actorList do
        local actorID = actorList[k].actorInfo.id
        if actorID ~= nil and actorID ~= 0 and not actorList[k].isAssist and 0 >= actorList[k].dynamicAttrs[HP_INDEX].value then
          table.insert(delList, actorList[k].uniqueID)
        end
      end
    end
  end
  local sequence = activeData.sequenceList
  for i = 1, #delList do
    for k = 1, #sequence do
      if sequence[k].uid == delList[i] then
        sequence[k].dead = true
        break
      end
    end
  end
end

function FightHelp.getActivePlayerID(activeData)
  for i = 1, #activeData.teamList do
    local teamInfo = activeData.teamList[i]
    for j = 1, #teamInfo.playerList do
      local playerInfo = teamInfo.playerList[j]
      local actorList = playerInfo.actorList
      local curCount = #activeData.activeActorList
      for m = 0, #activeData.activeActorList do
        for k = 1, #actorList do
          if activeData.activeActorList[m] == actorList[k].uniqueID then
            curCount = curCount - 1
            break
          end
        end
      end
      if curCount == 0 then
        return playerInfo.playerId
      end
    end
  end
  return ""
end

function FightHelp.getNextActiveActor(activeData, cur_actor)
  local roundchange = false
  local find_actor = 0
  local sequence = {}
  local base_list = activeData.sequenceList
  for i = 1, #base_list do
    if not base_list[i].dead then
      table.insert(sequence, base_list[i].uid)
    end
  end
  for i = 1, #sequence do
    if cur_actor == sequence[i] then
      if i == #sequence then
        roundchange = true
        find_actor = sequence[1]
        break
      end
      find_actor = sequence[i + 1]
      break
    end
  end
  if cur_actor == 0 and find_actor == 0 and 0 < #sequence then
    find_actor = sequence[1]
  end
  return {find_actor, roundchange}
end

function FightHelp.getActiveList(curActor, activeData)
  local result = {}
  for i = 1, #activeData.teamList do
    local teamInfo = activeData.teamList[i]
    local link_info = teamInfo.linkInfoList
    for j = 1, #link_info do
      for k = 1, #link_info[j].uidList do
        if link_info[j].uidList[k] == curActor then
          return {
            link_info[j].uidList,
            teamInfo.team
          }
        end
      end
    end
  end
  return {result, 0}
end

function FightHelp.isSelfEnergy(dungeonType)
  if dungeonType == PB.enum.DungeonType.TeamPve then
    return true
  end
  return false
end

function FightHelp.getCurActiveSeat(teamInfo, dungeonType, actorUid)
  local activeSeat = -1
  if FightHelp.isSelfEnergy(dungeonType) then
    local activeActor = FightHelp.getActorByUid(teamInfo, actorUid)
    if activeActor ~= nil then
      activeSeat = activeActor.baseSeat
    end
  end
  return activeSeat
end

function FightHelp.getCurEnergy(teamInfo, dungeonType, actorUid)
  local activeSeat = FightHelp.getCurActiveSeat(teamInfo, dungeonType, actorUid)
  local energyMp = FightHelp.getTeamEnergy(1, teamInfo, activeSeat)
  local energySp = FightHelp.getTeamEnergy(2, teamInfo, activeSeat)
  return {energyMp, energySp}
end

function FightHelp.getTeamEnergy(kind, teamInfo, seat)
  local result = 0
  local link_info = teamInfo.linkInfoList
  for i = 1, #link_info do
    if seat == -1 or link_info[i].ownerSeat == seat then
      if kind == 1 then
        result = link_info[i].mpVal
      elseif kind == 2 then
        result = link_info[i].spVal
      end
    end
  end
  return result
end

function FightHelp.addTeamEnergy(kind, teamInfo, val, maxVal, seat, source)
  TLog.CollectEnergy({
    action = "change",
    kind = kind,
    teamInfo = teamInfo,
    val = val,
    maxVal = maxVal,
    source = source
  })
  local link_info = teamInfo.linkInfoList
  for i = 1, #link_info do
    if seat == -1 or link_info[i].ownerSeat == seat then
      if kind == 1 then
        link_info[i].mpVal = math.max(0, math.min(link_info[i].mpVal + val, maxVal))
      elseif kind == 2 then
        link_info[i].spVal = math.max(0, math.min(link_info[i].spVal + val, maxVal))
      end
    end
  end
end

function FightHelp.addWeaponEnergy(teamInfo, baseSeat)
  local weapons = FightHelp.getTeamWeapons({teamInfo}, teamInfo.team)
  for i = 1, #weapons do
    local weapon = weapons[i]
    local weaponDetail = weapon.actorInfo
    if weaponDetail.id and weaponDetail.id > 0 and 0 < weapon.dynamicAttrs[HP_INDEX].value and weapon.baseSeat == baseSeat + DEFINE.ACTOR_NUM then
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
      if uniqueWeaponSkill then
        weapon.energyWP = math.max(0, math.min(weapon.energyWP + uniqueWeaponSkill.chargeWP, uniqueWeaponSkill.limitWP))
      else
        warning("GamePlay", "missing UniqueWeaponSkill id : " .. tostring(weaponDetail.id) .. ", phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
      end
    end
  end
end

function FightHelp.setWeaponEnergy(teamInfo, baseSeat, energy)
  local weapons = FightHelp.getTeamWeapons({teamInfo}, teamInfo.team)
  for i = 1, #weapons do
    local weapon = weapons[i]
    local weaponDetail = weapon.actorInfo
    if weaponDetail.id and weaponDetail.id > 0 and 0 < weapon.dynamicAttrs[HP_INDEX].value and weapon.baseSeat == baseSeat + DEFINE.ACTOR_NUM then
      local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", weaponDetail.id, weaponDetail.uniqueWeaponPhase or 1)
      if uniqueWeaponSkill then
        weapon.energyWP = math.max(0, math.min(energy, uniqueWeaponSkill.limitWP))
      else
        warning("GamePlay", "missing UniqueWeaponSkill id : " .. tostring(weaponDetail.id) .. ", phase : " .. tostring(weaponDetail.uniqueWeaponPhase))
      end
    end
  end
end

function FightHelp.setTeamEnergy(kind, teamInfo, val, seat)
  local result = 0
  local link_info = teamInfo.linkInfoList
  for i = 1, #link_info do
    if seat == -1 or link_info[i].ownerSeat == seat then
      if kind == 1 then
        link_info[i].mpVal = math.max(0, val)
        result = link_info[i].mpVal
      elseif kind == 2 then
        link_info[i].spVal = math.max(0, val)
        result = link_info[i].spVal
      end
    end
  end
  return result
end

function FightHelp.printActorsUniqueId(actors)
  if actors ~= nil then
    local text = ""
    for i = 1, #actors do
      text = text .. actors[i].uniqueID
      if i ~= #actors then
        text = text .. ", "
      end
    end
    print("GamePlay", text)
  else
    error("GamePlay", "param actors is nil")
  end
end

function FightHelp.getAllActors(teamList, alive)
  local result = {}
  for i = 1, #teamList do
    local teamInfo = teamList[i]
    for j = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[j].actorList
      for k = 1, #actorList do
        local actorID = actorList[k].actorInfo.id
        if actorID ~= nil and actorID ~= 0 then
          if alive then
            if 0 < actorList[k].dynamicAttrs[HP_INDEX].value then
              table.insert(result, actorList[k])
            end
          else
            table.insert(result, actorList[k])
          end
        end
      end
    end
  end
  return result
end

function FightHelp.refreshDeadAndLockCard(teamInfo)
  for j = 1, #teamInfo.playerList do
    local actorList = teamInfo.playerList[j].actorList
    for k = 1, #actorList do
      local actorID = actorList[k].actorInfo.id
      if actorID ~= nil and actorID ~= 0 then
        local dead = false
        if 0 >= actorList[k].dynamicAttrs[HP_INDEX].value then
          dead = true
        end
        local id = actorList[k].uniqueID
        local lock = actorList[k].lock
        FightHelp.setDeadAndLockCardImpl(teamInfo.allCardList, id, dead, lock)
        FightHelp.setDeadAndLockCardImpl(teamInfo.cardsInHand, id, dead, lock)
        FightHelp.setDeadAndLockCardImpl(teamInfo.cardsInStack, id, dead, lock)
      end
    end
  end
end

function FightHelp.setDeadAndLockCardImpl(cardList, id, dead, lock)
  if cardList ~= nil then
    for c = 1, #cardList do
      local card = cardList[c]
      if card.actorRuntimeID == id then
        card.dead = dead
        card.lock = lock
      end
    end
  end
end

function FightHelp.removeDeadCard(teamInfo)
  local delList = {}
  for j = 1, #teamInfo.cardsInHand do
    local card = teamInfo.cardsInHand[j]
    if card.dead then
      table.insert(delList, card)
    end
  end
  for i = 1, #delList do
    local card = delList[i]
    for k = 1, #teamInfo.cardsInHand do
      if teamInfo.cardsInHand[k] == card then
        table.remove(teamInfo.cardsInHand, k)
        break
      end
    end
  end
end

function FightHelp.refreshTeamEnergy(teamList)
  for i = 1, #teamList do
    local teamInfo = teamList[i]
    teamInfo.energyMp = FightHelp.getTeamEnergy(1, teamInfo, -1)
    teamInfo.energySp = FightHelp.getTeamEnergy(2, teamInfo, -1)
  end
end

function FightHelp.getRandom(min, max)
  local result = fight_random:next(min, max)
  return result
end

function FightHelp.getTeamRandom(team, min, max)
  local result = team_random[team]:next(min, max)
  return result
end

function FightHelp.isRandomChanceMet(val)
  local random = FightHelp.getRandom(0, 9999)
  if val > random then
    return true
  end
  return false
end

function FightHelp.getProportionRandomIndex(weightList)
  local result = 1
  local total = 0
  for i = 1, #weightList do
    total = total + weightList[i]
  end
  local random = FightHelp.getRandom(0, total - 1)
  local temp = 0
  for i = 1, #weightList do
    temp = temp + weightList[i]
    if random < temp then
      result = i
      break
    end
  end
  return result
end

function FightHelp.getIntPart(x)
  if x <= 0 then
    return math.ceil(x)
  end
  if math.ceil(x) == x then
    x = math.ceil(x)
  else
    x = math.ceil(x) - 1
  end
  return x
end

function FightHelp.clearTeamRunTimeInfo(teamList)
  for i = 1, #teamList do
    local teamInfo = teamList[i]
    teamInfo.rtAssistBuffList = {}
    local list = teamInfo.playerList
    for j = 1, #list do
      for k = 1, #list[j].actorList do
        local actor = list[j].actorList[k]
        actor.rtAttBuffOnce = false
        actor.rtAttBuffAfterOnce = false
        actor.rtHurtBuffOnce = false
        actor.rtHurtBuffAfterOnce = false
        actor.rtAttBuffList = {}
        actor.rtAttBuffAfterList = {}
        actor.rtDeadOnce = false
      end
    end
  end
end

function FightHelp.fixGameSeat(teamList)
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.isAssist ~= true then
      local fixSeat = FightHelp.getAliveCount(teamList, actor.team, actor.seat) + 1
      actor.seat = fixSeat
    end
  end
end

function FightHelp.getAliveCount(teamList, team, seat)
  local aliveCount = 0
  local actorTable = FightHelp.getAllActors(teamList, true)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team == team and actor.isAssist ~= true and seat > actor.seat then
      aliveCount = aliveCount + 1
    end
  end
  return aliveCount
end

function FightHelp.blendActorBuff(table1, table2)
  for k, v in pairs(table2) do
    if 0 < #v then
      table1[k] = v
    end
  end
end

function FightHelp.blendAllActorBuff(table1, teamList)
  local actorTable = FightHelp.getAllActors(teamList, false)
  local allActorBuff = {}
  for k = 1, #actorTable do
    allActorBuff[actorTable[k].uniqueID] = FightHelp.copyActorBuff(actorTable[k])
  end
  FightHelp.blendActorBuff(table1, allActorBuff)
end

function FightHelp.copyActorBuff(actor)
  local result = {}
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    local showbuff = {
      buffKey = buff.buffKey,
      round = buff.round,
      stack = buff.stack,
      state = buff.state,
      val = buff.val,
      exRound = buff.exRound,
      mergeState = buff.mergeState,
      mergeList = buff.mergeList,
      isNewHit = buff.isNewHit,
      removeType = buff.removeType,
      ownerUid = buff.ownerUid,
      sourceId = buff.sourceId,
      indexId = buff.indexId,
      contentVal = buff.contentVal,
      rate = buff.rate
    }
    table.insert(result, showbuff)
  end
  return result
end

function FightHelp.copyActorOnceHp(actor, teamList, uid)
  if actor == nil then
    local actorTable = FightHelp.getAllActors(teamList, true)
    for k = 1, #actorTable do
      if actorTable[k].uniqueID == uid then
        actor = actorTable[k]
        break
      end
    end
  end
  if actor == nil then
    return {}
  end
  local result = {}
  for i = 1, #actor.hpOnceChange do
    local once = actor.hpOnceChange[i]
    local once_info = {
      kind = once.kind,
      val = once.val,
      index = once.index
    }
    table.insert(result, once_info)
  end
  return result
end

function FightHelp.clearAllNewHitBuff(teamList)
  local actorTable = FightHelp.getAllActors(teamList, false)
  for k = 1, #actorTable do
    FightHelp.clearBuffNewHit(actorTable[k])
  end
end

function FightHelp.clearBuffNewHit(actor)
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    buff.isNewHit = false
  end
end

function FightHelp.refreshActionFeedBackBuff(teamList, buffType, hitTable)
  FightHelp.clearAllActorHpChangeBuff(teamList, buffType)
  for k, v in pairs(hitTable) do
    if not k.isAssist and 0 < #v then
      FightHelp.refreshActorHpChange(teamList, k, buffType)
    end
  end
end

function FightHelp.refreshHpChangeBuff(teamList, team, uniqueID, buffType)
  local actorTable = FightHelp.clearAllActorHpChangeBuff(teamList, buffType)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    if actor.team == team and not actor.isAssist and actor.uniqueID == uniqueID then
      FightHelp.refreshActorHpChange(teamList, actor, buffType)
    end
  end
end

function FightHelp.clearAllActorHpChangeBuff(teamList, buffType)
  local actorTable = FightHelp.getAllActors(teamList, false)
  for k = 1, #actorTable do
    local actor = actorTable[k]
    local changeList = actor.hpChangeList
    for i = #changeList, 1, -1 do
      local idx, val = table.find(changeList, function(k, v)
        return v.kind == buffType
      end)
      if idx then
        table.remove(changeList, idx)
      end
    end
  end
  return actorTable
end

function FightHelp.refreshActorHpChange(teamList, actor, buffType)
  local damage_change = 0
  local team = actor.team
  local otherTeam = 1
  if team == 1 then
    otherTeam = 2
  end
  local actorTable = FightHelp.getAllActors(teamList, false)
  local otherTeamInfo = FightHelp.getTeamInfo(teamList, otherTeam)
  for b = 1, #actor.buffList do
    local buff = actor.buffList[b]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == buffType then
      local one_change_val = buff.val
      if 0 < one_change_val then
        one_change_val = FightHelp.changeHpAddByBuff(actor, one_change_val)
      end
      if one_change_val < 0 then
        local attackId = buff.ownerUid
        if attackId ~= 0 then
          for k = 1, #actorTable do
            local attack = actorTable[k]
            if attack.team == otherTeam and attack.uniqueID == attackId then
              TS.damageList(otherTeamInfo, attack, -one_change_val)
              break
            end
          end
        end
        damage_change = damage_change + one_change_val
      end
      FightHelp.DynamicHpChange(actor, one_change_val, false, buffType)
    end
  end
  if damage_change < 0 then
    local activeTeamInfo = FightHelp.getTeamInfo(teamList, team)
    activeTeamInfo.statistic.totalDamage = activeTeamInfo.statistic.totalDamage - damage_change
  end
end

function FightHelp.changeHpAddByBuff(target, hurt)
  local result = hurt
  local percentVal = 0
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.HpAddChange then
      local val = buff.val
      percentVal = percentVal + val / 10000
    end
  end
  result = hurt * (1 + percentVal)
  if result <= 0 then
    result = 1
  end
  return math.floor(result)
end

function FightHelp.getChangeBuffVal(type1, type2, type3, target, kind, stack)
  if target == nil then
    return 0
  end
  local val = 0
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.BuffValChange then
      local main_type = buffData.paramInt[1]
      local child_type = buffData.paramInt[2]
      local sign_type = buffData.paramInt[5]
      local sign_match = false
      if sign_type == 0 or sign_type == nil then
        sign_match = true
      elseif sign_type == type3 then
        sign_match = true
      end
      if main_type == type1 and child_type == type2 and kind == buffData.paramInt[4] and sign_match then
        local addVal = buff.val
        if stack ~= nil and 0 < stack and buffData.paramInt[6] == 1 then
          addVal = addVal / stack
        end
        val = val + addVal
      end
    end
  end
  return val
end

function FightHelp.CheckSkillMatch(targetVal, actorId, isAssist, card, sCard, link)
  local match = false
  local matchVal = {
    [1] = function()
      return not isAssist and FightHelp.getCardPlace(actorId, card, sCard) == 1
    end,
    [2] = function()
      return not isAssist and FightHelp.getCardPlace(actorId, card, sCard) == 2
    end,
    [3] = function()
      return not isAssist and FightHelp.getCardPlace(actorId, card, sCard) == 3
    end,
    [4] = function()
      return isAssist
    end,
    [5] = function()
      return 0 < link
    end,
    [6] = function()
      return true
    end,
    [7] = function()
      return 1 <= sCard
    end
  }
  if matchVal[targetVal] then
    match = matchVal[targetVal]()
  end
  return match
end

function FightHelp.getSpRateChangeByBuff(actor)
  local changeVal = 0
  local percentVal = 0
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.SpRateChange then
      local param = buffData.paramInt[1]
      local val = buff.val
      if param == 0 or param == nil then
        changeVal = changeVal + val
      else
        percentVal = percentVal + val / 10000
      end
    end
  end
  return {changeVal, percentVal}
end

function FightHelp.getCostChangeByBuff(actor, card, scard, link, type)
  local change = 0
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.CostChange then
      local buffDataType
      if buffData.paramInt[3] == 1 then
        buffDataType = "mp"
      elseif buffData.paramInt[3] == 2 then
        buffDataType = "sp"
      end
      if buffDataType == type then
        local val = buff.val
        local kind = buffData.paramInt[2]
        if FightHelp.CheckSkillMatch(kind, actor.actorInfo.id, actor.isAssist, card, scard, link) then
          change = change + val
        end
      end
    end
  end
  return change
end

function FightHelp.deleteBuff(buff, gameround, target)
  local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
  if buffData.type == PB.enum.BuffFightType.SpecialAttrChange then
    local definition = DEFINE.BuffFightType[buffData.type]
    if definition[buffData.paramInt[2]] == "inDuration" then
      local index = table.find(target.dynamicTalent, function(_, v)
        return v.talentId == buffData.paramInt[1]
      end)
      table.remove(target.dynamicTalent, index)
    end
  end
  local buffAction = target.buffAction
  if buffData.actionLogic > 0 and buffAction.type == buffData.actionLogic then
    buffAction.refCount = buffAction.refCount - 1
    if buffAction.refCount == 0 then
      target.buffAction = {type = 0, refCount = 0}
    end
  end
  buff.state = PB.enum.BuffFightState.Delete
  TLog.CollectBuff({
    action = "del",
    buffInfo = buff,
    round = gameround
  })
end

function FightHelp.removeActorBuff(teamList, timePoint, team, uniqueID, gameround)
  local team_equal = false
  if team == 0 then
    team_equal = true
  end
  local actorList = FightHelp.getAllActors(teamList, false)
  local specialAttrChange = {}
  for k = 1, #actorList do
    local target = actorList[k]
    local actor_equal = false
    if team_equal then
      actor_equal = true
    elseif target.team == team and target.uniqueID == uniqueID then
      actor_equal = true
    end
    if actor_equal then
      local buffChange = false
      for b = 1, #target.buffList do
        local buff = target.buffList[b]
        local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
        if buff.state ~= PB.enum.BuffFightState.Delete then
          if buffData.endPoint == timePoint then
            local owner_equal = false
            if team_equal then
              if not target.isAssist then
                if buffData.endPoint == PB.enum.BuffEndPoint.WeaponUserBegin or buffData.endPoint == PB.enum.BuffEndPoint.WeaponUserEnd then
                  owner_equal = buff.userUniqueId == uniqueID
                else
                  owner_equal = buff.ownerUid == uniqueID or buff.ownerUid - DEFINE.HALF_ACTOR_NUM == uniqueID or buff.ownerUid - DEFINE.ACTOR_NUM == uniqueID
                end
              end
            else
              owner_equal = true
            end
            if owner_equal and buff.round ~= nil and 0 < buff.round then
              if buff.exRound ~= nil and 0 < buff.exRound then
                buff.exRound = buff.exRound - 1
              else
                buff.round = buff.round - 1
                if 0 >= buff.round then
                  buffChange = true
                  if buffData.type == PB.enum.BuffFightType.SpecialAttrChange then
                    local definition = DEFINE.BuffFightType[buffData.type]
                    if definition[buffData.paramInt[2]] == "autoDisappear" then
                      table.insert(specialAttrChange, {target = target, buff = buff})
                    end
                  end
                  FightHelp.deleteBuff(buff, gameround, target)
                end
              end
            end
          end
          if buffData.type == PB.enum.BuffFightType.Remove or buffData.type == PB.enum.BuffFightType.RemoveStack or buffData.type == PB.enum.BuffFightType.MpOnceChange or buffData.type == PB.enum.BuffFightType.SpOnceChange or buffData.type == PB.enum.BuffFightType.SkillReset or buffData.type == PB.enum.BuffFightType.HpImmeChange or buffData.type == PB.enum.BuffFightType.HpImmeChangeMulti or buffData.type == PB.enum.BuffFightType.Bomb or buffData.type == PB.enum.BuffFightType.BuffRoundRefresh or buffData.type == PB.enum.BuffFightType.SpToMp then
            warning("GamePlay", "Remove buff exist? " .. buff.buffKey)
            buffChange = true
            FightHelp.deleteBuff(buff, gameround, target)
          end
          if buffData.type == PB.enum.BuffFightType.Shield and (buff.val == nil or 0 >= buff.val) then
            buffChange = true
            FightHelp.deleteBuff(buff, gameround, target)
            if buff.val ~= nil and 0 > buff.val then
              warning("GamePlay", buff.val)
            end
          end
          if buffData.type == PB.enum.BuffFightType.StackDelete and buff.stack >= buff.val then
            buffChange = true
            FightHelp.deleteBuff(buff, gameround, target)
          end
        end
      end
      if buffChange then
        FightHelp.updateAllBuff(target, teamList, gameround)
      end
    end
  end
  return specialAttrChange
end

function FightHelp.RefreshBuffRound(target, currentBuffData)
  local function SelectBuff(buffData, currentBuffData)
    local param_list = buffData.paramInt
    
    local definition = {
      "Type&SubType",
      "Category"
    }
    if definition[param_list[1]] == "Type&SubType" then
      if currentBuffData.type == param_list[2] and (param_list[3] == nil or param_list[3] == 0 or currentBuffData.paramInt[1] == param_list[3]) then
        return true
      end
    elseif definition[param_list[1]] == "Category" and table.has(currentBuffData.categoryList, param_list[2]) then
      return true
    end
  end
  
  for i = 1, #target.buffList do
    local buff = target.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and SelectBuff(currentBuffData, buffData) then
      buff.round = buffData.maxRound
    end
  end
end

function FightHelp.ShouldBeRemoved(removeBuffType, typeId, del_num, check_buff)
  local result = false
  local can_del = false
  if check_buff.mergeState == 0 then
    if 0 < del_num then
      can_del = true
    end
  else
    can_del = true
  end
  if can_del and check_buff.state ~= PB.enum.BuffFightState.Delete then
    local check_buffData = FightHelp.getBuffData(check_buff.buffKey.id, check_buff.buffKey.owner)
    if check_buffData.type ~= PB.enum.BuffFightType.Remove and check_buffData.type ~= PB.enum.BuffFightType.RemoveStack then
      if removeBuffType == 1 then
        if table.has(check_buffData.categoryList, typeId) then
          result = true
        end
      elseif removeBuffType == 2 then
        if check_buffData.id == typeId then
          result = true
        end
      elseif removeBuffType == 3 then
        if check_buffData.type == typeId then
          result = true
        end
      else
        error("GamePlay", "removeBuffType[" .. removeBuffType .. "] is invalid")
      end
    end
  end
  return result
end

function FightHelp.refreshShowBuff(result)
  for i = 1, #result do
    local buff = result[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete then
      if buffData.type == PB.enum.BuffFightType.Remove then
        buff.state = PB.enum.BuffFightState.Delete
        local removeBuffType = buffData.paramInt[1]
        local typeId = buffData.paramInt[2]
        local del_num = buff.val
        for j = 1, #result do
          local check_buff = result[j]
          if del_num == 0 and check_buff.mergeState == 0 then
            break
          end
          if FightHelp.ShouldBeRemoved(removeBuffType, typeId, del_num, check_buff) then
            if check_buff.mergeState == 0 then
              del_num = del_num - 1
            end
            check_buff.state = PB.enum.BuffFightState.Delete
            check_buff.removeType = 1
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.RemoveStack then
        buff.state = PB.enum.BuffFightState.Delete
        local removeBuffType = buffData.paramInt[1]
        local typeId = buffData.paramInt[2]
        local del_num = buff.val
        for j = 1, #result do
          local check_buff = result[j]
          if FightHelp.ShouldBeRemoved(removeBuffType, typeId, del_num, check_buff) then
            check_buff.stack = check_buff.stack - del_num
            if 0 >= check_buff.stack then
              check_buff.state = PB.enum.BuffFightState.Delete
              check_buff.removeType = 1
            end
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.Shield then
        if buff.val == nil or buff.val <= 0 then
          buff.state = PB.enum.BuffFightState.Delete
          if buff.val ~= nil and buff.val < 0 then
            warning("GamePlay", buff.val)
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.StackDelete then
        if buff.stack >= buff.val then
          buff.state = PB.enum.BuffFightState.Delete
        end
      elseif buffData.type == PB.enum.BuffFightType.MpOnceChange or buffData.type == PB.enum.BuffFightType.SpOnceChange or buffData.type == PB.enum.BuffFightType.SkillReset or buffData.type == PB.enum.BuffFightType.HpImmeChange or buffData.type == PB.enum.BuffFightType.Bomb or buffData.type == PB.enum.BuffFightType.HpImmeChangeMulti or buffData.type == PB.enum.BuffFightType.BuffRoundRefresh or buffData.type == PB.enum.BuffFightType.SpToMp then
        buff.state = PB.enum.BuffFightState.Delete
      end
    end
  end
end

function FightHelp.updateAllBuff(actor, teamList, gameround)
  local teamInfo = FightHelp.getTeamInfo(teamList, actor.team)
  FightHelp.refreshRemoveBuff(actor, teamInfo, gameround, teamList)
  local runtimeAttrs = FightHelp.getRuntimeAttrBuff(actor)
  local AllowLessThanZero = {
    [PB.enum.AttrType.CriticalResistanceRate] = true,
    [PB.enum.AttrType.FinalDamage] = true,
    [PB.enum.AttrType.FinalDamageRate] = true,
    [PB.enum.AttrType.FinalDamageHurt] = true,
    [PB.enum.AttrType.FinalDamageRateHurt] = true
  }
  for k, v in pairs(runtimeAttrs) do
    local type = v.type
    local baseVal = FightHelp.getActorBaseAttr(actor, type)
    actor.dynamicAttrs[type].value = baseVal * (1 + v.ratioValue / 10000) + v.value
    if actor.dynamicAttrs[type].value < 0 and not AllowLessThanZero[type] then
      actor.dynamicAttrs[type].value = 0
    end
  end
  FightHelp.refreshLockBuff(actor, teamInfo)
end

function FightHelp.refreshRemoveBuff(actor, teamInfo, gameround, teamList)
  if actor.buffList == nil then
    return
  end
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete then
      if buffData.type == PB.enum.BuffFightType.Remove then
        FightHelp.deleteBuff(buff, gameround, actor)
        local removeBuffType = buffData.paramInt[1]
        local typeId = buffData.paramInt[2]
        local del_num = buff.val
        for j = 1, #actor.buffList do
          local check_buff = actor.buffList[j]
          if del_num == 0 and check_buff.mergeState == 0 then
            break
          end
          if FightHelp.ShouldBeRemoved(removeBuffType, typeId, del_num, check_buff) then
            if check_buff.mergeState == 0 then
              del_num = del_num - 1
            end
            FightHelp.deleteBuff(check_buff, gameround, actor)
            check_buff.removeType = 1
            if buff.ownerUid ~= nil and check_buff.mergeState == 0 then
              local team = buff.ownerUid // 100
              if actor.team == 1 then
                if team == actor.team then
                  table.insert(teamInfo.statistic.buffKindList, buff.sourceId)
                end
              elseif actor.team == 2 and team ~= actor.team then
                table.insert(teamInfo.statistic.buffKindList, buff.sourceId)
              end
            end
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.RemoveStack then
        FightHelp.deleteBuff(buff, gameround, actor)
        local removeBuffType = buffData.paramInt[1]
        local typeId = buffData.paramInt[2]
        local del_num = buff.val
        for j = 1, #actor.buffList do
          local check_buff = actor.buffList[j]
          if FightHelp.ShouldBeRemoved(removeBuffType, typeId, del_num, check_buff) then
            check_buff.stack = check_buff.stack - del_num
            if 0 >= check_buff.stack then
              FightHelp.deleteBuff(check_buff, gameround, actor)
              check_buff.removeType = 1
              if buff.ownerUid ~= nil and check_buff.mergeState == 0 then
                local team = buff.ownerUid // 100
                if actor.team == 1 then
                  if team == actor.team then
                    table.insert(teamInfo.statistic.buffKindList, buff.sourceId)
                  end
                elseif actor.team == 2 and team ~= actor.team then
                  table.insert(teamInfo.statistic.buffKindList, buff.sourceId)
                end
              end
            end
          end
        end
      elseif buffData.type == PB.enum.BuffFightType.HpImmeChange or buffData.type == PB.enum.BuffFightType.HpImmeChangeMulti or buffData.type == PB.enum.BuffFightType.Bomb then
        FightHelp.deleteBuff(buff, gameround, actor)
        if 0 < actor.dynamicAttrs[HP_INDEX].value then
          local one_change_val = buff.val
          if 0 < one_change_val then
            one_change_val = FightHelp.changeHpAddByBuff(actor, one_change_val)
          end
          if one_change_val < 0 then
            local team = actor.team
            local otherTeam = 1
            if team == 1 then
              otherTeam = 2
            end
            local attackId = buff.ownerUid
            if attackId ~= 0 then
              local actorTable = FightHelp.getAllActors(teamList, false)
              local otherTeamInfo = FightHelp.getTeamInfo(teamList, otherTeam)
              for k = 1, #actorTable do
                local attack = actorTable[k]
                if attack.team == otherTeam and attack.uniqueID == attackId then
                  TS.damageList(otherTeamInfo, attack, -one_change_val)
                  break
                end
              end
            end
            local teamInfo = FightHelp.getTeamInfo(teamList, team)
            TS.totalDamage(teamInfo, one_change_val)
          end
          FightHelp.DynamicHpChange(actor, one_change_val, false, buffData.type)
        end
      elseif buffData.type == PB.enum.BuffFightType.MpOnceChange then
        FightHelp.deleteBuff(buff, gameround, actor)
        local mp_num = buff.val
        local activeSeat = -1
        if FightHelp.isSelfEnergy(teamInfo.dungeonType) then
          activeSeat = actor.baseSeat
        end
        FightHelp.addTeamEnergy(1, teamInfo, mp_num, DEFINE.GetDefineParams(teamInfo.stageParam).maxMp, activeSeat, 3)
      elseif buffData.type == PB.enum.BuffFightType.SpOnceChange then
        FightHelp.deleteBuff(buff, gameround, actor)
        local sp_num = buff.val
        local activeSeat = -1
        if FightHelp.isSelfEnergy(teamInfo.dungeonType) then
          activeSeat = actor.baseSeat
        end
        FightHelp.addTeamEnergy(2, teamInfo, sp_num, DEFINE.GetDefineParams(teamInfo.stageParam).maxSp, activeSeat, 3)
      elseif buffData.type == PB.enum.BuffFightType.SpToMp then
        FightHelp.deleteBuff(buff, gameround, actor)
        local spVal = math.max(0, buffData.paramInt[1])
        local activeSeat = -1
        if FightHelp.isSelfEnergy(teamInfo.dungeonType) then
          activeSeat = actor.baseSeat
        end
        local changeSp = math.min(spVal, FightHelp.getTeamEnergy(2, teamInfo, activeSeat))
        if buff.indexId ~= 9999 then
          FightHelp.addTeamEnergy(2, teamInfo, -changeSp, DEFINE.GetDefineParams(teamInfo.stageParam).maxSp, activeSeat, 3)
        else
          changeSp = spVal
        end
        local mp_num = math.ceil(changeSp * buff.val / 10000)
        FightHelp.addTeamEnergy(1, teamInfo, mp_num, DEFINE.GetDefineParams(teamInfo.stageParam).maxMp, activeSeat, 3)
      elseif buffData.type == PB.enum.BuffFightType.StackDelete then
        if buff.stack >= buff.val then
          FightHelp.deleteBuff(buff, gameround, actor)
        end
      elseif buffData.type == PB.enum.BuffFightType.BuffRoundRefresh then
        FightHelp.deleteBuff(buff, gameround, actor)
      elseif buffData.type == PB.enum.BuffFightType.SkillReset then
        FightHelp.deleteBuff(buff, gameround, actor)
        for c = 1, #teamInfo.cardsInHand do
          local card = teamInfo.cardsInHand[c]
          local uid = card.actorRuntimeID
          if uid == actor.uniqueID or uid - 3 == actor.uniqueID then
            local cardType = buff.val
            if FightHelp.CheckSkillMatch(cardType, card.actorID, card.assist, fif(not card.sCard, card.skillIndex, 0), fif(card.sCard, card.skillIndex, 0), card.linkID) then
              local use_count = 99999
              local fireCount = 0
              if card.sCard then
                fireCount = PB.get("ActorCombo", actor.actorInfo.id, 0, card.skillIndex).fireCount
              elseif card.linkID ~= 0 then
                fireCount = PB.get("ActorLink", card.linkID).fireCount
              else
                fireCount = PB.get("ActorCombo", actor.actorInfo.id, card.skillIndex, 0).fireCount
              end
              if DEFINE.GetDefineParams(teamInfo.stageParam).infiniteSkill ~= 1 and 0 < fireCount then
                use_count = fireCount
              end
              if FightHelp.isInfiniteCard(teamInfo.dungeonType, actor.team) then
                use_count = 99999
              end
              card.useCount = use_count
            end
          end
        end
      end
    end
  end
end

function FightHelp.getRoundMpChange(teamInfo, uid)
  local actor = FightHelp.getActorByUid(teamInfo, uid)
  if actor == nil then
    return 0
  end
  local result = 0
  for i = 1, #actor.buffList do
    local buff = actor.buffList[i]
    local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
    if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.ChangeRoundAddMp then
      local val = buff.val
      result = result + val
    end
  end
  return math.floor(result)
end

function FightHelp.refreshLockBuff(actor, teamInfo)
  if actor.isAssist then
    warning("GamePlay", "New Mode Can Not Add Buff To Assist")
    return
  end
  local islock = false
  if actor.buffList ~= nil then
    for i = 1, #actor.buffList do
      local buff = actor.buffList[i]
      local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
      if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.LockCard then
        islock = true
        break
      end
    end
  end
  local baseSeats = DEFINE.AllInOne[actor.baseSeat]
  for i = 1, #baseSeats do
    local uniqueId = DEFINE.GenRoundActorInfoUniqueId(actor.team, baseSeats[i])
    local actor = FightHelp.getActorByUid(teamInfo, uniqueId, true)
    if actor then
      actor.lock = islock
    end
  end
end

function FightHelp.DynamicHpChange(actor, val, allowZero, buffType)
  if buffType ~= 0 then
    table.insert(actor.hpOnceChange, {
      kind = buffType,
      val = val,
      index = #actor.hpOnceChange
    })
  end
  local change2Val = actor.dynamicAttrs[PB.enum.AttrType.Hp].value + val
  local max = FightHelp.getActorBaseAttr(actor, PB.enum.AttrType.Hp)
  local min = fif(allowZero, 0, 1)
  change2Val = math.max(min, math.min(max, change2Val))
  actor.dynamicAttrs[PB.enum.AttrType.Hp].value = change2Val
  TLog.CollectHp({
    action = "change",
    actorData = actor,
    changeVal = val,
    minVal = min,
    maxVal = max
  })
end

function FightHelp.getActorBaseAttr(actor, index)
  for m = 1, #actor.actorInfo.attrs do
    local attr = actor.actorInfo.attrs[m]
    if attr.type == index then
      return attr.value
    end
  end
  return 0
end

function FightHelp.getRuntimeAttrBuff(actor)
  local result = {}
  if actor.buffList == nil then
    return result
  end
  for n = HP_INDEX + 1, ATTR_MAX - 1 do
    local changeVal = 0
    local percentVal = 0
    for i = 1, #actor.buffList do
      local buff = actor.buffList[i]
      local buffData = FightHelp.getBuffData(buff.buffKey.id, buff.buffKey.owner)
      if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.Attr then
        local kind = buffData.paramInt[1]
        if kind == n then
          local val = buff.val
          if buffData.paramInt[2] == 0 or buffData.paramInt[2] == nil then
            changeVal = changeVal + val
          else
            local baseVal = FightHelp.getActorBaseAttr(actor, n)
            local predictVal = baseVal * (1 + val / 10000)
            if buffData.paramInt[7] and 0 < buffData.paramInt[7] and math.abs(predictVal - baseVal) >= buffData.paramInt[7] then
              changeVal = changeVal + fif(0 < predictVal - baseVal, buffData.paramInt[7], -buffData.paramInt[7])
            else
              percentVal = percentVal + val
            end
          end
        end
      end
      if buff.state ~= PB.enum.BuffFightState.Delete and buffData.type == PB.enum.BuffFightType.AttrTransmission then
        local kind = buffData.paramInt[1]
        if kind == n then
          local transmissionBaseAttr = buffData.paramInt[2]
          local baseAttr = FightHelp.getActorBaseAttr(actor, transmissionBaseAttr)
          if 0 < baseAttr then
            local param = buffData.paramInt[4]
            local val = buff.val
            local attrDiff = math.max(0, baseAttr - buffData.paramInt[5])
            if param == 0 or param == nil then
              changeVal = changeVal + math.floor(attrDiff * val / 10000)
            else
              percentVal = percentVal + attrDiff * val / 10000
            end
          end
        end
      end
    end
    table.insert(result, {
      type = n,
      ratioValue = percentVal,
      value = changeVal
    })
  end
  return result
end

function FightHelp.clearTeamUseCardData(teamList)
  for i = 1, #teamList do
    teamList[i].useResult = 0
    teamList[i].hitKeyList = {}
    teamList[i].hitResultList = {}
    teamList[i].buffKeyList = {}
    teamList[i].buffResultList = {}
    teamList[i].useCardList = {}
    teamList[i].useActionList = {}
    teamList[i].useLinkID = 0
    teamList[i].useCard = 0
    teamList[i].useSCard = 0
    teamList[i].useActorList = {}
    teamList[i].useSupportActor = 0
  end
end

function FightHelp.enableAutoFightCommandMode(dungeonType)
  local enabled = true
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.TowerNew or dungeonType == PB.enum.DungeonType.TeamPve or dungeonType == PB.enum.DungeonType.AsyncPvp or dungeonType == PB.enum.DungeonType.AsyncPvpV2 then
    enabled = false
  end
  return enabled
end

function FightHelp.getActorsByIdentityCategory(info, me, teamList)
  local result = {}
  local selfTeam = me.team
  local otherTeam = fif(selfTeam == 1, 2, 1)
  if info.identityCategory == PB.enum.IdentityCategory.Self then
    table.insert(result, FightHelp.getMainActor(teamList, me))
  elseif info.identityCategory == PB.enum.IdentityCategory.SelfTeam then
    result = FightHelp.getTeamActorsByKind(teamList, selfTeam, info.kind, info.isAll)
  elseif info.identityCategory == PB.enum.IdentityCategory.TargetTeam then
    result = FightHelp.getTeamActorsByKind(teamList, otherTeam, info.kind, info.isAll)
  elseif IdentityCategory2TeamSeat[info.identityCategory] then
    local teamSeat = IdentityCategory2TeamSeat[info.identityCategory]
    local actor = FightHelp.getTeamActorBySeatWithCorpse(teamList, teamSeat[1], teamSeat[2])
    if actor then
      table.insert(result, actor)
    end
  elseif info.identityCategory == PB.enum.IdentityCategory.SelfTeamNoMe then
    result = FightHelp.getTeamActorsByKind(teamList, selfTeam, PB.enum.KindForAppendSpecialAttrInfo.Main, true)
    local shouldRemove = table.find(result, function(_, v)
      return v.uniqueID == me.uniqueID
    end)
    if shouldRemove then
      table.remove(result, shouldRemove)
    end
  else
    warning("GamePlay", "invalid IdentityCategory [ " .. info.identityCategory .. " ] when getActorsByIdentityCategory()")
  end
  return result
end

function FightHelp.getTeamActorBySeatWithCorpse(teamList, team, seat)
  local actorTable = FightHelp.getAllActors(teamList, false)
  local seat2Actor = {}
  for i = 1, #actorTable do
    local actor = actorTable[i]
    if actor.team == team then
      seat2Actor[actor.seat] = actor
      if actor.seat == seat then
        if actor.dynamicAttrs[HP_INDEX].value > 0 then
          return actor
        else
          return nil
        end
      end
    end
  end
  return getTeamActorBySeatRecursive(seat2Actor, seat, true)
end

function getTeamActorBySeatRecursive(seat2Actor, seat, isForward)
  if isForward and seat < 1 or not isForward and 3 < seat then
    return nil
  end
  local fixSeat = seat + 1
  if isForward then
    fixSeat = seat - 1
  end
  if seat2Actor[fixSeat] then
    if seat2Actor[fixSeat].dynamicAttrs[HP_INDEX].value > 0 then
      return seat2Actor[fixSeat]
    else
      return nil
    end
  else
    return getTeamActorBySeatRecursive(seat2Actor, fixSeat, isForward)
  end
end

function FightHelp.GenDynamicTalentList(list, params)
  local result = {}
  if list and params then
    for i, v in pairs(list) do
      local level = 1
      local specialId = v
      local talentSource
      if type(v) == "table" then
        if params.nameLv and v[params.nameLv] then
          level = v[params.nameLv]
        end
        if params.nameSpecial and v[params.nameSpecial] then
          specialId = v[params.nameSpecial]
        end
        if params.nameSource and v[params.nameSource] then
          talentSource = v[params.nameSource]
        end
      end
      if type(specialId) == "number" and 0 < specialId then
        local elem = {
          talentId = specialId,
          talentValue = level,
          talentSource = talentSource,
          talentFlag = params.talentFlag or DEFINE.TalentFlagDEF.Common,
          talentIndex = params.index or i
        }
        table.insert(result, elem)
      end
    end
  end
  return result
end

return FightHelp
