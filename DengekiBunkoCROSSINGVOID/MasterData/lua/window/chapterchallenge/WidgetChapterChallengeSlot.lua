local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local RU = require("Common/RedMarkUtil")
local m_chapterId, m_isUnlocked

function Start()
  WU.BindButtonEvent(REF.Button, OnButtonClick)
end

function SetData(chapterId)
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  m_isUnlocked = DU.IsChapterUnlocked(chapterSummary, chapterId)
  WU.ToggleRendering(REF.Lock, not m_isUnlocked)
  REF.LabelName.UILabel.text = chapterId % 1000
  if m_chapterId ~= nil and m_chapterId ~= chapterId then
    this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnGetChapterInfo)
    RU.UnbindRedMark(this, string.format("Activity/%s/Reward/%s", PB.enum.ActivityType.ChallengeMode, m_chapterId))
  end
  m_chapterId = chapterId
  WU.ToggleRendering(REF.LabelStar, false)
  WU.ToggleRendering(REF.LabelStarTotal, false)
  this:Bind("fci/dungeon/chapter/" .. chapterId, OnGetChapterInfo)
  RU.BindRedMark(this, string.format("Activity/%s/Reward/%s", PB.enum.ActivityType.ChallengeMode, chapterId), OnRedMarkChange)
  REF.TextureBg.UITexture.mainTexturePath = "Texture/ChallengeChapter/challenge_card_" .. 1000 + chapterId % 1000
  WU.ToggleRendering(REF.SpritePassed, DU.IsChapterFinished(chapterSummary, chapterId))
end

function SetTweenDelay(delayTime)
  local tweens = REF.Visual.transform:GetComponents(typeof(CS.UITweener))
  for i = 0, tweens.Length - 1 do
    tweens[i].delay = delayTime
  end
end

function OnGetChapterInfo(chapter)
  if chapter then
    WU.ToggleRendering(REF.LabelStar, true)
    WU.ToggleRendering(REF.LabelStarTotal, true)
    local star
    if chapter.recordChapter then
      star = chapter.recordChapter.totalStar
      CheckChapterReward(chapter.recordChapter)
    else
      star = 0
    end
    local chapterInfo = PB.get("ChapterInfo", m_chapterId)
    if chapterInfo then
      REF.LabelStar.UILabel.text = star
      REF.LabelStarTotal.UILabel.text = #chapterInfo.dungeonId * 3
    end
  end
end

function OnButtonClick()
  WU.RecordButtonClick("167" .. m_chapterId)
  if m_isUnlocked then
    this:SetData("WindowDungeon/ChapterId", m_chapterId)
    this:SetData("DungeonPrepare/ChapterId", m_chapterId)
    WU.AcquireWindowAsync("ChallengeDungeon")
  else
    DU.ShowChallengeChapterUnlockHint(m_chapterId)
  end
end

function OnRedMarkChange(flag)
  WU.ToggleRendering(REF.SpriteRedMark, flag)
end

function CheckChapterReward(record)
  local hasReward = DU.DoesChapterHasStarReward(record)
  RU.SetRedMark(string.format("Activity/%s/Reward/%s", PB.enum.ActivityType.ChallengeMode, record.chapterId), hasReward)
end
