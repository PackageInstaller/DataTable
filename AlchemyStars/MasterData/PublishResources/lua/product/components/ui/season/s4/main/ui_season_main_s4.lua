_class("UISeasonMainS4", UIController)
UISeasonMainS4 = UISeasonMainS4

function UISeasonMainS4:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
  local module = GameGlobal.GetModule(SeasonModule)
  module:ForceRequestCurSeasonData(TT)
  module:HandleSeasonMiniGameInfoReq(TT)
  self._seasonModule = module
  self._seasonObj = module:GetCurSeasonObj()
  if not self._seasonObj then
    res:SetSucc(false)
    Log.error("无法获取到赛季数据")
    return
  end
  res:SetSucc(true)
  self._actionPointCpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.ACTION_POINT)
  local apCfg = self._actionPointCpt:GetActionPointConfig()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local apStart = loginModule:GetTimeStampByTimeStr(apCfg.StartTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local apStop = loginModule:GetTimeStampByTimeStr(apCfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local apTime = apCfg.RegainTime
  if apTime <= 0 then
    self._actionPointLastRecoverTime = 0
  else
    local t = apStart
    while apStop >= t do
      t = t + apTime
    end
    self._actionPointLastRecoverTime = t - apTime
  end
  self._component = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._componentInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._BusinessComp = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.BUSINESS)
  self._BusinessInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.BUSINESS)
  self._totalProcessComp = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.TOTAL_PROCESS)
  self._totalProcessInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.TOTAL_PROCESS)
  self._rewardProcessComp = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.REWARD_PROCESS)
  self._rewardProcessInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.REWARD_PROCESS)
end

function UISeasonMainS4:OnShow(uiParams)
  self.showTestFuncEntry = true
  self._disableOpenListReasons = {}
  self:InitWidget()
  self._black:SetActive(false)
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiModule:SeasonManager()
  self._topBtn = self.topBtns:SpawnObject("UISeasonTopBtn")
  local cfg = Cfg.cfg_season_campaign_client[self._seasonObj:GetSeasonID()]
  local entryVideoFunc
  if cfg.EnterVideo then
    function entryVideoFunc()
      if self._seasonManager:LockUI() then
        return
      end
      self:_PlayEnterVideo()
      self:_TryStopPlayer()
    end
  end
  self._topBtn:SetData(function()
    self._animation:Play("uieff_UISeasonMainS4_out")
    self:Lock("UISeasonMainS4:Back")
    GameGlobal.Timer():AddEvent(300, function()
      self:UnLock("UISeasonMainS4:Back")
      if self.view then
        self._active = false
        if self._component:ComponentIsOpen() then
          self._uiModule:ExitSeasonTo(UIStateType.UIS4Main)
        else
          self._uiModule:ExitSeasonTo(UIStateType.UIMain)
        end
      end
    end)
  end, function()
    self._active = false
    self._uiModule:ExitSeasonTo(UIStateType.UIMain)
  end, function()
    Log.info("隐藏ui")
    self:SetShow(false)
    self:_TryStopPlayer()
  end, function()
    if self._seasonManager:LockUI() then
      return
    end
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.Main)
    self:_TryStopPlayer()
  end, entryVideoFunc)
  self._ovalArea = self.ovalAreaPool:SpawnObject("UISeasonMainOvalAreaS4")
  self._seasonMap = self.mapAreaPool:SpawnObject("UISeasonMapArea")
  self._seasonDaily = self._daily:SpawnObject("UISeasonDaily")
  self._seasonDaily:SetData(true)
  self._seasonAnim = self._seasonDaily:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self:InitBuffLevelArea()
  self:InitFinalPlotEnterArea()
  self._active = true
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("<color=#37d2b0>%s</color>/%s", cur, ceil))
  local actionPointID = self._actionPointCpt:GetItemId()
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  if Cfg.cfg_top_tips[actionPointID] then
    self._topTipIcon.sprite = atlas:GetSprite(Cfg.cfg_top_tips[actionPointID].Icon)
  end
  self:SetShow(true)
  self:_SetTaskListNavi()
  self:_SetTaskListBtn()
  self:AttachEvents()
  self._levelList = self.levelListPool:SpawnObject("UISeasonMainLevelListS4")
  self._levelList:SetData(self._seasonObj)
  local infos = self._componentInfo.m_pass_mission_info
  if UISeasonHelper.CheckEnterVideo(self._seasonObj:GetSeasonID()) or table.count(infos) > 0 then
    self:AfterPlayEnterVideo(false)
  else
    UISeasonHelper.AfterShowEnterVideo(self._seasonObj:GetSeasonID())
    self._black:SetActive(true)
    self:_PlayEnterVideo(function()
      self._black:SetActive(false)
      self:AfterPlayEnterVideo(true)
    end)
  end
  self:_ResetCollectionInfo()
  self:_ResetQuestRed()
  self._modeSwitch = self._modeSwitchLoader:SpawnObject("UISeasonModeSwitchS4")
  self._modeSwitch:SetData(self._seasonObj)
  local mode = self._seasonManager:SeasonMapManager():Mode()
  self:_OnModeChanged(mode)
  self:_CheckSeasonBuildOpen()
  self:_SetBackTrackUI()
  self:_SetBackpackInfo()
  if not self._uiModule:IsBackTrack() then
    self:Lock("PlayS4EnterAnim")
    local prefab = ResourceManager:GetInstance():SyncLoadAsset("UIActivityN38Switch.prefab", LoadType.GameObject)
    local rect = prefab.Obj:GetComponent(typeof(UnityEngine.RectTransform))
    rect:SetParent(self._enterAnimRect)
    UIHelper.SetRectTransformToFillFullScreen(rect)
    prefab.Obj:SetActive(true)
    prefab.Obj:GetComponentInChildren(typeof(UnityEngine.Animation)):Play("uieff_N38_Switch_wait")
    self._animation:Play("uieff_UISeasonMainS4_in")
    self._levelList:PlayEnterAnim()
    GameGlobal.Timer():AddEvent(1000, function()
      self:UnLock("PlayS4EnterAnim")
      prefab:Dispose()
      if self._active then
        self._seasonAnim:Play("uieff_UISeasonDailyS4_in")
      end
    end)
    self._decor1:SetActive(true)
    self._decor2:SetActive(true)
  else
    self._levelList:PlayEnterAnim()
    self._animation:Play("uieff_UISeasonMainS4_in")
    self._seasonAnim:Play("uieff_UISeasonDailyS4_in")
    self._decor1:SetActive(false)
    self._decor2:SetActive(false)
  end
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  if curTime < self._BusinessInfo.m_unlock_time then
    self._tradeLock:SetActive(true)
  elseif not self._BusinessInfo.m_b_unlock then
    self._tradeLock:SetActive(true)
  else
    local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. "S4TradeGameNew"
    local ShowNew = LocalDB.GetInt(key, 0) == 0
    self._tradeNew:SetActive(ShowNew)
    self:SetTradeGameRed()
    self._tradeLock:SetActive(false)
  end
  self:_RefreshActionPointTip()
