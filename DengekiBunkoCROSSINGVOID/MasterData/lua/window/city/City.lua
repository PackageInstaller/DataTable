local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local DU = require("Common/DungeonUtil")
local AU = require("Common/ActorUtil")
local FU = require("Common/FriendUtil")
local U = require("Common/Util")
local GotoUtil = require("Common/GotoUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local RU = require("Common/RedMarkUtil")
local GU = require("Common/GuildUtil")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local NU = require("Common/NotepadUtil")
local CO = require("Common/Coroutine")
local GroupUtil = require("Common/GroupUtil")
local ACU = require("Common/ActivityUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local PU = require("Common/PlatformUtil")
local ATU = require("Common/AutumnUtil")
local MSDKSyncInterval = 86400
local Msdk = CS.Msdk
local m_platform, m_myOpenId, m_cachedQueryInfo, co, t_time, m_chaptersHasReward
local tutorial_fight = 0
local m_latestArticleId = 0
local m_coroutine, m_setSpeech, m_hideSpeech, m_timeInited, m_dailyRefreshTime, m_dailyRefreshHour
local m_categorizedTasks = {}
local m_chapterProgress, m_deoloyInfo
local m_timeElapased = 5
local m_chapterRedPointInited = false
local m_TriggerLockTip = 0
local m_eventDungeonActivities
local m_contentShowing = true
local m_MaxActorCultivaiton = 15
local m_activityFuncBinded = {}
local m_redPointData
local m_ActorCultivaitonFlag = true
local UnlockActivityWindowData = {
  PB.enum.UnlockWindow.AsyncPvp,
  PB.enum.UnlockWindow.ActivityStageChoose1,
  PB.enum.UnlockWindow.ActivityStageChoose2,
  PB.enum.UnlockWindow.Tower,
  PB.enum.UnlockWindow.Deploy,
  PB.enum.UnlockWindow.BurstLink,
  PB.enum.UnlockWindow.RacePvp
}
local m_focusedGachaActivity, m_modifyActivityList
local m_firstLoginEveryDay = true

function SetupWindow()
  WU.BindButtonEvent(REF.rhythmGame, OnClickRhythm)
  WU.BindButtonEvent(REF.ButtonHead, OnHeadClick)
  WU.BindButtonEvent(REF.ButtonStory, OnStoryClick)
  WU.BindButtonEvent(REF.ButtonActor, OnActorClick)
  WU.BindButtonEvent(REF.ButtonChallenge, OnChallengeClick)
  WU.BindButtonEvent(REF.ButtonGacha, OnButtonGacha)
  WU.BindButtonEvent(REF.ButtonRelation, OnButtonRelation)
  WU.BindButtonEvent(REF.ButtonWelfare, OnButtonWelfare)
  WU.BindButtonEvent(REF.ButtonShop, OnButtonShop)
  WU.BindButtonEvent(REF.ButtonRoleNotepad, OnButtonNotepad)
  WU.BindButtonEvent(REF.ButtonBag, OnButtonBag)
  WU.BindButtonEvent(REF.ButtonBulletin, OnButtonBulletin)
  WU.BindButtonEvent(REF.ButtonTask, OnButtonTask)
  WU.BindButtonEvent(REF.ButtonPortal, OnButtonPortal)
  WU.BindButtonEvent(REF.ShowContent, OnShowContent)
  WU.BindButtonEvent(REF.Share, OnClickShare)
  WU.BindButtonEvent(REF.Download, OnDownloadClick)
  this:RegisterGameEvent("LoadingQuickEnd", OnLoadingEnd)
  this:RegisterGameEvent("GotoFromBrowser", OnGotoFromBrowser)
  this:RegisterGameEvent("GetKingCardStatus", OnGetKingCardStatus)
  this:RegisterGameEvent("NetworkChangedDetail", OnNetworkChangedDetail)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  WU.SetActive(REF.ButtonSwitchActor, false)
  WU.SetActive(REF.ButtonWelfare2, false)
  WU.SetActive(REF.ButtonDorm, false)
  CreateActor2skin()
  this:SetData("City/CutBoardVoice", false)
end

function CreateActor2skin()
  if this:GetData("actor2skin") ~= nil then
    return
  end
  local resActorSkin = PB.all("ActorSkin")
  local actor2skin = {}
  local resConfigs = PB.all("ActorConfig")
  for i = 1, #resConfigs do
    actor2skin[resConfigs[i].id] = {0}
  end
  for i = 1, #resActorSkin do
    local skinId = resActorSkin[i].id
    local actorIds = resActorSkin[i].actorIds
    for j = 1, #actorIds do
      local actorId = actorIds[j]
      actor2skin[actorId] = actor2skin[actorId] or {}
      if AU.IsActorSkinOpen(skinId) then
        table.insert(actor2skin[actorId], skinId)
      end
    end
  end
  for i = 1, #resConfigs do
    table.sort(actor2skin[resConfigs[i].id], function(a, b)
      if a == 0 then
        return true
      end
      if b == 0 then
        return false
      end
      return a < b
    end)
  end
  this:SetData("actor2skin", actor2skin)
end

function UpdateBtnVisible()
  local switch = this:GetData("AccountSwitch")
  if switch and switch.bulletinSwitch == false then
    REF.Bulletin.gameObject:SetActive(false)
  else
    REF.Bulletin.gameObject:SetActive(true)
  end
  REF.ActivityGrid.UIGrid:Reposition()
end

function UpdateSpeechText(text, time)
  local row = PB.get("BoardVoice2Text", text)
  if row == nil then
    return
  end
  WU.ToggleRendering(REF.BoardSpeechText, true)
  local timeTotal = 0
  for i = 1, #row.data do
    local text = row.data[i].localizationText
    local di = row.data[i].delayInvoke
    timeTotal = timeTotal + di
    if 0 < di then
      m_setSpeech = this:DelayInvokeInSeconds(di, function()
        REF.BoardSpeechText.UIHtmlLabel.text = WU.GetString(text)
      end)
    else
      REF.BoardSpeechText.UIHtmlLabel.text = WU.GetString(text)
    end
  end
  m_hideSpeech = this:DelayInvokeInSeconds(time, function()
    WU.ToggleRendering(REF.BoardSpeechText, false)
  end)
end

function InitWindow()
  local gachaEntranceInfo = PB.all("GachaEntranceModification")
  m_modifyActivityList = _ENV["!"]({})
  WU.SetActive(REF.GachaHint, false)
  WU.SetActive(REF.SharePanel, false)
  _ENV["$"](REF.ShowContent).label.UILabel.text = "Hide"
  local modify = false
  for k, v in pairs(gachaEntranceInfo) do
    local acId = v.activityId
    local acType = v.activityType
    table.insert(m_modifyActivityList, acId)
    local activity = m_activityManager.GetActivitySync(acType, acId)
    if ACU.IsOpenForDoing(activity) then
      m_focusedGachaActivity = activity
      modify = true
      break
    end
  end
  ModifyGachaEntrance(modify)
  NU.GetCollectionsActor()
  this:BindRemote(DB:GameRequest("fci/emoji/"), function()
  end)
  this:RegisterGameEvent("OnScreenshotSuccessEvent", OnScreenshotSuccess)
  this:RegisterGameEvent("OnScreenshotFailureEvent", OnScreenshotFailure)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:RegisterGameEvent("ActivityStatusChanged", function(category, id, status, type)
    if m_modifyActivityList:has(id) then
      if status == PB.enum.ActivityStatus.Started then
        m_focusedGachaActivity = m_activityManager.GetActivitySync(type, id)
        ModifyGachaEntrance(true)
      else
        m_focusedGachaActivity = nil
        ModifyGachaEntrance(false)
      end
    end
  end)
  m_TriggerLockTip = 0
  m_dailyRefreshHour = U.ToInt(CS.System.TimeSpan.Parse(PB.index("Misc", 1).dailyRefreshTime).Hours)
  this:RegisterGameEvent("ActivityStatusChanged", function(category, id, status, type)
    if type == PB.enum.ActivityType.CultivationPvP and status == PB.enum.ActivityStatus.Started then
      local activities = m_activityManager.GetActivitiesByTypeSync(type)
      if activities then
        CreateCultivationPVPActivityTable(activities)
      end
    end
  end)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Warmup, function(acList)
    if acList == nil then
      return
    end
    if table.find(acList, function(k, v)
      return ACU.IsOpenForDoing(v)
    end) then
      this:BindRemote(DB:GameRequest("fci/warmup"), function(info)
        if info == nil then
          return
        end
        local enteredChapter = WU.GetPlayerCache("ArmWarmup/EnteredChapter") or {}
        local i, _ = table.find(info.chapterRecords, function(k, v)
          return not enteredChapter[tostring(v.chapterId)]
        end)
        RU.SetRedMark("Welfare/ArmWarmup/NewChapter", i ~= nil)
      end)
      this:Bind("fci/warmupTasks", function(tasks)
        if tasks ~= nil then
          RU.SetRedMark("Welfare/ArmWarmup/Task", TU.TaskCanReward(tasks))
        end
      end)
      this:Bind("fci/warmupDailyTasks", function(tasks)
        if tasks ~= nil then
          RU.SetRedMark("Welfare/ArmWarmup/DailyTask", TU.TaskCanReward(tasks))
        end
      end)
    end
  end)
  this:BindRemote(this:GameRequest("fci/ui-grid/"), function(resp)
    UpdateActivityDot(resp)
  end)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity, true) then
          this:BindRemote(DB:GameRequest("fci/maidcafe/rank-mode"), GetMaidCafeRnkInfo)
          this:BindRemote(DB:GameRequest("fci/maidcafe/rank-mode/pass-reward"), OnMaidCafePassReward)
          break
        end
      end
    end
  end)
  this:Bind("fci/dungeon/chapter-summary/", function(summary)
    if summary == nil then
      return
    end
    WU.SetActive(REF.SpriteStoryHintControl, not S:Get("TutorialManager").IsTutorialDoing() and not table.has(summary.unlockedChapterId, 7))
  end)
  this:Bind("ActorCultivation", function(activatedList)
    if activatedList == nil then
      return
    end
    UpdateActorCulticationPopupData()
    for i = 1, m_MaxActorCultivaiton do
      if activatedList[i] then
        local lastTime = WU.GetGameDataCache("ProgressTask/ActorCultivation" .. i .. "/firstLogin" .. DB:GetData("playerId"))
        local curTime = CS.GameTime.serverUtc
        local isFirst = not CS.GameTime.IsSameDate(lastTime, curTime)
        if activatedList[i].endTime == 0 then
          RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/firstLogin", isFirst)
        else
          RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/firstLogin", false)
        end
        local progressRewards = PB.all("ActorCultivationProgressReward")
        local curProgressNormal = activatedList[i].progressReward
        local curProgressVip = activatedList[i].progressRewardVip
        local progressRewardAva = false
        local rewardsTilNow = {}
        for _, v in pairs(progressRewards) do
          if activatedList[i].activityId == v.activityId then
            if v.progress > activatedList[i].progress then
              break
            end
            table.insert(rewardsTilNow, v)
          end
        end
        if 0 < #rewardsTilNow then
          progressRewardAva = curProgressNormal < rewardsTilNow[#rewardsTilNow].progress
          if activatedList[i].vip then
            progressRewardAva = progressRewardAva or curProgressVip < rewardsTilNow[#rewardsTilNow].progress and rewardsTilNow[#rewardsTilNow].progress ~= 100
          end
        end
        RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/ProgressReward", progressRewardAva)
      else
        RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/ProgressReward", false)
        RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/firstLogin", false)
        RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/new", false)
      end
    end
  end)
  this:BindRemote(DB:GameRequest("fci/actor-cultivation"), function(allList)
    if allList == nil then
      return
    end
    local config = PB.all("ProgressTaskConfig")
    local allCultivationConfig = config:where(function(k, v)
      return v.relatedActivityType == 53
    end)
    local activated = {}
    for _, v in pairs(allList) do
      m_activityManager.GetActivityByType(PB.enum.ActivityType.ActorCultivation, function(list)
        if list then
          local activity
          for _, ac in pairs(list) do
            if ac.activityId == v.activityId then
              activity = ac
              if activity and ACU.IsOpenForDoing(activity) and AU.GetActorListById(v.actorId) and allCultivationConfig then
                local _, clt = allCultivationConfig:find(function(k, value)
                  return value.relatedActivityIds[1] == ac.activityId
                end)
                if clt then
                  local index = tonumber(string.sub(clt.name, -1))
                  activated[index] = v
                end
              end
            end
          end
        end
      end)
    end
    this:SetData("ActorCultivation", activated)
    this:SetData("fci/actorCultivationTasks", this:GetData("fci/actorCultivationTasks"))
  end)
  this:RegisterGameEvent("ActivityStatusChanged", function(category, id, status, type)
    if type == PB.enum.ActivityType.ActorCultivation then
      this:SetData("ActorCultivation/ActivityChanged", true)
      this:SetData("fci/actor-cultivation", this:GetData("fci/actor-cultivation"))
    end
  end)
  this:Bind("cityBGM", function(bgmId)
    local xlsxConfig
    if this:GetData("CollectionsScene/isRandomMode") and this:GetData("cityScene") ~= bgmId or bgmId == nil then
      this:SetData("cityBGM", this:GetData("cityScene"))
      return
    else
      xlsxConfig = PB.get("CollectionsScenes", bgmId)
    end
    if xlsxConfig ~= "" then
      CS.SoundManager.Instance:PlayMusic(xlsxConfig.bgmRes)
    end
  end)
  this:Bind("cityScene", function(sceneId)
    if sceneId then
      local xlsxConfig = PB.get("CollectionsScenes", sceneId)
      if xlsxConfig then
        REF.BG.UITexture.mainTexturePath = "Texture/Background/" .. xlsxConfig.textureRes
        if xlsxConfig.effectRes == "" then
          WU.SetActive(REF.EffectBG, false)
        else
          WU.SetActive(REF.EffectBG, true)
          REF.EffectBG.EffectGenerator.m_EffectName = xlsxConfig.effectRes
          REF.EffectBG.EffectGenerator:Reset()
        end
      else
        warning("GamePlay", "there is no scene " .. tostring(sceneId))
      end
    end
  end)
  InitRefreshTime()
  UpdateBtnVisible()
  WU.ToggleRendering(REF.BoardSpeechText, false)
  REF.SpriteActor["$SetSpeechMode"](1)
  this:RegisterGameEvent("HasLeftCity", function(flag)
    WU.ToggleRendering(REF.BoardSpeechText, false)
    this:StopCoroutine(m_setSpeech)
    this:StopCoroutine(m_hideSpeech)
  end)
  this:RegisterGameEvent("BoardSpeechText", UpdateSpeechText)
  this:Bind("BoardActor/RoleId", function(signBoardID)
    print("Debug", "xx: " .. tostring(signBoardID))
    if signBoardID then
      local silent = true
      if this:GetData("NavigationContext") == this.name and WU.ContextWindow(WU.CurrentScene()) == nil then
        silent = false
      end
      REF.SpriteActor["$SetSignBoardByID"](signBoardID, true, silent)
    end
  end)
  local preferences = m_configDataManager.GetPreferences()
  if preferences.isPoorDevice then
    this:SetData("FightEffectLoadType", 3)
    this:SetData("FightActorLoadWaitTime", 0.2)
    this:SetData("FightActorLoadUseCache", false)
  end
  if WU.TutorialFight() then
    tutorial_fight = 1
  end
  this:Bind("NavigationContext", OnTopMostWindow)
  this:RegisterGameEvent("OnPlayerLevelup", OnPlayerLevelup)
  this:BindRemote(DB:GameRequest("fci/applylist/"), function(applylist)
    if applylist then
      applylist = applylist or {}
      RU.SetRedMark("Relation/Friend/NewApplier", 0 < #applylist and not this:GetData("applylistViewed"))
    end
  end)
  local context = this:GetData("SceneContext/SceneCity")
  this:Bind("SceneContext/SceneCity", function(context)
    if context == nil then
      return
    end
    m_activityManager.GetActivityByType(PB.enum.ActivityType.CultivationPvP, function(acList)
      if acList == nil then
        return
      end
      if table.find(acList, function(k, v)
        return ACU.IsOpenForDoing(v)
      end) then
        DB:SyncRemote(DB:GameRequest("fci/challenge-mode/reward"))
      end
    end)
  end)
  this:Bind("cultivationPVPDungeonIds", function(data)
    if data == nil then
      return
    end
    m_activityManager.GetActivityByType(PB.enum.ActivityType.CultivationPvP, function(acList)
      if acList == nil then
        return
      end
      if table.find(acList, function(k, v)
        return ACU.IsOpenForDoing(v)
      end) then
        DB:SyncRemote(DB:GameRequest("fci/challenge-mode/reward"))
      end
    end)
  end)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.CultivationPvP, function(acList)
    if acList == nil then
      return
    end
    local _, currActivity = table.find(acList, function(k, v)
      return ACU.IsOpenForDoing(v)
    end)
    if currActivity then
      this:BindRemote(DB:GameRequest("fci/challenge-mode/reward"), function(resp)
        if resp == nil then
          return
        end
        local canReward = {}
        local scoreRecord = resp.scoreRecord
        local rewardRecord = resp.rewardRecords
        this:SetData("CultivationPvP/scoreRecord", scoreRecord)
        this:SetData("CultivationPvP/rewardRecord", rewardRecord)
        local info = PB.get("ChallengeModeDungeon", currActivity.activityId)
        local allReward = PB.all("ChallengeModeScoreReward")
        if info == nil then
          return
        end
        local dungeonIds = info.dungeonId
        if info.dungeonId == nil then
          warning("No dungeon with this activity", currActivity.activityId)
          return
        end
        for i = 1, #dungeonIds do
          local id = tostring(dungeonIds[i])
          local hasReward = false
          if scoreRecord[id] then
            for _, v in pairs(allReward) do
              if v.dungeonId == dungeonIds[i] and v.score >= scoreRecord[id] and not IsCultivationRewardGot(v.dungeonId, v.score, rewardRecord) then
                table.insert(canReward, {
                  dungeonId = dungeonIds[i],
                  score = v.score
                })
                hasReward = true
              end
            end
          end
          RU.SetRedMark("Welfare/CultivationPvP/Reward/" .. i - 1, hasReward)
        end
        this:SetData("cultivationpvp/canrewardList", canReward)
      end)
    end
  end)
  UpdateQuestionRedPoint()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity == nil then
      return
    end
    local status = ACU.GetStatus(activity[1])
    if status == PB.enum.ActivityStatus.None then
      return
    end
    local dungeonUnlock = false
    DU.IsDungeonUnlocked(this:GetData("fci/dungeon/chapter-summary"), 5102, function(unlocked)
      dungeonUnlock = unlocked
    end)
    local reCondition = status == PB.enum.ActivityStatus.Finished or status == PB.enum.ActivityStatus.Close or status == PB.enum.ActivityStatus.None or not dungeonUnlock
    if reCondition then
      return
    end
    local redTime = WU.GetGameDataCache("ActorChipExchangeRedMarkTime")
    if redTime == nil then
      RU.SetRedMark("Welfare/ActorChipExchange", true)
    elseif not WU.IsToday(CS.GameTime.UtcToLocal(redTime)) and CS.GameTime.UtcToLocal(CS.GameTime.serverUtc).Hour >= 6 then
      local preheat = status == PB.enum.ActivityStatus.PreHeat
      if preheat then
        local data = DB:GetData("fci/chipexchange/")
        if data == nil then
          this:GameRequest("fci/chipexchange/"):Get(function(resp)
            this:SetData("fci/chipexchange/", resp)
            RU.SetRedMark("Welfare/ActorChipExchange", #resp.settlePosInfo <= 0)
          end)
        else
          RU.SetRedMark("Welfare/ActorChipExchange", #data.settlePosInfo <= 0)
        end
      else
        RU.SetRedMark("Welfare/ActorChipExchange", true)
      end
    else
      RU.SetRedMark("Welfare/ActorChipExchange", false)
    end
  end)
  ManageActorRedPoint()
  ManageGachaRedPoint()
  this:Bind("fci/dungeon/chapter-summary", function(chapterSummary)
    if chapterSummary == nil then
      return
    end
    ManageChapterRedPoint(chapterSummary)
    OnCartoonConfig(chapterSummary)
  end)
  RU.BindRedMark(this, "ChapterReward", function(flag)
    REF.SpriteRedPointStory.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Task", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Task)
    REF.SpriteTaskRedMark.gameObject:SetActive(not isLocked and flag)
    if not isLocked and flag then
      WU.SetActive(_ENV["$"](REF.Task).SpriteDot, false)
    end
  end)
  this:Bind("fci/task/", function(taskInfo)
    m_categorizedTasks = taskInfo
  end)
  CheckWlfActivePointRedMark()
  this:Bind("fci/actorCultivationTasks", function(taskAll)
    if taskAll == nil then
      return
    end
    local cultivationList = this:GetData("ActorCultivation")
    for i = 1, m_MaxActorCultivaiton do
      if cultivationList and cultivationList[i] and cultivationList[i].progress ~= 100 then
        local tasklist = TU.GetTaskListByActivityId(taskAll, cultivationList[i].activityId)
        local canReward = false
        if tasklist then
          for j = 1, #tasklist do
            local task = tasklist[j]
            if task and task.isDone and not task.rewardGot and not task.timeout then
              canReward = true
              if task.actorCultivationVipOnly and not cultivationList[i].vip then
                canReward = false
              end
              if canReward then
                break
              end
            end
          end
          RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/TaskReward", canReward)
        else
          RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/TaskReward", false)
        end
      else
        RU.SetRedMark("ProgressTask/ActorCultivation" .. i .. "/TaskReward", false)
      end
    end
  end)
  this:Bind("fci/week-activepoint/", function(weeklyInfo)
    if weeklyInfo ~= nil then
      RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Routine .. "/WeeklyActivePoint", TU.WeeklyActivePointCanReward(weeklyInfo))
    end
  end)
  RU.BindRedMark(this, "Journey", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Journey)
    REF.SpritePortalRedMark.gameObject:SetActive(not isLocked and flag)
    if not isLocked and flag then
      WU.SetActive(_ENV["$"](REF.Portal).SpriteDot, false)
    end
  end, {
    "Journey/Medal/New",
    "Journey/CollectionsNovel"
  })
  RU.BindRedMark(this, "Activity", function(flag)
    local isLocked = WU.WindowTableIsLocked(UnlockActivityWindowData)
    REF.SpriteRedPointChallenge.gameObject:SetActive(not isLocked and flag)
  end)
  this:Bind("fci/baseinfo/", function(baseInfo)
    if baseInfo ~= nil then
      REF.LabelLevel.UILabel.text = "[i]" .. WU.GetString("Window_LobbyPlayerLevel", baseInfo.level) .. "[i]"
      local name = baseInfo.name
      if name == "" then
        local accountCache = this:GetData("accountCache")
        local prefix = WU.GetString("WindowLogin_Player")
        if accountCache.EntryType == "guest" then
          prefix = WU.GetString("WindowLogin_Guest")
        end
        name = string.gsub(accountCache.openId, "fci_", prefix)
      end
      this:SetData("fci/displayname/", name)
      if not WU.WindowIsLocked(PB.enum.UnlockWindow.Shop) then
        RU.SetRedMark("Shop", RU.GetRedMark("Shop"))
      end
      ManageActivityViewedRedPoint()
    end
  end)
  this:Bind("fci/tower/summary", function(result)
    if result then
      RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.Tower), DU.IsTowerAwardCanGet(result))
    end
  end)
  this:Bind("fci/asyncpvprecord/", function(result)
    if result then
      RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.Tournament_AsyncPvp), #result.leftRewardsWinNum > 0)
    end
  end)
  RU.BindRedMark(this, "Welfare", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare)
    REF.SpriteWelfareRedMark.gameObject:SetActive(not isLocked and flag)
    if not isLocked and flag then
      WU.SetActive(_ENV["$"](REF.Welfare).SpriteDot, false)
    end
  end)
  this:Bind("fci/signin/", function(result)
    if result then
      RU.SetRedMark("Welfare/Checkin", not result.signed or WU.CheckinGiftUndrawn())
    end
  end)
  this:Bind("fci/RolePresent", function(result)
    if result then
      RU.SetRedMark("Welfare/RolePresent", 0 < #result)
    end
  end)
  this:Bind("fci/NewPlayerSignIn/", function(resp)
    if resp then
      local maxLoginDayNum = #PB.all("NewPlayerSignReward")
      local signDays = math.min(resp.signDays, maxLoginDayNum)
      RU.SetRedMark("Welfare/ViewNoviceGift", signDays > resp.rewardDays)
    end
  end)
  local popupGameRequestComplete = {}
  this:SetData("PopupGameRequestComplete", popupGameRequestComplete)
  this:Bind("fci/redpoint/data", function(redpointData)
    if redpointData == nil then
      return
    end
    m_redPointData = redpointData
    m_activityManager.GetActivityByType(PB.enum.ActivityType.NewPlayerSignIn, function(acList)
      if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
        local data = redpointData.newPlayerSignIn
        if data then
          local maxLoginDayNum = #PB.all("NewPlayerSignReward")
          data.rewardDays = math.min(data.rewardDays, maxLoginDayNum)
          data.signDays = math.min(data.signDays, maxLoginDayNum)
          this:SetData("fci/NewPlayerSignIn/", data)
        end
      end
    end)
    m_activityManager.GetActivityByType(PB.enum.ActivityType.Seal, function(acList)
      if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) and this:GetData("fci/seal") then
        this:SetData("fci/seal/flag", redpointData.sealFlagResult and redpointData.sealFlagResult.newOpenFlag)
      end
    end)
    m_activityManager.GetActivityByType(PB.enum.ActivityType.TenCheckin, function(acList)
      if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
        local data = redpointData.activitySigninGet
        if data then
          data.GetDay = CS.GameTime.serverNow.Day
          this:SetData("fci/activity-signin", data)
          this:SetData("fci/tenCheckin/flag", not data.signed)
          if not data.signed then
            this:SetData("PopupTenCheckin", CheckTenCheckinOpen())
            return
          end
        end
      end
      this:SetData("PopupTenCheckin", false)
    end, function()
      this:SetData("PopupTenCheckin", false)
    end)
    m_activityManager.GetActivityByType(PB.enum.ActivityType.EveryDayCheckin, function(activityList)
      if activityList and not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) then
        for k, v in pairs(activityList) do
          if v.type == PB.enum.ActivityType.EveryDayCheckin and ACU.IsOpenForDoing(v) then
            local everyDaySignInInfo = this:GetData("everydaysignin")
            if everyDaySignInInfo == nil then
              do
                local activityId = v.activityId
                local popupGameRequestComplete = this:GetData("PopupGameRequestComplete")
                popupGameRequestComplete.everydaysignin = false
                DB:GameRequest("fci/everyday-signin/" .. activityId .. "/"):Get(function(res)
                  local info = SetEveryDaySigninRedMark(res, v)
                  this:SetData("everydaysignin", info)
                  local index, _ = table.find(info.signinedDays, function(k, v)
                    return v == info.nowDay
                  end)
                  if v.activityId == 46004 and index == nil then
                    this:SetData("Popupeverydaysignin", true)
                  end
                  popupGameRequestComplete.everydaysignin = true
                end)
              end
              break
            end
            do
              local info = this:GetData("everydaysignin")
              SetEveryDaySigninRedMark(info, v)
            end
            break
          end
        end
      end
    end)
    m_activityManager.GetActivityByType(PB.enum.ActivityType.HalfYearBack, function(acList)
      if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) and not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) and redpointData.activeHalfYearBack then
        local activityId = acList[1].activityId
        this:BindRemote(DB:GameRequest("fci/half-year-back-activity/"), function(res)
          this:SetData("halfyearbackinactive", true)
          if res and res.reciveProgress < 0 then
            this:SetData("PopupCoverJumpinHalfYearBack", true)
          elseif res and res.reciveProgress >= 0 then
            this:SetData("PopupCoverJumpinHalfYearBack", false)
          end
          if res then
            local misc = PB.index("Misc", 1)
            local canSign = false
            local activeTime = CS.GameTime.UtcToLocal(res.activeTime)
            local activeDay24 = CS.System.DateTime(activeTime.Year, activeTime.Month, activeTime.Day, 0, 0, 0):AddDays(1)
            local endDoTime = activeDay24:AddDays(misc.halfYearBackDuration)
            if endDoTime > CS.GameTime.serverNow then
              this:SetData("halfyearbackcando", true)
              local allRewardsList = PB.all("ActivitySigninGift"):where(function(k, v)
                return v.activityId == activityId
              end):toarray()
              table.sort(allRewardsList, function(a, b)
                return a.days < b.days
              end)
              for i = 1, #allRewardsList do
                if allRewardsList[i].days > res.signStep and not CS.GameTime.IsSameDate(res.lastSignTime, CS.GameTime.serverUtc) then
                  RU.SetRedMark("Welfare/HalfYearBack/Signin/", true)
                  canSign = true
                  break
                end
              end
              if canSign == false then
                RU.SetRedMark("Welfare/HalfYearBack/Signin/", false)
              end
            else
              this:SetData("halfyearbackcando", false)
              RU.SetRedMark("Welfare/HalfYearBack/Task/" .. PB.enum.TaskCategory.PlayerBack .. "/Reward", false)
              RU.SetRedMark("Welfare/HalfYearBack/Signin/", false)
            end
            local hasThisProgress = false
            for i = res.reciveProgress + 1, res.completProgress do
              local progress = PB.all("PlayerBackProcess"):where(function(k, v)
                return v.activityId == activityId and v.progress == i and v.levelMax >= res.activeLevel and v.levelMin <= res.activeLevel
              end)
              if not table.empty(progress) then
                hasThisProgress = true
                break
              end
            end
            RU.SetRedMark("Welfare/HalfYearBack/Task/" .. PB.enum.TaskCategory.PlayerBack .. "/RewardSkilful", hasThisProgress)
          end
        end)
        return
      end
      this:SetData("PopupCoverJumpinHalfYearBack", false)
    end, function()
      this:SetData("PopupCoverJumpinHalfYearBack", false)
    end)
    RefreshNotPlayerBack(redpointData)
  end)
  this:Bind("activityViewed", ManageActivityViewedRedPoint)
  CheckNewSeasonOfCultivationPVP()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Couple, function(acList)
    if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
      local lastCoupleTime = WU.GetGameDataCache("LastCoupleTime")
      if lastCoupleTime and lastCoupleTime < acList[1].timestampStart then
        lastCoupleTime = nil
      end
      if lastCoupleTime == nil then
        RU.SetRedMark("Welfare/CoupleActorCultivation", true)
        WU.SetGameDataCache("LastCoupleTime", CS.GameTime.serverUtc)
        WU.SetGameDataCache("Welfare/CoupleActorCultivation", true)
      end
      this:Bind("fci/resource/ResCoupleScore_0", OnCoupleRedPoint)
    else
      this:Unbind("fci/resource/ResCoupleScore_0", OnCoupleRedPoint)
    end
  end)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.EventDungeon_Autumn2018, function(acList)
    if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
      REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_autumn"
      REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_autumn"
      REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
      this:SetData("PopupCoverJumpin", CheckCoverJumpinOpen("CoverJump"))
      return
    end
    this:SetData("PopupCoverJumpin", false)
  end, function()
    this:SetData("PopupCoverJumpin", false)
  end)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Carnival91, function(acList)
    if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
      REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_carnival"
      REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_carnival"
      REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
      this:SetData("PopupCoverJumpinCarnival91", CheckCoverJumpinOpen("CoverJumpCarnival91"))
      return
    end
    this:SetData("PopupCoverJumpinCarnival91", false)
  end, function()
    this:SetData("PopupCoverJumpinCarnival91", false)
  end)
  popupGameRequestComplete.popup = false
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Popup, function(acList)
    this:BindRemote(DB:GameRequest("fci/popup/"), function(popup)
      if popup then
        popupGameRequestComplete.popup = true
        if acList then
          local Ids = {}
          local level = this:GetData("fci/baseinfo").level
          for _, activity in pairs(acList) do
            local popupInfo = PB.get("PopupInfo", activity.activityId)
            if ACU.IsOpenForDoing(activity, true) and fif(popupInfo.minLevel == nil, true, level >= popupInfo.minLevel) and fif(popupInfo.maxLevel == nil, true, level <= popupInfo.maxLevel) then
              local time = WU.GetGameDataCache("lastCoverJumpTime_CoverJumpShareReward_" .. DB:GetData("playerId") .. "_" .. activity.activityId)
              if popupInfo.popuptype == 1 then
                if time == nil then
                  table.insert(Ids, activity.activityId)
                end
              elseif popupInfo.popuptype == 2 then
                if not CS.GameTime.IsSameDate(time, CS.GameTime.serverUtc) then
                  table.insert(Ids, activity.activityId)
                end
              elseif popupInfo.popuptype == 3 then
                table.insert(Ids, activity.activityId)
              end
            end
          end
          if #Ids ~= 0 then
            table.sort(Ids, function(a, b)
              local priorityA = PB.get("PopupInfo", a).priority
              local priorityB = PB.get("PopupInfo", b).priority
              if priorityA ~= priorityB then
                return priorityA < priorityB
              else
                return a < b
              end
            end)
            this:SetData("PopupCoverJumpinShareRewardCurrentActivityId", Ids[1])
            this:SetData("PopupCoverJumpinShareReward", true)
          else
            this:SetData("PopupCoverJumpinShareReward", false)
          end
        end
      end
    end)
  end, function()
    this:SetData("PopupCoverJumpinShareReward", false)
  end)
  RegisterWelfareChristmasRed()
  RegisterWelfareChineseNewYearRed()
  RegisterWelfareCookingRed()
  RegisterWelfareMaidCafeRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.CultivationPvP, function(acList)
    local open = false
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) then
          open = true
          break
        end
      end
      if open then
        this:SetData("PopupCoverCultivationPvP", CheckPopupState("CultivationPvPCover", CheckPopOnce))
        return
      end
    end
    this:SetData("PopupCoverCultivationPvP", false)
  end, function()
    this:SetData("PopupCoverCultivationPvP", false)
  end)
  m_activityManager.GetActivityRedByType(PB.enum.ActivityType.DiffActorInherit, function(bFlag)
    this:SetData("fci/decrepitTransport/flag", bFlag)
  end)
  this:Bind("fci/decrepitTransport/flag", function(flag)
    RU.SetRedMark("Welfare/DecrepitTransport", flag)
  end)
  this:Bind("fci/seal/flag", function(flag)
    RU.SetRedMark("Welfare/Seal", flag)
  end)
  this:Bind("fci/tenCheckin/flag", function(flag)
    RU.SetRedMark("Welfare/TenCheckin", flag)
  end)
  if this:GetData("HasSetConditionReward") ~= true then
    this:SetData("HasSetConditionReward", true)
    m_activityManager.GetActivityRedByType(PB.enum.ActivityType.ActivityType_ConditionReward, function(bFlag)
      RU.SetRedMark("Welfare/ConditionReward", bFlag)
    end)
  end
  RU.BindRedMark(this, "Shop", function(flag)
    local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Shop)
    REF.SpriteShopRedMark.gameObject:SetActive(not isLocked and flag)
    if not isLocked and flag then
      WU.SetActive(_ENV["$"](REF.Shop).SpriteDot, false)
    end
  end)
  this:Bind("fci/Shop/", function(result)
    if result then
      local _, limitShopInfo = table.find(result, function(k, v)
        return v.endTime ~= 0
      end)
      RU.SetRedMark("Shop", limitShopInfo ~= nil and this:GetData("fci/baseinfo").level >= limitShopInfo.baseInfo.playerLevel and limitShopInfo.endTime - CS.GameTime.serverUtc >= 0 and limitShopInfo.newShop)
    end
  end)
  this:Bind("fci/ActorGroup/", function(actorGroup)
    if actorGroup == nil then
      return
    end
    local actorInWhichGroups = {}
    for k, v in pairs(actorGroup) do
      for i = 1, #v.members do
        local member = v.members[i]
        if actorInWhichGroups[member.actorUid] then
          table.insert(actorInWhichGroups[member.actorUid], k)
        else
          actorInWhichGroups[member.actorUid] = {k}
        end
      end
    end
    this:SetData("ActorInWhichGroups", actorInWhichGroups)
  end)
  local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.BurstLinkPvp)
  if not locked then
    this:BindRemote(DB:GameRequest("fci/BurstLinkPvpInfo/"), function(burstLinkPvpInfo)
      if burstLinkPvpInfo then
        S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.BurstLinkPvp, function(acInfoList)
          if acInfoList and acInfoList[1] then
            local acInfo = acInfoList[1]
            local status = ACU.GetTournamentStatus(acInfo.activityId)
            local maxWinCount = PB.all("Misc"):first().pvpMaxWinNum
            local maxLoseCount = PB.all("Misc"):first().pvpMaxDieNum
            RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.BurstLinkPvp), burstLinkPvpInfo.baseInfo and (burstLinkPvpInfo.baseInfo.winNum and maxWinCount <= burstLinkPvpInfo.baseInfo.winNum or burstLinkPvpInfo.baseInfo.failNum and maxLoseCount <= burstLinkPvpInfo.baseInfo.failNum))
          end
        end)
      end
    end)
  end
  local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.TriggeredEvent)
  if not locked then
    this:BindRemote(DB:GameRequest("fci/triggered-event/"), function(resp)
      if resp then
        local ticketCnt = 0
        if resp.eventInfo[1] then
          local ticketId = PB.get("DungeonReward", resp.eventInfo[1].eventId).costWin[1].id
          ticketCnt = this:GetData("fci/item/" .. ticketId).count
        end
        local ticketId = PB.all("Misc"):first().triggeredEventTickets[1]
        local canPlay = 0 < #resp.eventInfo and 0 < ticketCnt
        RU.SetRedMark(string.format("Activity/%s/CanPlay", PB.enum.ActivityType.TriggeredEvent), canPlay and not this:GetData("triggeredEventRedMarkViewed"))
      end
    end)
  end
  local itemInfo = PB.all("ItemInfo")
  for i = 1, #itemInfo do
    if itemInfo[i].funcType == PB.enum.ItemFuncType.Star then
      this:Bind("fci/item/" .. itemInfo[i].id, function(result)
        if result then
          ManageActorRedPoint()
        end
      end)
    end
  end
  this:Bind("fci/actor", function(result)
    if result then
      ManageActorRedPoint()
    end
  end, false)
  this:Bind("GroupActorUids", function(data)
    if data then
      ManageActorRedPoint()
    end
  end, false)
  RU.BindRedMark(this, "Relation", function(flag)
    local data = {
      PB.enum.UnlockWindow.Friend,
      PB.enum.UnlockWindow.Guild
    }
    REF.SpriteRedPointRelation.gameObject:SetActive(not WU.WindowTableIsLocked(data) and flag)
  end)
  this:Bind("fci/guild-player/invited/", function(guildInvitation)
    RU.SetRedMark("Relation/Guild/Invite", guildInvitation and 0 < #guildInvitation)
  end)
  this:Bind("fci/guild/donate", function(donateInfo)
    local guildPlayer = this:GetData("fci/guild-player")
    if guildPlayer then
      if guildPlayer.guildId ~= 0 and this:GetData("fci/guild/") then
        if donateInfo then
          local myRequest = donateInfo.donates[this:GetData("playerId")]
          if myRequest == nil then
            RU.SetRedMark("Relation/Guild/Support/Donate", GU.CheckSupportRequestCD(true))
          else
            RU.SetRedMark("Relation/Guild/Support/Donate", false)
            local receivedCount = GU.GetDonateInfo(myRequest)
            local guildMisc = PB.index("GuildMisc", 1)
            local touched = WU.IsToday(CS.GameTime.UtcToLocal(myRequest.lastTouchTime))
            RU.SetRedMark("Relation/Guild/Support/Touch", GU.CheckFunctionCD() and 0 < receivedCount and not touched and myRequest.loveScore < guildMisc.maxLoveScore)
          end
        else
          RU.SetRedMark("Relation/Guild/Support/Donate", false)
        end
      else
        RU.SetRedMark("Relation/Guild/Support/Donate", false)
      end
    end
  end)
  this:Bind("fci/guild-player/", function(guildPlayerInfo)
    if guildPlayerInfo and guildPlayerInfo.guildId == 0 then
      WU.SetGameDataCache("seenGuild", false)
    end
    RU.SetRedMark("Relation/Guild/New", guildPlayerInfo and guildPlayerInfo.guildId > 0 and not WU.GetGameDataCache("seenGuild"))
  end)
  RU.BindRedMark(this, "Bulletin", function(flag)
    local unlock = IsNoticeUnlock()
    REF.SpriteBulletinRedMark.gameObject:SetActive(flag and unlock)
    if unlock and flag then
      WU.SetActive(_ENV["$"](REF.Bulletin).SpriteDot, false)
    end
  end)
  RU.SetRedMark("Bulletin", false)
  if IsNoticeUnlock() then
    CS.SceneCity.Instance:FetchLatestArticleId(OnEventFetchLatestArticle, OnEventFetchLatestArticleFailed)
  end
  local fromLogin = WU.FindWindow("Login")
  if fromLogin ~= nil then
    local loginTime = this:GetData("loginTime")
    if loginTime ~= nil then
      local dt = CS.GameTime:UtcToLocal(loginTime)
      local hour = dt.Hour
      local sex = this:GetData("playerSex")
      local condition = NU.CheckBoardSpeech(PB.enum.SpeechType.Login, function(params)
        local gender = tonumber(params[1])
        local startTime = tonumber(params[2])
        local endTime = tonumber(params[3])
        return startTime ~= nil and endTime ~= nil and startTime <= hour and endTime >= hour or gender ~= nil and gender == sex or startTime == nil and endTime == nil and gender == nil
      end)
      if condition ~= nil then
        this:BroadcastGameEvent("BoardActorSpeech", condition.id)
      end
    end
  end
  WU.SetActive(REF.SpriteKingCardFreeTraffic, false)
  Msdk.MsdkEvent.Instance:RelationEvent("+", MsdkRelationCallback)
  m_platform = this:GetData("accountCache").socialPlatform
  m_myOpenId = this:GetData("accountCache").socialEntry
  
  local function FetchTXFriends()
    info("MSDK", "fetch queryInfo TX")
    if m_platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
      Msdk.WGPlatform.Instance:WGQueryWXGameFriendsInfo()
    elseif m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
      Msdk.WGPlatform.Instance:WGQueryQQGameFriendsInfo()
    end
  end
  
  m_cachedQueryInfo = WU.GetGameDataCache("MSDKQueryInfo") or {}
  if m_cachedQueryInfo[tostring(m_myOpenId)] then
    local platformInfo = m_cachedQueryInfo[tostring(m_myOpenId)][tostring(m_platform)]
    if platformInfo and CS.GameTime.serverUtc - platformInfo.cacheTime < MSDKSyncInterval then
      info("MSDK", "using cached queryInfo")
      HandlerMsdkPersons(platformInfo.persons or {})
    else
      FetchTXFriends()
    end
  else
    FetchTXFriends()
  end
  if m_platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    Msdk.WGPlatform.Instance:WGQueryWXMyInfo()
  elseif m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    Msdk.WGPlatform.Instance:WGQueryQQMyInfo()
  end
  CheckKingCardStatus()
  this:Bind("fci/deploy/mission/", function(result)
    m_deoloyInfo = result
  end)
  DB:Bind("fci/RacePVPSummary/", function(result)
    if result ~= nil then
      local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.RacePvp)
      RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.RacePVP), not locked and result.rewardTag)
      RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.RacePVPActivity), not locked and result.rewardTag)
    end
  end)
  this:Bind("ActivityList", function(activityMap)
    if activityMap == nil then
      return
    end
    this:SetData("ChatRoom/ShowTriggeredEvent", false)
    
    local function IsEventDungeon(type)
      return type == PB.enum.ActivityType.EventDungeon or type == PB.enum.ActivityType.EventDungeon_Autumn2018 or type == PB.enum.ActivityType.EventDungeon_Autumn2018Hard
    end
    
    m_eventDungeonActivities = {}
    local cultivationPVPAcInfos = {}
    for k, v in pairs(activityMap) do
      if IsEventDungeon(v.type) and ACU.IsOpenForDoing(v) then
        table.insert(m_eventDungeonActivities, v)
      elseif v.type == PB.enum.ActivityType.TriggeredEvent and ACU.IsOpenForDoing(v) then
        this:SetData("ChatRoom/ShowTriggeredEvent", true)
      elseif v.type == PB.enum.ActivityType.CultivationPvP then
        table.insert(cultivationPVPAcInfos, v)
      end
    end
    CreateCultivationPVPActivityTable(cultivationPVPAcInfos)
    this:Unbind("fci/event-dungeon/star-reward", OnEventDungeonStarReward)
    this:Bind("fci/event-dungeon/star-reward", OnEventDungeonStarReward)
    ManageActivityViewedRedPoint()
  end)
  this:RegisterGameEvent("HasActorStarLevelup", function()
    this:SetData("CollectionsNovel/clean", false)
  end)
  this:RegisterGameEvent("HasNewActors", function()
    this:GameRequest("fci/CollectionsActor"):SyncInput(false):Get(function(response)
      NU.UpdateCollectionsActor(response.actors)
    end)
  end)
  RegisterHalloweenRed()
  RegisterPostcardRed()
  PopupAnnouncementPre()
  RegisterActivityStarRewardRed(PB.enum.ActivityType.Carnival91)
  RegisterActivityStarRewardRed(PB.enum.ActivityType.Christmas)
  RegisterActivityStarRewardRed(PB.enum.ActivityType.ChineseNewYear)
  RegisterActivityStarRewardRed(PB.enum.ActivityType.MaidCafe_DaemonMode)
  this:BindRemote(this:GameRequest("fci/custom-actor-cultivation/"), function(result)
    if result == nil or result.culPlans == nil then
      return
    end
    local culPlans = result.culPlans
    for i = 1, #culPlans do
      local curCulPlan = culPlans[i]
      local maxProgress = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, curCulPlan.activityId).maxProgress
      local lastSeenTime = WU.GetGameDataCache(string.format("CustomActorCultivation/%s/LastSeenTime", i))
      if not curCulPlan.vip and maxProgress > curCulPlan.progress and (lastSeenTime == nil or not CS.GameTime.IsSameDate(lastSeenTime, CS.GameTime.serverUtc)) then
        RU.SetRedMark(string.format("ProgressTask/CustomActorCultivation%s/Login", i), true)
      end
      local canReward = false
      if curCulPlan.progressReward < 100 then
        for i = curCulPlan.progressReward + 1, curCulPlan.progress do
          local xlsxConfig = PB.get("CustomActorCultivationProgressReward", i)
          if xlsxConfig then
            canReward = true
            break
          end
        end
        if not canReward and curCulPlan.vip then
          for i = curCulPlan.progressRewardVip + 1, curCulPlan.progress do
            local xlsxConfig = PB.get("CustomActorCultivationProgressReward", i)
            if xlsxConfig then
              canReward = true
              break
            end
          end
        end
      end
      RU.SetRedMark(string.format("ProgressTask/CustomActorCultivation%s/ProgressReward", i), canReward)
      this:Unbind("fci/customActorCultivationTasks", OnCustomActorCultivationTasks)
      this:Bind("fci/customActorCultivationTasks", OnCustomActorCultivationTasks)
    end
  end)
  this:Bind("fci/dungeon/chapter-summary/", function(summary)
    if summary == nil then
      return
    end
    WU.SetActive(REF.SpriteStoryHintControl, not S:Get("TutorialManager").IsTutorialDoing() and not table.has(summary.unlockedChapterId, 7))
  end)
  this:GameRequest("fci/surprise-event/"):Get(function(result)
    if result and result.surpriseEvent and result.surpriseEvent.eventUid ~= 0 then
      this:SetData("surpriseEventInfo", result)
    end
  end)
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.AsyncPvpNew) then
    this:SetData("PopupCoverJumpinAsyncPvpNew", not CheckPopOnce("CoverJumpAsyncPvpNew"))
  end
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    WU.IsOpenNewbieGiftPrompt(0)
    WU.IsOpenNewbieGiftPrompt(1)
  end)
  this:SetData("PopupCoverJumpinNewbieGift", not CheckPopOnce("CoverJumpNewbieGift"))
  this:Bind("fci/medal", function(medals)
    local misc = PB.index("Misc", 1)
    if misc.PringlesGifts == 0 then
      return
    end
    local pringlesMedalId = misc.PringlesMedalId
    if table.find(medals, function(_, v)
      return v.id == pringlesMedalId
    end) then
      local playerId = this:GetData("playerId")
      this:GameRequest(string.format("fci/PringlesGift/%s", playerId)):Get(function(res)
        this:SetData("fci/WlfPringlesGift", res)
        RU.SetRedMark("Welfare/PringlesGift/New", res.rewardTimes == 0)
      end)
    end
  end)
  this:GameRequest("fci/Maze/Hollow/34001/"):Get(function(data)
    this:SetData("fci/mazeHollow/", data.equipHollows)
  end)
