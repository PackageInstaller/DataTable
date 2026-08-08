local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_awardsTable, m_progressIndex, m_firstCanRewardIndex, m_summary

function SetupWindow()
  WU.TraverseChildren(REF.WrapContentReward, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.BtnGet, function(btn)
      local rewardInfo = _ENV["$"](btn)["@data"]
      this:GameRequest("fci/tower/floor-reward/"):Post({
        floorReward = rewardInfo.rewardTarget
      }, function(result)
        DBH.ResChange(result.resChange)
        m_summary.rewardGot = result.rewardGot
        this:SetData("fci/tower/summary/", m_summary)
        WU.ShowRewards(result.resChange)
        UpdateScrollContent()
      end)
    end)
  end)
end

function InitWindow()
  m_summary = this:GetData("fci/tower/summary")
  local awardList = PB.all("TowerFloorReward")
  m_awardsTable = {}
  for i = 1, #awardList do
    table.insert(m_awardsTable, 1, awardList[i])
  end
  LU.Bind(REF.WrapContentReward, {
    updateRow = OnAwardItemShow
  })
  UpdateScrollContent()
end

function UpdateScrollContent()
  m_progressIndex = nil
  m_firstCanRewardIndex = nil
  local awardCount = #m_awardsTable
  for i = awardCount, 1, -1 do
    local awards = m_awardsTable[i]
    if awards.towerFloor > m_summary.towerFloorRecord then
      if m_progressIndex == nil then
        m_progressIndex = i
      end
    elseif m_firstCanRewardIndex == nil and not _ENV["!"](m_summary.rewardGot):has(awards.towerFloor) then
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

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_awardsTable == nil or realIndex >= #m_awardsTable then
    return
  end
  local awards = m_awardsTable[realIndex + 1]
  local data = {}
  data.reward = awards.reward
  local _, floor = table.find(m_summary.rewardGot, function(_, v)
    return awards.towerFloor == v
  end)
  if floor ~= nil then
    data.rewardState = PB.enum.RewardState.HasGot
  elseif awards.towerFloor <= m_summary.towerFloorRecord then
    data.rewardState = PB.enum.RewardState.CanGet
  elseif m_progressIndex == realIndex + 1 then
    data.rewardState = PB.enum.RewardState.IsDoing
  else
    data.rewardState = PB.enum.RewardState.WillDo
  end
  data.currentValue = m_summary.towerFloorRecord
  data.rewardTarget = awards.towerFloor
  rowRef["$$SetData"](data)
  rowRef["$$SetRewardView"]()
  rowRef["$$SetStateView"]()
end
