local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local ATU = require("Common/AutumnUtil")
local m_allAwards, m_curAwards
local mTotalStar = 0
local mActivityId = 0
local mCurrentSummary = {}
local Mode = {
  "AutumnBonus",
  "GameCardMatch"
}

function SetupWindow()
end

function InitWindow()
end

function SetMode(mode)
  if Mode[mode] == "AutumnBonus" then
    AutumnBonus()
  elseif Mode[mode] == "GameCardMatch" then
    GameCardMatch()
  end
end

function GameCardMatch()
  REF.LabelTitle.UILabel.text = WU.GetString("GameCardMatch_Reward_Title")
  REF.NodeStar.gameObject:SetActive(false)
  m_allAwards = PB.all("PurblePairsReward")
  table.sort(m_allAwards, function(a, b)
    return a.matchedPairs < b.matchedPairs
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = OnGameCardMatchRewards
  })
  LU.Set(REF.WrapContent, #m_allAwards)
end

function OnGameCardMatchRewards(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allAwards == nil or realIndex >= #m_allAwards then
    return
  end
  local awards = m_allAwards[realIndex + 1]
  rowRef.StarNumber.UILabel.text = WU.GetString("Window_GameCardMatch_PreviewAffix", awards.matchedPairs)
  rowRef.StarNumber.transform.localPosition = CS.UnityEngine.Vector3(-370, 0, 0)
  rowRef.Grid.gameObject:SetActive(awards.reward)
  for i = 0, #rowRef.Grid - 1 do
    rowRef.Grid[i]["$gameObject"]:SetActive(i < #awards.reward)
    if i < #awards.reward then
      local award = awards.reward[i + 1]
      rowRef.Grid[i]["$$SetData"](award.type, award.id, award.count)
      if award.type == PB.enum.ResourceType.ResMedal then
        local data = {name = false}
        rowRef.Grid[i]["$$ShowCustom"](data)
      end
      rowRef.Grid[i]["$$SetClickCallback"](function()
        WU.ShowResourceDetail(award.type, award.id)
      end)
    end
  end
  rowRef.Grid.UIGrid:Reposition()
  rowRef.SpriteGet.gameObject:SetActive(false)
  rowRef.StarSprite.gameObject:SetActive(false)
  rowRef.ButtonGrayGet.gameObject:SetActive(false)
  rowRef.ButtonReward.gameObject:SetActive(false)
end

function AutumnBonus()
  REF.NodeStar.gameObject:SetActive(true)
  REF.LabelTitle.UILabel.text = WU.GetString("EventActivity_Reward_Title")
  local rewardSummary = this:GetData("fci/event-dungeon/star-reward")
  local activityId = this:GetData("EventActivity/CurrentActivity").activityId
  mActivityId = activityId
  m_allAwards = PB.all("EventReward"):where(function(k, v)
    return v.activityId == activityId
  end):toarray():sort(function(a, b)
    return a.star < b.star
  end)
  if rewardSummary.rewardSummary then
    UpdateRewardSummary(rewardSummary.rewardSummary)
  end
  LU.Bind(REF.WrapContent, {
    updateRow = OnAwardItemShow
  })
  LU.Set(REF.WrapContent, #m_allAwards)
  ScrollToFirstReward()
end

function ScrollToFirstReward()
  local currentAwardIndex = 0
  local rewardNotFound = true
  for k, item in pairs(m_allAwards) do
    if item.isReachStar and not item.hasGotReward then
      rewardNotFound = false
      break
    else
      currentAwardIndex = currentAwardIndex + 1
    end
  end
  if rewardNotFound then
    currentAwardIndex = 0
  end
  local itemHeight = REF.WrapContent.UIWrapContent.itemSize
  if 1 < currentAwardIndex then
    currentAwardIndex = currentAwardIndex - 0.5
  end
  local moveDistance = currentAwardIndex * itemHeight
  if moveDistance < 0 then
    moveDistance = 0
  end
  REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, moveDistance, 0))
  REF.ScrollView.UIScrollView:RestrictWithinBounds(true)
end

function IsRewardGot(star)
  if mCurrentSummary then
    for k, v in pairs(mCurrentSummary.rewardGot) do
      if v == star then
        return true
      end
    end
  end
  return false
end

function UpdateSummaryImpl()
  if m_allAwards == nil then
    return
  end
  if mCurrentSummary then
    mTotalStar = fif(mCurrentSummary.totalStar, mCurrentSummary.totalStar, 0)
    REF.LabelStarCount.UILabel.text = mTotalStar
    for k, item in pairs(m_allAwards) do
      item.isReachStar = mTotalStar >= item.star
      item.hasGotReward = IsRewardGot(item.star)
    end
  else
    REF.LabelStarCount.UILabel.text = "0"
    for k, item in pairs(m_allAwards) do
      item.isReachStar = false
      item.hasGotReward = false
    end
  end
end

function UpdateRewardSummary(rewardSummary)
  if m_allAwards == nil then
    return
  end
  mCurrentSummary = rewardSummary[mActivityId]
  UpdateSummaryImpl()
end

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allAwards == nil or realIndex >= #m_allAwards then
    return
  end
  local awards = m_allAwards[realIndex + 1]
  local hasGotReward = awards.hasGotReward
  local reachReward = awards.isReachStar
  rowRef.StarNumber.UILabel.text = awards.star
  rowRef.StarNumber.transform.localPosition = CS.UnityEngine.Vector3(-329, 0, 0)
  for i = 0, #rowRef.Grid - 1 do
    if awards.reward == nil then
      rowRef.Grid[i].root.gameObject:SetActive(true)
      rowRef.Grid[i].root["$SetClickCallback"](nil)
    else
      rowRef.Grid[i].root.gameObject:SetActive(i < #awards.reward)
      if i < #awards.reward then
        local award = awards.reward[i + 1]
        rowRef.Grid[i].root["$SetData"](award.type, award.id, award.count)
        if award.type == PB.enum.ResourceType.ResMedal then
          local data = {name = false}
          rowRef.Grid[i].root["$ShowCustom"](data)
        end
        rowRef.Grid[i].root["$SetClickCallback"](function()
          WU.ShowResourceDetail(award.type, award.id)
        end)
      end
    end
  end
  rowRef.Grid.UIGrid:Reposition()
  WU.ClearButtonEvent(rowRef.ButtonReward)
  rowRef.StarSprite.gameObject:SetActive(true)
  if hasGotReward then
    rowRef.SpriteGet.gameObject:SetActive(true)
    rowRef.ButtonReward.gameObject:SetActive(false)
    WU.SetActive(rowRef.ButtonGrayGet, false)
  elseif reachReward then
    rowRef.SpriteGet.gameObject:SetActive(false)
    rowRef.ButtonReward.gameObject:SetActive(true)
    WU.SetActive(rowRef.ButtonGrayGet, false)
    WU.BindButtonEvent(rowRef.ButtonReward, function()
      OnRewardClick({
        star = awards.star
      })
    end)
  else
    rowRef.SpriteGet.gameObject:SetActive(false)
    rowRef.ButtonReward.gameObject:SetActive(false)
    WU.SetActive(rowRef.ButtonGrayGet, true)
  end
end

function OnRewardClick(param)
  local rewardParams = {
    activity_id = mActivityId,
    star = param.star
  }
  this:GameRequest("fci/event-dungeon/star-reward"):Post(rewardParams, function(response)
    DBH.ResChange(response.resChange)
    WU.ShowRewards(response.resChange)
    table.insert(mCurrentSummary.rewardGot, param.star)
    UpdateSummaryImpl()
    LU.Set(REF.WrapContent, #m_allAwards, false)
    this:SetData("EventDungeon/RewardUpdateAble", true)
  end)
end
