local base = inherit("Window/ChapterNormal/WidgetDungeonBaseSlot", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_unlocked = false
local m_normalChapterId, m_dunRecord

function Awake()
  WU.BindButtonEvent(REF["$"], OnDungeonClick)
end

function SetData(data)
  base.SetData(data)
  m_chapterId = base.GetChapterId()
  m_dungeonId = base.GetDunId()
  m_normalChapterId = data.normalChapterId
  local chapter = data.chapter
  local dungeonId = data.dungeonId
  local dungeonRecord = chapter.recordDungeons[dungeonId]
  m_dunRecord = dungeonRecord
  m_unlocked = DU._IsDungeonUnlock(dungeonRecord)
  REF.Reward.UIPlayTween:Stop()
  if m_unlocked then
    REF.RewardBG.UISprite.spriteName = "training_on"
    if dungeonRecord and dungeonRecord.finished == false and dungeonRecord.unlocked then
      REF.Reward.UIPlayTween:Play(true)
    end
  else
    REF.RewardBG.UISprite.spriteName = "training_off"
  end
  REF.FinishedSprite.gameObject:SetActive(m_unlocked and dungeonRecord.finished)
end

function OnDungeonClick()
  local isUnlock = DU._IsDungeonUnlock(m_dunRecord)
  if isUnlock then
    this:SetData("WindowDungeon/DungeonId", m_dungeonId)
    this:SetData("WindowDungeon/ChapterId", m_chapterId)
    this:SetData("DungeonPrepare/ChapterId", m_chapterId)
    this:SetData("DungeonPrepare/DungeonId", m_dungeonId)
    this:BroadcastGameEvent("SaveChapterPos", m_normalChapterId)
    WU.AcquireWindowAsync("DungeonTraining")
  else
    local dungeonReward = PB.get("DungeonReward", m_dungeonId)
    if dungeonReward then
      DU.IsDungeonFinished(DB:GetData("fci/dungeon/chapter-summary"), dungeonReward.preDungeonId, function(unlocked)
        if unlocked then
          local chapterInfo = PB.get("ChapterInfo", m_chapterId)
          if chapterInfo then
            do
              local preChapterInfo = PB.get("ChapterInfo", chapterInfo.preChapterId)
              if preChapterInfo and preChapterInfo.type == PB.enum.ChapterType.Training then
                WU.ShowHintText(WU.GetString("Training_dungeon_locked_by_training_chapter", chapterInfo.preChapterId % 1000))
              elseif preChapterInfo and preChapterInfo.type == PB.enum.ChapterType.Normal then
                WU.ShowMessageYesNo(WU.GetString("Training_dungeon_locked_by_chapter", chapterInfo.preChapterId), function(msg)
                  if msg == "YES" then
                    local summary = this:GetData("fci/dungeon/chapter-summary")
                    if summary and summary.unlockedNormalDungeonsCnt > 0 then
                      WU.AcquireWindowAsync("ChapterNormal", function(ui)
                        local chapterInfo = PB.get("ChapterInfo", chapterInfo.preChapterId)
                        if chapterInfo then
                          local index = chapterInfo.chapterIndex
                          this:BroadcastGameEvent("ChapterPageTo", index - 1)
                        end
                      end)
                    end
                  end
                end)
              end
            end
          end
        else
          WU.ShowHintText(WU.GetString("Training_dungeon_locked"))
        end
      end)
    end
  end
end
