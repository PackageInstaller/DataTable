local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local m_chapterId, m_chapterRecord, m_chapterChoose, m_rewards, m_specialReward
local storyModeChosen = 0
local normalModeChosen = 1
local challengeModeChosen = 2
local m_unlockedNormalChapters = {}
local m_unlockedTrainingChapters = {}
local m_currentChapters = {}
local m_currentSelectMode, m_currentTab
local m_chapterBindFlagCache = {}
local m_storyMapNormal = {}
local m_currentChapterId, m_from

function SetupWindow()
  LU.Bind(REF.WrapChapterContent, {
    updateRow = UpdateChapterList
  })
  LU.Bind(REF.RewardWrapContent, {
    updateRow = UpdateRewardSlot
  })
  WU.BindButtonEvent(REF.ButtonClose, OnButtonExitClick)
  WU.BindButtonEvent(REF.ButtonPageTo, OnButtonPageToClick)
  REF.ToggleModeChoose.UIToggleGroup:Init(OnModeChanged)
  local chapters = PB.all("ChapterInfo")
  for i, v in ipairs(chapters) do
    m_storyMapNormal[v.storyChapterId] = v
  end
end

function InitWindow()
  m_currentSelectMode = nil
  m_currentChapterId = nil
  this:RegisterGameEvent("NavigateToCanGetReward", NavigateToCanGetReward)
  this:Bind("fci/dungeon/chapter-summary", OnUnlockChapterChange)
  this:Bind("Chapter/ChapterChoose", OnChapterChooseChange)
  this:DelayInvokeInSeconds(0.1, function()
    NaviagteToChapter()
  end)
  this:Bind("ChapterRewardMode", function(result)
    m_currentSelectMode = result
    local selectedMode = REF.ToggleModeChoose.UIToggleGroup.value
    if result == "ChapterNormal" then
      REF.LabelButtonPageTo.UILabel.text = WU.GetString("Window_ChapterReward_Back")
      if selectedMode ~= normalModeChosen then
        REF.ToggleModeChoose.UIToggleGroup.value = normalModeChosen
      end
    elseif result == "ChapterChallenge" then
      REF.LabelButtonPageTo.UILabel.text = WU.GetString("Window_ChallengeReward_Back")
      if selectedMode ~= challengeModeChosen then
        REF.ToggleModeChoose.UIToggleGroup.value = challengeModeChosen
      end
    end
  end)
end

