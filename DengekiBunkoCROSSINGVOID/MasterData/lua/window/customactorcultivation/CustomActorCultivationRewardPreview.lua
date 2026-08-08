local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_actorId, m_activityId, m_rewardsConfig

function SetupWindow()
  LU.Bind(REF.WrapContentReward, {
    updateRow = updateReward,
    delta = 0.01
  })
  local wrap = REF.WrapContentReward
end

function SetData(actorId, activityId)
  m_actorId = actorId
  m_activityId = activityId
  m_rewardsConfig = PB.all("CustomActorCultivationProgressReward")
  LU.Set(REF.WrapContentReward, #m_rewardsConfig)
end

function updateReward(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_rewardsConfig ~= nil and realIndex < #m_rewardsConfig then
    rowRef.LabelIndex.UILabel.text = m_rewardsConfig[realIndex + 1].progress
    local refNormalReward = rowRef.RewardList[0]
    local refVipReward = rowRef.RewardList[1]
    WU.SetActive(refNormalReward.VipNode, false)
    WU.SetActive(refNormalReward.root, false)
    WU.SetActive(refVipReward.root, false)
    WU.SetActive(rowRef.SpecialReward, false)
    local normalRewardConfig = m_rewardsConfig[realIndex + 1].reward[1]
    local vipRewardConfig = m_rewardsConfig[realIndex + 1].rewardVip[1]
    SetRewardWidget(refNormalReward, normalRewardConfig)
    SetRewardWidget(refVipReward, vipRewardConfig)
    local maxProgress = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_activityId).maxProgress
    if m_rewardsConfig[realIndex + 1].progress == maxProgress then
      WU.SetActive(rowRef.SpecialReward, true)
      rowRef.WidgetCustomActorCultivationCG["$SetData"](m_activityId, m_actorId)
    end
  end
end

function SetRewardWidget(refReward, rewardConfig)
  WU.SetActive(refReward.root, false)
  if rewardConfig then
    WU.SetActive(refReward.root, true)
    local item = {}
    if rewardConfig.chipCount > 0 then
      table.copy(PB.get("TalentResetCost", m_actorId).cost, item)
      item.count = rewardConfig.chipCount
    else
      item = rewardConfig.item
    end
    refReward.WidgetIconSlot["$SetData"](item.type, item.id, item.count)
  end
end