end

function IsDayFirstSignIn(activePointType)
  local old = WU.GetGameDataCache("lastLoginTime" .. DB:GetData("playerId") .. "/" .. activePointType)
  local now = CS.GameTime.serverUtc
  return not CS.GameTime.IsSameDate(old, now)
end

function OnCustomActorCultivationTasks(taskList)
  if taskList == nil or #taskList == 0 then
    return
  end
  local data = this:GetData("fci/custom-actor-cultivation/")
  if data.culPlans == nil then
    return
  end
  local canRewardList = {}
  for i = 1, #data.culPlans do
    canRewardList[i] = false
  end
  for _, v in ipairs(taskList) do
    local acIndex, plan = table.find(data.culPlans, function(_, p)
      return p.activityId == v.actorCultivationActivityId
    end)
    if acIndex then
      canRewardList[acIndex] = (not v.actorCultivationVipOnly or v.actorCultivationVipOnly and plan.vip) and v.isDone and not v.rewardGot and not v.timeout
      if canRewardList[acIndex] then
        break
      end
    end
  end
  for acIndex, canReward in ipairs(canRewardList) do
    RU.SetRedMark(string.format("ProgressTask/CustomActorCultivation%s/TaskReward", acIndex), canReward and data.culPlans[acIndex].progress < 100)
  end
