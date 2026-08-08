local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local ACM = S:Get("ActivityManager")
local GU = require("Common/GroupUtil")
local NU = require("Common/NotepadUtil")
local LU = require("Common/ListUtil")
local m_data, m_selectedRankSlot, m_selectedRankActor, m_isInActivity
local m_selectActorGroupId = 1
local m_groups
local RankInfoColor = {
  rank1 = {2277113599, 995593215},
  rank2 = {2124535039, 1972487679},
  otherPlayer = {759396607, 3034117375},
  myself = {143382271, 753205247}
}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGrade, function()
    WU.RecordButtonClick(100126004)
    WU.AcquireWindowAsync("PrizePreview", function(window)
      _ENV["$"](window)["$$SetPrizePreview"]("RacePVPGrade")
    end)
  end)
  WU.BindButtonEvent(REF.ButtonBattleScoreReward, function()
    WU.AcquireWindowAsync("PrizePreview", function(window)
      WU.RecordButtonClick(100126001)
      _ENV["$"](window)["$$SetPrizePreview"]("RacePVPScore", {
        playerRecord = this:GetData("fci/RacePVPInfo").battleScore
      })
    end)
  end)
  WU.BindButtonEvent(REF.ButtonJoin, function()
    WU.RecordButtonClick(100126003)
    WU.AcquireWindowAsync("RacePVPPrepare")
  end)
  WU.BindButtonEvent(REF.TeamBlock, function()
    REF.TeamInfo["$Hide"]()
    WU.SetActive(REF.TeamBlock, false)
    WU.SetActive(m_selectedRankSlot.SpriteSelected, false)
    m_selectedRankSlot = nil
    m_selectedRankActor = 0
  end)
  LU.Bind(REF.RankWrapContent, {
    updateRow = UpdateRankSlot
  })
  WU.TraverseChildren(REF.RankWrapContent, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.root, function()
      WU.RecordButtonClick(100126002)
      local info = ref["@info"]
      if m_selectedRankSlot ~= nil then
        WU.SetActive(m_selectedRankSlot.SpriteSelected, false)
      end
      WU.SetActive(ref.SpriteSelected, true)
      m_selectedRankSlot = ref
      m_selectedRankActor = info.playerId
      REF.LabelPlayerName.UILabel.text = info.name
      for i = 1, 6 do
        local actor = info.battleActors[i]
        if actor == nil or actor.id == 0 then
          info.battleActors[i] = {id = -3}
        end
      end
      REF.WidgetDungeonGroup["$SetViewByActors"](info.battleActors, true)
      REF.TeamInfo["$Show"]()
      WU.SetActive(REF.TeamBlock, true)
    end)
  end)
  REF.LabelCost.ResourceChangeListener:AddListener(function(type, id, count)
    local resIconHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[U.ToInt(type)] .. "_" .. id .. "' />&nbsp;"
    local countHtml = fif(0 < count, count, "<font color=#fd5454>" .. count .. "</font>")
    REF.LabelCost.UIHtmlLabel.text = resIconHtml .. countHtml
  end, false)
  WU.SetActive(REF.TeamInfo, true)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/racePVP"), function(res)
    if res then
      if res.selectActorGroupId == 0 then
        m_selectActorGroupId = 1
      else
        m_selectActorGroupId = res.selectActorGroupId
      end
    end
  end)
  this:BindRemote(DB:GameRequest("fci/ActorGroup/"), function(groups)
    m_groups = groups
  end)
end

function InitWindow()
  this:RegisterGameEvent("OnNavigation", function(type)
    if type == "City" then
      OnNavigateToCity()
    end
  end)
  REF.TeamInfo["$Reset"]()
  WU.SetActive(REF.TeamBlock, false)
  m_selectedRankSlot = nil
  m_selectedRankActor = 0
  m_data = nil
  m_isInActivity = false
  local activityList = this:GetData("ActivityList")
  for k, v in ipairs(activityList) do
    if v.type == PB.enum.ActivityType.RacePVPActivity and ACU.IsActivityOn(v) then
      m_isInActivity = true
      break
    end
  end
  this:SetData("RacePVPisInActivity", m_isInActivity)
  WU.ToggleRendering(REF.Content, false)
  this:GameRequest("fci/RacePVPInfo"):Get(OnRacePVPInfo)
end

function UninitWindow()
  this:SetData("Share/RacePvpHasScore", nil)
  this:SetData("Share/RacePVP", nil)