end

function UISeasonMainS4:AttachEvents()
  self:AttachEvent(GameEventType.SeasonLeaveToBattle, self.LeaveToBattle)
  self:AttachEvent(GameEventType.SeasonLeaveToMain, self.LeaveToMain)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self:AttachEvent(GameEventType.OnSeasonCollectionObtained, self._OnGetCollection)
  self:AttachEvent(GameEventType.OnSeasonActionPointChanged, self._OnActionPointChanged)
  self:AttachEvent(GameEventType.UISeasonS1OnSelectCollageItem, self._ResetCollageNew)
  self:AttachEvent(GameEventType.OnSeasonQuestAwardCollected, self._ResetQuestRed)
  self:AttachEvent(GameEventType.OnSeasonSceneAwardCollected, self._OnGetCollection)
  self:AttachEvent(GameEventType.OnSerialAutoFightSweepFinish, self._OnAutoFightSweepFinished)
  self:AttachEvent(GameEventType.OnSeasonDailyResetSucc, self._OnSeasonDailyResetSucc)
  self:AttachEvent(GameEventType.UISeasonOnLevelDiffChanged, self._OnDiffChanged)
  self:AttachEvent(GameEventType.OnSeasonMainBottomEftPlay, self._PlayBtmEft)
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self._OnModeChanged)
  self:AttachEvent(GameEventType.OnEventPointProgressChange, self._TriggerGuide)
  self:AttachEvent(GameEventType.OnSeasonStoryChanged, self._OnSeasonStoryChanged)
  self:AttachEvent(GameEventType.OnSeasonBackpackClose, self._OnSeasonBackpackClose)
end

function UISeasonMainS4:DisableOpenList(bDisable, reason)
  if not self._disableOpenListReasons then
    self._disableOpenListReasons = {}
  end
  self._disableOpenListReasons[reason] = bDisable
  self:_TryShowOpenList()
end