end

function CheckWlfActivePointRedMark()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Theme, function(acList)
    if acList == nil or table.count(acList) == 0 then
      return
    end
    this:BindRemote(DB:GameRequest("fci/task/extra-activepoint/"), function(result)
      if result == nil then
        return
      end
      local checklist = {
        [PB.enum.ActivePointType.Theme] = "fci/themeActivityTasks",
        [PB.enum.ActivePointType.HalfYear] = "fci/halfYearActivityTasks",
        [PB.enum.ActivePointType.NewYear] = "fci/newYearActivityTasks",
        [PB.enum.ActivePointType.LabourDay] = "fci/labourDayActivityTasks"
      }
      for activePointType, taskPath in pairs(checklist) do
        local _, a = _ENV["!"](acList):find(function(k, v)
          return v.activityId == activePointType
        end)
        if a ~= nil and ACU.IsOpenForDoing(a, true) then
          local redMarkKey = "Welfare/" .. PB.enum.ActivePointType.__keys[activePointType]
          RU.SetRedMark(redMarkKey .. "/FirstLogin", IsDayFirstSignIn(activePointType))
          local res = result.activePointInfos[activePointType]
          local hasGift = false
          local curActivePoint = res.extraActivePoint
          for i = 1, #res.progress do
            if curActivePoint >= res.progress[i].targetActivePoint and not res.progress[i].rewardGot then
              hasGift = true
              break
            end
          end
          RU.SetRedMark(redMarkKey .. "/ActivePoint", hasGift)
          this:Bind(taskPath, function(tasks)
            if tasks == nil then
              return
            end
            local canReward = TU.TaskCanReward(tasks)
            RU.SetRedMark(redMarkKey .. "/Task", canReward)
          end)
        end
      end
    end)
  end)
