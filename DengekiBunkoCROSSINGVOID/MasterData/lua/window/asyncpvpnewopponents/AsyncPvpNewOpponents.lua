local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local m_opponents, m_effectOn

function SetupWindow()
  for i = 0, #REF.OpponentList - 1 do
    local ref = REF.OpponentList[i]
    WU.BindButtonEvent(ref["$gameObject"], OnFightClick)
  end
  REF.ButtonClose["$SetCallback"](OnCloseClick)
end

function InitWindow()
  WU.SetActive(REF.FindEffect, false)
  WU.SetActive(REF.EffectBg, false)
  WU.SetActive(REF.Opponent, false)
end

function SetView(isRemote)
  WU.SetActive(REF.Opponent, false)
  if isRemote then
    m_effectOn = true
    WU.SetActive(REF.FindEffect, true)
    WU.SetActive(REF.ButtonClose, false)
    this:DelayInvokeInSeconds(1, function()
      this:GameRequest("fci/asyncpvp_v2_match/"):Get(function(res)
        DBH.ResChange(res.resChange)
        m_opponents = res.opponents
        WU.SetActive(REF.FindEffect, false)
        WU.SetActive(REF.ButtonClose, true)
        m_effectOn = false
        InitOpponentView()
      end, function()
        WU.RecycleWindow("AsyncPvpNewOpponents")
      end)
    end)
  else
    local data = this:GetData("AsyncPvpNew/BaseInfo")
    m_opponents = data.opponents
    InitOpponentView()
  end
end

function InitOpponentView()
  local oList = _ENV["!"]({})
  for type, team in pairs(m_opponents) do
    team.targetType = type
    table.insert(oList, team)
  end
  table.sort(oList, function(a, b)
    return a.targetType < b.targetType
  end)
  for i = 1, #oList do
    local opponent = oList[i]
    local ref = REF.OpponentList[i - 1]
    ref["@targetType"] = opponent.targetType
    ref.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](opponent.team)
    ref.WidgetOpponentGroup["$ResetStyle"]()
    ref.WidgetOpponentGroup["$SetViewStyle"]({showArm = true})
    ref.WidgetOpponentGroup["$SetViewByActors"](opponent.team.battleActors, true)
    ref.LabelName.UILabel.text = opponent.team.playerName
    ref.LabelAssessment.UILabel.text = WU.GetString("NAsyncPvp_AssessmentScore", opponent.team.winScore)
    local segInfo = PB.get("AsyncPvpRankReward", opponent.team.curSeg)
    ref.SpriteRank.UISprite.spriteName = "icon_" .. segInfo.segRank
    ref.SpriteRankName.UISprite.spriteName = "illusion_level_" .. segInfo.segRank
    ref.SpriteSubRankName.UISprite.spriteName = "level_" .. segInfo.subSegRank
    ref.LabelLevel.UILabel.text = WU.GetString("Window_Level", opponent.team.playerLevel)
  end
  REF["$Animator"]:Play("Open", -1, 0)
  WU.SetActive(REF.EffectBg, true)
  this:DelayInvokeInFrames(1, function()
    WU.SetActive(REF.Opponent, true)
  end)
end

function OnFightClick(go)
  WU.ShowMessageYesNo(WU.GetString("NAsyncPvp_ChooseOpponentTip"), function(result)
    if result == "YES" then
      local ref = _ENV["$"](go)
      local targetType = ref["@targetType"]
      local opponentInfo = m_opponents[targetType]
      this:SetData("AsyncPvpNew/Opponent", opponentInfo)
      SetFightMembers(opponentInfo)
    end
  end)
end

function SetFightMembers(opponentInfo)
  local actorList = {}
  this:RegisterGameEvent("fci/actor/", function()
    SetFightActorInfo(actorList, opponentInfo)
  end)
  GU.SetGroupMode(PB.enum.ActorGroupType.AsyncPvpNew)
  this:GameRequest(this:GetData("ActorGroup/SelectedGroupIdUri")):Get(function(result)
    local selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:GameRequest(this:GetData("ActorGroup/GroupUri")):Get(function(groups)
      local members = groups[tostring(selectedGroupId)].members
      for i = 1, #members do
        local member = members[i]
        if member.actorUid and member.actorUid ~= 0 then
          this:Bind("fci/actor/" .. member.actorUid, function(actor)
            if actor then
              actorList[member.index + 1] = actor
            end
          end)
        else
          actorList[member.index + 1] = {}
        end
      end
      local fightActorInfo = {
        {
          playerId = this:GetData("playerId"),
          actors = actorList
        },
        {
          playerId = opponentInfo.team.playerId,
          actors = opponentInfo.team.battleActors
        }
      }
      this:SetData("FightActorInfo", fightActorInfo)
      local dungeonId = PB.index("Misc", 1).asyncPvpV2Info.dungeonID
      local param = {
        dungeonExCreateParam = {
          common = {dungeonId = dungeonId, selectActorGroupId = selectedGroupId},
          asyncPvpV2 = {
            targetType = opponentInfo.targetType
          }
        }
      }
      local uri = "fci/dungeon-ex/"
      local wireFormatTable = ProtobufT("ApiDungeonEx", param)
      this:GameRequest(uri):Post(wireFormatTable, function(response)
        this:BroadcastGameEvent("MedalAttrAppend")
        this:SetData("AsyncPvpNew/FightGroup", members)
        local exResponse = response.dungeonExCreateResult
        WU.EnterGameLevel(exResponse.common.dungeonUid, nil, dungeonId, PB.enum.DungeonType.AsyncPvpV2, 1, false)
      end)
    end)
  end)
end

function OnCloseClick()
  local data = this:GetData("AsyncPvpNew/BaseInfo")
  data.opponents = m_opponents
  this:SetData("AsyncPvpNew/BaseInfo", data)
  WU.RecycleWindow("AsyncPvpNewOpponents")
end