function UISeasonMainS4:IsDisableOpenList()
  if self._disableOpenListReasons then
    for key, value in pairs(self._disableOpenListReasons) do
      if value then
        return true
      end
    end
  end
  return false
end

function UISeasonMainS4:OnAfterUILayerChanged()
  self:_TryShowOpenList()
end

function UISeasonMainS4:_TryShowOpenList()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:ShowOpenList()
  end
end

function UISeasonMainS4:ShowOpenList()
  if self:IsDisableOpenList() then
    return
  end
  if self:CheckShowExpressBubbleOnEnter() then
    return
  end
  if self:CheckShowSerialRewards() then
    return
  end
  if self:CheckShowCollectionRewardOnEnter() then
    return
  end
  if self:CheckShowCollectionComposePlotOnEnter() then
    return
  end
  if self:CalcBuffLevelOnEnter() then
    return
  end
end

function UISeasonMainS4:CheckShowExpressBubbleOnEnter()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local waitShowBubbles = uiSeasonModule:GetWaitShowBubbleCallbacks()
  if waitShowBubbles and 0 < #waitShowBubbles then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonTryShowEventBubble)
    uiSeasonModule:EraseFirstWaitShowBubbleCallback()
    return true
  end
end

function UISeasonMainS4:OnUIGetItemCloseInQuest(type)
  self:RefreshBuffArea()
end

function UISeasonMainS4:OnUpdate(dtMS)
  if (IsPc() or IsUnityEditor()) and GameGlobal.EngineInput().GetKeyDown(UnityEngine.KeyCode.BackQuote) then
    self.showTestFuncEntry = not self.showTestFuncEntry
    self:SwitchTestFuncEntry(self.showTestFuncEntry)
  end
  if not self._uiModule:InSeasaonRunning() then
    return
  end
  if not self._active then
    return
  end
  if self._ovalArea then
    self._ovalArea:Update(dtMS)
  end
  if self._seasonMap then
    self._seasonMap:Update(dtMS)
  end
end

function UISeasonMainS4:OnHide()
  self._active = false
  if self._apCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._apCountdownTimer)
    self._apCountdownTimer = nil
  end
end

function UISeasonMainS4:InitWidget()
  self._animation = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.buffLevelGen = self:GetUIComponent("UISelectObjectPath", "BuffLevelArea")
  self.finalPlotEnterGen = self:GetUIComponent("UISelectObjectPath", "FinalPlotEnterArea")
  self.collectionCount = self:GetUIComponent("UILocalizationText", "CollectionCount")
  self.topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  if EngineGameHelper.IsDevelopmentBuild() or HelperProxy:GetInstance():GetConfig("EnableTestFunc", "false") == "true" then
    local testFuncPool = self:GetUIComponent("UISelectObjectPath", "TestFunc")
    if testFuncPool then
      self._testFunc = testFuncPool:SpawnObject("UISeasonTestFunc")
    end
  end
  self.levelListPool = self:GetUIComponent("UISelectObjectPath", "LevelList")
  self.ovalAreaPool = self:GetUIComponent("UISelectObjectPath", "OvalArea")
  self.mapAreaPool = self:GetUIComponent("UISelectObjectPath", "MapArea")
  self._levelInfos = self:GetUIComponent("UISelectObjectPath", "LevelInfos")
  self.root = self:GetGameObject("Root")
  self.showUI = self:GetGameObject("ShowUI")
  self._levelBtn = self:GetGameObject("LevelBtn")
  self._pointCount = self:GetUIComponent("UILocalizationText", "PointCount")
  self._collageNew = self:GetGameObject("CollageNew")
  self._questRed = self:GetGameObject("QuestRed")
  self._topTipIcon = self:GetUIComponent("Image", "TopTipIcon")
  self._black = self:GetGameObject("Black")
  self._daily = self:GetUIComponent("UISelectObjectPath", "Daily")
  self._modeSwitchLoader = self:GetUIComponent("UISelectObjectPath", "ModeSwitch")
  self._playerIcon = self:GetUIComponent("Image", "PlayerIcon")
  self.buildBtnPool = self:GetUIComponent("UISelectObjectPath", "buildBtn")
  self._enterAnimRect = self:GetUIComponent("RectTransform", "Anim")
  self:InitTalenTreeEnter()
  self._decor1 = self:GetGameObject("Decor1")
  self._decor2 = self:GetGameObject("Decor2")
  self._tradeNew = self:GetGameObject("TradeNew")
  self._tradeRed = self:GetGameObject("TradeRed")
  self._tradeLock = self:GetGameObject("TradeLock")
  self._apCountdownPr = self:GetGameObject("CountDownTipPr")
  self._apCountdownTip = self:GetUIComponent("UILocalizationText", "CountDownTip")
  self._apStopPr = self:GetGameObject("StopTipPr")
