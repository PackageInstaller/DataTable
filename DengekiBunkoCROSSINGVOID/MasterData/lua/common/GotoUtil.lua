local DU = require("Common/DungeonUtil")
local ACU = require("Common/ActivityUtil")
local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local NU = require("Common/NotepadUtil")
local GU = {}

function _Goto(windowName, params, substituteCallback)
  if substituteCallback then
    substituteCallback()
    return
  end
  WU.AcquireWindowAsync(windowName, function(ui)
    if _ENV["$"](ui)["$$Goto"] then
      _ENV["$"](ui)["$$Goto"](table.unpack(params))
    end
  end)
end

function GU.Goto(windowName, params, bForCheck, substituteCallback)
  if windowName == "DungeonStory" then
    if tonumber(params[1]) == nil then
      warning("GamePlay", "Goto.xlsx error, DungeonStory param0 is nil")
      return
    end
    DU.IsDungeonUnlocked(DB:GetData("fci/dungeon/chapter-summary"), math.floor(tonumber(params[1])), function(unlocked)
      if unlocked then
        _Goto(windowName, params, substituteCallback)
      elseif not bForCheck then
        WU.ShowHintText(WU.GetString("Error_DungeonLocked"))
      end
    end)
  elseif windowName == "WeekActivityPrepare" then
    if params[1] and params[2] then
      GetRequestDataAsync("fci/activity-dungeon/record/", function(record)
        DB:SetData("fci/activity-dungeon/record/", record)
        local activityId = math.floor(tonumber(params[1]))
        local dungeonId = math.floor(tonumber(params[2]))
        local activityType = PB.enum.ActivityType.CollectionDungeon
        local currentActivityList = ACU.GetCurrentActivityList(activityType)
        local _, activityItem = _ENV["!"](currentActivityList):find(function(k, v)
          return v.activityId == activityId
        end)
        if activityItem and ACU.IsOpenForDoing(activityItem) then
          local rewardItem = PB.get("DungeonReward", dungeonId)
          local preDungeonId = rewardItem.preDungeonId
          local unlockLevel = rewardItem.unlockLevel
          local preUnlocked = false
          if preDungeonId == nil or preDungeonId == 0 then
            preUnlocked = true
          else
            local _, dungeonRecord = _ENV["!"](record):find(function(k, v)
              return v.dungeonId == preDungeonId
            end)
            preUnlocked = dungeonRecord and dungeonRecord.finished
          end
          if preUnlocked and unlockLevel <= DB:GetData("fci/baseinfo/").level then
            if not bForCheck then
              DB:SetData("Activity/CurrentActivity", currentActivityList)
              DB:SetData("Activity/CurrentType", activityType)
            end
            _Goto(windowName, params, substituteCallback)
            if not bForCheck then
              ACU.MarkActivityViewed(PB.enum.ActivityType.CollectionDungeon, 1)
            end
          elseif not bForCheck then
            WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
          end
        elseif not bForCheck then
          WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
        end
      end)
    end
  elseif windowName == "ChapterNormal" then
    local summary = DB:GetData("fci/dungeon/chapter-summary")
    if summary and summary.unlockedNormalDungeonsCnt > 0 then
      _Goto(windowName, params, substituteCallback)
    elseif not bForCheck then
      WU.ShowHintText(WU.GetString("WindowDungeon_LockedHint"))
    end
  elseif windowName == "ChapterChallenge" then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Challenge, fif(bForCheck, nil, PB.enum.UnlockWindow.Challenge)) then
      local summary = DB:GetData("fci/dungeon/chapter-summary")
      if summary and 0 < summary.unlockedChallengeDungeonsCnt then
        WU.AcquireWindowAsync("ChapterChallenge")
        if not bForCheck then
          ACU.MarkActivityViewed(PB.enum.ActivityType.ChallengeMode, 1)
        end
      else
        local chapterInfos = PB.all("ChapterInfo"):where(function(k, v)
          return v.type == PB.enum.DungeonType.Challenge
        end):toarray():sort(function(a, b)
          return a.chapterIndex < b.chapterIndex
        end)
        DU.ShowChallengeChapterUnlockHint(chapterInfos[1].chapterId)
      end
    end
  elseif windowName == "Shop" then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Shop, fif(bForCheck, nil, PB.enum.UnlockWindow.Shop)) then
      _Goto(windowName, params, substituteCallback)
    end
  elseif windowName == "Deploy" then
    GoToActivity(windowName, params, PB.enum.ActivityType.DeployMission, bForCheck, substituteCallback)
  elseif windowName == "Tower" then
    GoToActivity(windowName, params, PB.enum.ActivityType.Tower, bForCheck, substituteCallback)
  elseif windowName == "ActivityStageChoose2" then
    GoToActivity(windowName, params, PB.enum.ActivityType.CollectionDungeon, bForCheck, substituteCallback)
  elseif windowName == "DungeonGold" then
    GoToActivity(windowName, params, PB.enum.ActivityType.GoldDungeon, bForCheck, substituteCallback)
  elseif windowName == "Welfare" then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare, fif(bForCheck, nil, PB.enum.UnlockWindow.Welfare)) then
      DB:SetData("WelfareTab", "Checkin")
      _Goto(windowName, params, substituteCallback)
    end
  elseif windowName == "Task" then
    GotoTask(params, bForCheck, substituteCallback)
  elseif windowName == "Tournament" then
    local param = tonumber(params[1])
    if param == nil then
      warning("GamePlay", "Goto.xlsx error, Tournament param0 is nil")
      return
    end
    if param == 1 then
      GotoTournament(PB.enum.ActivityType.Tournament_AsyncPvp, bForCheck, substituteCallback)
    elseif param == 2 then
      GotoTournament(PB.enum.ActivityType.BurstLinkPvp, bForCheck, substituteCallback)
    elseif param == 3 then
      GotoTournament(PB.enum.ActivityType.RacePVP, bForCheck, substituteCallback)
    end
  elseif windowName == "Friend" then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Friend, fif(bForCheck, nil, PB.enum.UnlockWindow.Friend)) then
      _Goto(windowName, params, substituteCallback)
    end
  elseif windowName == "ActorTalent" then
    local canGo = DB:GetData("fci/actor") and DB:GetData("fci/actor")[1]
    if bForCheck then
      substituteCallback(canGo)
      return
    elseif canGo then
      WU.AcquireWindowAsync("ActorInfo", function(window)
        DB:SetData("Actor/SelectedUid/", DB:GetData("fci/actor")[1].uid)
        _ENV["$"](window)["$$SetSelectedTab"]("TabTalent")
        _ENV["$"](window)["$$ShowSwitch"]()
      end)
    end
  elseif windowName == "CollectionsActor" then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, fif(bForCheck, nil, PB.enum.UnlockWindow.Journey)) then
      NU.GetCollectionsActor(function()
        _Goto(windowName, params, substituteCallback)
      end)
    end
  elseif windowName == "ActorMain" then
    if bForCheck then
      substituteCallback(true)
      return
    else
      DB:SetData("Actor/SelectedUid", nil)
      WU.AcquireWindowAsync("ActorMain", function()
        DB:SetData("Actor/SelectedUid", math.floor(tonumber(params[1])))
      end)
    end
  elseif windowName == "TowerNewEntrance" then
    WU.EnableToRequest("TowerNew/UpdateAble", "fci/extreme-challenge/summary/", function(result)
      ACU.MarkActivityViewed(PB.enum.ActivityType.ExtremeChallenge, 1)
      if result.locked then
        windowName = "TowerNewPrepare"
      else
        windowName = "TowerNewEntrance"
      end
      _Goto(windowName, params, substituteCallback)
    end)
  elseif windowName == "MazeEnter" then
    if ACU.IsActivityUnlockedWithHint(PB.enum.ActivityType.Maze, bForCheck) then
      local function fuc()
        local mazeInfo = DB:GetData("fci/MazeInfo/")
        
        if mazeInfo == nil then
          windowName = "MazeEnter"
        else
          windowName = "MazeMain"
        end
        _Goto(windowName, params, substituteCallback)
      end
      
      local mazeId = DB:GetData("fci/MazeId/34001/")
      local mazeActivityId = DB:GetData("MazeActivityId")
      if mazeActivityId == nil or mazeActivityId ~= PB.all("Misc")[1].mazeMiscConf.mazeActivityId then
        DB:GameRequest("fci/Maze/Summary/34001/"):Get(function(res)
          DB:SetData("MazeActivityId", PB.all("Misc")[1].mazeMiscConf.mazeActivityId)
          DB:SetData("fci/MazeId/34001/", res.mazeId)
          DB:SetData("mazePassedIds", res.mazePassed)
          DB:SetData("fci/MazeInfo/", res.mazeInfo)
          fuc()
        end)
      else
        fuc()
      end
    end
  elseif windowName ~= "None" then
    _Goto(windowName, params, substituteCallback)
  end