end

function UpdateWindow(delta)
  if m_data ~= nil then
    local remainTime = m_data.endTime - CS.GameTime.serverUtc
    if 0 <= remainTime then
      REF.HtmlLabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(remainTime, REF.HtmlLabelRemainTime.UIHtmlLabel.fontSize)
    else
      m_data = nil
      this:GameRequest("fci/RacePVPInfo"):Get(OnRacePVPInfo)
    end
  end
end

function SetShareInfo()
  if m_groups == nil then
    return
  end
  local members = m_groups[tostring(m_selectActorGroupId)].members
  if members == nil then
    return
  end
  this:SetData("ShareConfig", {
    shareName = "RacePVP",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local allActors = DB:GetData("fci/actor/")
  local actorIds = {}
  for i = 1, #members do
    local _, actor = table.find(allActors, function(k, actor)
      return actor.uid == members[i].actorUid
    end)
    if actor then
      local index = 1
      if i <= 3 then
        index = 6 - (i - 1) * 2
      else
        index = 5 - (i - 4) * 2
      end
      actorIds[index] = actor.id
    end
  end
  local data = {
    actorIds = actorIds,
    highScore = m_data.battleScore,
    seg = m_data.grade.seg,
    subSeg = m_data.grade.subSeg
  }
  this:SetData("Share/RacePVP", data)
end

function OnRacePVPInfo(data)
  table.sort(data.players, function(a, b)
    if a.battleScore == b.battleScore then
      return a.timestamp < b.timestamp
    else
      return a.battleScore > b.battleScore
    end
  end)
  m_data = data
  SetView()
  local oldInfo = this:GetData("fci/RacePVPInfo")
  if oldInfo == nil or oldInfo.round ~= m_data.round then
    this:SetData("fci/RacePVPBattleScoreReward/", nil)
  end
  this:BindRemote(DB:GameRequest("fci/RacePVPBattleScoreReward/"), OnBattleScoreReward)
  this:SetData("Share/RacePvpHasScore", m_selectActorGroupId and m_selectActorGroupId ~= 0 and data.battleScore ~= 0)
  this:SetData("fci/RacePVPInfo", data)
end

function UpdateRankSlot(ref, wrapIndex, realIndex)
  if m_data and realIndex ~= nil and realIndex < #m_data.players then
    local rank = realIndex + 1
    local info = m_data.players[rank]
    ref["@info"] = info
    WU.SetActive(ref.SpriteSelected, m_selectedRankActor == info.playerId)
    ref.LabelName.UIHtmlLabel.text = info.name
    ref.LabelLevel.UIHtmlLabel.text = WU.GetString("Window_Level", info.level)
    ref.LabelScore.UIHtmlLabel.text = info.battleScore
    ref.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](info, 0.74)
    local isMyself = info.playerId == this:GetData("playerId")
    local colorIndex = fif(m_isInActivity, 2, 1)
    local rankfontSize = fif(rank <= 3, 92, 60)
    local rankfontColor = RankInfoColor[fif(rank <= 3, "rank1", "rank2")][colorIndex]
    local infofontColor = RankInfoColor[fif(isMyself, "myself", "otherPlayer")][colorIndex]
    ref.LabelRank.UIHtmlLabel.text = rank
    ref.LabelRank.UIHtmlLabel.fontSize = rankfontSize
    ref.LabelRank.UIHtmlLabel.color = CS.NGUIMath.HexToColor(rankfontColor)
    WU.TraverseChildren(ref.Info, function(go)
      _ENV["$"](go).root.UIHtmlLabel.color = CS.NGUIMath.HexToColor(infofontColor)
    end)
  end
end

function SetView()
  local all = PB.all("RacePVPSeg")
  local index, curGrade = GetGrade(m_data.score)
  if curGrade == nil then
    index = all:count()
    curGrade = all[index]
  end
  m_data.grade = curGrade
  local nextGrade = all[index + 1]
  local curScore = m_data.score - curGrade.score
  local nextScore
  if nextGrade == nil then
    nextScore = "99999"
  else
    nextScore = nextGrade.score - curGrade.score
  end
  REF.LabelProgress.UILabel.text = string.format("%d/%d", curScore, nextScore)
  REF.LabelGradeName.UILabel.text = WU.GetString(string.format("PVPREALRACE_GRADE_%d_%d", curGrade.seg, curGrade.subSeg))
  REF.ProgressBar.UIProgressBar.value = curScore / nextScore
  local rank, info = _ENV["!"](m_data.players):find(function(k, v)
    return v.playerId == this:GetData("playerId")
  end)
  m_data.battleScore = info.battleScore
  if m_data.battleScore == 0 then
    rank = PB.all("RacePVPRankScore"):count()
  end
  local rankScore = PB.get("RacePVPRankScore", rank).score
  if curGrade.protect and rankScore < 0 then
    rankScore = 0
  end
  if 0 <= rankScore then
    rankScore = "+" .. rankScore
  end
  REF.LabelRankScore.UILabel.text = rankScore
  REF.LabelRound.UILabel.text = WU.GetString("PVPREALRACE_ROUNDNUMBER", m_data.round)
  REF.EffectGrade.EffectGenerator.m_EffectName = fif(m_data.score == m_data.oldScore, "UI_DecrepitDream_L" .. curGrade.seg, "UI_DecrepitDream_ChangeL" .. curGrade.seg)
  REF.EffectGrade.EffectGenerator:Reset()
  WU.SetWindowTitle("RacePVP", fif(m_isInActivity, "RacePVPSpecial", "RacePVP"))
  REF.EffectBG.EffectGenerator.m_EffectName = fif(m_isInActivity, "UI_DecrepitDream_bgb", "UI_DecrepitDream_bg")
  REF.EffectBG.EffectGenerator:Reset()
  LU.Set(REF.RankWrapContent, #m_data.players)
  local dungeonReward = PB.get("DungeonReward", m_data.dungeonId)
  if dungeonReward then
    local cost = dungeonReward.cost[1]
    if cost ~= nil then
      do
        local stock = this:GetData("fci/item/" .. cost.id).count
        REF.LabelCost.ResourceChangeListener:SetResource(cost.type, cost.id)
        WU.ClearButtonEvent(REF.LabelCost)
        WU.BindButtonEvent(REF.LabelCost, function()
          OnShowTicketMessage(cost)
        end)
      end
    end
  else
    warning("DungeonReward not found", m_data.dungeonId)
  end
  if m_data.state == PB.enum.RacePVPStatus.Fight then
    REF.ButtonJoin.UIButton.isEnabled = true
    REF.LabelTimeTitle.UILabel.text = WU.GetString("PVPREALRACE_FIGHTREMAINTIME")
    REF.LabelJoin.UILabel.text = WU.GetString("PVPREALRACE_JOIN")
  elseif m_data.state == PB.enum.RacePVPStatus.Match then
    REF.ButtonJoin.UIButton.isEnabled = false
    REF.LabelTimeTitle.UILabel.text = WU.GetString("PVPREALRACE_SETTLEREMAINTIME")
    REF.LabelJoin.UILabel.text = WU.GetString("PVPREALRACE_SETTLEMENT")
  end
  WU.ToggleRendering(REF.Content, true)
end

function OnShowTicketMessage(cost)
  if cost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(cost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. cost.type))
  end
end

function OnBattleScoreReward(result)
  if result == nil then
    return
  end
  local rewardAvailable = false
  local isFighting = m_data.state == PB.enum.RacePVPStatus.Fight
  WU.SetActive(REF.ButtonBattleScoreReward, isFighting)
  WU.SetActive(REF.DisabledBattleScoreReward, not isFighting)
  if isFighting then
    local allRewards = PB.all("RacePVPBattleScoreReward")
    for i = 1, #allRewards do
      local info = allRewards[i]
      if info.battleScore <= m_data.battleScore and not _ENV["!"](result.rewardRecved):has(info.battleScore) then
        rewardAvailable = true
        break
      end
    end
    WU.SetActive(REF.BattleScoreAwardEffect, rewardAvailable)
    WU.SetActive(REF.SpriteRed, rewardAvailable)
  end
  local summary = this:GetData("fci/RacePVPSummary/")
  summary.rewardTag = rewardAvailable
  summary.tag = false
  this:SetData("fci/RacePVPSummary/", summary)
end

function OnNavigateToCity()
  local condition = NU.GetBoardSpeechConditions(PB.enum.SpeechType.RacePvp):first()
  if condition ~= nil then
    this:BroadcastGameEvent("BoardActorSpeech", condition.id)
  end
end

function GetGrade(score)
  local all = PB.all("RacePVPSeg")
  for i = 1, #all do
    if score < all[i].score then
      return i - 1, all[i - 1]
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(100126, on)
end