end

function UISeasonMainS4:InitTalenTreeEnter()
  local enter = self:GetUIComponent("UISelectObjectPath", "TalentTreeEnter")
  self._talentTreeLineEnter = enter:SpawnObject("UISeasonTalentEntry")
  self._talentTreeLineEnter:SetData()
end

function UISeasonMainS4:_SetTaskListNavi()
  local className, prefabName = UISeasonHelper.GetCurSeasonTaskList("Navi")
  if not string.isnullorempty(className) then
    local obj = UIWidgetHelper.SpawnObject(self, "TaskListNavi", className, prefabName)
  end
end

function UISeasonMainS4:_SetTaskListBtn()
  local className, prefabName = UISeasonHelper.GetCurSeasonTaskList("Btn")
  if not string.isnullorempty(className) then
    local obj = UIWidgetHelper.SpawnObject(self, "TaskListBtn", className, prefabName)
  end
end

function UISeasonMainS4:InitBuffLevelArea()
  self._buffLevelArea = self.buffLevelGen:SpawnObject("UISeasonBuffMainAreaS4")
  if self._buffLevelArea then
    self._buffLevelArea:SetData(self._seasonObj)
  end
end

function UISeasonMainS4:InitFinalPlotEnterArea()
  if not self.finalPlotEnterGen then
    return
  end
  self._finalPlotEnterArea = self.finalPlotEnterGen:SpawnObject("UISeasonFinalPlotEnter")
  if self._finalPlotEnterArea then
    self._finalPlotEnterArea:SetData(self._seasonObj)
  end
end

function UISeasonMainS4:SwitchTestFuncEntry(show)
  if self._testFunc ~= nil then
    self._testFunc:Switch(show)
  end
end

function UISeasonMainS4:SetShow(show)
  self.root:SetActive(show)
  self.showUI:SetActive(not show)
end

function UISeasonMainS4:PlayerIconOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self._seasonManager:SeasonCameraManager():SwitchMode(SeasonCameraMode.Follow)
end

function UISeasonMainS4:ArchieveBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  if not self._seasonModule:CheckSeasonAndComponentCloseAndJump(ECCampaignSeasonComponentID.QUEST) then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonQuest()
end

function UISeasonMainS4:CollectionBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  if not self._seasonModule:CheckSeasonCloseAndJump() then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonCollage()
end

function UISeasonMainS4:TopTipOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self:_TryStopPlayer()
  self:_HideActionPointTip()
  self:ShowDialog("UISeasonActionPointTipS4", self._actionPointCpt, go.transform.anchoredPosition, function()
    self:_RefreshActionPointTip()
  end)
end

function UISeasonMainS4:RefreshBuffArea()
  if self._buffLevelArea then
    self._buffLevelArea:RefreshInfo()
  end
end

function UISeasonMainS4:LeaveToBattle()
  self._active = false
  self._uiModule:ExitSeasonGame()
end

function UISeasonMainS4:LeaveToMain()
  self._active = false
end

function UISeasonMainS4:ShowUIOnClick()
  self:SetShow(true)
end

function UISeasonMainS4:AfterPlayEnterVideo(played)
  if UISeasonHelper.CheckEnterStory(self._seasonObj:GetSeasonID()) then
    self:AfterPlayEnterStory(false)
  else
    local cfg = Cfg.cfg_season_campaign_client[self._seasonObj:GetSeasonID()]
    UISeasonHelper.PlayStoryInSeasonScence(cfg.EnterStory, function()
      self:AfterPlayEnterStory(true)
    end)
  end
end

function UISeasonMainS4:AfterPlayEnterStory(played)
  if played then
    UISeasonHelper.AfterPlayEnterStory(self._seasonObj:GetSeasonID())
  end
  self:_PlayEnterAnim()
end

function UISeasonMainS4:ShowSerialRewards()
  self._isWaitShowSerialRewards = true
end

function UISeasonMainS4:CheckShowSerialRewards()
  if self._isWaitShowSerialRewards then
    self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
    self._isWaitShowSerialRewards = false
    return true
  end
end

