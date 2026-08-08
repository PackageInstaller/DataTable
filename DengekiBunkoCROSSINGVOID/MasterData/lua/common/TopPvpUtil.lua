local ACU = require("Common/ActivityUtil")
local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local DU = require("Common/DungeonUtil")
local TPU = {}
local m_summaryKey = "fci/top-pvp/summary/"
local m_SegInfo, m_friendFightMsg
local m_noPopScene = {}
m_noPopScene.SceneFight = 1
m_noPopScene.SceneCartoon = 1
m_noPopScene.ScenePatch = 1
m_noPopScene.SceneLogin = 1
m_noPopScene.SceneNoman = 1
m_noPopScene.SceneBalance = 1
local m_busyWindow = {}
m_busyWindow.GachaResult = 1
m_busyWindow.GachaNormal = 1
m_busyWindow.GachaPeriodic = 1
m_busyWindow.NewActorGet = 1
m_busyWindow.DungeonTeamPrepare = 1
m_busyWindow.BurstLinkMatching = 1
m_busyWindow.GachaCinematic = 1
m_busyWindow.BurstLinkMatchSuccess = 1
m_busyWindow.DungeonStory = 1
m_busyWindow.DungeonGold = 1
m_busyWindow.WeekActivityPrepare = 1
m_busyWindow.ActivityActorGroup = 1
m_busyWindow.ActorGroup = 1
m_busyWindow.DungeonTraining = 1
m_busyWindow.BurstLinkJoin = 1
m_busyWindow.DungeonTeam = 1

function TPU.Init()
  local info = PB.all("TopPVPSeg"):toarray()
  table.sort(info, function(a, b)
    return a.score < b.score
  end)
  m_SegInfo = info
  m_friendFightMsg = {}
end

function TPU.GetSegRecordKey()
  return DB:GetData("playerId") .. "TopPvpSeqLvUpEffect"
end

function TPU.GetInfo()
  return DB:GetData(m_summaryKey)
end

function TPU.GetBaseInfo()
  return DB:GetData(m_summaryKey).baseInfo
end

function TPU.EnterFight(response)
  local dungeonInfo = response.dungeonInfo
  local team = dungeonInfo.teams
  CS.Restifizer.RestifizerManager.Instance:SetFightWebSocketUrl(response.fightsvrUrl)
  local fightActorInfo = {
    {
      playerId = team[1].members[1].playerId,
      actors = team[1].members[1].actors,
      name = team[1].members[1].name,
      level = team[1].members[1].level,
      headPhoto = team[1].members[1].headPhoto,
      socialPicture = team[1].members[1].socialPicture,
      members = team[1].members[1].actors,
      score = team[1].members[1].score
    },
    {
      playerId = team[2].members[1].playerId,
      actors = team[2].members[1].actors,
      name = team[2].members[1].name,
      level = team[2].members[1].level,
      headPhoto = team[2].members[1].headPhoto,
      socialPicture = team[2].members[1].socialPicture,
      members = team[2].members[1].actors,
      score = team[2].members[1].score
    }
  }
  DB:SetData("FightActorInfo", fightActorInfo)
  DB:SetData("TopPvpFightActorInfo", fightActorInfo)
  local enemyPlayer
  for i, v in ipairs(team) do
    if v.members[1].playerId ~= DB:GetData("playerId") then
      enemyPlayer = v
      break
    end
  end
  local myId = DB:GetData("playerId")
  local teamNum = 0
  if myId == team[1].members[1].playerId then
    teamNum = 1
  elseif myId == team[2].members[1].playerId then
    teamNum = 2
  end
  local playerNum = 2
  DB:SetData("FightPlayerCount", playerNum)
  local dungeonType = dungeonInfo.dungeonType
  WU.AcquireWindowAsync("TopPvpFightLoading", function(window)
    DB:SetData("DungeonTeam/TopPvpJoin", false)
    _ENV["$"](window).root["$InitData"](dungeonType)
    _ENV["$"](window).root["$SetCallback"](function()
      WU.EnterGameLevel(dungeonInfo.dungeonUid, nil, dungeonInfo.dungeonId, dungeonType, teamNum, false)
    end)
  end)
