local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local m_chapterId = 0
local m_storyId = 0
local m_trainingId = 0
local m_randomDungeonRecordMap = {}
local m_dragDelta
local m_oldNode = {}
local m_mapSlot = {}
local m_preChapterId
local m_closeTimeId = -1

function ShowMoive()
  WU.AcquireWindowAsync("StoryMoive", function(ui)
    _ENV["$"](ui)["$$SetData"](m_chapterId)
  end)
end

function Awake()
  CS.EventDelegate.Add(REF.root.UIPlayTween.onFinished, function()
    if REF.NormalDungeons and 0 < #m_oldNode then
      for i, v in ipairs(m_oldNode) do
        CS.UnityEngine.GameObject.Destroy(v["$gameObject"])
      end
      m_oldNode = {}
    end
  end)
  this:RegisterGameEvent("UpdateChapterRewardSlot", UpdateChapterRewardSlot)
  this:RegisterGameEvent("TurnChapterBottom", function()
    local openInfo = PB.get("DungeonOpenTime", m_closeTimeId)
    if openInfo then
      local openTime = openInfo.openTime
      local str = WU.GetString("Window_DungeonOpenTime2", openTime)
      WU.ShowHintText(str)
    end
  end)
  this:RepeatInvokeInSeconds(1.0, function()
    UpdateMapForOpenTime()
  end)
end

function GetBounds()
  local index = 1
  local width = -1
  while true do
    local ref = REF["Container" .. index]
    if ref == nil then
      break
    end
    if ref.gameObject.activeSelf then
      local size = ref.UIWidget.localSize
      width = size.x
    end
    index = index + 1
  end
  return width
end

function OnEnable()
  this:RepeatInvokeInSeconds(0.33, function()
    if REF.Left.UIPanel then
      REF.Left.UIPanel:SetDirty()
    end
  end, 4)
end

function UpdateMapForOpenTime()
  if m_closeTimeId ~= -1 then
    local closeTimeId = m_closeTimeId
    local openInfo = PB.get("DungeonOpenTime", m_closeTimeId)
    if openInfo then
      local openTime = CS.GameTime.ServerTimeStrToUtc(openInfo.openTime)
      if openTime <= CS.GameTime.serverUtc then
        m_closeTimeId = -1
        local chapterInfo = PB.get("ChapterInfo", m_chapterId)
        
        local function check(dunIds)
          for k, v in pairs(dunIds) do
            UpdateOpenTimeZone(v)
            if m_closeTimeId ~= -1 then
              break
            end
          end
        end
        
        check(chapterInfo.dungeonId)
        if m_closeTimeId == -1 then
          local tempChapterInfo = PB.get("ChapterInfo", chapterInfo.storyChapterId)
          if tempChapterInfo then
            check(tempChapterInfo.dungeonId)
          end
        end
        if m_closeTimeId == -1 then
          local tempChapterInfo = PB.get("ChapterInfo", chapterInfo.trainingId)
          if tempChapterInfo then
            check(tempChapterInfo.dungeonId)
          end
        end
      end
    end
    if closeTimeId ~= m_closeTimeId then
      UpdateMapBounds()
      UpdateMapData()
    end
  end
end

function UpdateMapBounds()
  local index = 1
  while true do
    local ref = REF["Container" .. index]
    if ref == nil then
      break
    end
    ref.gameObject:SetActive(true)
    if _ENV["$"](ref).PanelEffect then
      _ENV["$"](ref).PanelEffect.gameObject:SetActive(false)
    end
    index = index + 1
  end
  index = index - 1
  if m_closeTimeId ~= -1 and 0 < index then
    for i = m_closeTimeId, index do
      local ref = REF["Container" .. i]
      ref.gameObject:SetActive(false)
    end
  end
  local temp = m_closeTimeId - 1
  local ref = REF["Container" .. temp]
  if ref and _ENV["$"](ref).PanelEffect then
    _ENV["$"](ref).PanelEffect.EffectGenerator:SetActive(true)
    _ENV["$"](ref).PanelEffect.EffectGenerator:Play()
  end
end

