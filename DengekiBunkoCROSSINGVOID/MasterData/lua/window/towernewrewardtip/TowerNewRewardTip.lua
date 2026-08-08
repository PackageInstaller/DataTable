local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allRewards = {}
local m_getAble = false
local m_curFloor, m_summary, m_reward

function SetupWindow()
  LU.Bind(REF.RewardContent, {
    updateRow = OnRewardShow
  })
  WU.BindButtonEvent(REF.BtnOK, function()
    if m_getAble then
      DB:GameRequest("fci/extreme-challenge/reward/"):Post({floor = m_curFloor}, function(result)
        DBH.ResChange(result.resChange)
        m_reward.rewardGot = result.rewardGot
        Show(m_allRewards, m_curFloor)
        WU.ShowRewards(result.resChange, function()
          this:SetData("fci/extreme-challenge/reward/", m_reward)
          WU.RecycleWindow(this)
        end)
      end)
    else
      WU.RecycleWindow(this)
    end
  end)
end

function Show(rewards, floor, getAble)
  m_allRewards = rewards
  m_getAble = getAble
  m_curFloor = floor
  m_summary = this:GetData("fci/extreme-challenge/summary/")
  m_reward = this:GetData("fci/extreme-challenge/reward/")
  REF.LabelDesc.UILabel.text = WU.GetString("Tower_RewardTip", WU.GetString("Tower_DifficultyRecommend_" .. m_summary.curDifficulty), floor)
  REF.LabelOK.UILabel.text = fif(m_getAble, WU.GetString("Window_Get"), WU.GetString("Window_GotIt"))
  LU.Set(REF.RewardContent, #m_allRewards)
end

function OnRewardShow(rowRef, wrapIndex, realIndex)
  if m_allRewards and realIndex < #m_allRewards then
    local item = m_allRewards[realIndex + 1]
    rowRef["$$SetData"](item.type, item.id, item.count)
    rowRef["$$SetClickCallback"](function()
      WU.ShowResourceDetail(item.type, item.id)
    end)
  end
end
