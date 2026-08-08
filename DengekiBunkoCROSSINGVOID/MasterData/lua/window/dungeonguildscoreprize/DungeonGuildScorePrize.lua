inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GuildUtil")
local m_guildId, m_summary, m_rankList, m_rewardList, m_rewardsGot, m_totalScore, m_currentIndex

function SetupWindow()
  LU.Bind(REF.WrapContentRank, {
    updateRow = UpdateRankSlot
  })
  LU.Bind(REF.WrapContentReward, {
    updateRow = UpdateRewardSlot
  })
  WU.TraverseChildren(REF.WrapContentReward, function(go)
    WU.BindButtonEvent(_ENV["$"](go).Reward, OnRewardClick)
  end)
  WU.BindButtonEvent(REF.BtnPassReward, OnRewardClick)
end

function InitWindow()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
  WU.ToggleRendering(REF.RankList, false)
  WU.ToggleRendering(REF.NodeRewards, false)
  m_summary = this:GetData("DungeonGuild/Summary")
  UpdateSummaryUI()
  this:GameRequest("fci/guild-dungeon/v2/challenge-score/" .. m_guildId):Get(function(res)
    UpdateRankUI(res)
  end)
  this:BindRemote(DB:GameRequest("fci/guild-dungeon/v2/challenge-score/reward/"), function(res)
    UpdateRewardUI(res)
  end)
end

function UpdateSummaryUI()
  m_totalScore = m_summary.challengeTotalScore or 0
  REF.LabelTotalScore.UILabel.text = m_totalScore
  local dungeonProgress = m_summary.dungeonRecords[6].progress
  REF.LabelProgress.UILabel.text = tostring(dungeonProgress) .. "%"
  local dungeonId = m_summary.dungeonRecords[6].dungeonId
  m_rewardList = PB.all("GuildDungeonChallengeScoreReward"):where(function(k, v)
    return v.dungeonId == dungeonId
  end):toarray()
  table.sort(m_rewardList, function(a, b)
    return a.score < b.score
  end)
end

function UpdateRankUI(res)
  if res == nil or res.challengeScore == nil then
    m_rankList = _ENV["!"]({})
  else
    m_rankList = res.challengeScore
  end
  local memberList = this:GetData("fci/guild/members/")
  for i = #m_rankList, 1, -1 do
    local member = m_rankList[i]
    local _, v = table.find(memberList, function(k1, v1)
      return v1.playerId == member.playerId
    end)
    if v == nil then
      member.baseInfo = {
        headPhoto = -1,
        headFrame = -1,
        name = WU.GetString("DungeonGuild_AlreadyExit"),
        level = 0
      }
    else
      member.baseInfo = v
    end
  end
  local count = #m_rankList
  WU.SetActive(REF.RankEmpty, count == 0)
  if count ~= 0 then
    LU.Set(REF.WrapContentRank, count)
  end
  WU.ToggleRendering(REF.RankList, count ~= 0)
end

function UpdateRewardUI(res)
  if res == nil or res.rewardRecords == nil then
    m_rewardsGot = _ENV["!"]({})
  else
    m_rewardsGot = res.rewardRecords
  end
  local _, v = table.find(m_rewardsGot, function(k1, v1)
    return v1 == 0
  end)
  local hasPass = m_summary.dungeonRecords[6].isFinished
  local state
  if v then
    state = PB.enum.RewardState.HasGot
  elseif hasPass then
    state = PB.enum.RewardState.CanGet
  else
    state = PB.enum.RewardState.WillDo
  end
  WU.SetActive(REF.SpritePassReward, state == PB.enum.RewardState.WillDo)
  WU.SetActive(REF.SpritePassRewardGot, state == PB.enum.RewardState.HasGot)
  WU.SetActive(REF.EffectPassReward, state == PB.enum.RewardState.CanGet)
  if state == PB.enum.RewardState.CanGet then
    REF.EffectPassReward.EffectGenerator:Play()
  end
  local rewardRef = _ENV["$"](REF.BtnPassReward)
  rewardRef["@state"] = state
  rewardRef["@rewardIndex"] = 1
  rewardRef["@isPassReward"] = true
  LU.Set(REF.WrapContentReward, #m_rewardList - 1)
  WU.ToggleRendering(REF.NodeRewards, true)
  m_currentIndex = 0
  UpdateScrollContent()
end

function UpdateRankSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_rankList == nil or index > #m_rankList then
    return
  end
  local member = m_rankList[index]
  slotRef.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](member.baseInfo)
  slotRef.LabelName.UIHtmlLabel.text = member.baseInfo.name
  slotRef.LabelLevel.UIHtmlLabel.text = WU.GetString("Window_Level", member.baseInfo.level)
  slotRef.LabelScore.UIHtmlLabel.text = member.playerScore.maxBattleScore
  slotRef.LabelRank.UIHtmlLabel.text = index