function UpdateMapData()
  if m_storyId and 0 < m_storyId then
    local data = this:GetData("fci/dungeon/chapter/" .. m_storyId)
    OnStoryChapterChanged(data)
  end
  if m_trainingId and 0 < m_trainingId then
    local data = this:GetData("fci/dungeon/chapter/" .. m_trainingId)
    OnTrainingChapterChanged(data)
  end
  if m_chapterId then
    WU.ToggleRendering(REF["$"], false)
    local data = this:GetData("fci/dungeon/chapter/" .. m_chapterId)
    OnChapterChanged(data)
  end
end

function SetChapterId(chapterId)
  local bLeft = false
  if m_preChapterId then
    bLeft = chapterId < m_preChapterId
  end
  if m_chapterId ~= chapterId then
    if m_chapterId then
      this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
    end
    m_chapterId = chapterId
    local chapterInfo = PB.get("ChapterInfo", m_chapterId)
    if chapterInfo then
      m_storyId = chapterInfo.storyChapterId
      m_trainingId = chapterInfo.trainingId
    end
    if m_storyId and 0 < m_storyId then
      this:Bind("fci/dungeon/chapter/" .. m_storyId, OnStoryChapterChanged)
    end
    if m_trainingId and 0 < m_trainingId then
      this:Bind("fci/dungeon/chapter/" .. m_trainingId, OnTrainingChapterChanged)
    end
    if m_chapterId then
      WU.ToggleRendering(REF["$"], false)
      this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
    end
  end
  if bLeft then
    REF.root.UIPlayTween.tweenGroup = 3
  else
    REF.root.UIPlayTween.tweenGroup = 2
  end
  this:DelayInvokeInSeconds(1.0, function()
    if REF.NormalDungeons and 0 < #m_oldNode then
      for i, v in ipairs(m_oldNode) do
        CS.UnityEngine.GameObject.Destroy(v["$gameObject"])
      end
      m_oldNode = {}
    end
  end)
  REF.root.UIPlayTween:Play(true)
  UpdateMapBounds()
end

function DisableContainer()
  if REF.Container then
    REF.Container.gameObject:SetActive(false)
  end
  local index = 1
  while true do
    local ref = REF["Container" .. index]
    if ref == nil then
      break
    end
    ref.gameObject:SetActive(false)
    index = index + 1
  end
end

function SetOldNode(n, preChapterId)
  table.insert(m_oldNode, n)
  m_preChapterId = preChapterId
end

function LocateChapter(index)
  local refNormal = _ENV["$"](REF[string.format("Dungeon%d", index)])
  local position = refNormal["$transform"].position
  this:BroadcastGameEvent("LocateChapterPos", position)
end

function OnStoryChapterChanged(chapter)
  if chapter == nil then
    return
  end
  local storyChapterInfo = PB.get("ChapterInfo", m_storyId)
  if storyChapterInfo == nil then
    error("Dungeon", string.format("ChapterInfo id:%d no StoryDungeon:%d", m_chapterId, m_storyId))
    return
  end
  local index = 0
  while true do
    local refStory = _ENV["$"](REF[string.format("DungeonStory%d", index)])
    if refStory == nil then
      break
    end
    if refStory then
      local dungeonId = storyChapterInfo.dungeonId[index + 1]
      if dungeonId == nil then
        error("Dungeon", string.format("ChapterInfo id:%d that story dungeon not match ui,xlsx no index:%d", m_chapterId, index))
      else
        local dungeonRecord = chapter.recordDungeons[dungeonId]
        local dungeonRef = refStory
        SetRoadState(dungeonRef, dungeonRecord)
        local slotRef
        if dungeonRef.WidgetStorySlot ~= nil then
          slotRef = _ENV["$"](dungeonRef.WidgetStorySlot)
        end
        SetDungeonInfo(slotRef, dungeonId, dungeonRecord, chapter)
      end
    end
    index = index + 1
  end
end

