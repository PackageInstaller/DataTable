local WU, DB, REF = require("Common/WindowUtil")(this)
local LU = require("Common/ListUtil")
local m_allPrizes = {}

function SetupWindow()
  LU.Bind(REF.WrapContentReward, {
    updateRow = OnAwardItemShow
  })
end

function InitWindow()
  m_allPrizes = {}
  WU.ToggleRendering(REF.WrapContentReward, false)
end

function SetPrizes(prizes)
  if m_allPrizes then
    m_allPrizes = prizes
    WU.ToggleRendering(REF.WrapContentReward, true)
    LU.Set(REF.WrapContentReward, #m_allPrizes)
  end
end

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allPrizes == nil or realIndex >= #m_allPrizes then
    return
  end
  local awards = m_allPrizes[realIndex + 1]
  local data = {}
  data.reward = awards.reward
  rowRef["$$SetData"](data)
  rowRef["$$SetRewardView"]()
  rowRef.LabelTitle.UILabel.text = WU.GetString("Tournament_WinTimes", awards.id)
end