end

function GoToActivity(windowName, params, type, bForCheck, substituteCallback)
  if not ACU.IsActivityUnlockedWithHint(type, bForCheck) then
    return
  end
  if type == PB.enum.ActivityType.CollectionDungeon then
    GoToActivityImpl(windowName, params, type, bForCheck, substituteCallback)
  else
    _Goto(windowName, params, substituteCallback)
    if not bForCheck then
      ACU.MarkActivityViewed(type, 1)
    end
  end
end

function GoToActivityImpl(windowName, params, type, bForCheck, substituteCallback)
  GetRequestDataAsync("fci/activity-dungeon/record/", function(record)
    DB:SetData("fci/activity-dungeon/record/", record)
    if not bForCheck then
      DB:SetData("Activity/CurrentMaterialId", nil)
      DB:SetData("Activity/CurrentType", type)
      DB:SetData("Activity/CurrentActivity", ACU.GetCurrentActivityList(type))
    end
    if params[1] then
      if ACU.IsOpenForDoing(DB:GetData("Activity/CurrentActivity")[math.floor(tonumber(params[1]))]) then
        _Goto(windowName, params, substituteCallback)
        if not bForCheck then
          ACU.MarkActivityViewed(type, 1)
        end
      elseif not bForCheck then
        WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
      end
    else
      _Goto(windowName, params, substituteCallback)
      if not bForCheck then
        ACU.MarkActivityViewed(type, 1)
      end
    end
  end)
