local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local RU = require("Common/RedMarkUtil")
local m_chapterId, m_rewards, m_type

function Awake()
  CS.EventDelegate.Add(REF.root.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      OnButtonChooseClick()
    end
  end)
end

function ModifyContent(chapterId, type)
  if chapterId == nil then
    return
  end
  local redMarkPath
  local chapterInfo = PB.get("ChapterInfo", chapterId)
  if chapterInfo then
    local chapterType = chapterInfo.type
    if chapterType == PB.enum.DungeonType.Normal then
      redMarkPath = "ChapterReward/" .. chapterId
    elseif chapterType == PB.enum.DungeonType.Challenge then
      redMarkPath = "Activity/" .. PB.enum.ActivityType.ChallengeMode .. "/" .. chapterId
    end
  end
  if m_chapterId ~= nil then
    this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
    RU.UnbindRedMark(this, redMarkPath)
  end
  m_chapterId = chapterId
  m_type = type
  m_rewards = DU.GetChapterRewards(m_chapterId)
  RU.BindRedMark(this, redMarkPath, function(flag)
    REF.SpriteRedPoint.gameObject:SetActive(flag)
  end)
  this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
  REF.LabelTitle.UILabel.text = WU.GetString("ChapterName_" .. chapterId)
  HightLight()
end

function OnButtonChooseClick()
  this:SetData("Chapter/ChapterChoose", m_chapterId)
end

function OnChapterChanged(chapter)
  if chapter and chapter.recordChapter then
    local chapterInfo = PB.get("ChapterInfo", m_chapterId)
    local sum = 0
    if chapterInfo then
      for i, v in ipairs(chapterInfo.dungeonId) do
        if DU.IsShowStar(v) then
          local dungeonReward = PB.get("DungeonReward", v)
          sum = sum + #dungeonReward.target
        end
      end
    end
    if 0 < #m_rewards then
      REF.LabelStar.UILabel.text = chapter.recordChapter.totalStar .. "/" .. sum
      REF.SpriteStar.UISprite.graify = sum > chapter.recordChapter.totalStar
    else
      error("ChapterReward", "chapter rewards for chapterId[" .. m_chapterId .. "] is empty. check ChapterReward xlsx")
    end
  end
end

function HightLight()
  REF.root.UIToggle.optionCanBeNone = true
  local temp = this:GetData("Chapter/ChapterChoose")
  REF.root.UIToggle.value = temp == m_chapterId
  REF.root.UIToggle.optionCanBeNone = false
end