end

function RegisterWelfareChristmasRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Christmas, function(acList)
    if acList and acList[1] then
      local isOpen = false
      for i = 1, #acList do
        if ACU.IsOpenForDoing(acList[i], true) then
          isOpen = true
          break
        end
      end
      if isOpen then
        RU.SetRedMark("Welfare/Christmas/First", WU.IsFirstTimeInClient("Welfare2018Christmas"))
        local inviteConfigs = PB.all("ActivityInviteActorInfo"):where(function(k, v)
          return v.activityType == PB.enum.ActivityType.Christmas
        end):toarray()
        for i = 1, #inviteConfigs do
          local goodId = inviteConfigs[i].goodId
          local itemId = PB.get("ActivityShopGoods", goodId).res[1].id
          local item = this:GetData("fci/item/" .. itemId)
          if item and item.count ~= 0 then
            RU.SetRedMark("Welfare/Christmas/Invite/" .. goodId, true)
          end
        end
        REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_christmas"
        REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_christmas"
        REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
        this:SetData("PopupCoverJumpinChristmas", CheckCoverJumpinOpen("CoverJumpChristmas"))
        return
      end
    end
    this:SetData("PopupCoverJumpinChristmas", false)
  end, function()
    this:SetData("PopupCoverJumpinChristmas", false)
  end)
end

function RegisterWelfareChineseNewYearRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ChineseNewYear, function(acList)
    if acList and acList[1] then
      local isOpen = false
      local isAllOpen = true
      for i = 1, #acList do
        if ACU.IsOpenForDoing(acList[i]) then
          isOpen = true
        else
          isAllOpen = false
        end
      end
      if isAllOpen and WU.IsFirstTimeInClient("Welfare2019CNYHardDungeonUnlock") then
        RU.SetRedMark("Welfare/ChineseNewYear/Reward/HardUnlockFirst", true)
      end
      if isOpen then
        if WU.IsFirstTimeInClient("Welfare2019CNY") then
          RU.SetRedMark("Welfare/ChineseNewYear/First", true)
        end
        REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_newyear"
        REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_newyear"
        REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
        this:SetData("PopupCoverJumpinChineseNewYear", CheckCoverJumpinOpen("CoverJumpChineseNewYear"))
        return
      end
    end
    this:SetData("PopupCoverJumpinChineseNewYear", false)
  end, function()
    this:SetData("PopupCoverJumpinChineseNewYear", false)
  end)
end

function RegisterWelfareCookingRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Cooking, function(acList)
    if acList and acList[1] then
      local isOpen = false
      for i = 1, #acList do
        if ACU.IsOpenForDoing(acList[i]) then
          isOpen = true
          break
        end
      end
      if isOpen then
        if WU.IsFirstTimeInClient("Welfare2019CNYHotPotResearch") then
          RU.SetRedMark("Welfare/ChineseNewYear/HotPot/Research/First", true)
        end
        if WU.IsFirstTimeInClient("Welfare2019CNYHotPotCook") then
          RU.SetRedMark("Welfare/ChineseNewYear/HotPot/CookFirst", true)
        end
        if WU.IsFirstTimeInClient("Welfare2019CNYHotPotEat") then
          local _, item = PB.all("ItemInfo"):find(function(k, v)
            local flag = false
            if v.bindActivityType == PB.enum.ActivityType.Cooking and v.funcType == PB.enum.ItemFuncType.Food and v.param[1] ~= 3 and v.param[1] ~= 4 then
              local itemInfo = this:GetData("fci/item/" .. v.id)
              if itemInfo and itemInfo.count > 0 then
                flag = true
              end
            end
            return flag
          end)
          RU.SetRedMark("Welfare/ChineseNewYear/HotPot/EatFirst", item)
        end
      end
    end
  end)
end

function RegisterActivityStarRewardRed(activityType)
  m_activityManager.GetActivityByType(activityType, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        local acFuncBindedKey = string.format("%s_%s", activityType, activity.activityId)
        if ACU.IsOpenForDoing(activity, true) and activity.category == PB.enum.ActivityCategory.Dungeon and not m_activityFuncBinded[acFuncBindedKey] then
          this:BindRemote(this:GameRequest(string.format("fci/activity/record/%s/%s", activityType, activity.activityId)), function(result)
            if result then
              OnActivityDungeonRecord(activityType, activity.activityId, result.records)
            end
          end)
          this:Bind(string.format("fci/activity/star-reward/%s/%s", activityType, activity.activityId), function(result)
            if result then
              OnActivityDungeonStarReward(activityType, activity.activityId, result.rewardSummary)
            end
          end)
          m_activityFuncBinded[acFuncBindedKey] = true
        end
      end
    end
  end)
end

function OnActivityDungeonRecord(activityType, activityId, records)
  local isStarChanged = false
  local cntOldStarPath = string.format("Event/ActivityStarCount/%s/%s", activityType, activityId)
  local cntOldStar = this:GetData(cntOldStarPath) or 0
  local cntStar = 0
  for _, record in ipairs(records) do
    cntStar = cntStar + #record.targetsDone
  end
  this:SetData(cntOldStarPath, cntStar)
  local uri = string.format("fci/activity/star-reward/%s/%s", activityType, activityId)
  isStarChanged = cntStar ~= cntOldStar or this:GetData(uri) == nil
  if isStarChanged then
    DB:SyncRemote(this:GameRequest(uri))
  end
end

function OnActivityDungeonStarReward(activityType, activityId, rewardSummary)
  local isReward = DU.DoesEventActivityHasStarReward(rewardSummary, activityId)
  RU.SetRedMark(string.format("Welfare/%s/Reward/%s", PB.enum.ActivityType.__keys[activityType], activityId), isReward)
end

function RegisterHalloweenRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.JigsawPuzzle, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity, true) then
          local function func(res)
            local flag = ACU.HasHalloweenRedPoint(res)
            
            RU.SetRedMark("Welfare/Halloween", flag)
          end
          
          this:Unbind("fci/JigsawPuzzle/", func)
          this:BindRemote(DB:GameRequest("fci/JigsawPuzzle/"), func)
          return
        end
      end
    end
    RU.SetRedMark("Welfare/Halloween", false)
  end)
end

function RegisterPostcardRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Postcard, function(acList)
    if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) then
      local data = this:GetData("fci/Postcard")
      local flag = ACU.DosePostCardHasRedPoint(data)
      if acList[1].activityId == 26001 then
        RU.SetRedMark("Welfare/CoffeePostcard", flag)
      elseif acList[1].activityId == 26002 then
        RU.SetRedMark("Welfare/MikuPostcard", flag)
      else
        RU.SetRedMark("Welfare/Postcard", flag)
      end
      return
    end
  end)
end

function CreateCultivationPVPActivityTable(acInfos)
  table.sort(acInfos, function(a, b)
    return a.season < b.season
  end)
  local lastIndex = table.find(acInfos, function(k, v)
    return ACU.IsOpenForDoing(v)
  end) or -1
  local cultivationPVPDungeonIds = {}
  local dungeon2activity = {}
  for i = lastIndex - 3, lastIndex do
    if acInfos[i] then
      local config = PB.get("ChallengeModeDungeon", acInfos[i].activityId)
      if config then
        cultivationPVPDungeonIds[config.activityId] = config.dungeonId
      else
        warning("GamePlay", "cultivationPVP activity data is not aligned between server and client. activity id: " .. tostring(acInfos[i].activityId))
      end
    end
  end
  this:SetData("cultivationPVPDungeonIds", cultivationPVPDungeonIds)
  for activityId, dungeonIds in pairs(cultivationPVPDungeonIds) do
    for _, dungeonId in ipairs(dungeonIds) do
      dungeon2activity[dungeonId] = activityId
    end
  end
  this:SetData("dungeon2cultivationPVPActivityId", dungeon2activity)
end

function CheckNewSeasonOfCultivationPVP()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.CultivationPvP, function(acList)
    local currActivity, currentId
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) then
          currActivity = activity
        end
      end
    end
    if currActivity then
      currentId = currActivity.activityId
    end
    local preferences = m_configDataManager.GetPreferences()
    if preferences.cultivationpvp ~= nil then
      for _, v in pairs(preferences.cultivationpvp) do
        if v == currentId then
          return
        end
      end
    else
      preferences.cultivationpvp = {}
    end
    RU.SetRedMark("Welfare/CultivationPvP/New", true)
  end)
end

function OnEventDungeonStarReward(result)
  if result then
    for i = 1, #m_eventDungeonActivities do
      local hasReward = DU.DoesEventActivityHasStarReward(result.rewardSummary, m_eventDungeonActivities[i].activityId)
      if hasReward then
        RU.SetRedMark("Welfare/Autumn/Dungeon", hasReward)
      end
      RU.SetRedMark(string.format("Activity/%s/%s/Reward", m_eventDungeonActivities[i].type, m_eventDungeonActivities[i].activityId), hasReward)
    end
  end
end

function CheckCoverJumpinOpen(windowName)
  if WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) or CS.GameTime.IsSameDate(WU.GetGameDataCache("lastCoverJumpTime_" .. windowName .. "_" .. DB:GetData("playerId")), CS.GameTime.serverUtc) then
    return false
  end
  return true
end

function CheckPopupState(windowName, func)
  if WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) then
    return false
  else
    if func ~= nil then
      return not func(windowName)
    end
    return true
  end
end

function PopupJumpin(windowName, callback, welfareTab)
  WU.AcquireWindowAsync(windowName, function()
    if callback then
      callback(windowName)
    end
    if welfareTab then
      this:SetData("WelfareTab", welfareTab)
    end
  end)
end

function RecordPopupOnce(windowName)
  local winId = windowName .. DB:GetData("playerId")
  local preferences = m_configDataManager.GetPreferences()
  if preferences.PopupWindowRecord == nil then
    preferences.PopupWindowRecord = {}
  end
  table.insert(preferences.PopupWindowRecord, winId)
  m_configDataManager.SetPreferences(preferences)
end

function CheckPopOnce(windowName)
  local winId = windowName .. DB:GetData("playerId")
  local preferences = m_configDataManager.GetPreferences()
  if preferences.PopupWindowRecord ~= nil then
    for _, v in pairs(preferences.PopupWindowRecord) do
      if v == winId then
        return true
      end
    end
  else
    preferences.PopupWindowRecord = {}
  end
  return false
end

function PopupCoverJumpin(windowName)
  WU.AcquireWindowAsync(windowName, function(window)
    WU.SetGameDataCache("lastCoverJumpTime_" .. windowName .. "_" .. DB:GetData("playerId"), CS.GameTime.serverUtc)
  end)
end

function CheckTenCheckinOpen()
  if WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) then
    return false
  end
  return true
