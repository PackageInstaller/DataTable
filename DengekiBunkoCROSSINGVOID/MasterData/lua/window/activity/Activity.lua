local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local GU = require("Common/GotoUtil")
local DU = require("Common/DungeonUtil")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local ATU = require("Common/AutumnUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activitySortList, m_activityGroupMap, m_activityGroupList, m_activityRedMarks, m_selectedActivityGroup, m_dungeonSummary, m_sortIndex, m_lastRedMarkIndex
local m_scrollViewInitY = (REF.ActivityScrollView.UIPanel.finalClipRegion.w - REF.Visual.UIWidget.height) / 2
local m_isRacePvpOverlaped
local m_randomCallId = 18002

function SetupWindow()
  LU.Bind(REF.ActivityContent, {
    updateRow = UpdateActivityGroupSlot
  })
  WU.BindButtonEvent(REF.ButtonEnter, OnEnterClick)
  WU.BindButtonEvent(REF.ButtonShowSort, OnShowSortClick)
  WU.BindButtonEvent(REF.ButtonHideSort, OnHideSortClick)
  WU.BindButtonEvent(REF.ButtonNext, OnButtonNext)
  REF.ActivityScrollView.UIPanel:AddOnClipMoveListener(OnScrollViewMove)
end

function InitWindow()
  InitSort()
  this:Bind("ActivityList", OnActivityListChange)
  this:Bind("SelectedActivityGroup", OnSelectedActivityGroupChange)
  m_dungeonSummary = this:GetData("fci/dungeon/chapter-summary")
  RU.BindRedMark(this, "Activity", function(flag)
    UpdateRedMarks()
  end)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  InitSort()
end

function Focus(on)
  WU.RecordWindowFocus(100117, on)
end

function InitSort()
  m_sortIndex = nil
  m_activitySortList = PB.all("ActivitySort")
  local sortTypeCount = #m_activitySortList
  for i, activitySort in ipairs(m_activitySortList) do
    local sortButton
    if i > #REF.SortButtonGrid then
      sortButton = _ENV["$"](CS.UnityEngine.GameObject.Instantiate(REF.SortButtonGrid[0]["$gameObject"], REF.SortButtonGrid.transform))
    else
      sortButton = REF.SortButtonGrid[i - 1]
    end
    sortButton["@sortIndex"] = i
    local sortKey = WU.GetString("Activity_SortType_" .. activitySort.sortType)
    sortButton.LabelNormal.UILabel.text = sortKey
    sortButton.LabelSelected.UILabel.text = sortKey
    WU.SetActive(sortButton.SpriteSelected, false)
    WU.ClearButtonEvent(sortButton["$"])
    WU.BindButtonEvent(sortButton["$"], OnSortClick)
  end
  REF.SortButtonGrid.UIGrid:Reposition()
  REF.DropList.UISprite.height = math.floor(REF.SortButtonGrid.UIGrid.cellHeight * (sortTypeCount + 0.5))
  WU.SetActive(REF.DropList, false)
  OnSortClick(REF.SortButtonGrid[0]["$"])
end

function UninitWindow()
  this:SetData("SelectedActivityGroup", nil)
end

function UpdateRedMarks()
  m_activityRedMarks = {}
  m_lastRedMarkIndex = nil
  if m_activityGroupList then
    for index, activityGroup in ipairs(m_activityGroupList) do
      local flag = false
      if activityGroup[1].type == PB.enum.ActivityType.EventDungeon then
        flag = RU.GetRedMark(string.format("Activity/%s/%s", PB.enum.ActivityType.EventDungeon, activityGroup[1].activityId))
      else
        flag = RU.GetRedMark("Activity/" .. activityGroup[1].type)
      end
      table.insert(m_activityRedMarks, flag)
      if flag then
        m_lastRedMarkIndex = index
      end
    end
  end
end

function OnActivityListChange(activityList)
  if activityList then
    m_isRacePvpOverlaped = false
    for k, v in ipairs(activityList) do
      if v.type == PB.enum.ActivityType.RacePVPActivity and ACU.IsActivityOn(v) then
        m_isRacePvpOverlaped = true
        break
      end
    end
    m_activityGroupMap = _ENV["!"]({})
    for k, v in ipairs(activityList) do
      if (v.category == PB.enum.ActivityCategory.WeeklyActivity or v.category == PB.enum.ActivityCategory.Tournament) and (v.type ~= PB.enum.ActivityType.RacePVP or not m_isRacePvpOverlaped) then
        if not m_activityGroupMap[v.type] then
          m_activityGroupMap[v.type] = {}
        end
        table.insert(m_activityGroupMap[v.type], v)
      end
    end
    SortActivityList()
    LU.Set(REF.ActivityContent, #m_activityGroupList, true, true)
    REF.ActivityContent.UIPlayTween:Play(true)
    local selectedActivityGroup = m_activityGroupList[1]
    if m_selectedActivityGroup then
      local _, targetActivityGroup = table.find(m_activityGroupList, function(k, v)
        return v.type == m_selectedActivityGroup.type
      end)
      if targetActivityGroup then
        selectedActivityGroup = targetActivityGroup
      end
    end
    this:SetData("SelectedActivityGroup", selectedActivityGroup)
    DB:SyncRemote(DB:GameRequest("fci/tournament/summary/"):SyncInput(false))
  end
end

function SortActivityList()
  if m_sortIndex then
    m_activityGroupList = _ENV["!"]({})
    local lockedList = {}
    local activitySort = m_activitySortList[m_sortIndex]
    for _, type in ipairs(activitySort.activityType) do
      local activityGroup = m_activityGroupMap[type]
      if activityGroup and ACU.IsActivitiesOn(activityGroup) then
        if IsActivityUnlocked(type) then
          table.insert(m_activityGroupList, activityGroup)
        else
          table.insert(lockedList, activityGroup)
        end
      end
    end
    m_activityGroupList:append(lockedList)
  else
    m_activityGroupList = m_activityGroupMap:toarray()
  end
  UpdateRedMarks()
end

function UpdateActivityGroupSlot(rowRef, wrapIndex, realIndex)
  local tutorial = this:GetData("CurrentTutorial")
  local trueIndex = realIndex + 1
  if tutorial == 56 and realIndex == 0 then
    for k, v in ipairs(m_activityGroupList) do
      for _, v2 in ipairs(v) do
        if v2.type == PB.enum.ActivityType.CollectionDungeon then
          trueIndex = tonumber(k)
          break
        end
      end
    end
  end
  if m_activityGroupList and realIndex ~= nil and realIndex < #m_activityGroupList then
    local activityGroup = m_activityGroupList[trueIndex]
    rowRef["$$SetData"](activityGroup)
  end
end

function GetActivityUnlockLevel(type)
  local table = this:GetData("UnlockWindowData")
  return table[WU.ActivityTypeToUnlockWindowType(type)] or 0
end

function IsActivityUnlocked(type)
  return GetActivityUnlockLevel(type) <= this:GetData("fci/baseinfo").level
end

function OnSelectedActivityGroupChange(activityGroup)
  if m_selectedActivityGroup ~= activityGroup then
    if m_selectedActivityGroup then
      REF.TextureOldBG.UITexture.mainTexturePath = "Texture/Background/activities_bg_" .. m_selectedActivityGroup[1].type
      REF.TextureOldBGTint.UITexture.mainTexturePath = "Texture/Background/activities_bg_" .. m_selectedActivityGroup[1].type
    end
    m_selectedActivityGroup = activityGroup
    if m_selectedActivityGroup then
      local winType = WU.ActivityTypeToUnlockWindowType(m_selectedActivityGroup[1].type)
      local isLocked = WU.WindowIsLocked(winType)
      local isOpen = ACU.IsActivitiesOn(m_selectedActivityGroup)
      REF.ButtonEnter.gameObject:SetActive(not isLocked and isOpen)
      local tips = ""
      if isLocked then
        tips = WU.GetString("WindowUnlock_Hint_Activity", WU.GetString("UnlockType_" .. winType), GetActivityUnlockLevel(m_selectedActivityGroup[1].type))
      elseif not isOpen then
        tips = WU.GetString("WindowActivity_IsNotOpen_Activity")
      end
      REF.NodeTips.gameObject:SetActive(isLocked or not isOpen)
      REF.LabelTips.UILabel.text = tips
      REF.TextureNewBG.UITexture.mainTexturePath = "Texture/Background/activities_bg_" .. m_selectedActivityGroup[1].type
      REF.NodeBG.UIPlayTween:Play(true)
    end
  end
end

function OnEnterClick()
  local activity = m_selectedActivityGroup[1]
  if 1 < #m_selectedActivityGroup and activity.type == PB.enum.ActivityType.BurstLinkPvp then
    local _, ac = table.find(m_selectedActivityGroup, function(k, v)
      return v.activityId == m_randomCallId
    end)
    if ac ~= nil then
      activity = ac
    end
  end
  GU.CheckGameModeEnterCondition(GetGameMode(activity.type), function()
    if activity.category == PB.enum.ActivityCategory.WeeklyActivity then
      local currentActivityList = ACU.GetCurrentActivityList(activity.type)
      this:SetData("Activity/CurrentActivity", currentActivityList)
      this:SetData("Activity/CurrentType", activity.type)
      local windowName = ""
      if activity.type == PB.enum.ActivityType.Tower then
        windowName = "Tower"
      elseif activity.type == PB.enum.ActivityType.TriggeredEvent then
        windowName = "TriggeredEvent"
      elseif activity.type == PB.enum.ActivityType.DeployMission then
        windowName = "Deploy"
      elseif activity.type == PB.enum.ActivityType.GoldDungeon then
        windowName = "DungeonGold"
      elseif activity.type == PB.enum.ActivityType.EventDungeon then
        windowName = "EventActivityStage"
      elseif activity.type == PB.enum.ActivityType.EventDungeon_Autumn2018 then
        ATU.GetActivitesByType(activity.type)
        windowName = "EventAutumnStage"
      elseif activity.type == PB.enum.ActivityType.EventDungeon_Autumn2018Hard then
        ATU.GetActivitesByType(activity.type)
        windowName = "EventAutumnStageHard"
      elseif activity.type == PB.enum.ActivityType.StarResDungeon or activity.type == PB.enum.ActivityType.CollectionDungeon then
        this:SetData("Activity/CurrentMaterialId", nil)
        windowName = "ActivityStageChoose" .. activity.type
        if activity.type == PB.enum.ActivityType.CollectionDungeon then
          local activities = DB:GetData("ActivityList")
          for i = 1, #activities do
            local tab = PB.get("ActivityDungeon", activities[i].activityId)
            local k, v = table.find(currentActivityList, function(k, v)
              return v.activityId == activities[i].activityId
            end)
            if tab ~= nil and k == nil and tab.category == 2 and ACU.IsOpenForDoing(activities[i]) then
              table.insert(currentActivityList, activities[i])
            end
          end
          table.sort(currentActivityList, function(a, b)
            return a.activityId < b.activityId
          end)
          this:SetData("Activity/CurrentActivity", currentActivityList)
        end
      elseif activity.type == PB.enum.ActivityType.DungeonTeam then
        windowName = "DungeonTeam"
      elseif activity.type == PB.enum.ActivityType.ChallengeMode then
        if m_dungeonSummary and m_dungeonSummary.unlockedChallengeDungeonsCnt > 0 then
          WU.AcquireWindowAsync("ChapterChallenge")
          ACU.MarkActivityViewed(PB.enum.ActivityType.ChallengeMode, 1)
        else
          local chapterInfos = PB.all("ChapterInfo"):where(function(k, v)
            return v.type == PB.enum.DungeonType.Challenge
          end):toarray():sort(function(a, b)
            return a.chapterIndex < b.chapterIndex
          end)
          DU.ShowChallengeChapterUnlockHint(chapterInfos[1].chapterId)
        end
      elseif activity.type == PB.enum.ActivityType.Maze then
        local mazeActivityId = PB.all("Misc")[1].mazeMiscConf.mazeActivityId
        this:SetData("MazeActivityId", mazeActivityId)
        this:GameRequest("fci/Maze/Summary/" .. mazeActivityId .. "/"):Get(function(res)
          this:SetData("mazePassedIds", res.mazePassed)
          this:SetData("fci/MazeInfo/", res.mazeInfo)
          if res.mazeId == 0 then
            this:SetData("fci/MazeId/" .. mazeActivityId .. "/", res.mazeId)
            WU.AcquireWindowAsync("MazeEnter")
            ACU.MarkActivityViewed(PB.enum.ActivityType.Maze, 1)
          elseif res.mazeInfo.isMazeOver and res.mazeInfo.isMazeOver == true then
            this:GameRequest("fci/Maze/ReceivePrize/" .. mazeActivityId .. "/"):Post({}, function(result)
              if result then
                DBH.ResChange(result.resChange)
                WU.AcquireWindowAsync("MazeAllBalance", function(window)
                  _ENV["$"](window)["$$SetData"](result)
                end)
              end
            end)
          else
            this:SetData("fci/MazeId/" .. mazeActivityId .. "/", res.mazeId)
            this:SetData("MazeFirstTweenOn", false)
            WU.AcquireWindowAsync("MazeMain", function(window)
              _ENV["$"](window)["$$SetContinue"]()
            end)
          end
        end)
      elseif activity.type == PB.enum.ActivityType.RacePVP or activity.type == PB.enum.ActivityType.RacePVPActivity then
        windowName = "RacePVP"
      elseif activity.type == PB.enum.ActivityType.ExtremeChallenge then
        ACU.MarkActivityViewed(PB.enum.ActivityType.ExtremeChallenge, 1)
        WU.EnableToRequest("TowerNew/UpdateAble", "fci/extreme-challenge/summary/", function(result)
          if result.locked then
            WU.AcquireWindowAsync("TowerNewPrepare")
          else
            WU.AcquireWindowAsync("TowerNewEntrance")
          end
        end)
      end
      if windowName ~= "" and not WU.WindowIsLocked(WU.ActivityTypeToUnlockWindowType(activity.type)) and ACU.IsActivitiesOn(m_selectedActivityGroup) then
        if windowName == "DungeonTeam" then
          this:GameRequest("fci/teamdungeongroups/"):Get(function(result)
            this:SetData("fci/teamdungeongroups/", result)
            this:SetData("DungeonTeamType", PB.enum.ActivityType.DungeonTeam)
            WU.AcquireWindowAsync(windowName)
            ACU.MarkActivityViewed(PB.enum.ActivityType.DungeonTeam, 1)
          end)
        else
          if windowName == "EventActivityStage" then
            ACU.MarkActivityViewed(activity.type, activity.activityId)
          else
            ACU.MarkActivityViewed(activity.type, 1)
          end
          WU.AcquireWindowAsync(windowName)
        end
      end
    elseif activity.category == PB.enum.ActivityCategory.Tournament then
      local status = ACU.GetTournamentStatus(activity.activityId)
      local windowName
      if activity.activityId == m_randomCallId then
        this:SetData("RandomCall/Activity", activity)
        WU.AcquireWindowAsync("RandomCallJoin")
        return
      end
      if status == PB.enum.TournamentStatus.Participation then
        ACU.SetCurTournamentId(activity.activityId)
        if activity.type == PB.enum.ActivityType.Tournament_AsyncPvp then
          windowName = "AsyncPvp"
        elseif activity.type == PB.enum.ActivityType.AsyncPvpV2 then
          windowName = "AsyncPvpNew"
        elseif activity.type == PB.enum.ActivityType.BurstLinkPvp then
          windowName = "BurstLinkActorSelect"
        end
        WU.AcquireWindowAsync(windowName)
        ACU.MarkActivityViewed(activity.type, 1)
      elseif status == PB.enum.TournamentStatus.Group then
        ACU.SetCurTournamentId(activity.activityId)
        if activity.type == PB.enum.ActivityType.BurstLinkPvp then
          WU.AcquireWindowAsync("BurstLinkActorSelect")
        end
      elseif status == PB.enum.TournamentStatus.Group_End then
        ACU.SetCurTournamentId(activity.activityId)
        if activity.type == PB.enum.ActivityType.BurstLinkPvp then
          WU.AcquireWindowAsync("BurstLinkActorGroup")
        end
      elseif status == PB.enum.TournamentStatus.NoParticipation then
        local baseInfo = this:GetData("fci/baseinfo/")
        if baseInfo and baseInfo.level >= activity.levelLimit then
          ACU.SetCurTournamentId(activity.activityId)
          if activity.type == PB.enum.ActivityType.BurstLinkPvp then
            WU.AcquireWindowAsync("BurstLinkJoin", function(ui)
              _ENV["$"](ui)["$$SetTournamentInfo"](activity)
            end)
            ACU.MarkActivityViewed(activity.type, 1)
          elseif activity.type == PB.enum.ActivityType.Tournament_AsyncPvp then
            WU.AcquireWindowAsync("AsyncPvp")
            ACU.MarkActivityViewed(activity.type, 1)
          elseif activity.type == PB.enum.ActivityType.AsyncPvpV2 then
            this:SetData("AsyncPvpNew/ActivityInfo", activity)
            WU.AcquireWindowAsync("AsyncPvpNew")
            ACU.MarkActivityViewed(activity.type, 1)
          else
            error("GamePlay", "Unhandled tournament type")
          end
        else
          WU.ShowHintText(WU.GetString("WindowAccount_LevelLimit", activity.levelLimit))
        end
      end
    end
  end)
end

function OnShowSortClick()
  WU.SetActive(REF.DropList, true)
  TU.TaskFirstCheck(PB.enum.UseFuncMTimes.SelectPlayMethod)
end

function OnHideSortClick()
  WU.SetActive(REF.DropList, false)
end

function OnSortClick(sortButton)
  local sortIndex = _ENV["$"](sortButton)["@sortIndex"]
  if m_sortIndex ~= sortIndex then
    if m_sortIndex then
      WU.SetActive(REF.SortButtonGrid[m_sortIndex - 1].SpriteSelected, false)
    end
    m_sortIndex = sortIndex
    if m_sortIndex then
      WU.SetActive(REF.SortButtonGrid[m_sortIndex - 1].SpriteSelected, true)
      if m_activityGroupMap then
        SortActivityList()
        LU.Set(REF.ActivityContent, #m_activityGroupList, true, true)
        REF.ActivityContent.UIPlayTween:Play(true)
        this:SetData("SelectedActivityGroup", m_activityGroupList[1])
      end
    end
    OnScrollViewMove()
  end
end

function GetGameMode(activityType)
  local result = PB.enum.GameModeType.None
  if activityType == PB.enum.ActivityType.BurstLinkPvp then
    result = PB.enum.GameModeType.BurstLinkPvp
  elseif activityType == PB.enum.ActivityType.RacePVP then
    result = PB.enum.GameModeType.RacePVP
  elseif activityType == PB.enum.ActivityType.DungeonTeam then
    result = PB.enum.GameModeType.TeamPve
  end
  return result
end

function OnScrollViewMove()
  local showButton = false
  if m_lastRedMarkIndex then
    local entryBottomHeight = (m_lastRedMarkIndex - 1) * REF.ActivityContent.UIWrapContent.itemSize + REF.Visual.UIWidget.height
    local scrollViewOffsetY = REF.ActivityScrollView.transform.localPosition.y - m_scrollViewInitY
    local entryOffsetYFromViewTop = entryBottomHeight - scrollViewOffsetY
    showButton = entryOffsetYFromViewTop > REF.ActivityScrollView.UIPanel.finalClipRegion.w
  end
  WU.SetActive(REF.ButtonNext, showButton)
end

function OnButtonNext()
  local visibleContentHeight = REF.ActivityScrollView.transform.localPosition.y - m_scrollViewInitY + REF.ActivityScrollView.UIPanel.finalClipRegion.w
  local bottomDataIndex = math.floor((visibleContentHeight - REF.Visual.UIWidget.height) / REF.ActivityContent.UIWrapContent.itemSize) + 1
  local nextIndex
  for index, flag in ipairs(m_activityRedMarks) do
    if flag and index > bottomDataIndex then
      nextIndex = index
      break
    end
  end
  if nextIndex then
    local entryBottomHeight = (nextIndex - 1) * REF.ActivityContent.UIWrapContent.itemSize + REF.Visual.UIWidget.height
    local newOffsetY = entryBottomHeight - REF.ActivityScrollView.UIPanel.finalClipRegion.w + m_scrollViewInitY
    local offset = CS.UnityEngine.Vector3(0, newOffsetY - REF.ActivityScrollView.transform.localPosition.y, 0)
    REF.ActivityScrollView.UIScrollView:SpringRelative(offset, 20)
  end
end
