local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local m_awardsTable, m_progressIndex, m_firstCanRewardIndex, m_rewardStatus, m_battleScore, m_curProgressReward

function SetupWindow()
  WU.TraverseChildren(REF.WrapContentReward, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.BtnGet, function(btn)
      local rewardInfo = _ENV["$"](btn)["@data"]
      this:GameRequest("fci/RacePVPBattleScoreReward/"):Post({
        battleScore = rewardInfo.rewardTarget
      }, function(result)
        DBH.ResChange(result.resChange)
        table.insert(m_rewardStatus.rewardRecved, rewardInfo.rewardTarget)
        this:SetData("fci/RacePVPBattleScoreReward/", m_rewardStatus)
        WU.ShowRewards(result.resChange)
        UpdateScrollContent()
      end)
    end)
  end)
end

function InitWindow()
  m_rewardStatus = this:GetData("fci/RacePVPBattleScoreReward/")
  if m_rewardStatus then
    InitView()
  else
    this:GameRequest("fci/RacePVPBattleScoreReward/"):Get(function(res)
      if res == nil then
        return
      end
      this:SetData("fci/RacePVPBattleScoreReward/", res)
      m_rewardStatus = res
      InitView()
    end)
  end
end

function InitView()
  local awardList = PB.all("RacePVPBattleScoreReward")
  m_battleScore = this:GetData("fci/RacePVPInfo").battleScore
  m_awardsTable = {}
  for i = 1, #awardList do
    table.insert(m_awardsTable, 1, awardList[i])
  end
  LU.Bind(REF.WrapContentReward, {
    updateRow = OnAwardItemShow
  })
  UpdateScrollContent()
end

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_awardsTable == nil or realIndex >= #m_awardsTable then
    return
  end
  local awards = m_awardsTable[realIndex + 1]
  local data = {}
  data.reward = awards.rewards
  local _, score = table.find(m_rewardStatus.rewardRecved, function(_, v)
    return awards.battleScore == v
  end)
  if score ~= nil then
    data.rewardState = PB.enum.RewardState.HasGot
  elseif awards.battleScore <= m_battleScore then
    data.rewardState = PB.enum.RewardState.CanGet
  elseif m_progressIndex == realIndex + 1 then
    data.rewardState = PB.enum.RewardState.IsDoing
  else
    data.rewardState = PB.enum.RewardState.WillDo
  end
  data.currentValue = m_battleScore
  data.rewardTarget = awards.battleScore
  rowRef["$$SetData"](data)
  rowRef["$$SetThreeRewardsLeftStyle"]()
  rowRef["$$SetRewardView"]()
  rowRef["$$SetStateView"]()
end

function UpdateScrollContent()
  m_progressIndex = nil
  m_firstCanRewardIndex = nil
  local awardCount = #m_awardsTable
  for i = awardCount, 1, -1 do
    local awards = m_awardsTable[i]
    if awards.battleScore > m_battleScore then
      if m_progressIndex == nil then
        m_progressIndex = i
      end
    elseif m_firstCanRewardIndex == nil and not _ENV["!"](m_rewardStatus.rewardRecved):has(awards.battleScore) then
      m_firstCanRewardIndex = i
    end
  end
  LU.Set(REF.WrapContentReward, #m_awardsTable)
  local itemHeight = REF.WrapContentReward.UIWrapContent.itemSize
  local index = fif(m_firstCanRewardIndex == nil, m_progressIndex, m_firstCanRewardIndex)
  if index == nil then
    index = 1
  end
  local m_moveDistance = itemHeight * (index - 1)
  REF.ScrollViewReward.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
  REF.ScrollViewReward.UIScrollView:RestrictWithinBounds(true)
end