end

function TPU.IsFriendPVPUnlock(lv)
  local enumVal = WU.ActivityTypeToUnlockWindowType(PB.enum.ActivityType.TopPVP)
  return not WU.WindowIsLocked(enumVal, nil, lv)
end

function TPU.InviteFriendPVP(playerId)
  local friends = DB:GetData("fci/friendlist/")
  if friends then
    local i = table.find(friends, function(k, v)
      return v.playerId == playerId
    end)
    DB:SetData("TopPvpFriendOpPlayerCacheData", friends[i])
  end
  DB:SetData("TopPvpFriendOpPlayerId", playerId)
  WU.AcquireWindowAsync("TopPvpFriendJoin")
end

function TPU.IsShowRank(score)
  local seg = TPU.GetCurSegInfo(score)
  if seg == nil then
    return false
  end
  return seg.id == m_SegInfo[#m_SegInfo].id
end

function TPU.ResponseInvite(playerId, op)
  if op == 1 then
    DB:SetData("TopPvpFriendOpPlayerId", playerId)
    DB:GameRequest("fci/friendpvp/apply/"):Post({initiatorId = playerId}, function(response)
      WU.AcquireWindowAsync("TopPvpFriendActorGroup", function(window)
        _ENV["$"](window)["$$SetData"](response)
        local playerInfo = {}
        playerInfo.name = response.friendName
        playerInfo.level = response.friendLevel
        playerInfo.headPhoto = response.friendHeadPhoto
        playerInfo.headFrame = response.friendHeadFrame
        playerInfo.socialPicture = response.friendSocialPicture
        playerInfo.sex = response.friendSex
        _ENV["$"](window)["$$SetPlayerInfo"](playerInfo)
      end)
    end)
  elseif op == 2 then
    DB:GameRequest("fci/friendpvp/refuse/" .. playerId):Delete(function(response)
    end)
  end
end

function TPU.PlayReplay(dungeonUid)
  if dungeonUid == nil or dungeonUid == 0 then
    return
  end
  DB:GameRequest(string.format("fci/pvp-replay/watch/%d", dungeonUid)):Get(function(res)
    local fightActorInfo = {}
    local fightLuaTable = {}
    fightLuaTable.winTeam = res.winTeam
    fightLuaTable.initSeed = res.initSeed
    fightLuaTable.teamList = {}
    for i, v in ipairs(res.teamList) do
      local player = v.playerList[1]
      local fixActor = {}
      local playerInfo = {}
      for i = 1, 6 do
        fixActor[i] = player.actorList[i] or {}
      end
      playerInfo.playerId = player.playerId
      playerInfo.actors = fixActor
      playerInfo.members = fixActor
      playerInfo.headPhoto = player.headPhoto
      playerInfo.score = 0
      if player.score then
        playerInfo.score = player.score
      end
      playerInfo.socialPicture = player.socialPicture
      playerInfo.name = player.name
      playerInfo.isWin = i == res.winTeam
      fightActorInfo[#fightActorInfo + 1] = playerInfo
      local team = {}
      team.statistic = {}
      team.team = i
      team.statistic.inputList = v.inputList
      fightLuaTable.teamList[#fightLuaTable.teamList + 1] = team
    end
    DB:SetData("FightRecordMode", {})
    DB:SetData("FightDataRecord", fightLuaTable)
    DB:SetData("TopPvpFightActorInfo", fightActorInfo)
    DB:SetData("FightActorInfo", fightActorInfo)
    DB:SetData("FightActorInfoSynced", true)
    WU.EnterGameLevel(0, nil, res.dungeonId, PB.enum.DungeonType.AsyncPvp, 1, false)
  end)
end

function TPU.GetCurSegInfo(score)
  local curSeg = m_SegInfo[1]
  if score == nil then
    local data = CS.DataBindingManager.Instance:GetData(m_summaryKey)
    if data then
      score = data.baseInfo.score
    else
      score = 0
    end
  end
  for i, v in ipairs(m_SegInfo) do
    if score < v.score then
      break
    end
    curSeg = v
  end
  return curSeg
end

function TPU.CanAcceptFight(playerId)
  local windowName = DB:GetData("NavigationContext")
  local sceneName = WU.GetCurrentScene().name
  if m_noPopScene[sceneName] or m_busyWindow[windowName] then
    return 1
  end
  local go = CS.UnityEngine.GameObject.Find("BrowserToolbar")
  if go and go.activeSelf then
    return 1
  end
  local isDealingPlayer = DB:GetData("TopPvpFriendAcceptFight")
  if isDealingPlayer then
    if playerId == isDealingPlayer then
      return 2
    else
      return 1
    end
  end
  if DU.IsWaitingForJob(nil, true) then
    return 1
  end
  return 0
end

function TPU.DealScFriendPvpMatch(res)
  local function closeJoin()
    local ui = WU.FindWindow("TopPvpFriendJoin")
    
    if ui and ui.gameObject.activeSelf then
      _ENV["$"](ui)["$$CancelWaiting"](nil, true)
    end
  end
  
  if res.resultCode == 0 then
    WU.AcquireWindowAsync("TopPvpFriendActorGroup", function(window)
      _ENV["$"](window)["$$SetData"](res)
      local friends = DB:GetData("fci/friendlist/")
      if friends then
        local i = table.find(friends, function(k, v)
          return v.playerId == res.playerId
        end)
        local friendData = friends[i]
        if friendData == nil then
          friendData = DB:GetData("TopPvpFriendOpPlayerCacheData")
        end
        _ENV["$"](window)["$$SetPlayerInfo"](friendData)
      end
      closeJoin()
    end)
  elseif res.resultCode == PB.enum.FriendPvpMatchCode.TimeOver or res.resultCode == PB.enum.FriendPvpMatchCode.TimeOut or res.resultCode == PB.enum.FriendPvpMatchCode.Abandon then
    local ui = WU.FindWindow("TopPvpFriendActorGroup")
    if ui and ui.gameObject.activeSelf then
      _ENV["$"](ui)["$$ForceClose"](true)
    end
  else
    closeJoin()
  end
end

function TPU.DealScFriendPvpInvite(res)
  if res.resultCode == 0 then
    local result = TPU.CanAcceptFight(res.playerId)
    if result == 2 then
      return
    elseif result == 1 then
      TPU.ResponseInvite(res.playerId, 2)
    else
      DB:SetData("TopPvpFriendAcceptFight", res.playerId)
      local playerName = res.name
      local msg = WU.GetString("TopPvpJoin_Tips56", playerName)
      WU.ShowMessageYesNo(msg, function(result)
        DB:SetData("TopPvpFriendAcceptFight", nil)
        if result == "YES" then
          TPU.ResponseInvite(res.playerId, 1)
        else
          TPU.ResponseInvite(res.playerId, 2)
        end
      end)
    end
  else
    WU.ShowHintText(WU.GetString("TopPvpJoin_Tips65"))
    if DU.IsWatingPVPFriend(nil, true) then
      local ui = WU.FindWindow("TopPvpFriendJoin")
      if ui and ui.gameObject.activeSelf then
        _ENV["$"](ui)["$$CancelWaiting"]()
      end
    end
  end
end

function TPU.EnterFriendPvpReady(room_uid)
  DB:GameRequest("fci/friendpvp/ready/"):Post({roomUid = room_uid})
end

function TPU.EnterFriendPvpFight()
end

TPU.Init()
return TPU