function UISeasonMainS4:CheckShowCollectionRewardOnEnter()
  local seasonModule = self:GetModule(SeasonModule)
  local waitShowRewards = seasonModule:GetWaitShowCollectionRewards()
  if waitShowRewards and 0 < #waitShowRewards then
    local showRewards = {
      waitShowRewards[1]
    }
    UISeasonHelper.ShowUIGetRewards(showRewards)
    seasonModule:EraseFirstWaitShowCollectionRewards()
    return true
  end
end

function UISeasonMainS4:CalcBuffLevelOnEnter()
  local seasonModule = self:GetModule(SeasonModule)
  local componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  local curLevel, curProgress = UISeasonHelper.CalcBuffLevel(componentID)
  local oldLevel, oldProgress = seasonModule:GetRecordBuffLevel()
  if oldLevel == -1 then
    seasonModule:RecordBuffLevel(curLevel, curProgress)
  elseif curLevel ~= oldLevel then
    self:DisableOpenList(true, UISeasonMainDisableOpenListReason.BuffLevelUp)
    self:ShowDialog("UISeasonBuffLevelUpS4", oldLevel, curLevel, componentID, function()
      self:DisableOpenList(false, UISeasonMainDisableOpenListReason.BuffLevelUp)
    end)
    seasonModule:RecordBuffLevel(curLevel, curProgress)
    return true
  end
end

function UISeasonMainS4:CheckShowCollectionComposePlotOnEnter()
  if not self.questCmpt then
    self.questCmpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST_STORY)
  end
  if self.questCmpt and self.questCmpt then
    self._questList = self.questCmpt:GetQuestInfo()
    local questStatus = self.questCmpt:GetCampaignQuestStatus(self._questList)
    local completedQuest
    local seasonId = self._seasonObj:GetSeasonID()
    local finalStoryQuestId
    local seasonClientCfg = Cfg.cfg_season_campaign_client[seasonId]
    if seasonClientCfg then
      finalStoryQuestId = seasonClientCfg.FinalStoryQuestID
    end
    for quest, v in pairs(questStatus) do
      if v ~= CampaignQuestStatus.CQS_Completed or finalStoryQuestId and quest._questInfo.quest_id == finalStoryQuestId then
      else
        completedQuest = quest
        break
      end
    end
    if completedQuest then
      self:DisableOpenList(true, UISeasonMainDisableOpenListReason.QuestPlot)
      do
        local function cb()
          self:OnCollectionComposePlotEnd(completedQuest)
        end
        
        local composeStoryID
        local cfgs = Cfg.cfg_item_season_collection({
          ComposeQuestID = completedQuest._questInfo.quest_id
        })
        if 0 < #cfgs then
          local cfg = cfgs[1]
          composeStoryID = cfg.ComposeStoryID
        end
        if composeStoryID then
          self._animation:Stop()
          UISeasonHelper.PlayStoryInSeasonScence(composeStoryID, cb)
          return true
        end
      end
    end
  end
end

function UISeasonMainS4:OnCollectionComposePlotEnd(completedQuest)
  if not self.questCmpt then
    self:DisableOpenList(false, UISeasonMainDisableOpenListReason.QuestPlot)
    return
  end
  local questStatus = self.questCmpt:CheckCampaignQuestStatus(completedQuest._questInfo)
  if questStatus == CampaignQuestStatus.CQS_Completed then
    self.questCmpt:Start_HandleQuestTake(completedQuest._questInfo.quest_id, function(res, rewards)
      if not self.view then
        return
      end
      if res and res:GetSucc() then
        UISeasonHelper.ShowUIGetRewards(rewards)
      else
      end
      self:DisableOpenList(false, UISeasonMainDisableOpenListReason.QuestPlot)
    end)
  else
  end
end

function UISeasonMainS4:_OnGetCollection()
  self:_ResetCollectionInfo()
  self:_TryShowOpenList()
end

function UISeasonMainS4:_ResetCollectionInfo()
  local data = self._uiModule:GetCollageData()
  data:FlushAllCollages()
  local count = data:GetCollectionProgress()
  self.collectionCount:SetText(count)
  self:_ResetCollageNew()
end

function UISeasonMainS4:_ResetCollageNew()
  local data = self._uiModule:GetCollageData()
  self._collageNew:SetActive(data:CollectionHasNew())
end

function UISeasonMainS4:_ResetQuestRed()
  local cpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST)
  self._questRed:SetActive(cpt:HaveRedPoint())
end