function OnTrainingChapterChanged(chapter)
  if chapter == nil then
    return
  end
  local trainingChapterInfo = PB.get("ChapterInfo", m_trainingId)
  if trainingChapterInfo == nil then
    error("Dungeon", string.format("ChapterInfo id:%d no TrainingDungeon:%d", m_chapterId, m_trainingId))
    return
  end
  local index = 0
  while true do
    local refTraining = _ENV["$"](REF[string.format("DungeonTraining%d", index)])
    if refTraining == nil then
      break
    end
    if refTraining then
      local dungeonId = trainingChapterInfo.dungeonId[index + 1]
      if dungeonId == nil then
        error("Dungeon", string.format("ChapterInfo id:%d that Training dungeon not match ui,xlsx no index:%d", m_chapterId, index))
      else
        local dungeonRecord = chapter.recordDungeons[dungeonId]
        local dungeonRef = refTraining
        SetRoadState(dungeonRef, dungeonRecord)
        local slotRef
        if dungeonRef.WidgetTrainingSlot ~= nil then
          slotRef = _ENV["$"](dungeonRef.WidgetTrainingSlot)
        end
        SetDungeonInfo(slotRef, dungeonId, dungeonRecord, chapter)
      end
    end
    index = index + 1
  end
end

function OnChapterChanged(chapter)
  if chapter and m_chapterId ~= nil then
    m_randomDungeonRecordMap = {}
    for i = 1, #chapter.recordDungeons do
      local dungeonRecord = chapter.recordDungeons[i]
      local dungeonReward = PB.get("DungeonReward", dungeonRecord.dungeonId)
      if dungeonReward and dungeonReward.randomDungeon then
        m_randomDungeonRecordMap[dungeonRecord.randomPosition] = dungeonRecord
      end
    end
    UpdateNormalDungeons(chapter)
    WU.ToggleRendering(REF["$"], true)
    local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
    local unlocked = DU.IsChapterUnlocked(chapterSummary, m_chapterId)
    REF.SpriteChapter.UISprite.graify = not unlocked
    REF.SpriteChapter.UISprite.spriteName = "chapter_" .. m_chapterId
  end
end

function SetOutSideIcon(slotRef, dungeonId)
  if slotRef.SpritePreview then
    local dungeonReward = PB.get("DungeonReward", dungeonId)
    local showOutsideIcon = dungeonReward and #dungeonReward.dropDisplayOutside > 0
    if showOutsideIcon then
      local outInfo = dungeonReward.dropDisplayOutside
      if DB:GetData("fci/chipexchange/") ~= nil then
        S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
          if activity and activity[1] and ACU.GetStatus(activity[1]) == PB.enum.ActivityStatus.Started then
            local _, tmpList = DU.ReplaceActorChip(dungeonId, outInfo)
            if tmpList then
              outInfo = tmpList
            end
          end
        end)
      end
      local dropDisplayOutside = outInfo[1]
      slotRef.SpritePreview.gameObject:SetActive(true)
      if dropDisplayOutside.type ~= PB.enum.ResourceType.ResPlayerMoney then
        slotRef.SpritePreview.UITexture.mainTexturePath = "Texture/ItemIcon/" .. PB.enum.ResourceType.__keys[dropDisplayOutside.type] .. "_" .. dropDisplayOutside.id
      end
    else
      slotRef.SpritePreview.gameObject:SetActive(false)
    end
  end
end

function UpdateChapterRewardSlot()
  for dungeonId, slotRef in pairs(m_mapSlot) do
    SetOutSideIcon(slotRef, dungeonId)
  end
end

function SetDungeonInfo(slotRef, dungeonId, dungeonRecord, chapter)
  if slotRef == nil then
    return
  end
  slotRef.root.UIWidget.ignoreBounds = true
  m_mapSlot[dungeonId] = slotRef
  if slotRef.SpritePreview then
    SetOutSideIcon(slotRef, dungeonId)
    local isUnlock = DU._IsDungeonUnlock(dungeonRecord)
    if dungeonRecord then
      if isUnlock then
        slotRef.SpritePreview.UITexture.graify = false
      else
        slotRef.SpritePreview.UITexture.graify = true
      end
    else
      slotRef.SpritePreview.UITexture.graify = true
    end
  end
  local chapterId
  if chapter.recordChapter then
    chapterId = chapter.recordChapter.chapterId
  end
  UpdateOpenTimeZone(dungeonId)
  local cultivationPVPDungeonId = DU.GetCultivationDungeonId(dungeonId)
  slotRef["$$SetData"]({
    normalChapterId = m_chapterId,
    chapterId = chapterId,
    dungeonId = dungeonId,
    chapter = chapter,
    isCultivationPVP = ACU.IsInCultivationPVPActivity(cultivationPVPDungeonId),
    dungeonRecord = dungeonRecord
  })