end

function GotoTask(params, bForCheck, substituteCallback)
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Task, fif(bForCheck, nil, PB.enum.UnlockWindow.Task)) then
    local type = tonumber(params[1])
    if type == 1 then
      WU.WindowIsLocked(PB.enum.UnlockWindow.TaskRoutine, fif(bForCheck, nil, PB.enum.UnlockWindow.TaskRoutine))
    elseif type == 2 then
      WU.WindowIsLocked(PB.enum.UnlockWindow.TaskMain, fif(bForCheck, nil, PB.enum.UnlockWindow.TaskMain))
    end
    _Goto("Task", params, substituteCallback)
  end
end

function GotoTournament(type, bForCheck, substituteCallback)
  local isLocked, unlockLevel
  if type == PB.enum.ActivityType.Tournament_AsyncPvp then
    if WU.WindowIsLocked(PB.enum.UnlockWindow.AsyncPvp, fif(bForCheck, nil, PB.enum.UnlockWindow.AsyncPvp)) then
      return
    end
  elseif type == PB.enum.ActivityType.BurstLinkPvp then
    if WU.WindowIsLocked(PB.enum.UnlockWindow.BurstLink, fif(bForCheck, nil, PB.enum.ActivityType.BurstLink)) then
      return
    end
  elseif type == PB.enum.ActivityType.RacePVP and WU.WindowIsLocked(PB.enum.UnlockWindow.RacePvp, fif(bForCheck, nil, PB.enum.UnlockWindow.RacePvp)) then
    return
  end
  GetRequestDataAsync("fci/tournament/summary/", function(summaryInfo)
    DB:SetData("fci/tournament/summary/", summaryInfo)
    local activityInfoList = summaryInfo.activityInfo
    local _, entry = table.find(activityInfoList, function(_, v)
      return v.activity.type == type
    end)
    local activityInfo = entry.activity
    GotoTournamentImpl(activityInfo, bForCheck, substituteCallback)
  end)
end