end

function PopupTenCheckin(call)
  this:SetData("WelfareTab", "TenCheckin")
  WU.AcquireWindowAsync("Welfare")
end

function PopupAnnouncementPre()
  if CheckPopupAnnouncement() then
    RequirePopupAnnouncement()
  else
    this:SetData("PopupAnnouncement", false)
    ShowGuestWarning()
  end
  this:SetData("City/CutBoardVoice", true)
end

function PopupAnnouncement()
  WU.AcquireWindowAsync("PopupAnnouncement", function(window)
    local noticeData = this:GetData("AnnouncementContent")
    _ENV["$"](window)["$$SetNoticeData"](noticeData)
    _ENV["$"](window)["$$ShowNotice"]()
    _ENV["$"](window)["$$SetOnClose"](function()
      ShowGuestWarning()
    end)
  end)
end

function OnPlayerLevelup(lvFrom, lvTo)
  this:SetData("fci/RacePVPSummary/", this:GetData("fci/RacePVPSummary/"))
end

function Focus(on)
  if on then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local RangeLeft, RangeRight
    DU.IsDungeonFinished(chapterInfo, 3, function(finished)
      RangeLeft = finished
    end)
    DU.IsDungeonFinished(chapterInfo, 10, function(finished)
      RangeRight = finished
    end)
    if RangeLeft and not RangeRight and not this:GetData("PurchasedNewbieGift") then
      if m_firstLoginEveryDay then
        m_firstLoginEveryDay = false
      else
        do
          local pCoverJumpinNewbieGift = this:GetData("PopupCoverJumpinNewbieGift")
          if pCoverJumpinNewbieGift then
            PopupJumpin("CoverJumpNewbieGift", RecordPopupOnce)
            this:SetData("PopupCoverJumpinNewbieGift", false)
          end
        end
      end
    end
  end
  REF.SpriteActorRoot.gameObject:SetActive(on)
  if on == false then
    REF.WidgetPlatform["$HideOtherMenu"]()
    REF.SpriteActor["$StopAnimation"]()
  else
    ManageGachaRedPoint()
  end
  WU.RecordWindowFocus(100101, on)
end

function UninitWindow()
  Msdk.MsdkEvent.Instance:RelationEvent("-", MsdkRelationCallback)
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
end

function UpdateActorCulticationPopupData()
  if not this:GetData("PopupActorCultivation") then
    local activatedList = this:GetData("ActorCultivation")
    local k, newActivity = table.find(activatedList, function(k, v)
      return v.new
    end)
    if newActivity then
      this:SetData("ActorCultivation/Popup", true)
      this:SetData("ActorCultivation/PopupActor", newActivity.actorId)
      this:SetData("ActorCultivation/PopupTab", k)
      this:SetData("ActorCultivaton/PopupActivity", newActivity.activityId)
      RU.SetRedMark("ProgressTask/ActorCultivation" .. k .. "/new", true)
    else
      this:SetData("ActorCultivation/Popup", false)
      this:SetData("ActorCultivation/PopupActor", nil)
    end
  end
end

function OnTopMostWindow(windowName)
  REF.SpriteActor.gameObject:SetActive(true)
  if windowName ~= this.name then
    DB:BroadcastGameEvent("LeaveCity")
    WU.SetActive(REF.GachaHint, false)
    REF.GachaHint.EffectGenerator.m_EffectName = ""
    REF.GachaHint.EffectGenerator:Reset()
  end
  if windowName == this.name then
    ModifyGachaEntrance(m_focusedGachaActivity ~= nil)
    m_TriggerLockTip = 0
    UpdateActivityLock()
    local clickData = this:GetData("fci/ui-grid/")
    UpdateActivityDot(clickData)
    REF["$UILuaWindow"]:PlayUITweener()
    local silent = WU.ContextWindow(WU.CurrentScene()) ~= nil
    local roleId
    local signBoardID = this:GetData("BoardActor/RoleId")
    local allEntity = PB.all("Signboard")
    for _, v in pairs(allEntity) do
      if v.signboardId == signBoardID then
        roleId = v.roleId
        break
      end
    end
    if roleId then
      REF.SpriteActor["$PlayRandomAnimation"](false, silent)
      this:BroadcastGameEvent("BoardActorEventVoice", "custom")
    end
    local topWindowName = WU.TopWindow().name
    local context = this:GetData("SceneContext/SceneCity")
    local isTutorialOn = S:Get("TutorialManager").IsTutorialDoing()
    local isFirstInit = this:GetData("InitForLogin")
    if not isTutorialOn and isFirstInit == false and topWindowName == "City" and (context == nil or context == "") then
      this:SetData("PopupActorCultivation", false)
      UpdateActorCulticationPopupData()
      local pCoverJumpinActorCultivation = this:GetData("ActorCultivation/Popup")
      local popupActor = this:GetData("ActorCultivation/PopupActor")
      if pCoverJumpinActorCultivation and popupActor and not this:GetData("PopupActorCultivation") then
        this:SetData("PopupActorCultivation", true)
        if m_ActorCultivaitonFlag then
          m_ActorCultivaitonFlag = false
          WU.AcquireWindowAsync("NormalPopupWindow", function(win)
            _ENV["$"](win)["$$SetView"]({
              texture = "Texture/Welfare/ActorCultivation_welfare_" .. popupActor .. "a",
              closeEffect = "UI_CirclePrompt_01",
              closeTarget = "WidgetProgressTask",
              onEffectArrive = function()
                this:BroadcastGameEvent("ShowView", popupActor)
              end
            }, OnActorCultivationPopup)
          end)
        end
      else
        do
          local baseInfo = this:GetData("fci/baseinfo")
          if baseInfo and baseInfo.level then
            if CheckRecordGachaVideoSetting(baseInfo.level) then
              Level10VideoOpenRemind()
            elseif CheckRecordFightVideoSetting(baseInfo.level) then
              Level17VideoOpenRemind()
            elseif CheckNotificationSetting(baseInfo.level) then
              Level20NotifyOpenRemind()
            elseif CheckSubscribeSetting(baseInfo.level) then
              Level35SubscribeOpenRemind()
            else
              ShowUnlockFunc()
            end
          end
        end
      end
    end
    local pvpReason = this:GetData("FightNetModeLeaveReason")
    if pvpReason ~= nil then
      this:SetData("FightNetModeLeaveReason", nil)
      if pvpReason == 1 or pvpReason == 9 then
        local dungeonType = this:GetData("FightDungeonType")
        if dungeonType == PB.enum.DungeonType.BurstLinkPvp then
          this:SetData("FightLeaveReasonHint", pvpReason)
          WU.SaveCitySceneContext("Activity, BurstLinkActorGroup")
        elseif dungeonType == PB.enum.DungeonType.TeamPve then
          WU.ShowHintText(WU.GetString("TeamLeaveReasonHint"))
        end
      end
    end
    if this:GetData("cityScene") then
      this:DelayInvokeInFrames(1, function()
        local bgmId = this:GetData("cityBGM")
        local id
        if bgmId ~= nil then
          id = bgmId
        else
          id = this:GetData("cityScene")
        end
        local xlsxConfig = PB.get("CollectionsScenes", id)
        if xlsxConfig then
          CS.SoundManager.Instance:PlayMusic(xlsxConfig.bgmRes)
        end
      end)
    end
  elseif windowName ~= "ChatRoom" and windowName ~= "Share" then
    REF.SpriteActor.gameObject:SetActive(false)
  end
end

function OnLoadingEnd()
  if WU.TutorialFight() then
    this:SetData("TutorialSign", 1)
    CS.UIBaseProcess.Instance:SetBlack(true)
  else
    this:SetData("TutorialSign", 0)
  end
end

function UpdateWindow(delta)
  if tutorial_fight == 1 then
    local switch = this:GetData("AccountSwitch")
    local CurrentTutorialStep = this:GetData("CurrentTutorial")
    if CurrentTutorialStep == 1 then
      local busy = CS.Restifizer.RestifizerManager.Instance:isNetworkBusy()
      if WU.FindWindow("Login") == nil and not busy then
        tutorial_fight = 0
        if switch and switch.CityFilmOP then
          CS.SoundManager.Instance:StopCurrentMusic()
          this:SetData("MovieStart", CS.GameTime.serverUtc)
          WU.PlayMovie("first", function(status)
            if status then
              CS.UIBaseProcess.Instance:FadeOut()
            else
              FirstCartoon()
            end
          end)
        else
          CS.UIBaseProcess.Instance:FadeOut()
          FirstCartoon()
        end
      end
    elseif CurrentTutorialStep == 99 then
      local busy = CS.Restifizer.RestifizerManager.Instance:isNetworkBusy()
      if WU.FindWindow("Login") == nil and not busy then
        tutorial_fight = 0
        WU.AcquireWindowAsync("SakuIntroduction", function()
          CS.UIBaseProcess.Instance:SetBlack(false)
        end)
      end
    end
  end
  if 2 <= m_TriggerLockTip then
    ShowStoryGuide()
  end
  if m_timeInited and CS.GameTime.serverNow > m_dailyRefreshTime then
    this:GetData("gameDataCache").lastBoardSpeechRefreshTime = m_dailyRefreshTime:ToString()
    BoardActorSpeechRefresh()
    m_dailyRefreshTime = m_dailyRefreshTime:AddDays(1)
  end
  TU.CheckTaskTime(m_categorizedTasks)
  m_timeElapased = m_timeElapased + delta
  if 5 <= m_timeElapased then
    m_timeElapased = 0
    CheckDeployMission()
  end
  if this:GetData("CollectionsScene/isRandomMode") then
    CheckCitySceneUpdate()
  end
  local isLogin = this:GetData("InitForLogin")
  local gameRequestComplete = true
  for k, v in pairs(this:GetData("PopupGameRequestComplete")) do
    if not v then
      gameRequestComplete = false
      break
    end
  end
  if isLogin == nil and gameRequestComplete then
    CheckPopWindow()
  end
  local lastRefreshTime = WU.GetGameDataCache("City/lastRefreshTime")
  if lastRefreshTime == nil then
    if CS.GameTime.UtcToLocal(CS.GameTime.serverUtc).Hour >= m_dailyRefreshHour then
      RefreshFunc()
    end
    lastRefreshTime = CS.GameTime.serverUtc
    WU.SetGameDataCache("City/lastRefreshTime", lastRefreshTime)
  end
  if not WU.IsToday(CS.GameTime.UtcToLocal(lastRefreshTime)) and CS.GameTime.UtcToLocal(CS.GameTime.serverUtc).Hour >= m_dailyRefreshHour then
    RefreshFunc()
    WU.SetGameDataCache("City/lastRefreshTime", CS.GameTime.serverUtc)
  end
end

function CheckPopWindow()
  local topWindowName = WU.TopWindow().name
  if topWindowName ~= "City" then
    return
  end
  local context = this:GetData("SceneContext/SceneCity")
  if context ~= nil and context ~= "" then
    return
  end
  if S:Get("TutorialManager").IsTutorialDoing() then
    this:SetData("InitForLogin", false)
    return
  end
  local pCoverJumpinHalfYearBack = this:GetData("PopupCoverJumpinHalfYearBack")
  if pCoverJumpinHalfYearBack then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJumpHalfYearBack")
    return
  elseif pCoverJumpinHalfYearBack == nil then
    return
  end
  local pCoverJumpinChineseNewYear = this:GetData("PopupCoverJumpinChineseNewYear")
  if pCoverJumpinChineseNewYear then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJumpChineseNewYear")
    return
  end
  local pCoverJumpinShareReward = this:GetData("PopupCoverJumpinShareReward")
  if pCoverJumpinShareReward then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJumpShareReward")
    return
  end
  local pCoverJumpinAsyncPvpNew = this:GetData("PopupCoverJumpinAsyncPvpNew")
  if pCoverJumpinAsyncPvpNew then
    this:SetData("InitForLogin", false)
    PopupJumpin("CoverJumpAsyncPvpNew", RecordPopupOnce)
    return
  end
  local pCoverJumpinMaidCafe = this:GetData("PopupCoverJumpinMaidCafe")
  if pCoverJumpinMaidCafe then
    this:SetData("InitForLogin", false)
    PopupJumpin("CoverJumpMaidCafe", RecordPopupOnce, "MaidCafe")
    return
  end
  local isTutorialOn = S:Get("TutorialManager").IsTutorialDoing()
  if not isTutorialOn then
    UpdateActorCulticationPopupData()
    local pCoverJumpinActorCultivation = this:GetData("ActorCultivation/Popup")
    local popupActor = this:GetData("ActorCultivation/PopupActor")
    if pCoverJumpinActorCultivation and popupActor then
      this:SetData("InitForLogin", false)
      this:SetData("PopupActorCultivation", true)
      m_ActorCultivaitonFlag = false
      WU.AcquireWindowAsync("NormalPopupWindow", function(win)
        _ENV["$"](win)["$$SetView"]({
          texture = "Texture/Welfare/ActorCultivation_welfare_" .. popupActor .. "a",
          closeEffect = "UI_CirclePrompt_01",
          closeTarget = "WidgetProgressTask",
          onEffectArrive = function()
            this:BroadcastGameEvent("ShowView", popupActor)
          end
        }, OnActorCultivationPopup)
      end)
      return
    end
  end
  local pCoverJumpinEveryDayCheckin = this:GetData("Popupeverydaysignin")
  if pCoverJumpinEveryDayCheckin then
    this:SetData("InitForLogin", false)
    this:SetData("WelfareTab", "EveryDayCheckin")
    WU.AcquireWindowAsync("Welfare")
    return
  end
  local pCoverJumpinChristmas = this:GetData("PopupCoverJumpinChristmas")
  if pCoverJumpinChristmas then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJumpChristmas")
    return
  end
  local CPvP = this:GetData("PopupCoverCultivationPvP")
  if CPvP then
    this:SetData("InitForLogin", false)
    PopupJumpin("CultivationPvPCover", RecordPopupOnce, "CultivationPvP")
    return
  end
  local pCoverJumpinCarnival91 = this:GetData("PopupCoverJumpinCarnival91")
  if pCoverJumpinCarnival91 then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJumpCarnival91")
    return
  end
  local pCoverJumpin = this:GetData("PopupCoverJumpin")
  if pCoverJumpin then
    this:SetData("InitForLogin", false)
    PopupCoverJumpin("CoverJump")
    return
  end
  local pTenCheckin = this:GetData("PopupTenCheckin")
  local pAnnouncement = this:GetData("PopupAnnouncement")
  if pCoverJumpin == nil or pTenCheckin == nil or pAnnouncement == nil then
    return
  end
  this:SetData("InitForLogin", false)
  if pTenCheckin then
    PopupTenCheckin(function()
      if pAnnouncement then
        PopupAnnouncement()
      end
    end)
    return
  end
  if pAnnouncement then
    PopupAnnouncement()
    return
  end
  local pNewPlayerSignIn = this:GetData("fci/NewPlayerSignIn/")
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) and pNewPlayerSignIn and pNewPlayerSignIn.rewardDays < pNewPlayerSignIn.signDays then
    this:SetData("InitForLogin", false)
    this:SetData("WelfareTab", "ViewNoviceGift")
    WU.AcquireWindowAsync("Welfare")
    return
  end
  if pCoverJumpin == false and pTenCheckin == false and pAnnouncement == false then
    local baseInfo = this:GetData("fci/baseinfo")
    if baseInfo and baseInfo.level then
      if CheckRecordGachaVideoSetting(baseInfo.level) then
        Level10VideoOpenRemind()
      elseif CheckRecordFightVideoSetting(baseInfo.level) then
        Level17VideoOpenRemind()
      elseif CheckNotificationSetting(baseInfo.level) then
        Level20NotifyOpenRemind()
      elseif CheckSubscribeSetting(baseInfo.level) then
        Level35SubscribeOpenRemind()
      end
    end
  end
