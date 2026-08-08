local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_chapterId, m_clickCallback
local m_isNormalOrChallenge = true

function Start()
  this:BindRemote(DB:GameRequest("fci/dungeon/chapter-summary"), OnChapterSummaryChanged)
  WU.BindButtonEvent(REF.ButtonEntry, OnEntryClick)
  this:Bind("Chapter/chaptersHasReward", function(chapters)
    REF.Effect.gameObject:SetActive(0 < #chapters)
  end)
end

function OnEnable()
  m_chapterId = nil
end

function OnChapterSummaryChanged(chapterSummary)
  if chapterSummary then
    REF.LabelStar.UILabel.text = fif(m_isNormalOrChallenge, chapterSummary.totalNormalStar, chapterSummary.totalChallengeStar)
  end
end

function SetChapterId(chapterId)
  if WU.IsStandaloneGame() then
    REF["$gameObject"]:SetActive(false)
    return
  end
  if m_chapterId ~= chapterId then
    m_chapterId = chapterId
    if m_chapterId then
      this:SetData("ChapterRewardDefaultSelectChapter", m_chapterId)
    end
  end
  local chapterInfo = PB.get("ChapterInfo", chapterId)
  if chapterInfo then
    m_isNormalOrChallenge = chapterInfo.type == PB.enum.DungeonType.Normal
    local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
    REF.LabelStar.UILabel.text = fif(m_isNormalOrChallenge, chapterSummary.totalNormalStar, chapterSummary.totalChallengeStar)
  end
end

function SetShowStar(showStar)
  WU.ToggleRendering(REF.NodeStar, showStar)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function OnEntryClick()
  if m_clickCallback then
    m_clickCallback()
  end
  if m_chapterId then
    this:SetData("ChapterRewardDefaultSelectChapter", m_chapterId)
  end
  WU.AcquireWindowAsync("ChapterRewardListAll", function(win)
    _ENV["$"](win)["$$SetFrom"]("ChapterNormal")
  end)
end