function GotoTournamentImpl(activityInfo, bForCheck, substituteCallback)
  if ACU.IsOpenForDoing(activityInfo) == false and not bForCheck then
    WU.ShowHintText(WU.GetString("PVPREALRACE_TIPS4"))
    return
  end
  local status = ACU.GetTournamentStatus(activityInfo.activityId)
  ACU.SetCurTournamentId(activityInfo.activityId)
  local windowName
  if status == PB.enum.TournamentStatus.Participation then
    if activityInfo.type == PB.enum.ActivityType.Tournament_AsyncPvp then
      windowName = "AsyncPvp"
    elseif activityInfo.type == PB.enum.ActivityType.BurstLinkPvp then
      windowName = "BurstLinkActorSelect"
    elseif activityInfo.type == PB.enum.ActivityType.RacePVP then
      windowName = "RacePVP"
    else
      windowName = "TournamentPrepare"
    end
  elseif status == PB.enum.TournamentStatus.Group then
    if activityInfo.type == PB.enum.ActivityType.BurstLinkPvp then
      windowName = "BurstLinkActorSelect"
    end
  elseif status == PB.enum.TournamentStatus.Group_End then
    if activityInfo.type == PB.enum.ActivityType.BurstLinkPvp then
      windowName = "BurstLinkActorGroup"
    end
  elseif status == PB.enum.TournamentStatus.NoParticipation then
    if activityInfo.type == PB.enum.ActivityType.BurstLinkPvp then
      windowName = "BurstLinkJoin"
    elseif activityInfo.type == PB.enum.ActivityType.Tournament_AsyncPvp then
      windowName = "AsyncPvp"
    end
  end
  _Goto(windowName, {activityInfo}, substituteCallback)
end

function CheckEnterCondition(condition, continueCallback, preferenceId, gameMode)
  local chapterSummary = DB:GetData("fci/dungeon/chapter-summary")
  local isChapterFinished = DU.IsChapterFinished(chapterSummary, condition.finishedChapterId)
  if not isChapterFinished then
    local chapterInfo = PB.get("ChapterInfo", condition.finishedChapterId)
    if chapterInfo then
      local chapterName = ""
      if chapterInfo.type == PB.enum.ChapterType.Challenge then
        chapterName = WU.GetString("Challenge_Chapter") .. condition.finishedChapterId % 1000
      end
      local configDataManager = S:Get("ConfigDataManager")
      local preferences = configDataManager.GetPreferences()
      if not preferences[preferenceId] then
        local content = ""
        local noText = ""
        if condition.finishedChapterIdIsOptional then
          if gameMode == nil then
            content = WU.GetString("GameModeEnterDungeonConditionRecommend", chapterName)
          else
            content = WU.GetString("GameModeEnterConditionRecommend", WU.GetString("GameModeName" .. gameMode), chapterName)
          end
          noText = WU.GetString("GameModeEnterConditionGo")
        else
          if gameMode == nil then
            content = WU.GetString("GameModeEnterDungeonCondition", chapterName)
          else
            content = WU.GetString("GameModeEnterCondition", WU.GetString("GameModeName" .. gameMode), chapterName)
          end
          noText = WU.GetString("GameModeEnterConditionNo")
        end
        WU.ShowMessageYesNo(content, function(msg, toggle)
          if msg == "YES" then
            if chapterInfo.type == PB.enum.ChapterType.Challenge then
              GU.Goto("ChapterChallenge", {})
            else
              error("GamePlay", "Unhandled chapter type, ask programmer to add it")
            end
          elseif msg == "NO" and condition.finishedChapterIdIsOptional then
            continueCallback()
          end
          if toggle then
            preferences[preferenceId] = true
            configDataManager.SetPreferences(preferences)
          end
        end, WU.GetString("GameModeEnterConditionYes"), noText, nil, nil, true, fif(condition.finishedChapterIdIsOptional, "", nil))
      else
        continueCallback()
      end
    else
      error("GamePlay", "no chapterInfo,chapterfinishid is: " .. condition.finishedChapterId)
    end
  else
    continueCallback()
  end
end

function GU.CheckDungeonEnterCondition(dungeonId, continueCallback)
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward and dungeonReward.enterCondition and dungeonReward.enterCondition.finishedChapterId > 0 then
    CheckEnterCondition(dungeonReward.enterCondition, continueCallback, "DonotShowGameModeHintDungeonId" .. dungeonId, nil)
  else
    continueCallback()
  end
end

function GU.CheckGameModeEnterCondition(gameMode, continueCallback)
  if gameMode ~= PB.enum.GameModeType.None then
    local gameModeInfo = PB.get("GameModeInfo", gameMode)
    if gameModeInfo and gameModeInfo.enterCondition then
      CheckEnterCondition(gameModeInfo.enterCondition, continueCallback, "DonotShowGameModeHintGameMode" .. gameMode, gameMode)
    else
      continueCallback()
    end
  else
    continueCallback()
  end
end

function GetRequestDataAsync(uri, callback)
  local data = DB:GetData(uri)
  if data then
    callback(data)
  else
    DB:GameRequest(uri):Get(function(data)
      callback(data)
    end)
  end
end

return GU
