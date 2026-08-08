local WU, DB, REF = require("Common/WindowUtil")(this)
local DBH = require("Manager/DataBindingHandler")
local RU = require("Common/RedMarkUtil")
local m_chapterRecord

function SetupWindow()
end

function SetChapter(ChapterRecord)
  if ChapterRecord then
    m_chapterRecord = ChapterRecord
    REF.LabelChapterRewards.UILabel.text = WU.GetString("Window_ChapterGiftHint", ChapterRecord.chapterId)
  end
  if m_chapterRecord then
    this:GameRequest("fci/dungeon/chapter/" .. m_chapterRecord.chapterId .. "/reward-all/"):Post({}, function(result)
      DBH.ResChange(result.resChange)
      this:SetData("ChapterRewardDefaultSelectChapter", m_chapterRecord.chapterId)
      m_chapterRecord.starRewardGot = result.starRewardGot
      local chapter = this:GetData("fci/dungeon/chapter/" .. m_chapterRecord.chapterId)
      if chapter then
        chapter.recordChapter = m_chapterRecord
        this:SetData("fci/dungeon/chapter/" .. m_chapterRecord.chapterId, chapter)
        RU.SetRedMark("ChapterReward/" .. m_chapterRecord.chapterId, false)
      end
      REF.EffectBg.EffectGenerator:Play(function()
        WU.ShowRewards(result.resChange, function()
          this:BroadcastGameEvent("TutorialTlog", "ChapterReward")
          WU.RecycleWindow("ChapterFinishPopup")
        end)
      end)
    end)
  end
end