function UISeasonMainS4:_PlayEnterVideo(onEnd)
  local seasonAudio = self._seasonManager:SeasonAudioManager():GetSeasonAudio()
  seasonAudio:StopSeasonSounds()
  local cfg = Cfg.cfg_season_campaign_client[self._seasonObj:GetSeasonID()]
  local leftBg, rightBg
  if cfg.EnterVideoBG then
    leftBg = cfg.EnterVideoBG[1]
    rightBg = cfg.EnterVideoBG[2]
  end
  if CriWare.CriManaMovieControllerForUI then
    self:ShowDialog("UICriVideoController", cfg.EnterVideo, leftBg, function()
      seasonAudio:ResumeSeasonSounds()
      if onEnd then
        onEnd()
      end
    end, rightBg)
  else
    self:ShowDialog("UICriVideoControllerNowrap", cfg.EnterVideo, leftBg, function()
      seasonAudio:ResumeSeasonSounds()
      if onEnd then
        onEnd()
      end
    end, rightBg)
  end
end

function UISeasonMainS4:_OnActionPointChanged()
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("<color=#37d2b0>%s</color>/%s", cur, ceil))
end

function UISeasonMainS4:_OnAutoFightSweepFinished()
  self:_OnActionPointChanged()
  self:_ResetCollectionInfo()
  self:_ResetQuestRed()
end

function UISeasonMainS4:_TryStopPlayer()
  self._seasonManager:SeasonPlayerManager():GetPlayer():Stop(false)
end

function UISeasonMainS4:_PlayEnterAnim()
  if not self._active or not self._uiModule:InSeasaonRunning() then
    return
  end
  self._seasonManager:SeasonCameraManager():DoEnterAnim()
  self:StartTask(function(TT)
    YIELD(TT, 400)
    if not self._active or not self._uiModule:InSeasaonRunning() then
      return
    end
    self._seasonManager:SeasonMapManager():TryResumeExpress()
    self:_TriggerGuide()
    local talentVal = GameGlobal.GetUIModule(SeasonModule):GetTalentTreeBattleOut()
    if talentVal then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnOpenTalentLine)
    end
  end)
end

function UISeasonMainS4:_OnSeasonDailyResetSucc()
  if self._seasonDaily then
    self._seasonDaily:SetData()
  end
end

function UISeasonMainS4:_OnDiffChanged(curDiff)
  if curDiff == UISeasonLevelDiff.Normal then
    self:_PlayBtmEftOut()
  else
    if curDiff == UISeasonLevelDiff.Hard then
      self:_PlayBtmEftIn()
    else
    end
  end
end

function UISeasonMainS4:_PlayBtmEft(isIn)
  if isIn then
    self:_PlayBtmEftIn()
  else
    self:_PlayBtmEftOut()
  end
end

function UISeasonMainS4:_PlayBtmEftIn()
end

function UISeasonMainS4:_PlayBtmEftOut()
end

function UISeasonMainS4:IsPlayAnimation()
  if self._animation then
    local name = "uieffanim_UISeasonMain_in"
    if self._animation:IsPlaying(name) then
      local state = self._animation:get_Item(name)
      return true, state.length
    end
  end
  return false
end

function UISeasonMainS4:_OnModeChanged(mode)
  local atlasName, spriteName = UISeasonHelper.GetPlayIconSprite()
  if atlasName and spriteName then
    local atlas = self:GetAsset(atlasName, LoadType.SpriteAtlas)
    self._playerIcon.sprite = atlas:GetSprite(spriteName)
  end
end

function UISeasonMainS4:_TriggerGuide()
  self:_CheckGuide()
  self:_SetBackpackInfo()
end

function UISeasonMainS4:_CheckGuide()
  if self:_CheckModeValid(SeasonMapMode.Mode2) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMainS4)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMainS4)
  end
end

function UISeasonMainS4:_CheckModeValid(mode)
  local cfg = Cfg.cfg_season_map[self._seasonObj:GetSeasonID()]
  if not cfg then
    Log.exception("cfg_season_map 中找不到配置:", self._seasonObj:GetSeasonID())
    return false
  end
  if cfg.ModeUnlock == nil or next(cfg.ModeUnlock) == nil then
    return false
  end
  local condition = cfg.ModeUnlock[mode]
  if string.isnullorempty(condition) then
    return true
  end
  local valid = GameGlobal.GetModule(SeasonModule):CheckCondition(condition, self._componentInfo.m_stage_info)
  return valid
end

function UISeasonMainS4:_OnSeasonStoryChanged(isOpen)
  self:SetShow(not isOpen)
end