end

function UpdateRewardSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1 + 1
  local allCount = #m_rewardList
  if m_rewardList == nil or index > allCount then
    return
  end
  local rewardInfo = m_rewardList[index]
  local showRight = index % 2 == 0
  WU.SetActive(slotRef.SpriteLeftLine, not showRight and index ~= allCount)
  WU.SetActive(slotRef.SpriteRightLine, showRight and index ~= allCount)
  local rewardRef = _ENV["$"](slotRef.Reward)
  rewardRef["$transform"].localPosition = fif(showRight, CS.UnityEngine.Vector3(-220, 80, 0), CS.UnityEngine.Vector3(220, 80, 0))
  local _, v = table.find(m_rewardsGot, function(k1, v1)
    return v1 == rewardInfo.score
  end)
  local state
  if v then
    state = PB.enum.RewardState.HasGot
  elseif rewardInfo.score <= m_totalScore then
    state = PB.enum.RewardState.CanGet
  else
    state = PB.enum.RewardState.WillDo
  end
  rewardRef["@state"] = state
  rewardRef["@rewardIndex"] = index
  rewardRef.LabelTarget.UILabel.text = rewardInfo.score
  WU.SetActive(rewardRef.EffectGet, state == PB.enum.RewardState.CanGet)
  if state == PB.enum.RewardState.CanGet then
    rewardRef.EffectGet.EffectGenerator:Play()
  end
  WU.SetActive(rewardRef.SpriteBase, state ~= PB.enum.RewardState.CanGet)
  WU.SetActive(rewardRef.SpriteGift, state == PB.enum.RewardState.WillDo)
  WU.SetActive(rewardRef.SpriteHasGot, state == PB.enum.RewardState.HasGot)
end

function OnRewardClick(go)
  local ref = _ENV["$"](go)
  local state = ref["@state"]
  local index = ref["@rewardIndex"]
  local rewardInfo = m_rewardList[index]
  local isPassReward = ref["@isPassReward"]
  if state == PB.enum.RewardState.WillDo then
    local title = fif(isPassReward, WU.GetString("DungeonGuild_PassReward"), WU.GetString("DungeonGuild_ScorePrizeTittle"))
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](rewardInfo.rewards, title, "", false)
    end)
  elseif state == PB.enum.RewardState.HasGot then
    local title = fif(isPassReward, WU.GetString("DungeonGuild_PassReward"), WU.GetString("DungeonGuild_ScorePrizeTittle"))
    local buttonTitle = WU.GetString("WindowGacha_Close")
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](rewardInfo.rewards, title, "", true, buttonTitle)
    end)
  else
    local path = "fci/guild-dungeon/v2/challenge-score/reward/"
    local postData = {
      dungeonId = m_summary.dungeonRecords[6].dungeonId,
      score = rewardInfo.score
    }
    this:GameRequest(path):Post(postData, function(result)
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange)
      this:SetData(path, result)
      if rewardInfo.score == 0 then
        ref["@state"] = PB.enum.RewardState.HasGot
      end
      GU.UpdateGuildDungeonRedPoint()
    end)
  end
end

function UpdateScrollContent()
  local refCount = #REF.WrapContentReward
  local canGetIndex, willDoIndex
  for i = m_currentIndex, refCount - 1 do
    local ref = _ENV["$"](REF.WrapContentReward[i].Reward)
    if ref["@state"] == PB.enum.RewardState.CanGet then
      canGetIndex = i
      break
    elseif ref["@state"] == PB.enum.RewardState.WillDo then
      willDoIndex = i
      break
    end
  end
  m_currentIndex = canGetIndex or willDoIndex or refCount - 1
  local itemHeight = REF.WrapContentReward.UIWrapContent.itemSize
  local distance = itemHeight * (m_currentIndex - 1)
  REF.ScrollViewReward.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, distance, 0))
  REF.ScrollViewReward.UIScrollView:RestrictWithinBounds(true)
end
