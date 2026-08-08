local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local m_activities
local m_activeData = {}
local m_sortWrapData = {}
local m_maxCol = 4
local m_reuseTable = REF.WrapContent.ReuseTable
local m_scrollView = REF.ScrollView.UIScrollView
local m_initScrollViewPos, m_activitySummary
local m_focusActivity = {}
local m_main, m_fantasy, m_event, m_movie
local m_tagPos = {}
local enumActivity2TagBg = {
  [1] = "story_title_bg_2",
  [27001] = "story_title_bg_2",
  [39001] = "story_title_bg_3",
  [74002] = "story_title_bg_4",
  [74003] = "story_title_bg_4",
  [74004] = "story_title_bg_4",
  [74005] = "story_title_bg_4",
  [84001] = "story_title_bg_4"
}

function SetupWindow()
  local preferences = m_configDataManager.GetPreferences()
  m_initScrollViewPos = REF.ScrollView.transform.localPosition
  m_reuseTable.onInitializeItem = UpdateSlot
  m_reuseTable.onGetChildWidget = Trans2BoundsWidget
  m_reuseTable:SetDataCount(0)
end

function InitWindow()
  this:SetData("JourneyStory/Type", nil)
  this:SetData("JourneyStory/Entrance", nil)
  GetFocusActivity()
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  this:RegisterGameEvent("JourneyVideo/Enter", OnEnter)
  m_activities = this:GetData("ActivityList")
  this:BindRemote(DB:GameRequest("fci/activity/record/summary"), OnActivitySummary)
  m_reuseTable:ResetPosition(true)
  local lastPosition = DB:GetData("JourneyStory/LastPosition")
  if lastPosition ~= nil then
    this:DelayInvokeInFrames(1, function()
      LocateToPosition(lastPosition.y)
      DB:SetData("JourneyStory/LastPosition", nil)
    end)
  end
  this:Bind("JourneyStory/Type", LocateToSpecificType)
end

function UnInitWindow()
  this:SetData("JourneyStory/Type", nil)
end

function OnEnter()
  DB:SetData("JourneyStory/LastPosition", REF.ScrollView.transform.localPosition)
end

function OnActivitySummary(summary)
  if summary == nil then
    return
  end
  local allCartoonInfo = this:GetData("CartoonConfig/UnlockedInfo")
  if allCartoonInfo == nil then
    return
  end
  m_activitySummary = summary.activityRecordSummary
  SetWrapContent(allCartoonInfo)
end

