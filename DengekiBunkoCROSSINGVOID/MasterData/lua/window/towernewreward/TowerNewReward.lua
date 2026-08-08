local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allRewards = {}
local m_rewardGot = {}
local m_summary = {}

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnRewardShow
  })
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/socre-reward/"), function(result)
    if result == nil then
      return
    end
    m_rewardGot = result.scoreRewardGot
    OnFloorChanged(this:GetData("fci/extreme-challenge/summary/"))
  end)
end

function OnFloorChanged(summary)
  m_allRewards = PB.all("ExtremeChallengeScoreReward"):where(function(k, v)
    return v.difficulty == summary.curDifficulty
  end):toarray()
  table.sort(m_allRewards, function(a, b)
    return a.score < b.score
  end)
  m_summary = summary
  REF.LabelTitle.UILabel.text = WU.GetString("Tower_RewardTitleFinal", WU.GetString("Tower_DifficultyRecommend_" .. m_summary.curDifficulty))
  REF.WrapContent.gameObject:SetActive(0 < #m_allRewards)
  LU.Set(REF.WrapContent, #m_allRewards)
end

function OnRewardShow(rowRef, wrapIndex, realIndex)
  if m_allRewards == nil or realIndex + 1 > #m_allRewards then
    return
  end
  local data = m_allRewards[realIndex + 1]
  local rewardGroup = data.reward
  local groupGasket = _ENV["$"](rowRef.RewardList).root
  local hasAchieve = table.find(m_rewardGot, function(_, v)
    return v == data.score
  end) ~= nil
  local getAble = m_summary.curScore >= data.score and not hasAchieve
  rowRef.BtnGet.gameObject:SetActive(getAble)
  rowRef.SpriteGot.gameObject:SetActive(hasAchieve)
  rowRef.Progress.gameObject:SetActive(not hasAchieve and not getAble)
  rowRef.SpriteProgress.UISprite.fillAmount = m_summary.curScore / data.score
  rowRef.LabelProgress.UILabel.text = m_summary.curScore .. " / " .. data.score
  rowRef.LabelTarget.UILabel.text = WU.GetString("Tower_Score") .. m_allRewards[realIndex + 1].score
  WU.ClearButtonEvent(rowRef.BtnGet)
  WU.BindButtonEvent(rowRef.BtnGet, function()
    WU.RecordButtonClick(100121501)
    DB:GameRequest("fci/extreme-challenge/socre-reward/"):Post({
      score = data.score
    }, function(result)
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange, function()
        this:SetData("fci/extreme-challenge/socre-reward/", {
          scoreRewardGot = result.scoreRewardGot
        })
      end)
    end)
  end)
  WU.TraverseChildren(groupGasket, function(go, index)
    local item = _ENV["$"](go)
    local idx = index + 1
    if rewardGroup[idx] then
      local reward = rewardGroup[idx]
      item["$$SetData"](reward.type, reward.id, reward.count)
      item["$$SetClickCallback"](function()
        WU.ShowResourceDetail(reward.type, reward.id)
      end)
    else
      item.root.gameObject:SetActive(false)
    end
  end)
end

function Focus(on)
  WU.RecordWindowFocus(1001215, on)
end
