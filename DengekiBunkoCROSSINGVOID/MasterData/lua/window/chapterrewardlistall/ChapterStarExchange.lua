local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_chapterId, m_oneStarRewardCount, m_remainNum

function Awake()
  m_oneStarRewardCount = PB.index("Misc", 1).oneStarRewardCount
  WU.BindButtonEvent(REF.ButtonGet, OnGetClick)
  WU.ToggleRendering(REF.StarExchangeContent, false)
  this:BindRemote(DB:GameRequest("fci/starexchange"), OnStarExchangeChange)
end

function OnStarExchangeChange(result)
  if result == nil then
    return
  end
  m_remainNum = result.starNum
  WU.ToggleRendering(REF.StarExchangeContent, true)
  REF.LabelOneStarRewardCount.UILabel.text = WU.GetString("ChapterReward_OneStarRewardCount", m_oneStarRewardCount)
  REF.ButtonGet.UIButton.isEnabled = 0 < m_remainNum
  REF.LabelStarCount.UILabel.text = m_remainNum
  REF.LabelMoneyCount.UILabel.text = m_remainNum * m_oneStarRewardCount
  if 0 < m_remainNum then
    REF.LabelButtonGet.UILabel.text = WU.GetString("Window_Get")
  else
    REF.LabelButtonGet.UILabel.text = WU.GetString("ChapterReward_NoReward")
  end
end

function OnGetClick()
  this:GameRequest("fci/starexchange/" .. m_remainNum):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    this:SetData("fci/starexchange", result)
  end)
end