function OnChapterChanged(chapter)
  if chapter then
    m_chapterRecord = chapter.recordChapter
    if m_chapterRecord == nil then
      m_chapterRecord = {}
      m_chapterRecord.chapterId = m_chapterId
      m_chapterRecord.totalStar = 0
      m_chapterRecord.finished = false
      m_chapterRecord.starRewardGot = {}
    end
    if m_chapterRecord then
      local allStars = this:GetData("fci/dungeon/chapter-summary").totalNormalStar
      REF.LabelChapterStar.UILabel.text = WU.GetString("Window_ChapterTotalStar", allStars)
      local rowRef = _ENV["$"](_ENV["$"](REF.SpecialReward).WidgetChapterRewardSlot)
      if m_specialReward then
        rowRef.root.gameObject:SetActive(true)
        rowRef["$$SetReward"](m_specialReward, m_chapterRecord)
      else
        rowRef.root.gameObject:SetActive(false)
      end
      LU.Set(REF.RewardWrapContent, #m_rewards)
      local tutorial = REF.RewardWrapContent.TutorialIndicator
      if tutorial ~= nil and tutorial.Id == 6 then
        tutorial.Uri = "fci/dungeon/chapter/" .. m_chapterRecord.chapterId .. "/reward"
      end
    end
  end
end

function UpdateRewardSlot(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil then
    local rewardIndex = realIndex
    if m_rewards and m_chapterRecord and rewardIndex < #m_rewards then
      rowRef["$$SetReward"](m_rewards[rewardIndex + 1], m_chapterRecord)
    end
  end
end

function OnModeChanged()
  local val = REF.ToggleModeChoose.UIToggleGroup.value
  if val == normalModeChosen then
    m_currentChapters = m_unlockedNormalChapters
  elseif val == challengeModeChosen then
    m_currentChapters = m_unlockedTrainingChapters
  end
  m_currentTab = val
  local temp = this:GetData("ChapterRewardDefaultSelectChapter")
  if temp == nil then
    temp = m_currentChapters[1]
  end
  this:SetData("Chapter/ChapterChoose", temp)
  LU.Set(REF.WrapChapterContent, #m_currentChapters)
end

function UpdateChapterList(rowRef, wrapIndex, realIndex)
  if m_currentChapters and realIndex ~= nil and realIndex < #m_currentChapters then
    local index = realIndex + 1
    local chapterId = m_currentChapters[index]
    rowRef["$$ModifyContent"](chapterId, m_currentTab)
  end
end

function SetUnlockChapters(unLockList)
  m_unlockedNormalChapters = {}
  m_unlockedTrainingChapters = {}
  local temp = {}
  table.sort(unLockList, function(a, b)
    local infoA = PB.get("ChapterInfo", a)
    local infoB = PB.get("ChapterInfo", b)
    if infoA == nil then
      return false
    end
    if infoB == nil then
      return true
    end
    return infoA.chapterIndex < infoB.chapterIndex
  end)
  for k, chapterId in pairs(unLockList) do
    local info = PB.get("ChapterInfo", chapterId)
    if info and info.type == PB.enum.DungeonType.Normal then
      if temp[chapterId] == nil then
        table.insert(m_unlockedNormalChapters, chapterId)
        temp[chapterId] = 1
      end
      BindChapter(normalModeChosen, chapterId)
    elseif info and info.type == PB.enum.DungeonType.Story then
      local normalChapter = m_storyMapNormal[chapterId]
      if normalChapter and temp[normalChapter.chapterId] == nil then
        table.insert(m_unlockedNormalChapters, normalChapter.chapterId)
        temp[normalChapter.chapterId] = 1
      end
      BindChapter(normalModeChosen, chapterId)
    elseif info and info.type == PB.enum.DungeonType.Challenge then
      table.insert(m_unlockedTrainingChapters, chapterId)
      BindChapter(challengeModeChosen, chapterId)
    end
  end
end

function BindChapter(mode, chapterId)
  local function UpdateRedMark(chapter)
    if chapter then
      local hasReward = DU.DoesChapterHasStarReward(chapter.recordChapter)
      
      local chapterType = PB.get("ChapterInfo", chapterId).type
      if chapterType == PB.enum.ChapterType.Normal then
        RU.SetRedMark("ChapterReward/" .. chapter.recordChapter.chapterId, hasReward)
      elseif chapterType == PB.enum.ChapterType.Challenge then
        RU.SetRedMark("Activity/" .. PB.enum.ActivityType.ChallengeMode .. "/" .. chapter.recordChapter.chapterId, hasReward)
      end
    end
  end
  
  local key = "fci/dungeon/chapter/" .. chapterId
  this:Unbind(key, UpdateRedMark)
  if not m_chapterBindFlagCache[chapterId] then
    this:Bind(key, UpdateRedMark)
    m_chapterBindFlagCache[chapterId] = true
  else
    this:Bind(key, UpdateRedMark, false)
  end
end

function GetSelectModeIndex(selectMode)
  local result
  if selectMode == "ChapterNormal" then
    result = normalModeChosen
  elseif selectMode == "ChapterChallenge" then
    result = challengeModeChosen
  else
    error("GamePlay", "unhandled selectMode: " .. tostring(selectMode))
  end
  return result
end

function OnUnlockChapterChange(result)
  if result == nil then
    return
  end
  SetUnlockChapters(result.unlockedChapterId)
  if m_currentSelectMode == nil then
    local selectMode = this:GetData("ChapterRewardMode")
    m_currentSelectMode = selectMode
    REF.ToggleModeChoose.UIToggleGroup.value = GetSelectModeIndex(selectMode)
  end
  local chapterRewardDefaultSelectChapter = this:GetData("ChapterRewardDefaultSelectChapter")
  this:SetData("Chapter/ChapterChoose", chapterRewardDefaultSelectChapter)
  NaviagteToChapter()
end

function OnChapterChooseChange(id)
  if id == nil then
    return
  end
  if m_chapterId then
    this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
  end
  m_chapterId = id
  m_rewards = DU.GetChapterRewards(m_chapterId)
  m_specialReward = nil
  local temp = {}
  for i, v in ipairs(m_rewards) do
    if v.star ~= 0 then
      temp[#temp + 1] = v
    else
      m_specialReward = v
    end
  end
  m_rewards = temp
  if m_chapterId then
    this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
  end
  NavigateToCanGetReward()
  if m_currentChapterId == nil then
    m_currentChapterId = m_chapterId
    REF.ButtonPageTo.gameObject:SetActive(false)
  elseif m_chapterId ~= m_currentChapterId then
    REF.ButtonPageTo.gameObject:SetActive(true)
  else
    REF.ButtonPageTo.gameObject:SetActive(false)
  end
end

function NaviagteToChapter()
  if m_chapterId ~= nil then
    local wrapContent = REF.WrapChapterContent.UIWrapContent
    local scrollView = REF.ScrollViewChapter.UIScrollView
    wrapContent:UpdateContent(#m_currentChapters, true)
    scrollView:ResetPosition()
    local index = PB.get("ChapterInfo", m_chapterId).chapterIndex
    if 5 < index then
      REF.ChapterChoose.UIWidget:UpdateAnchors()
      REF.ScrollViewChapter.UIPanel:UpdateAnchors()
      local v3 = CS.UnityEngine.Vector3.zero
      v3.y = wrapContent.itemSize * (index - 1)
      scrollView:MoveRelative(v3)
      scrollView:RestrictWithinBounds(true)
      wrapContent:MarkAsDirty()
      wrapContent:WrapContent()
    end
  end
end

function NavigateToCanGetReward()
  if m_chapterRecord == nil then
    return
  end
  local index = 1
  for i, v in ipairs(m_rewards) do
    local starMatched = v.star <= m_chapterRecord.totalStar
    local got = table.has(m_chapterRecord.starRewardGot, v.star)
    if not got and starMatched then
      index = i
      break
    elseif not got then
      index = i
      break
    end
  end
  local wrapContent = REF.RewardWrapContent.UIWrapContent
  local scrollView = REF.RewardScrollView.UIScrollView
  wrapContent:UpdateContent(#m_rewards, true)
  scrollView:ResetPosition()
  local v3 = CS.UnityEngine.Vector3.zero
  v3.y = wrapContent.itemSize * (index - 2)
  scrollView:MoveRelative(v3)
  scrollView:RestrictWithinBounds(true)
  wrapContent:MarkAsDirty()
  wrapContent:WrapContent()
end

function OnButtonExitClick()
  if m_from == "ChallengeDungeon" then
    WU.RecordButtonClick("167" .. m_chapterId .. "4")
  else
    WU.RecordButtonClick(129004)
  end
  WU.RecycleWindow(this)
end

function OnButtonPageToClick()
  if m_from == "ChallengeDungeon" then
    WU.RecordButtonClick("167" .. m_chapterId .. "3")
  elseif m_from == "ChapterNormal" then
    WU.RecordButtonClick(129003)
  end
  local currentMode = this:GetData("ChapterRewardMode")
  local newModeVal = REF.ToggleModeChoose.UIToggleGroup.value
  SwitchToNewMode(newModeVal, currentMode)
  WU.RecycleWindow(this)
end

function SwitchToNewMode(newModeVal, curMode)
  local modeNames = {
    "ChapterStory",
    "ChapterNormal",
    "ChapterChallenge"
  }
  local newMode = modeNames[newModeVal + 1]
  if newMode ~= curMode then
    WU.AcquireWindowAsync(newMode, nil, true)
    this:SetData("ChapterRewardMode", newMode)
  else
    local index = PB.get("ChapterInfo", this:GetData("Chapter/ChapterChoose")).chapterIndex
    this:BroadcastGameEvent("ChapterPageTo", index)
  end
end

function Focus(on)
  if not on then
    if m_from == "ChallengeDungeon" then
      WU.RecordWindowFocus(100167, on)
    elseif m_from == "ChapterNormal" then
      WU.RecordWindowFocus(100129, on)
    end
  end
end

function SetFrom(from)
  m_from = from
  WU.TraverseChildren(REF.RewardWrapContent, function(go)
    _ENV["$"](go)["$$SetDrawCallback"](function()
      if m_from == "ChallengeDungeon" then
        WU.RecordButtonClick("167" .. m_chapterId .. "2")
      else
        WU.RecordButtonClick(129002)
      end
    end)
  end)
  if m_from == "ChallengeDungeon" then
    WU.RecordWindowFocus(100167, true)
  elseif m_from == "ChapterNormal" then
    WU.RecordWindowFocus(100129, true)
  end
end