end

function CheckDeployMission()
  if m_deoloyInfo ~= nil then
    local hasFinished = false
    for _, mission in pairs(m_deoloyInfo.missionInfo) do
      if mission.endTimestamp ~= 0 and mission.endTimestamp <= CS.GameTime.serverUtc then
        hasFinished = true
        break
      end
    end
    RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.DeployMission), hasFinished)
  end
end

function CheckCitySceneUpdate()
  local lastUpdateTime = WU.GetGameDataCache("citySceneLastUpdateTime")
  local succeed
  succeed, lastUpdateTime = CS.GameTime.TryParse(lastUpdateTime)
  if succeed and lastUpdateTime then
    local shouldCitySceneUpdate, updateTime = ShouldCitySceneUpdate(lastUpdateTime)
    if shouldCitySceneUpdate then
      SetRandomCityScene(updateTime)
      WU.SetGameDataCache("citySceneLastUpdateTime", updateTime:ToString())
    end
  else
    WU.SetGameDataCache("citySceneLastUpdateTime", CS.GameTime.serverNow:ToString())
  end
end

function ShouldCitySceneUpdate(lastUpdateTime)
  local nowTime = CS.GameTime.serverNow
  local misc = PB.all("Misc"):first()
  local todayStartTime = nowTime - nowTime.TimeOfDay
  local timeSpan0 = CS.System.TimeSpan(0)
  local timeToCheckYesterday = todayStartTime:AddDays(-1):AddHours(misc.citySceneUpdateTime2)
  local timeToCheckToday1 = todayStartTime:AddHours(misc.citySceneUpdateTime1)
  local timeToCheckToday2 = todayStartTime:AddHours(misc.citySceneUpdateTime2)
  if nowTime < timeToCheckToday1 then
    return timeSpan0 < timeToCheckYesterday - lastUpdateTime, timeToCheckYesterday
  end
  if nowTime < timeToCheckToday2 then
    return timeSpan0 < timeToCheckToday1 - lastUpdateTime, timeToCheckToday1
  end
  return timeSpan0 < timeToCheckToday2 - lastUpdateTime, timeToCheckToday2
end

function SetRandomCityScene(updateTime)
  if this:GetData("CollectionsScene/isRandomMode") then
    local unlockedScenes = PB.all("CollectionsScenes"):where(function(k, v)
      return U.IsTimeOpen(v.openTime) and (v.unlockType == PB.enum.CollectionsSceneUnlockType.Default or this:GetData("fci/item/" .. v.id).count > 0)
    end):toarray()
    local dayScenes = unlockedScenes:where(function(k, v)
      return v.isDayType
    end):toarray()
    local nightScenes = unlockedScenes:where(function(k, v)
      return not v.isDayType
    end):toarray()
    local noonTime = (CS.GameTime.serverNow - CS.GameTime.serverNow.TimeOfDay):AddHours(12)
    if updateTime < noonTime then
      if 0 < #dayScenes then
        local index = math.random(1, #dayScenes)
        this:SetData("cityScene", dayScenes[index].id)
      end
    elseif 0 < #nightScenes then
      local index = math.random(1, #nightScenes)
      this:SetData("cityScene", nightScenes[index].id)
    end
  end
end

function IsNoticeUnlock()
  local baseInfo = this:GetData("fci/baseinfo")
  if baseInfo and baseInfo.level then
    return baseInfo.level >= PB.all("Misc"):first().unlockNoticeSystemLevel
  end
  return false
end

function FirstCartoon()
  local startMovieTime = this:GetData("MovieStart")
  if startMovieTime then
    local endTime = CS.GameTime.serverUtc
    local lastTime = endTime - startMovieTime
    if lastTime < 20 then
      this:BroadcastGameEvent("TutorialTlog", "stopFirst")
    end
  end
  local m_chapterId = 1001
  local dungeonId = 2011
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  local tutorialManager = S:Get("TutorialManager")
  tutorialManager.TutorialDone(1)
  WU.RecycleWindow("Movie")
  this:SetData("CurrentTutorial", 99)
  CS.UIBaseProcess.Instance:SetBlack(true)
  WU.AcquireWindowAsync("SakuIntroduction", function()
    CS.UIBaseProcess.Instance:SetBlack(false)
  end)
end

function IsCultivationRewardGot(id, score, rewardGotList)
  if rewardGotList[tostring(id)] == nil then
    return false
  end
  local data = rewardGotList[tostring(id)].rewardGot
  return table.has(data, score)
end

function OnHeadClick()
  WU.RecordButtonClick(100137)
  this:BroadcastGameEvent("BoardActorEventVoice", "option")
  NU.GetCollectionsActor(function()
    this:GameRequest("fci/CollectionsEquip"):Get(function(resp)
      this:SetData("fci/CollectionsEquip", resp)
      WU.AcquireWindowAsync("Account")
    end)
  end)
end

function OnStoryClick()
  this:BroadcastGameEvent("BoardActorEventVoice", "story")
  WU.AcquireWindowAsync("ChapterNormal")
end

function OnActorClick()
  this:BroadcastGameEvent("BoardActorEventVoice", "custom")
  WU.AcquireWindowAsync("ActorList")
end

function OnButtonGacha()
  WU.AcquireWindowAsync("Gacha")
end

function OnButtonRelation()
  local data = {
    PB.enum.UnlockWindow.Friend,
    PB.enum.UnlockWindow.Guild
  }
  if not WU.WindowTableIsLocked(data, "Relation") then
    WU.AcquireWindowAsync("RelationPortal")
  end
end

function OnChallengeClick()
  if not WU.WindowTableIsLocked(UnlockActivityWindowData, "ChallengeMode") then
    this:BroadcastGameEvent("BoardActorEventVoice", "challenge")
    WU.AcquireWindowAsync("Activity")
  end
end

function OnButtonBulletin()
  WU.RecordButtonClick(100135)
  if not IsNoticeUnlock() then
    local unlockLevel = PB.all("Misc"):first().unlockNoticeSystemLevel
    WU.ShowHintText(WU.GetString("WindowUnlock_Hint", WU.GetString("UnlockType_Bulletin"), unlockLevel))
    m_TriggerLockTip = m_TriggerLockTip + 1
    return
  end
  RequestGridActivityRecord("Bulletin")
  local accountCache = this:GetData("accountCache")
  local worldId = this:GetData("worldId")
  this:GameRequest("fci/WebActivity"):Get(function(response)
    local activitiesString = "[]"
    if response.activities and #response.activities > 0 then
      activitiesString = "[" .. table.concat(response.activities, ",") .. "]"
    end
    local sns = "guest"
    local platform = accountCache.socialPlatform
    if platform then
      if platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
        sns = "wx"
      elseif platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
        sns = "qq"
      end
    end
    local pushSessionId = CS.SceneBaseImpl.CurrentScene:GetSessionId()
    local finalApi = string.format("/ingame?openId=%s&session=%s&activityId=%s&sns=%s&worldId=%s&source=city", accountCache.openId, pushSessionId, activitiesString, sns, worldId)
    CS.SceneBaseImpl.CurrentScene:OpenNotify(finalApi)
  end)
  if 0 < m_latestArticleId then
    local preferences = m_configDataManager.GetPreferences()
    preferences.lastReadId = m_latestArticleId
    m_configDataManager.SetPreferences(preferences)
    info("OnButtonBulletin save to ", m_configDataManager.GetPreferences().lastReadId)
  end
  RU.SetRedMark("Bulletin", false)
end

function OnButtonWelfare()
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare, PB.enum.UnlockWindow.Welfare) then
    RequestGridActivityRecord("Welfare")
    this:SetData("WelfareTab", "MaidCafe")
    WU.AcquireWindowAsync("Welfare")
  else
    m_TriggerLockTip = m_TriggerLockTip + 1
  end
end

function OnButtonShop()
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Shop, PB.enum.UnlockWindow.Shop) then
    RequestGridActivityRecord("Shop")
    WU.AcquireWindowAsync("Shop")
  else
    m_TriggerLockTip = m_TriggerLockTip + 1
  end
end

function OnButtonNotepad()
  WU.RecordButtonClick(100134)
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.RoleNotepad, PB.enum.UnlockWindow.RoleNotepad) then
    RequestGridActivityRecord("RoleNotepad")
    WU.AcquireWindowAsync("RoleNotepad")
  else
    m_TriggerLockTip = m_TriggerLockTip + 1
  end
end

function OnButtonBag()
  WU.AcquireWindowAsync("Bag")
end

function OnButtonTask()
  WU.RecordButtonClick(100133)
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Task, PB.enum.UnlockWindow.Task) then
    RequestGridActivityRecord("Task")
    WU.AcquireWindowAsync("Task")
  else
    m_TriggerLockTip = m_TriggerLockTip + 1
  end
end

function OnButtonPortal()
  WU.RecordButtonClick(100136)
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
    RequestGridActivityRecord("Portal")
    this:BroadcastGameEvent("BoardActorEventVoice", "special")
    WU.AcquireWindowAsync("Portal")
  else
    m_TriggerLockTip = m_TriggerLockTip + 1
  end
end

function OnGotoFromBrowser(args)
  local hide = args.hide
  if hide == "true" then
    this:BroadcastGameEvent("CloseBrowser")
  end
  local gotoId = args.gotoId
  local g = PB.get("Goto", gotoId)
  if g == nil then
    if m_task ~= nil then
      error("City", "Goto id " .. m_task.res.gotoId .. " doesn't exist")
    end
  else
    GotoUtil.Goto(g.windowName, g.params)
  end
end

function ManageActorRedPoint()
  local showActorRedPoint = false
  local result = this:GetData("fci/actor/")
  if result ~= nil then
    for i = 1, #result do
      local actor = result[i]
      if GroupUtil.IsShowRedMark(actor.uid) and AU.UpgradeStarEnable(actor) then
        showActorRedPoint = true
        break
      end
    end
  end
  REF.SpriteRedPointActor.gameObject:SetActive(showActorRedPoint)
end

function ManageGachaRedPoint()
  local redList = {}
  
  local function updateRed()
    REF.SpriteRedPointGacha.gameObject:SetActive(false)
    for k, v in pairs(redList) do
      if v == true then
        REF.SpriteRedPointGacha.gameObject:SetActive(v)
        break
      end
    end
  end
  
  local function normalRed(gachaInfo)
    if gachaInfo == nil then
      return
    end
    for i = 1, #gachaInfo do
      local info = gachaInfo[i]
      if info.id == 1 then
        local b = info.nextFreeGachaTime - CS.GameTime.serverUtc <= 0 and info.nextFreeGachaTime > 0
        redList[1] = b
        updateRed()
        break
      end
    end
  end
  
  this:Unbind("fci/gachainfo/", normalRed)
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), normalRed)
  
  local function plotEmoteRed(res)
    if res and res.isFirstPlotEmote then
      redList[2] = true
      updateRed()
    end
  end
  
  this:Unbind("fci/gacha-plot-emote/", plotEmoteRed)
  updateRed()
end

function ManageChapterRedPoint(chapterSummary)
  if chapterSummary and not m_chapterRedPointInited then
    m_chapterRedPointInited = true
    local unlockChapterList = chapterSummary.unlockedChapterId
    for i = 1, #unlockChapterList do
      if this:GetData("fci/dungeon/chapter/" .. unlockChapterList[i]) then
        local record = this:GetData("fci/dungeon/chapter/" .. unlockChapterList[i]).recordChapter
        local hasReward = DU.DoesChapterHasStarReward(record)
        if hasReward then
          local chapterInfo = PB.get("ChapterInfo", record.chapterId)
          if chapterInfo then
            local chapterType = chapterInfo.type
            if chapterType == PB.enum.ChapterType.Normal then
              RU.SetRedMark(string.format("ChapterReward/%s", record.chapterId), true)
            elseif chapterType == PB.enum.ChapterType.Story then
              local chapterId = DU.StoryChapterToNormal(record.chapterId)
              if chapterId then
                RU.SetRedMark(string.format("ChapterReward/%s", chapterId), true)
              end
            elseif chapterType == PB.enum.ChapterType.Challenge then
              RU.SetRedMark(string.format("Activity/%s/Reward/%s", PB.enum.ActivityType.ChallengeMode, record.chapterId), true)
            end
          end
        end
      else
        warning("Chapter Databinding", "fci/dungeon/chapter/" .. unlockChapterList[i] .. " is nil")
      end
    end
  end
end

function ManageActivityViewedRedPoint()
  local viewedData = this:GetData("activityViewed")
  local activityData = this:GetData("ActivityList")
  if viewedData == nil or activityData == nil then
    return
  end
  local activityMap = {}
  for i = 1, #activityData do
    activityMap[activityData[i].type] = activityMap[activityData[i].type] or {}
    table.insert(activityMap[activityData[i].type], activityData[i])
  end
  local activityTypes = _ENV["!"](PB.all("ActivitySort")[1].activityType):duplicate()
  local indexOfRacePvp = table.find(activityTypes, function(k, v)
    return v == PB.enum.ActivityType.RacePVP
  end)
  if ACU.IsActivityUnlocked(PB.enum.ActivityType.RacePVPActivity) and ACU.IsActivitiesOn(activityMap[PB.enum.ActivityType.RacePVPActivity]) then
    table.remove(activityTypes, indexOfRacePvp)
  end
  for _, type in ipairs(activityTypes) do
    if activityMap[type] then
      local showed = false
      if table.find(activityMap[type], function(k, v)
        return v.category == PB.enum.ActivityCategory.WeeklyActivity or v.category == PB.enum.ActivityCategory.Tournament
      end) then
        showed = true
      end
      local unlocked = showed and ACU.IsActivityUnlocked(type) and ACU.IsActivitiesOn(activityMap[type])
      if type == PB.enum.ActivityType.EventDungeon then
        local eventDungeonId = PB.all("EventDungeon"):toarray()[1].activityId
        local viewed = viewedData[type] and viewedData[type][eventDungeonId] and viewedData[type][eventDungeonId].redpointValue
        RU.SetRedMark(string.format("Activity/%s/%s/NotViewed", type, eventDungeonId), unlocked and not viewed)
      else
        local viewed = viewedData[type] and viewedData[type][1] and viewedData[type][1].redpointValue
        RU.SetRedMark(string.format("Activity/%s/NotViewed", type), unlocked and not viewed)
      end
    else
      warning("Activity", "cannot find activity by type: " .. tostring(type))
    end
  end
end

function MsdkRelationCallback(relationRet)
  if relationRet.flag == Msdk.eFlag.eFlag_Succ then
    if relationRet.type == 0 then
      local persons = relationRet.persons
      if persons ~= nil then
        local me = persons[0]
        local msdkBaseinfo = {}
        msdkBaseinfo.nickName = me.nickName
        msdkBaseinfo.gender = me.gender
        msdkBaseinfo.pictureSmall = me.pictureSmall
        msdkBaseinfo.pictureMiddle = me.pictureMiddle
        msdkBaseinfo.pictureLarge = me.pictureLarge
        this:SetData("Msdk/baseinfo/", msdkBaseinfo)
        local serverSocialPicture = this:GetData("socialPicture")
        if serverSocialPicture ~= me.pictureSmall then
          local sex = PB.enum.PlayerSex.Man
          if me.gender == "\229\165\179" then
            sex = PB.enum.PlayerSex.Woman
          end
          this:GameRequest("fci/socialpicture/"):Patch({
            socialPicture = me.pictureSmall,
            sex = sex
          }, function(result)
            local baseinfo = this:GetData("fci/baseinfo/")
            baseinfo.sex = result.sex
            baseinfo.socialPicture = result.socialPicture
            this:SetData("fci/baseinfo/", baseinfo)
          end)
        end
      end
    elseif relationRet.type == 1 then
      local persons = {}
      for i = 0, relationRet.persons.Count - 1 do
        local person = relationRet.persons[i]
        table.insert(persons, {
          nickName = person.nickName,
          openId = person.openId,
          gender = person.gender,
          pictureSmall = person.pictureSmall,
          pictureMiddle = person.pictureMiddle,
          pictureLarge = person.pictureLarge,
          province = person.province,
          city = person.city,
          gpsCity = person.gpsCity,
          distance = person.distance,
          isFriend = person.isFriend,
          timestamp = person.timestamp,
          lang = person.lang,
          country = person.country
        })
      end
      m_cachedQueryInfo = m_cachedQueryInfo or {}
      m_cachedQueryInfo[tostring(m_myOpenId)] = m_cachedQueryInfo[tostring(m_myOpenId)] or {}
      m_cachedQueryInfo[tostring(m_myOpenId)][tostring(m_platform)] = {
        persons = persons,
        cacheTime = CS.GameTime.serverUtc
      }
      HandlerMsdkPersons(persons, true)
      WU.SetGameDataCache("MSDKQueryInfo", m_cachedQueryInfo)
    end
  else
    warning("MSDK", "MsdkRelationRet error, platform " .. m_platform .. [[

desc:]] .. relationRet.desc)
  end
