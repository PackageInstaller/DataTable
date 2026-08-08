local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DU = require("Common/DungeonUtil")
local m_chapterInfos, m_itemWidth
local m_delayInterval = 0

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnSetChapterSlot
  })
end

function InitWindow()
  this:SetData("ChapterRewardMode", "ChapterChallenge")
  m_itemWidth = REF.WrapContent[0]["$UIWidget"].width
  m_chapterInfos = PB.all("ChapterInfo"):where(function(k, v)
    return v.type == PB.enum.DungeonType.Challenge
  end):toarray():sort(function(a, b)
    return a.chapterIndex < b.chapterIndex
  end)
  m_delayInterval = REF.ScrollView.UIPlayTween.mDelay
  LU.Set(REF.WrapContent, #m_chapterInfos)
  LocateScrollView()
  REF.LabelTotalStar.UILabel.text = ""
  this:Bind("fci/dungeon/chapter-summary", OnChapterSummaryChanged)
  this:RegisterGameEvent("ChapterPageTo", OnChapterPageTo)
end

function OnChapterPageTo(index)
  local chapterId = m_chapterInfos[index].chapterId
  this:SetData("WindowDungeon/ChapterId", chapterId)
  this:SetData("DungeonPrepare/ChapterId", chapterId)
end

function OnChapterSummaryChanged(chapterSummary)
  if chapterSummary then
    REF.LabelTotalStar.UILabel.text = chapterSummary.totalChallengeStar
  end
end

function OnSetChapterSlot(rowRef, wrapIndex, realIndex)
  rowRef["$$SetData"](m_chapterInfos[realIndex + 1].chapterId)
  rowRef["$$SetTweenDelay"](realIndex * m_delayInterval)
end

function LocateScrollView()
  local locateChapterId
  local lastUnlockChapterIndex = 0
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  for k, v in ipairs(m_chapterInfos) do
    if DU.IsChapterUnlocked(chapterSummary, m_chapterInfos[k].chapterId) then
      lastUnlockChapterIndex = k - 1
      locateChapterId = m_chapterInfos[k].chapterId
    else
      break
    end
  end
  REF.ScrollView.UIPanel:UpdateAnchors()
  local scrollViewWidth = REF.ScrollView.UIPanel.width
  local wrapContentItemWidth = REF.WrapContent.UIWrapContent.itemSize
  local leftItemIndex = lastUnlockChapterIndex - math.ceil((scrollViewWidth * 0.5 - m_itemWidth * 0.5) / wrapContentItemWidth)
  local offset = REF.WrapContent.UIWrapContent.itemSize * leftItemIndex * -1
  REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(offset, 0, 0))
  REF.ScrollView.UIScrollView:RestrictWithinBounds(true)
  return locateChapterId
end

function Goto()
end

function Focus(on)
  WU.RecordWindowFocus(100167, on)
end
