local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local DEFINE = require("Logic/Define")

local function BuildRoundTeamInfo(teamInfo)
  local roundTeamInfo = {
    playerList = {}
  }
  local roundPlayerInfoList = {}
  local roundActorInfoList = {}
  local baseSeat = 1
  for i = 0, teamInfo.playerList.Count - 1 do
    local FCPlayerInfo = teamInfo.playerList[i]
    local roundPlayerInfo = {
      playerId = FCPlayerInfo.playerId
    }
    table.insert(roundPlayerInfoList, roundPlayerInfo)
    for ai = 0, FCPlayerInfo.actorGroupList.Count - 1 do
      roundActorInfoList[baseSeat] = {}
      local actorGroup = FCPlayerInfo.actorGroupList[ai]
      local mainSTActor = {
        id = actorGroup.id,
        uniqueWeaponId = actorGroup.uniqueWeaponId,
        uniqueWeaponPhase = actorGroup.uniqueWeaponPhase
      }
      mainSTActor.talentInfo = {}
      for si = 0, actorGroup.specials.Count - 1 do
        local special = actorGroup.specials[si]
        table.insert(mainSTActor.talentInfo, {
          talentId = special.specialIndex,
          talentValue = special.level
        })
      end
      table.insert(roundActorInfoList[baseSeat], {actorInfo = mainSTActor, seat = baseSeat})
      local subSTActor = {
        id = actorGroup.sub_id,
        uniqueWeaponId = actorGroup.sub_uniqueWeaponId,
        uniqueWeaponPhase = actorGroup.sub_uniqueWeaponPhase
      }
      subSTActor.talentInfo = {}
      for si = 0, actorGroup.sub_specials.Count - 1 do
        local special = actorGroup.sub_specials[si]
        table.insert(subSTActor.talentInfo, {
          talentId = special.specialIndex,
          talentValue = special.level
        })
      end
      table.insert(roundActorInfoList[baseSeat], {
        actorInfo = subSTActor,
        seat = baseSeat + DEFINE.HALF_ACTOR_NUM
      })
      baseSeat = baseSeat + 1
    end
  end
  while baseSeat <= 3 do
    roundActorInfoList[baseSeat] = {}
    table.insert(roundActorInfoList[baseSeat], {
      actorInfo = {id = 0},
      seat = baseSeat
    })
    table.insert(roundActorInfoList[baseSeat], {
      actorInfo = {id = 0},
      seat = baseSeat + DEFINE.HALF_ACTOR_NUM
    })
    baseSeat = baseSeat + 1
  end
  if #roundPlayerInfoList == 1 then
    roundPlayerInfoList[1].actorList = {}
    for i = 1, #roundActorInfoList do
      table.append(roundPlayerInfoList[1].actorList, roundActorInfoList[i])
    end
  else
    while #roundPlayerInfoList < 3 do
      local roundPlayerInfo = {
        playerId = "FixPlayer" .. tostring(#roundPlayerInfoList)
      }
      table.insert(roundPlayerInfoList, roundPlayerInfo)
    end
    for i = 1, #roundPlayerInfoList do
      roundPlayerInfoList[i].actorList = roundActorInfoList[i]
    end
  end
  for i = 1, #roundPlayerInfoList do
    table.insert(roundTeamInfo.playerList, roundPlayerInfoList[i])
  end
  return roundTeamInfo
end

function BuildTeamList(dungeonType)
  local result = {}
  local roundTeamInfo = BuildRoundTeamInfo(CS.FightConfig.Instance.m_team1)
  roundTeamInfo.team = 1
  table.insert(result, roundTeamInfo)
  if dungeonType == PB.enum.DungeonType.None then
    roundTeamInfo = BuildRoundTeamInfo(CS.FightConfig.Instance.m_team2)
    roundTeamInfo.team = 2
    table.insert(result, roundTeamInfo)
  else
    local dungeonMonster = PB.get("DungeonMonster", tonumber(CS.GameLoading.Instance.StageName))
    local FightConfig = CS.FightConfig.Instance
    local params = {}
    for seat = 1, DEFINE.ACTOR_NUM do
      table.insert(params, dungeonMonster.monsterId[seat] or 0)
    end
    local playerInfoCS = CS.FCPlayerInfo(table.unpack(params))
    FightConfig.m_team2.playerList[0] = playerInfoCS
  end
  return result
end

function CreateModel(randomSeed)
  local dungeonType = DB:GetData("FightDungeonType")
  local currentTutorial = DB:GetData("CurrentTutorial") or 0
  currentTutorial = fif(dungeonType == PB.enum.DungeonType.Story, currentTutorial, 0)
  local playerCount = DB:GetData("FightPlayerCount") or 1
  local debugMode = 0
  local testActor = 0
  local teamList = {}
  if __EditorMode then
    local FightConfig = CS.FightConfig.Instance
    debugMode = FightConfig.m_FirstTeam
    testActor = FightConfig.m_AutoGenSkillActorId
    local FightTest = CS.FightTest.Instance
    if 0 < FightTest.m_testLinkActors.Count then
      testActor = FightTest.m_testLinkActors[0]
    end
  end
  if CS.SceneFight.s_Standalone then
    info("GameLogic", "---------\230\173\163\229\156\168\228\189\191\231\148\168\229\141\149\230\156\186\230\181\139\232\175\149\231\154\132\232\167\146\232\137\178\230\149\176\230\141\174---------")
    teamList = BuildTeamList(dungeonType)
  else
    local fightActorInfo = DB:GetData("FightActorInfo") or {}
    for i = 1, #fightActorInfo do
      local e = fightActorInfo[i]
      local roundPlayerInfo = {
        playerId = e.playerId,
        actorList = {}
      }
      for seat = 1, #e.actors do
        local STActor = {}
        table.copy(e.actors[seat], STActor, true)
        local roundActorInfo = {actorInfo = STActor, seat = seat}
        table.insert(roundPlayerInfo.actorList, roundActorInfo)
      end
      local roundTeamInfo = {
        team = i,
        playerList = {roundPlayerInfo}
      }
      table.insert(teamList, roundTeamInfo)
    end
  end
  local initList = {}
  local fightInitInfo = DB:GetData("FightInitInfo") or {}
  local gameRound = fightInitInfo.gameRound or 0
  for i = 1, #fightInitInfo do
    local initInfo = fightInitInfo[i]
    local roundTeamInitData = {
      hpList = initInfo.hp or {},
      recordSp = initInfo.sp or 0,
      recordMp = initInfo.mp or 0,
      monsterList = initInfo.monsterList or {},
      recordBuffs = initInfo.recordBuffs or {},
      allCardUseCount = initInfo.allCardUseCount or {},
      energyWPList = initInfo.energyWPList or {},
      baseSeat1AffixList = initInfo.baseSeat1AffixList or {},
      baseSeat2AffixList = initInfo.baseSeat2AffixList or {},
      baseSeat3AffixList = initInfo.baseSeat3AffixList or {}
    }
    table.insert(initList, roundTeamInitData)
  end
  return {
    dungeonType = dungeonType,
    stageID = tonumber(CS.GameLoading.Instance.StageName),
    teamList = teamList,
    initList = initList,
    guideType = currentTutorial,
    debugMode = debugMode,
    testActor = testActor,
    playerCount = playerCount,
    randomSeed = randomSeed,
    fightBuffs = DB:GetData("FightBuffAffix") or {},
    speedMode = 0,
    gameRound = gameRound
  }
end