end

function HandlerMsdkPersons(persons, forceSync)
  if not forceSync and this:GetData("fci/socialfriend/") then
    return
  end
  local msdkfriends = {}
  local openIdList = {}
  for i = 1, #persons do
    table.insert(openIdList, persons[i].openId)
    table.insert(msdkfriends, persons[i])
  end
  info("MSDK", table.dump(msdkfriends))
  local postTable = {socialOpenIdList = openIdList}
  local wireFormatTable = ProtobufT("ApiRelationSocialFriendList", postTable)
  this:GameRequest("fci/socialfriend/"):Post(wireFormatTable, function(result)
    local socialfriend = {}
    for i = 1, #result.players do
      local playerId = result.players[i].playerInfo.playerId
      if U.trim(playerId) ~= "" and playerId ~= this:GetData("playerId") then
        local _, val = table.find(msdkfriends, function(k, v)
          return result.players[i].socialOpenId == v.openId
        end)
        local data = {
          playerInfo = result.players[i].playerInfo,
          msdkInfo = val
        }
        table.insert(socialfriend, data)
      end
    end
    this:SetData("fci/socialfriend/", socialfriend)
  end)
end

function CheckPopupAnnouncement()
  local switch = this:GetData("AccountSwitch")
  if switch and switch.bulletinSwitch == false then
    return false
  end
  local hasShowAd = DB:GetData("hasShowAd")
  if hasShowAd then
    return false
  end
  local isDisableByUser = false
  local disablePopupAnnouncement = m_configDataManager.GetPreferences().disablePopupAnnouncement
  if disablePopupAnnouncement and disablePopupAnnouncement.isDisable then
    local disableDate = CS.GameTime.UtcToLocal(disablePopupAnnouncement.time)
    info("PopupAnnouncement", "Disable time " .. disableDate:ToString("HH:mm yyyy/MM/dd"))
    local today = CS.GameTime.serverNow.Date
    info("PopupAnnouncement", "serverNow time " .. today:ToString("HH:mm yyyy/MM/dd"))
    if WU.IsToday(disableDate) then
      info("PopupAnnouncement", "Disable popupannouncement by user.")
      isDisableByUser = true
    end
  end
  if isDisableByUser then
    return false
  end
  return IsNoticeUnlock() and not WU.TutorialFight()
end

function RequirePopupAnnouncement()
  CS.SceneCity.Instance:FetchNotifyData(OnEventPopupAnnounceSuccess, OnEventPopupAnnounceFailed)
end

function OnEventPopupAnnounceSuccess(result)
  if result == nil then
    warning("PopupAnnouncement", "success but return empty content")
    OnEventPopupAnnounceFailed()
    return
  end
  local packed = JsonD(result)
  if not packed then
    warning("PopupAnnouncement", "success but pack content failed.")
    OnEventPopupAnnounceFailed()
    return
  end
  local noticeData = packed[1]
  if not noticeData then
    warning("PopupAnnouncement", "The Ad data in backend was not configured, will not be appeared")
    OnEventPopupAnnounceFailed()
    return
  end
  local currentTime = CS.GameTime.serverUtc
  if currentTime > noticeData.beginDatetime and currentTime < noticeData.endDatetime then
    local disablePopupAnnouncement = m_configDataManager.GetPreferences().disablePopupAnnouncement
    if disablePopupAnnouncement and disablePopupAnnouncement.isDisable and disablePopupAnnouncement.id == noticeData.id then
      local disableDate = CS.GameTime.UtcToLocal(disablePopupAnnouncement.time)
      if WU.IsToday(disableDate) then
        info("PopupAnnouncement", "Disable popupannouncement by user.")
        OnEventPopupAnnounceFailed()
        return
      end
    end
    local topWindowName = WU.TopWindow().name
    local context = this:GetData("SceneContext/SceneCity")
    this:SetData("PopupAnnouncement", true)
    this:SetData("AnnouncementContent", noticeData)
  else
    OnEventPopupAnnounceFailed()
    info("PopupAnnouncement will not show due to time", currentTime)
  end
end

function OnEventPopupAnnounceFailed()
  this:SetData("PopupAnnouncement", false)
  info("PopupAnnouncement", "OnPopupAnnounceFailed Ad will not be appeared ")
  ShowGuestWarning()
end

function OnEventFetchLatestArticle(result)
  if not result then
    info("PopupAnnouncement", "lastarticleid return successful but result content can't be read")
    return
  end
  local lastId = m_configDataManager.GetPreferences().lastReadId
  m_latestArticleId = tonumber(result)
  if lastId then
    RU.SetRedMark("Bulletin", m_latestArticleId > tonumber(lastId))
  else
    RU.SetRedMark("Bulletin", true)
  end
end

function OnEventFetchLatestArticleFailed()
  info("PopupAnnouncement", "OnFetchLatestArticleFailed, RedMark in NoticeButton will not show")
end

function InitRefreshTime()
  local Misc = PB.all("Misc"):first()
  local timeSetting = CS.System.TimeSpan.Parse(Misc.dailyRefreshTime)
  local now = CS.GameTime.serverNow
  m_dailyRefreshTime = (now - now.TimeOfDay):Add(timeSetting)
  local cache = this:GetData("gameDataCache")
  if cache.lastBoardSpeechRefreshTime == nil or not CS.GameTime.TryParse(cache.lastBoardSpeechRefreshTime) then
    cache.lastBoardSpeechRefreshTime = m_dailyRefreshTime:AddDays(fif(CS.GameTime.serverNow > m_dailyRefreshTime, 0, -1)):ToString()
    this:SetData("gameDataCache", cache)
    BoardActorSpeechRefresh()
  end
  local success, lastBoardSpeechRefreshTime = CS.GameTime.TryParse(cache.lastBoardSpeechRefreshTime)
  if success then
    local dt = now - lastBoardSpeechRefreshTime
    if now > m_dailyRefreshTime and lastBoardSpeechRefreshTime < m_dailyRefreshTime then
      cache.lastBoardSpeechRefreshTime = m_dailyRefreshTime:ToString()
      this:SetData("gameDataCache", cache)
      BoardActorSpeechRefresh()
    elseif now < m_dailyRefreshTime and dt.Hours >= 24 then
      cache.lastBoardSpeechRefreshTime = m_dailyRefreshTime:AddDays(-1):ToString()
      this:SetData("gameDataCache", cache)
      BoardActorSpeechRefresh()
    end
  end
  if now > m_dailyRefreshTime then
    m_dailyRefreshTime = m_dailyRefreshTime:AddDays(1)
  end
  CheckBoardActorSpeechCache()
  m_timeInited = true
end

function BoardActorSpeechRefresh()
  local conditions = PB.all("BoardSpeechCondition")
  local cache = this:GetData("gameDataCache")
  cache.boardActorSpeechTimes = cache.boardActorSpeechTimes or {}
  for i = 1, #conditions do
    local condition = conditions[i]
    cache.boardActorSpeechTimes[condition.id] = 0
  end
  this:SetData("gameDataCache", cache)
end

function CheckBoardActorSpeechCache()
  local conditions = PB.all("BoardSpeechCondition")
  local cache = this:GetData("gameDataCache")
  local dirty = false
  for i = 1, #conditions do
    local condition = conditions[i]
    if cache.boardActorSpeechTimes[condition.id] == nil then
      dirty = true
      cache.boardActorSpeechTimes[condition.id] = 0
    end
  end
  if dirty then
    this:SetData("gameDataCache", cache)
  end
end

function ShowGuestWarning()
  DB:SetData("hasTestedAnnouncement", true)
  local hasShow = this:GetData("hasShowGuestWarning")
  if hasShow then
    return
  end
  local accountCache = this:GetData("accountCache")
  local isGuest = accountCache.entryType == "guest"
  if isGuest then
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("GuestPrompt"))
      _ENV["$"](ui)["$$SetTitle"](WU.GetString("WindowLogin_Warning"))
      _ENV["$"](ui)["$$SetCloseCallBack"](function()
        WU.RecycleWindow(ui)
      end)
    end)
    this:SetData("hasShowGuestWarning", true)
  else
  end
end

function CheckSubscribeSetting(level)
  if level < 35 then
    return false
  end
  if not PU.IsPlatformOfQQ and not PU.IsPlatformOfWX then
    return false
  end
  local preferences = m_configDataManager.GetPreferences()
  if preferences.SubscribeOpenRemind ~= false then
    return false
  end
  return true
end

function Level35SubscribeOpenRemind()
  local preferences = m_configDataManager.GetPreferences()
  this:DelayInvokeEndOfFrame(function()
    WU.ShowMessageYesNo(WU.GetString("NotepadMessage_CanSubscribe"), function(result)
      preferences.SubscribeOpenRemind = true
      m_configDataManager.SetPreferences(preferences)
      if result == "YES" then
        WU.AcquireWindowAsync("Account", function(window)
          _ENV["$"](window)["$$SetNotifySettings"]()
        end)
      end
    end, WU.GetString("NotepadMessage_SettingYes"), WU.GetString("NotepadMessage_SettingNo"))
  end)
end

function CheckNotificationSetting(level)
  if level < 20 then
    return false
  end
  local preferences = m_configDataManager.GetPreferences()
  if preferences.NotifyOpenRemind ~= false then
    return false
  end
  local hasSetBefore = preferences.energyFull or preferences.dispatchBack or preferences.drawEnergy
  if hasSetBefore then
    preferences.NotifyOpenRemind = true
    m_configDataManager.SetPreferences(preferences)
    return false
  end
  return true
end

function Level20NotifyOpenRemind()
  local preferences = m_configDataManager.GetPreferences()
  this:DelayInvokeEndOfFrame(function()
    WU.ShowMessageYesNo(WU.GetString("NotepadMessage_Setting"), function(result)
      preferences.NotifyOpenRemind = true
      m_configDataManager.SetPreferences(preferences)
      if result == "YES" then
        WU.AcquireWindowAsync("Account", function(window)
          _ENV["$"](window)["$$SetNotifySettings"]()
        end)
      end
    end, WU.GetString("NotepadMessage_SettingYes"), WU.GetString("NotepadMessage_SettingNo"))
  end)
end

function CheckRecordGachaVideoSetting(level)
  if level < 10 then
    return false
  end
  if not PU.IsRecordVideoSwitchOn() then
    return false
  end
  local preferences = m_configDataManager.GetPreferences()
  if preferences.VideoGachaOpenRemind ~= false then
    return false
  end
  local hasSetBefore = PU.IsRecordGachaEnabled()
  if hasSetBefore then
    preferences.VideoGachaOpenRemind = true
    m_configDataManager.SetPreferences(preferences)
    return false
  end
  return true
end

function Level10VideoOpenRemind()
  local preferences = m_configDataManager.GetPreferences()
  this:DelayInvokeEndOfFrame(function()
    WU.ShowMessageYesNo(WU.GetString("Remind_CanGoToGachaVideo"), function(result)
      preferences.VideoGachaOpenRemind = true
      m_configDataManager.SetPreferences(preferences)
      if result == "YES" then
        WU.AcquireWindowAsync("Account", function(window)
          _ENV["$"](window)["$$SetVideoSettings"]()
        end)
      end
    end, WU.GetString("NotepadMessage_SettingYes"), WU.GetString("NotepadMessage_SettingNo"))
  end)
end

function CheckRecordFightVideoSetting(level)
  if level < 17 then
    return false
  end
  if not PU.IsRecordVideoSwitchOn() then
    return false
  end
  local preferences = m_configDataManager.GetPreferences()
  if preferences.VideoOpenRemind ~= false then
    return false
  end
  local hasSetBefore = PU.IsRecordVideoEnabled()
  if hasSetBefore then
    preferences.VideoOpenRemind = true
    m_configDataManager.SetPreferences(preferences)
    return false
  end
  return true
end

function Level17VideoOpenRemind()
  local preferences = m_configDataManager.GetPreferences()
  this:DelayInvokeEndOfFrame(function()
    WU.ShowMessageYesNo(WU.GetString("NotepadMessage_CanGoToVideo"), function(result)
      preferences.VideoOpenRemind = true
      m_configDataManager.SetPreferences(preferences)
      if result == "YES" then
        WU.AcquireWindowAsync("Account", function(window)
          _ENV["$"](window)["$$SetVideoSettings"]()
        end)
      end
    end, WU.GetString("NotepadMessage_SettingYes"), WU.GetString("NotepadMessage_SettingNo"))
  end)
end

function OnCartoonConfig(chapterSummary)
  local unlockedChapterId = chapterSummary.unlockedChapterId or {}
  local cartoonConfigs = PB.all("CartoonConfig")
  local unlockedInfo = {}
  for _, cartoonConfig in pairs(cartoonConfigs) do
    unlockedInfo[cartoonConfig.id] = false
    local isUnlocked, chapterId = table.find(unlockedChapterId, function(_, chapterId)
      return chapterId == cartoonConfig.chapterId
    end)
    if isUnlocked then
      local chapterInfo = this:GetData("fci/dungeon/chapter/" .. chapterId)
      if chapterInfo and chapterInfo.recordDungeons then
        for _, dungeon in pairs(chapterInfo.recordDungeons) do
          if dungeon.unlocked and dungeon.dungeonId == cartoonConfig.dungeonId then
            unlockedInfo[cartoonConfig.id] = true
          end
        end
      end
    end
  end
  this:SetData("CartoonConfig/UnlockedInfo", unlockedInfo)
end

function CheckKingCardStatus()
  local result = false
  local reachability = CS.UnityEngine.Application.internetReachability
  if reachability == CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
    CS.NativeInterface.External_CheckKingCardStatus()
    result = true
  end
  return result
end

function OnNetworkChangedDetail(internetReachableDetail)
  this:DelayInvokeInSeconds(0.5, function()
    local topWindowName = WU.TopWindow().name
    if topWindowName ~= "City" or CheckKingCardStatus() then
    else
      OnGetKingCardStatus(false)
    end
  end)
end