function SetWrapContent(allCartoonInfo)
  local allCartoonInfoCpy = _ENV["!"](allCartoonInfo):duplicate()
  m_activeData = GetActiveStoryCartoons(allCartoonInfoCpy)
  REF.LabelCount.UIHtmlLabel.text = WU.GetString("StoryCounts", #m_activeData)
  SortWrapData()
  WU.SetActive(REF.NodeEmpty, _ENV["!"](m_activeData):empty())
  WU.SetActive(REF.DragBG, not _ENV["!"](m_activeData):empty())
  m_reuseTable:SetDataCount(#m_sortWrapData)
  this:SetData("JourneyStory/Type", this:GetData("JourneyStory/Type"))
end

function GetActiveStoryCartoons(allCartooninfo)
  local activeCartoon = {}
  local allCartoonInfo = PB.all("CartoonConfig")
  for _, cartoon in pairs(allCartoonInfo) do
    if allCartooninfo[cartoon.id] == true then
      local idx, sameDungeon = _ENV["!"](activeCartoon):find(function(k, v)
        return not cartoon.isOp and cartoon.dungeonId == v.dungeonId
      end)
      if sameDungeon ~= nil then
        if sameDungeon.id > cartoon.id then
          cartoon.hasNext = sameDungeon.id
          table.remove(activeCartoon, idx)
          table.insert(activeCartoon, cartoon)
        else
          sameDungeon.hasNext = cartoon.id
        end
      else
        table.insert(activeCartoon, cartoon)
      end
    elseif cartoon.isOp and cartoon.storyType == PB.enum.CartoonStoryType.EventActivity and m_activities then
      local _, curActivity = _ENV["!"](m_activities):find(function(k, v)
        return cartoon.eventActivityId == v.activityId
      end)
      if (cartoon.finishEventDungeonId ~= 0 or cartoon.unlockEventDungeonId ~= 0) and curActivity and ACU.IsOpenForDoing(curActivity) then
        local activityId = cartoon.eventActivityId
        local cativityType = cartoon.eventActivityType
        local _, dungeonInfo = PB.all("EventDungeon"):find(function(k, v)
          if cartoon.unlockEventDungeonId ~= 0 then
            return _ENV["!"](v.dungeonId):has(cartoon.unlockEventDungeonId)
          elseif cartoon.finishEventDungeonId ~= 0 then
            return _ENV["!"](v.dungeonId):has(cartoon.finishEventDungeonId)
          else
            return false
          end
        end)
        if dungeonInfo then
          activityId = dungeonInfo.activityId
          cativityType = dungeonInfo.activityType
        end
        local url = "fci/activity/record/" .. cativityType .. "/" .. activityId
        local data = this:GetData(url)
        if data then
          local records
          records = data.records or _ENV["!"]({})
          local s, i = table.find(records, function(k, v)
            return v.dungeonId == cartoon.finishEventDungeonId and v.finished or v.dungeonId == cartoon.unlockEventDungeonId and v.unlocked
          end)
          if s then
            table.insert(activeCartoon, cartoon)
          end
        end
      elseif curActivity and ACU.IsOpenForDoing(curActivity) then
        table.insert(activeCartoon, cartoon)
      elseif curActivity and not ACU.IsOpenForDoing(curActivity) and curActivity.timestampStart <= CS.GameTime.serverUtc then
        if cartoon.finishEventDungeonId ~= 0 or cartoon.unlockEventDungeonId ~= 0 then
          local _, unlockInfo = table.find(m_activitySummary, function(k, v)
            return cartoon.finishEventDungeonId ~= 0 and v.dungeonId == cartoon.finishEventDungeonId and v.finished or cartoon.unlockEventDungeonId ~= 0 and v.dungeonId == cartoon.unlockEventDungeonId and v.unlocked
          end)
          if unlockInfo then
            table.insert(activeCartoon, cartoon)
          end
        elseif table.find(m_activitySummary, function(k, v)
          return v.activityId == cartoon.eventActivityId and v.activityType == cartoon.eventActivityType
        end) then
          table.insert(activeCartoon, cartoon)
        end
      end
    end
  end
  table.sort(activeCartoon, CmpCartoon)
  return activeCartoon
end

function CmpCartoon(a, b)
  if a.order == b.order then
    if a.chapterId == b.chapterId then
      if a.eventActivityType == b.eventActivityType then
        if a.eventActivityId == b.eventActivityId then
          return a.dungeonId < b.dungeonId
        else
          return a.eventActivityId < b.eventActivityId
        end
      else
        return a.eventActivityType > b.eventActivityType
      end
    elseif a.chapterId == 0 then
      return false
    elseif b.chapterId == 0 then
      return true
    else
      return a.chapterId < b.chapterId
    end
  else
    return a.order < b.order
  end
end

function dumpVideoInfo(data)
  if data == nil then
    return nil
  end
  local theMoiveIcon = GetMovieIcon(data.movieIcon)
  local chapterId = fif(data.chapterId ~= 0, data.chapterId, data.eventActivityId)
  local theChapterTag = GetTag(chapterId, data.dungeonId, data.storyType)
  local theStoryName = GetStoryName(data.dungeonId, data.eventActivityId)
  local theTagBg = "story_title_bg_1"
  local theTagColor = CS.NGUIMath.HexToColor(1601869311)
  if data.storyType == PB.enum.CartoonStoryType.EventActivity then
    local bgName = "eventStoryBg" .. data.eventActivityId
    theTagColor = CS.NGUIMath.HexToColor(4294967295)
    theTagBg = enumActivity2TagBg[data.eventActivityId] or enumActivity2TagBg[1]
  end
  local showInfo = {
    showNew = not isPlayedCartoon(data.id),
    chapterTag = theChapterTag,
    movieIcon = theMoiveIcon,
    cartoonId = data.id,
    storyName = theStoryName,
    hasNext = data.hasNext,
    pvName = data.pvName,
    tagBg = theTagBg,
    tagColor = theTagColor
  }
  return showInfo
end

function isPlayedCartoon(cartoonId)
  local preferences = m_configDataManager.GetPreferences()
  local playerCartoonId = cartoonId .. DB:GetData("playerId")
  if preferences.playedStoryCartoon ~= nil then
    for _, v in pairs(preferences.playedStoryCartoon) do
      if v == playerCartoonId then
        return true
      end
    end
  else
    preferences.playedStoryCartoon = {}
  end
  return false
end

function GetTag(id, dungeonID, storyType)
  local tag
  if storyType == PB.enum.CartoonStoryType.EventActivity then
    tag = WU.GetString("ActivityNameTag_" .. id)
  elseif storyType == PB.enum.CartoonStoryType.Fantasy then
    tag = WU.GetString("FantasyStoryTypeName")
  elseif storyType == PB.enum.CartoonStoryType.Movie then
    tag = WU.GetString("MovieStoryTypeName")
  else
    tag = WU.GetString("MainStoryTag", id - 1000)
  end
  return tag
end

function GetStoryName(dungeonId, activityId)
  local storyName
  if dungeonId ~= 0 then
    storyName = WU.GetString("DungeonName_" .. dungeonId)
  else
    storyName = WU.GetString("ActivityOpName_" .. activityId)
  end
  return storyName
end

function GetMovieIcon(movieIcon)
  local iconPath
  if movieIcon == "xx" then
    iconPath = "Texture/JouneyVideo/"
  else
    iconPath = "Texture/JouneyVideo/" .. movieIcon
  end
  return iconPath
end

function SortWrapData()
  m_main = {}
  m_fantasy = {}
  m_event = {}
  m_movie = {}
  m_sortWrapData = {}
  local mainDes = {
    Desc = WU.GetString("MainStoryTypeName")
  }
  local fantasyDes = {
    Desc = WU.GetString("FantasyStoryTypeName")
  }
  local eventDes = {
    Desc = WU.GetString("EventStoryTypeName")
  }
  local movieDes = {
    Desc = WU.GetString("MovieStoryTypeName")
  }
  for _, cartoonInfo in pairs(m_activeData) do
    if cartoonInfo.storyType == PB.enum.CartoonStoryType.EventActivity then
      table.insert(m_event, cartoonInfo)
    elseif cartoonInfo.storyType == PB.enum.CartoonStoryType.Fantasy then
      table.insert(m_fantasy, cartoonInfo)
    elseif cartoonInfo.storyType == PB.enum.CartoonStoryType.Movie then
      table.insert(m_movie, cartoonInfo)
    else
      table.insert(m_main, cartoonInfo)
    end
  end
  table.insert(m_sortWrapData, mainDes)
  ConstructDataList(m_main)
  m_tagPos[PB.enum.CartoonStoryType.Main] = 0
  table.insert(m_sortWrapData, fantasyDes)
  ConstructDataList(m_fantasy)
  m_tagPos[PB.enum.CartoonStoryType.Fantasy] = 310 * math.ceil(m_main:count() / 4) + 80
  table.insert(m_sortWrapData, movieDes)
  ConstructDataList(m_movie)
  if m_movie:count() == 0 then
    m_tagPos[PB.enum.CartoonStoryType.Movie] = m_tagPos[PB.enum.CartoonStoryType.Fantasy] + 80 + 208
  else
    m_tagPos[PB.enum.CartoonStoryType.Movie] = m_tagPos[PB.enum.CartoonStoryType.Fantasy] + 310 * math.ceil(m_movie:count() / 4) + 80
  end
  table.insert(m_sortWrapData, eventDes)
  ConstructDataList(m_event)
  if m_movie:count() == 0 then
    m_tagPos[PB.enum.CartoonStoryType.EventActivity] = m_tagPos[PB.enum.CartoonStoryType.Movie] + 80 + 208
  else
    m_tagPos[PB.enum.CartoonStoryType.EventActivity] = m_tagPos[PB.enum.CartoonStoryType.Movie] + 310 * math.ceil(m_fantasy:count() / 4) + 80
  end
end

function ConstructDataList(data)
  if _ENV["!"](data):empty() then
    table.insert(m_sortWrapData, {none = true})
    return
  end
  for i = 0, math.ceil(#data / m_maxCol) - 1 do
    local showInfo = {}
    for j = 1, m_maxCol do
      showInfo[j] = dumpVideoInfo(data[i * m_maxCol + j])
    end
    table.insert(m_sortWrapData, showInfo)
  end
end

function UpdateSlot(go, wrapIndex, realIndex)
  if m_sortWrapData ~= nil and realIndex < #m_sortWrapData then
    local ref = _ENV["$"](go)
    local videoInfo = m_sortWrapData[realIndex + 1]
    if videoInfo ~= nil then
      if videoInfo.Desc ~= nil then
        ref["$$ShowDesc"](videoInfo)
      elseif videoInfo.none then
        ref["$$ShowNone"]()
      else
        ref["$$ShowCustom"](videoInfo)
      end
    end
  end
end

function Trans2BoundsWidget(trans)
  local ref = _ENV["$"](trans)
  if ref["@type"] == 1 then
    ref.Container.UIWidget.height = 300
  elseif ref["@type"] == 2 then
    ref.Container.UIWidget.height = 70
  elseif ref["@type"] == 3 then
    ref.Container.UIWidget.height = 198
  end
  return ref.Container.UIWidget
end

function LocateToPosition(position)
  local fixedMove = CS.UnityEngine.Vector3(0, 300, 0)
  while position >= m_scrollView.transform.localPosition.y + 300 do
    m_scrollView:MoveRelative(fixedMove, true)
  end
  local relative = position - m_scrollView.transform.localPosition.y
  if 0 < relative then
    m_scrollView:MoveRelative(CS.UnityEngine.Vector3(0, relative, 0), true)
  end
end

function GetFocusActivity()
  local Info = PB.all("CartoonConfig")
  for _, cartoon in pairs(Info) do
    if cartoon.eventActivityId ~= 0 then
      table.insert(m_focusActivity, cartoon.eventActivityId)
    end
  end
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  if _ENV["!"](m_focusActivity):has(activityId) and status == PB.enum.ActivityStatus.Close then
    DB:SyncRemote(DB:GameRequest("fci/activity/record/summary"))
  end
end

function LocateToSpecificType(type)
  if type == nil then
    return
  end
  m_reuseTable:ResetPosition(true)
  local pos = m_tagPos[type]
  if pos then
    this:DelayInvokeInFrames(1, function()
      LocateToPosition(pos + m_initScrollViewPos.y)
    end)
  end
end