function UISeasonMainS4:_CheckSeasonBuildOpen()
  if self.buildBtn then
    self.buildBtn:RefreshStatus()
    return
  end
  local isOpen = self._seasonModule:CheckSeasonBuildOpen()
  if isOpen and not self.buildBtn then
    self.buildBtn = self.buildBtnPool:SpawnObject("UISeasonBuildEntryBtn")
  end
end

function UISeasonMainS4:_SetBackTrackUI()
  if self._uiModule:IsBackTrack() then
    self:GetGameObject("LevelList"):SetActive(false)
    self:GetGameObject("ModeSwitch"):SetActive(false)
    self:GetGameObject("BuffLevelArea"):SetActive(false)
    self:GetGameObject("TopTip"):SetActive(false)
    self:GetGameObject("Daily"):SetActive(false)
    self:GetGameObject("buildBtn"):SetActive(false)
    self:GetGameObject("CollectionBtn"):SetActive(false)
    self:GetGameObject("ArchieveBtn"):SetActive(false)
    self:GetGameObject("Daily"):SetActive(false)
    self:GetGameObject("BackpackBtn"):SetActive(false)
    local rectTransform = self:GetUIComponent("RectTransform", "TaskListBtn")
    if rectTransform then
      rectTransform.anchoredPosition = Vector2(-101, rectTransform.anchoredPosition.y)
    end
    self._topBtn:SetBacktrackUI()
    self:GetGameObject("BackSeasonBtn"):SetActive(true)
    self:GetGameObject("TalentTreeEnter"):SetActive(false)
    self:GetGameObject("TradeBtn"):SetActive(false)
  else
    self:GetGameObject("BackSeasonBtn"):SetActive(false)
  end
end

function UISeasonMainS4:BackSeasonBtnOnClick(go)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonAndMissionCoseAndJump() then
    self._uiModule:BackToCurSeason()
  end
end

function UISeasonMainS4:_IsBackpackOpen()
  if self._uiModule:IsBackTrack() then
    return false
  end
  local loginModule = self:GetModule(LoginModule)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  local constCfg = Cfg.cfg_season_debris_const[self._seasonModule:GetCurSeasonID()]
  if constCfg then
    local unlockTime = loginModule:GetTimeStampByTimeStr(constCfg.UnlockTime, constCfg.TimeTransform)
    local closeTime = loginModule:GetTimeStampByTimeStr(constCfg.CloseTime, constCfg.TimeTransform)
    local missionID = constCfg.MissionID[1]
    local progress = constCfg.MissionID[2]
    local targetProgress = self._componentInfo.m_stage_info[missionID]
    if curTime >= unlockTime and curTime < closeTime and targetProgress and progress <= targetProgress then
      return true
    else
      return false
    end
  else
    return false
  end
end

function UISeasonMainS4:_SetBackpackInfo()
  local loginModule = self:GetModule(LoginModule)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  local backpackBtn = self:GetGameObject("BackpackBtn")
  local backpackRedpoint = self:GetGameObject("BackpackRedpoint")
  local constCfg = Cfg.cfg_season_debris_const[self._seasonModule:GetCurSeasonID()]
  if constCfg then
    local unlockTime = loginModule:GetTimeStampByTimeStr(constCfg.UnlockTime, constCfg.TimeTransform)
    local closeTime = loginModule:GetTimeStampByTimeStr(constCfg.CloseTime, constCfg.TimeTransform)
    local missionID = constCfg.MissionID[1]
    local progress = constCfg.MissionID[2]
    local targetProgress = self._componentInfo.m_stage_info[missionID]
    if curTime >= unlockTime and curTime < closeTime and targetProgress and progress <= targetProgress then
      backpackBtn:SetActive(not self._uiModule:IsBackTrack())
    else
      backpackBtn:SetActive(false)
      return
    end
  else
    backpackBtn:SetActive(false)
    return
  end
  local key = "UISeasonBackpack" .. GameGlobal.GetModule(LoginModule):GetRoleShowID()
  local record = LocalDB.GetInt(key, 0)
  if record <= 0 then
    backpackRedpoint:SetActive(true)
  else
    local cfgs = Cfg.cfg_season_debris_mission({
      SeasonID = self._seasonModule:GetCurSeasonID(),
      Type = 1
    })
    if cfgs then
      for _, cfg in pairs(cfgs) do
        local unlockTime = loginModule:GetTimeStampByTimeStr(cfg.DateTimeBegin, cfg.TimeTransform)
        if curTime >= unlockTime then
          local nodeKey = key .. cfg.ID
          record = LocalDB.GetInt(nodeKey, 0)
          if record <= 0 then
            backpackRedpoint:SetActive(true)
            return
          end
        end
      end
    end
    backpackRedpoint:SetActive(false)
  end