function OnGetKingCardStatus(isKingCard)
  WU.SetActive(REF.SpriteKingCardFreeTraffic, isKingCard)
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  if type == PB.enum.ActivityType.EventDungeon_Autumn2018 and status == PB.enum.ActivityStatus.Started then
    REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_autumn"
    REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_autumn"
    REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
  elseif type == PB.enum.ActivityType.EventDungeon_Autumn2018 and status == PB.enum.ActivityStatus.Close then
    REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift"
    REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift"
    REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift"
  elseif type == PB.enum.ActivityType.JigsawPuzzle then
    RegisterHalloweenRed()
  elseif type == PB.enum.ActivityType.Postcard then
    RegisterPostcardRed()
  elseif type == PB.enum.ActivityType.Carnival91 then
    RegisterActivityStarRewardRed(PB.enum.ActivityType.Carnival91)
  elseif type == PB.enum.ActivityType.Christmas then
    RegisterWelfareChristmasRed()
    RegisterActivityStarRewardRed(PB.enum.ActivityType.Christmas)
  elseif type == PB.enum.ActivityType.ChineseNewYear then
    RegisterWelfareChineseNewYearRed()
    RegisterActivityStarRewardRed(PB.enum.ActivityType.ChineseNewYear)
  elseif type == PB.enum.ActivityType.MaidCafe then
    RegisterWelfareMaidCafeRed()
    RegisterActivityStarRewardRed(PB.enum.activityType.MaidCafe_DaemonMode)
  elseif type == PB.enum.ActivityType.Cooking then
    RegisterWelfareCookingRed()
  elseif type == PB.enum.ActivityType.Shop then
    DB:SyncRemote(DB:GameRequest("fci/Shop"))
  elseif type == PB.enum.ActivityType.EveryDayCheckin and status == PB.enum.ActivityStatus.Started then
    RU.SetRedMark("Welfare/EveryDayCheckin", true)
  elseif type == PB.enum.ActivityType.Lottery then
    RU.SetRedMark("Welfare/Lottery", status == PB.enum.ActivityStatus.Started)
  elseif type == PB.enum.ActivityType.EveryDayCheckin and status == PB.enum.ActivityStatus.Close then
    RU.SetRedMark("Welfare/EveryDayCheckin", false)
  elseif type == PB.enum.ActivityType.NotPlayerBack and status == PB.enum.ActivityStatus.Started then
    RefreshNotPlayerBack(m_redPointData)
  elseif type == PB.enum.ActivityType.NotPlayerBack and status == PB.enum.ActivityStatus.Close then
    this:SetData("halfYearNotBackFlag", false)
  end
end

function OnActorCultivationPopup()
  local activityId = this:GetData("ActorCultivaton/PopupActivity")
  local allActivated = this:GetData("ActorCultivation")
  if activityId then
    this:GameRequest("fci/actor-cultivation/" .. activityId .. "/new/"):Patch(nil, function(result)
      for _, v in pairs(allActivated) do
        if v.activityId == activityId then
          v.new = false
          break
        end
      end
      this:SetData("ActorCultivation", allActivated)
    end)
  end
  m_ActorCultivaitonFlag = true
end

function SetEveryDaySigninRedMark(signinRes, v)
  local nowTime = CS.GameTime.serverUtc - v.timestampStart
  local allTime = v.timestampEnd - v.timestampStart
  local timeSpanNow = CS.System.TimeSpan(0, 0, nowTime)
  local timeSpanAll = CS.System.TimeSpan(0, 0, allTime)
  local nowDay = timeSpanNow.Days + 1
  signinRes.day = CS.GameTime.serverNow.Day
  signinRes.allDayCount = timeSpanAll.Days + 1
  signinRes.nowDay = timeSpanNow.Days + 1
  if table.has(signinRes.signinedDays, nowDay) then
    RU.SetRedMark("Welfare/EveryDayCheckin", false)
  else
    RU.SetRedMark("Welfare/EveryDayCheckin", true)
  end
  return signinRes
end

function RefreshFunc()
  print("GamePlay", "Refresh in City")
  ReqQuestionActivity()
  this:BroadcastGameEvent("Welfare/PostcardRefresh")
end

function ShowStoryGuide()
  m_TriggerLockTip = 0
  local isFinished = false
  DU.IsDungeonFinished(this:GetData("fci/dungeon/chapter-summary"), 18, function(finished)
    isFinished = finished
  end)
  if not isFinished then
    WU.AcquireWindowAsync("SakuGuide", function(win)
      _ENV["$"](win)["$$SetContent"](WU.GetString("Tutorial_Story"), WU.GetString("Tutorial_Story_Enter"), WU.GetString("Tutorial_Story_Back"), enterStoryTutorial, exitStoryTutorial)
    end)
  end
end

function UpdateActivityLock()
  for i = 0, PB.enum.ActivityGridType.All - 1 do
    local name = PB.enum.ActivityGridType.__keys[i]
    if name == "Portal" then
      name = "Journey"
    end
    local ref = REF.ActivityGrid[i]
    if name == "Bulletin" then
      WU.SetActive(ref.SpriteLock, not IsNoticeUnlock())
    else
      for _, type in pairs(PB.enum.UnlockWindow) do
        if PB.enum.UnlockWindow.__keys[type] == name then
          WU.SetActive(ref.SpriteLock, WU.WindowIsLocked(type))
          break
        end
      end
    end
  end
end

function UpdateActivityDot(data)
  if data == nil then
    return
  end
  local isFinished
  DU.IsDungeonFinished(this:GetData("fci/dungeon/chapter-summary"), 18, function(finished)
    isFinished = finished
  end)
  if isFinished then
    for i = 0, #REF.ActivityGrid - 1 do
      local r = REF.ActivityGrid[i]
      WU.SetActive(r.SpriteDot, false)
    end
    return
  end
  local unlockGrid = data.unlockGrid
  for i = 0, PB.enum.ActivityGridType.All - 1 do
    local ref = REF.ActivityGrid[i]
    local name = ref.root.name
    local nameR = name
    if name == "Portal" then
      nameR = "Journey"
    end
    local locked = true
    if name == "Bulletin" then
      locked = not IsNoticeUnlock()
    else
      for _, type in pairs(PB.enum.UnlockWindow) do
        if PB.enum.UnlockWindow.__keys[type] == nameR then
          locked = WU.WindowIsLocked(type)
          break
        end
      end
    end
    if ref then
      do
        local hasredMark = ref["Sprite" .. name .. "RedMark"].gameObject.activeSelf
        WU.SetActive(ref.SpriteDot, not hasredMark and not _ENV["!"](unlockGrid):has(i) and not locked)
        this:DelayInvokeInSeconds(1.1, function()
          WU.SetActive(ref.EffectNewUnlock, not _ENV["!"](unlockGrid):has(i) and not locked)
        end)
      end
    end
  end
end

function RequestGridActivityRecord(name)
  for _, type in pairs(PB.enum.ActivityGridType) do
    if name == PB.enum.ActivityGridType.__keys[type] then
      local UnlockClickData = this:GetData("fci/ui-grid/")
      if UnlockClickData then
        local UnlockGrid = UnlockClickData.unlockGrid
        if UnlockGrid and not _ENV["!"](UnlockGrid):has(type) then
          DB:GameRequest("fci/ui-grid/"):Post({gridType = type}, function()
            table.insert(UnlockClickData.unlockGrid, type)
            this:SetData("fci/ui-grid/", UnlockClickData)
          end)
        end
      end
      break
    end
  end
end

function RefreshNotPlayerBack(redpointData)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.NotPlayerBack, function(acList)
    if acList and acList[1] and ACU.IsOpenForDoing(acList[1], true) and not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) and not redpointData.activeHalfYearBack then
      local activityId = acList[1].activityId
      this:SetData("halfYearNotBackFlag", true)
      DB:GameRequest("fci/half-year-not-back-activity"):Get(function(res)
        if res then
          this:SetData("fci/half-year-not-back-activity", res)
        end
      end)
    end
  end)
end

function OnCoupleRedPoint(count)
  if count == nil then
    return
  end
  local couple = this:GetData("fci/couple")
  if couple ~= nil then
    local showRedPoint = WU.GetGameDataCache("Welfare/CoupleActorCultivation")
    for i = 1, #couple.coupleRewardInfo do
      local data = couple.coupleRewardInfo[i]
      if not data.got and count >= data.coupleScore then
        showRedPoint = true
      end
    end
    RU.SetRedMark("Welfare/CoupleActorCultivation", showRedPoint)
  else
    this:GameRequest("fci/couple/"):Get(function(resp)
      this:SetData("fci/couple/", resp)
      local resCoupleScore = math.max(resp.totalCoupleScore, count)
      this:SetData("fci/resource/ResCoupleScore_0/", resCoupleScore)
    end)
  end
end

function GetMaidCafeRnkInfo(data)
  if data == nil then
    return
  end
  this:SetData("MaidCafe/RankMode/Reward", data.rankModeRewardInfo)
  this:SetData("MaidCafe/RankMode/GroupInfo", data.rankModeGroupInfo)
  this:SetData("MaidCafe/RankMode/Info", data.rankModeInfo)
end

function RegisterWelfareMaidCafeRed()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe, function(acList)
    if acList and acList[1] then
      local isOpen = false
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) then
          isOpen = true
        end
        if isOpen then
          if WU.IsFirstTimeInClient("WelfareMaidCafe") then
            RU.SetRedMark("Welfare/MaidCafe/First", true)
          end
          REF.ButtonWelfare.UISprite.spriteName = "activity/activity_gift_coffee"
          REF.ButtonWelfare.UIButton.normalSprite = "activity/activity_gift_coffee"
          REF.ButtonWelfare_txt.UISprite.spriteName = "activity/activity_txt_gift_autumn"
          this:SetData("PopupCoverJumpinMaidCafe", CheckPopupState("CoverJumpMaidCafe", CheckPopOnce))
          return
        end
      end
    end
    this:SetData("PopupCoverJumpinMaidCafe", false)
  end, function()
    this:SetData("PopupCoverJumpinMaidCafe", false)
  end)
end

function OnMaidCafePassReward(rewardInfo)
  if rewardInfo == nil then
    return
  end
  local canReward = false
  local allrewards = rewardInfo.passRewardInfo
  local currentCount = rewardInfo.currentPassCount
  for _, v in pairs(allrewards) do
    if not v.got and currentCount >= v.passCount then
      canReward = true
      break
    end
  end
  RU.SetRedMark("Welfare/MaidCafe/PassCountReward", canReward)
end

function ModifyGachaEntrance(modify)
  if S:Get("TutorialManager").IsTutorialDoing() then
    return
  end
  local modifyInfo
  if m_focusedGachaActivity then
    modifyInfo = PB.get("GachaEntranceModification", m_focusedGachaActivity.activityId, m_focusedGachaActivity.type)
  end
  if modify and modifyInfo then
    WU.SetActive(REF.GachaHint, modifyInfo.showHint)
    WU.SetActive(_ENV["$"](REF.RIGHT).SpriteCenter, not modifyInfo.showHint)
    if modifyInfo.showHint then
      REF.GachaHint.EffectGenerator.m_EffectName = modifyInfo.effectName
      this:DelayInvokeInSeconds(0.6, function()
        REF.GachaHint.EffectGenerator:Reset()
        REF.GachaHint.EffectGenerator:Play()
      end)
    end
    if modifyInfo.replaceTexture then
      REF.ButtonGacha.UITexture.mainTexturePath = "Texture/Loby/" .. modifyInfo.texturePath
    end
  else
    WU.SetActive(REF.GachaHint, false)
    WU.SetActive(_ENV["$"](REF.RIGHT).SpriteCenter, true)
    REF.ButtonGacha.UITexture.mainTexturePath = "Texture/Loby/egg_mode"
  end
end

function OnHideUI()
  if m_contentShowing then
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
    this:BroadcastGameEvent("HideContent", true)
    REF.ContentPanel.UIPlayTween:ResetToBeginning()
    REF.ContentPanel.UIPlayTween:Play(true)
    _ENV["$"](REF.ShowContent).label.UILabel.text = "Show"
  end
end

function OnShowContent()
  if not m_contentShowing then
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
    this:BroadcastGameEvent("HideContent", false)
    REF.ContentPanel.UIPlayTween:ResetToBeginning()
    REF.WindowSize.UIPlayTween:ResetToBeginning()
    REF.WindowSize.UIPlayTween:Play(true)
    ModifyGachaEntrance(true)
    WU.SetActive(REF.SharePanel, false)
    _ENV["$"](REF.ShowContent).label.UILabel.text = "Hide"
  end
end

function OnClickMusic()
  CS.SoundManager.Instance:StopCurrentMusic()
  CS.SoundManager.Instance:PlayMusic("8BitMusic")
end

function OnClickShare()
  WU.SetActive(REF.SharePanel, false)
  this:SetData("ShareConfig", {
    shareName = "City",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.AcquireWindowAsync("Share")
end

function OnWindowUninited(window)
end

function OnDownloadClick()
  REF.SharePanel.gameObject:SetActive(false)
  REF.CameraEffect.EffectGenerator:Play()
  this:DelayInvokeInSeconds(1, function()
    local m_imagePath = CS.ResourceManager.Instance.SharePath .. "/screencapture.png"
    CS.GameUtility.ScreenCapture(m_imagePath)
    CS.NativeInterface.External_SaveToAlbum(m_imagePath, "OnScreenshotSuccessEvent", "OnScreenshotFailureEvent")
  end)
end

function OnScreenshotSuccess()
  REF.SharePanel.gameObject:SetActive(true)
  WU.ShowHintText("Success!")
end

function OnScreenshotFailure()
  REF.SharePanel.gameObject:SetActive(true)
  WU.ShowHintText("Try Again!")
end

function ReqQuestionActivity()
  local config = PB.get("WelfareConfig", "QuestionReward")
  if config then
    local activity = m_activityManager.GetActivitySync(config.relatedActivityType, config.relatedActivityIds[1])
    if ACU.IsOpenForDoing(activity) then
      local key = "fci/question/system/" .. config.relatedActivityIds[1]
      this:GameRequest(key):Get(function(res)
        this:SetData(key, res)
        UpdateQuestionRedPoint()
      end)
    end
  end
end

function UpdateQuestionRedPoint()
  local config = PB.get("WelfareConfig", "QuestionReward")
  if config then
    m_activityManager.GetActivityByType(config.relatedActivityType, function(acList)
      if acList then
        for _, activity in pairs(acList) do
          if ACU.IsOpenForDoing(activity, true) then
            this:BindRemote(this:GameRequest("fci/question/system/" .. config.relatedActivityIds[1]), function(res)
              local isRed = m_activityManager.IsRedForWlfQuestion(res)
              RU.SetRedMark("Welfare/QuestionReward/" .. config.relatedActivityIds[1], isRed)
            end)
          end
        end
      end
    end)
  end
end

function OnClickpressclick2()
  warning("click")
end

function OnClickpressclick(go, press)
  if press then
    warning("press")
  else
    warning("release")
  end
end

function OnClickRhythm()
  WU.AcquireWindowAsync("RhythmGame")
end

function ShowUnlockFunc()
  local curLevel = this:GetData("fci/baseinfo").level
  local lastLevel = WU.GetGameDataCache("PlayerLevelUp/LastLevel")
  if lastLevel == nil then
    WU.SetGameDataCache("PlayerLevelUp/LastLevel", curLevel)
  else
    local unlockList = WU.GetUnlockFunc(lastLevel, curLevel)
    local tmpWin = unlockList[#unlockList]
    if 0 < #unlockList then
      local popParam = {unlockWin = tmpWin}
      if PB.get("UnlockWindowPos", tmpWin) ~= nil then
        WU.AcquireWindowAsync("LevelUnlockPopup", function(win)
          _ENV["$"](win)["$$SetView"](popParam)
        end)
      else
        warning("UnlockWindowShow ", "No info in xlsx UnlockWindowPos, type : " .. tmpWin)
      end
      table.remove(unlockList, #unlockList)
      WU.SetGameDataCache("PlayerLevelUp/LastLevel", curLevel)
      WU.SetGameDataCache("UnlockWinShow" .. this:GetData("playerId"), unlockList)
    end
  end
end

function enterStoryTutorial()
  this:BroadcastGameEvent("BoardActorEventVoice", "story")
  WU.AcquireWindowAsync("ChapterNormal")
  WU.RecycleWindow("SakuGuide")
end

function exitStoryTutorial()
  WU.RecycleWindow("SakuGuide")
end
