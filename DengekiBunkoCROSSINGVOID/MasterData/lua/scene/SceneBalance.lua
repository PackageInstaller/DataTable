local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local Type2WindowName = {
  [PB.enum.DungeonType.AsyncPvp] = {
    "DungeonBalanceBurstLink",
    "DungeonBalanceAsyncPvpFailed"
  },
  [PB.enum.DungeonType.BurstLinkPvp] = {
    "DungeonBalanceBurstLink",
    "DungeonBalanceBurstLinkFailed"
  },
  [PB.enum.DungeonType.RacePVP] = {
    "DungeonBalanceRacePVP"
  },
  [PB.enum.DungeonType.FriendPvp] = {
    "DungeonBalanceTopPvpFriend"
  },
  [PB.enum.DungeonType.TeamPve] = {
    "DungeonBalanceTeam",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.Tower] = {
    "DungeonBalanceTower",
    "DungeonBalanceTowerFailed"
  },
  [PB.enum.DungeonType.TowerNew] = {
    "DungeonBalanceTowerNew",
    "DungeonBalanceTowerFailed"
  },
  [PB.enum.DungeonType.WeekActivity] = {
    "DungeonBalance",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.Normal] = {
    "DungeonBalance",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.Story] = {
    "StoryBalance",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.Training] = {
    "StoryBalance",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.Challenge] = {
    "StoryBalance",
    "DungeonBalanceChallengeFailed"
  },
  [PB.enum.DungeonType.Gold] = {
    "DungeonBalanceGold"
  },
  [PB.enum.DungeonType.Maze] = {
    "DungeonBalanceMaze",
    "DungeonBalanceTowerFailed"
  },
  [PB.enum.DungeonType.Triggered] = {
    "DungeonBalance",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.AssistGuild] = {
    "DungeonBalanceGuild"
  },
  [PB.enum.DungeonType.ChallengeGuild] = {
    "DungeonBalanceGuild"
  },
  [PB.enum.DungeonType.SemiFixed] = {
    "DungeonBalanceSemiFixed",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.MaidCafe] = {
    "DungeonBalanceMaidCafe",
    "DungeonBalanceFailed"
  },
  [PB.enum.DungeonType.RD] = {
    "DungeonBalanceRandomCall",
    "DungeonBalanceRandomCall"
  },
  [PB.enum.DungeonType.AsyncPvpV2] = {
    "DungeonBalanceAsyncPvpNew",
    "DungeonBalanceAsyncPvpNew"
  }
}

function Start()
  this:Bind("DungeonBalance/result", OnResult)
end

function OnResult(result)
  if result == nil then
    DU.CreateResetList()
    DU.ResetFlagExitGame()
    WU.ReturnCity("")
    return
  end
  local fightDungeonType = this:GetData("FightDungeonType")
  local resChange = result.resChange
  local expReturn = result.expReturn
  if result.balanceInfo then
    resChange = result.balanceInfo.resChange
    expReturn = result.balanceInfo.expReturn
  end
  DBH.ResChange(resChange)
  DBH.ResChange(expReturn)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  if fightDungeonType == PB.enum.DungeonType.AsyncPvpV2 and result.recordMode ~= nil then
    local windowParam = this:GetData("AsyncPvpNewWindowParam")
    WU.ReturnCity(windowParam)
  else
    local isWin = GetWinFlag(result, fightDungeonType)
    if isWin then
      local commands = this:GetData("Fight/CommandSequenceTemp")
      DU.SaveAutoFightCommands(dungeonId, commands)
    end
    local showWindow = Type2WindowName[fightDungeonType][fif(isWin, 1, 2)]
    if dungeonId and dungeonId == 2012 and fightDungeonType == PB.enum.DungeonType.Story then
      TutorialLogic(result)
    end
    if showWindow == nil then
      warning("GameLogic", "not set showWindow fightDungeonType = " .. fightDungeonType)
    else
      WU.AcquireWindowAsync(showWindow)
    end
  end
end

function GetWinFlag(result, type)
  if type == PB.enum.DungeonType.RacePVP or type == PB.enum.DungeonType.Gold or type == PB.enum.DungeonType.AssistGuild or type == PB.enum.DungeonType.ChallengeGuild or type == PB.enum.DungeonType.FriendPvp then
    return true
  end
  if type == PB.enum.DungeonType.AsyncPvp then
    return result.balanceInfo.win
  elseif type == PB.enum.DungeonType.AsyncPvpV2 then
    return result.common.balanceInfo.win
  elseif type == PB.enum.DungeonType.BurstLinkPvp then
    return result.isWin
  elseif type == PB.enum.DungeonType.TeamPve then
    return result.balanceInfo.win
  elseif type == PB.enum.DungeonType.TowerNew then
    return result.result and result.result.win
  elseif type == PB.enum.DungeonType.Maze then
    return result.result and result.result.win
  elseif type == PB.enum.DungeonType.MaidCafe then
    return result.balanceInfo.win
  elseif type == PB.enum.DungeonType.RD then
    return result.common.balanceInfo.win
  else
    return result.win
  end
end

function TutorialLogic(result)
  local targetGroupInfo = {
    1001,
    1008,
    0,
    0,
    2114,
    0
  }
  local tRewards = DU.GetDungeonBalanceRewards(result)
  local newActors = tRewards:where(function(k, v)
    return v.actor
  end):select(function(v)
    return v.actor
  end):toarray()
  if not newActors:empty() then
    local members = {}
    local actors = this:GetData("fci/actor/")
    if actors and 4 <= #actors then
      for i = 1, 6 do
        if targetGroupInfo[i] ~= 0 then
          local _, actor = table.find(actors, function(k, v)
            return v.id == targetGroupInfo[i]
          end)
          if actor then
            table.insert(members, {
              index = i - 1,
              actorUid = actor.uid
            })
          end
        else
          table.insert(members, {
            index = i - 1,
            actorUid = 0
          })
        end
      end
      table.sort(members, function(a, b)
        return a.index < b.index
      end)
      if #members == 6 then
        this:GameRequest("fci/ActorGroup/1"):Put(ProtobufT("ApiActorGroup", {members = members}), function()
          local groups = this:GetData("fci/ActorGroup/")
          if groups ~= nil then
            groups["1"].members = members
            this:SetData("fci/ActorGroup/", groups)
          end
        end)
      end
    end
  end
end