end

function UISeasonMainS4:BackpackBtnOnClick(go)
  if not self:_IsBackpackOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local mgr = uiSeasonModule:SeasonManager()
  local eventPoint = mgr:SeasonMapManager():GetEventPoint(8003302)
  mgr:SeasonInputManager():GetInput():SetClickUnLockZone(eventPoint:IsUnlock())
  mgr:SeasonInputManager():GetInput():GetClickEffect():Click()
  mgr:SeasonInputManager():GetInput():SetCurClickEventPoint(eventPoint)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideDone(80030201) then
    eventPoint:AutoMoveToMe()
  else
    eventPoint:GuideMove()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
  end
end

function UISeasonMainS4:_OnSeasonBackpackClose()
  self:_SetBackpackInfo()
end

function UISeasonMainS4:TradeBtnOnClick(go)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  if curTime < self._BusinessInfo.m_unlock_time then
    local remainTime = self._BusinessInfo.m_unlock_time - curTime
    local timeStr = UIActivityHelper.GetFormatTimerStr(remainTime)
    local tips = StringTable.Get("str_season_s4_trade_unlock_eta", timeStr)
    ToastManager.ShowToast(tips)
    return
  end
  if not self._BusinessInfo or curTime >= self._BusinessInfo.m_close_time then
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
    return
  end
  local missionID = self._BusinessInfo.m_need_mission_id
  local open = self._component:IsPassCamMissionID(missionID)
  if not open then
    local cfg_mission = Cfg.cfg_season_mission[missionID]
    local cfgName = ""
    if cfg_mission then
      cfgName = StringTable.Get(cfg_mission.Name)
    end
    local tips = StringTable.Get("str_season_s4_trade_unlock_prelevel", cfgName)
    ToastManager.ShowToast(tips)
    return
  end
  if self._tradeLock.activeSelf then
    local remainTime = 0
    local timeStr = UIActivityHelper.GetFormatTimerStr(remainTime)
    local tips = StringTable.Get("str_season_s4_trade_unlock_eta", timeStr)
    ToastManager.ShowToast(tips)
    return
  end
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. "S4TradeGameNew"
  LocalDB.SetInt(key, 1)
  self._tradeNew:SetActive(false)
  self:ShowDialog("UIS4TradeMainController")
end

function UISeasonMainS4:SetTradeGameRed()
  if self._tradeNew.activeSelf then
    self._tradeRed:SetActive(false)
    return
  end
  local sampleInfo = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  local BusinessRed = self._BusinessComp:HasRed()
  local HarborRed = self._BusinessComp:HasRedHarborLv()
  local ShipLvRed = self._BusinessComp:HasRedShipLv()
  local totalRed = self._totalProcessComp:HasCanGetReward()
  local rewardRed = self._rewardProcessComp:HasCanGetReward()
  local rewardLevelRed = self._rewardProcessComp:HasCanLevelUp()
  self._tradeRed:SetActive(BusinessRed or HarborRed or ShipLvRed or totalRed or rewardRed or rewardLevelRed)
end

function UISeasonMainS4:_HideActionPointTip()
  self._apCountdownPr:SetActive(false)
  self._apStopPr:SetActive(false)
  if self._apCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._apCountdownTimer)
    self._apCountdownTimer = nil
  end
end

function UISeasonMainS4:_RefreshActionPointTip()
  if self._actionPointLastRecoverTime <= 0 then
    self:_HideActionPointTip()
    return
  end
  local now = GetSvrTimeNow()
  if now >= self._actionPointLastRecoverTime then
    self._apCountdownPr:SetActive(false)
    self._apStopPr:SetActive(true)
    if self._apCountdownTimer then
      GameGlobal.Timer():CancelEvent(self._apCountdownTimer)
      self._apCountdownTimer = nil
    end
    return
  end
  local delta = self._actionPointLastRecoverTime - now
  if 259200 < delta then
    self:_HideActionPointTip()
    return
  end
  if self.view then
    local t = HelperProxy:GetInstance():FormatTime(delta)
    self._apCountdownTip:SetText(StringTable.Get("str_season_s4_ticket_refresh_time", t))
  end
  if not self._apCountdownTimer then
    self._apCountdownPr:SetActive(true)
    self._apStopPr:SetActive(false)
    self._apCountdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_RefreshActionPointTip()
    end)
  end
end