end

function UpdateOpenTimeZone(dungeonId)
  local dunInfo = PB.get("DungeonReward", dungeonId)
  if dunInfo and dunInfo.openTimeId and dunInfo.openTimeId > 0 and m_closeTimeId == -1 then
    local openInfo = PB.get("DungeonOpenTime", dunInfo.openTimeId)
    if openInfo then
      local openTime = CS.GameTime.ServerTimeStrToUtc(openInfo.openTime)
      if openTime > CS.GameTime.serverUtc then
        m_closeTimeId = dunInfo.openTimeId
      end
    end
  end
end

function SetRoadState(dungeonRef, dungeonRecord)
  if dungeonRef.RoadSprite then
    dungeonRef.RoadSprite.UISprite.ignoreBounds = true
    if dungeonRecord and dungeonRecord.finished then
      dungeonRef.RoadSprite.UISprite.graify = false
    else
      dungeonRef.RoadSprite.UISprite.graify = true
    end
  end
  if dungeonRef.RoadSpriteSmall then
    dungeonRef.RoadSpriteSmall.UISprite.ignoreBounds = true
    if dungeonRecord and dungeonRecord.finished then
      dungeonRef.RoadSpriteSmall.UISprite.graify = false
    else
      dungeonRef.RoadSpriteSmall.UISprite.graify = true
    end
  end
end

function UpdateNormalDungeons(chapter)
  REF.UnlockTime.UILabel.text = ""
  local unlockTimeHasSet = false
  local nailHasSet = false
  local chapterInfo = PB.get("ChapterInfo", m_chapterId)
  if chapterInfo == nil then
    return
  end
  local index = 0
  local curMaxIndex = 0
  local maxDungeonId = 0
  while true do
    local refNormal = _ENV["$"](REF[string.format("Dungeon%d", index)])
    if refNormal == nil then
      break
    end
    if refNormal then
      local dungeonId = chapterInfo.dungeonId[index + 1]
      if dungeonId == nil then
        error("Dungeon", string.format("ChapterInfo id:%d that dungeon not match ui ,xlsx no index %d", m_chapterId, index))
        break
      end
      local dungeonRecord = chapter.recordDungeons[dungeonId]
      if maxDungeonId < dungeonId and dungeonId < 1000 then
        maxDungeonId = dungeonId
      end
      if not unlockTimeHasSet and chapter.recordChapter and 0 < chapter.recordChapter.unlockTime then
        REF.UnlockTime.UILabel.text = WU.RenderTime(chapter.recordChapter.unlockTime)
        unlockTimeHasSet = true
      end
      if refNormal.NailSprite then
        refNormal.NailSprite.UISprite.ignoreBounds = true
        local isUnlock = DU._IsDungeonUnlock(dungeonRecord)
        if not nailHasSet and dungeonRecord ~= nil and not dungeonRecord.finished and isUnlock then
          warning("dungeonId", dungeonRecord.dungeonId)
          refNormal.NailSprite.gameObject:SetActive(true)
          nailHasSet = true
          LocateChapter(index)
        else
          refNormal.NailSprite.gameObject:SetActive(false)
        end
      end
      local dungeonRef = refNormal
      SetRoadState(dungeonRef, dungeonRecord)
      local slotRef
      if dungeonRef.WidgetNormalSlot ~= nil then
        slotRef = _ENV["$"](dungeonRef.WidgetNormalSlot)
      elseif dungeonRef.WidgetBossSlot then
        slotRef = _ENV["$"](dungeonRef.WidgetBossSlot)
      elseif dungeonRef.WidgetSmallSlot then
        slotRef = _ENV["$"](dungeonRef.WidgetSmallSlot)
      end
      SetDungeonInfo(slotRef, dungeonId, dungeonRecord, chapter)
    end
    index = index + 1
  end
  if not nailHasSet then
    local ps = this:GetData("NormalChapterPosition" .. m_chapterId)
    if ps then
      this:BroadcastGameEvent("SetChapterPos", ps)
    else
      LocateChapter(1)
    end
  end
end
