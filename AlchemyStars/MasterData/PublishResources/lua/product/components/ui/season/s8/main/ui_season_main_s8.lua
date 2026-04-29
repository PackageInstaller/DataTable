_class("UISeasonMainS8", UIController)
UISeasonMainS8 = UISeasonMainS8

function UISeasonMainS8:LoadDataOnEnter(TT, res)
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

function UISeasonMainS8:OnShow(uiParams)
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
    self._animation:Play("uieff_UISeasonMainS6_out")
    self:Lock("UISeasonMainS8:Back")
    GameGlobal.Timer():AddEvent(300, function()
      self:UnLock("UISeasonMainS8:Back")
      if self.view then
        self._active = false
        if self._component:ComponentIsOpen() then
          self._uiModule:ExitSeasonTo(UIStateType.UIS8Main)
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
  end, nil, entryVideoFunc)
  self._ovalArea = self.ovalAreaPool:SpawnObject("UISeasonMainOvalAreaS8")
  self._seasonMap = self.mapAreaPool:SpawnObject("UISeasonMapArea")
  self._seasonDaily = self._daily:SpawnObject("UISeasonDaily")
  self._seasonDaily:SetData(true)
  self._seasonAnim = self._seasonDaily:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self:InitBuffLevelArea()
  self:InitFinalPlotEnterArea()
  self._active = true
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("%s/%s", cur, ceil))
  local actionPointID = self._actionPointCpt:GetItemId()
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  if Cfg.cfg_top_tips[actionPointID] then
    self._topTipIcon.sprite = atlas:GetSprite(Cfg.cfg_top_tips[actionPointID].Icon)
  end
  self:SetShow(true)
  self:_SetTaskListNavi()
  self:_SetTaskListBtn()
  self:AttachEvents()
  self._levelList = self.levelListPool:SpawnObject("UISeasonMainLevelListS8")
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
  self._modeSwitch = self._modeSwitchLoader:SpawnObject("UISeasonModeSwitchS8")
  self._modeSwitch:SetData(self._seasonObj)
  local mode = self._seasonManager:SeasonMapManager():Mode()
  self:_OnModeChanged(mode)
  self:_SetBackTrackUI()
  self:_SetBackpackInfo()
  if not self._uiModule:IsBackTrack() then
    self:Lock("PlayS8EnterAnim")
    self._levelList:PlayEnterAnim()
    GameGlobal.Timer():AddEvent(1000, function()
      self:UnLock("PlayS8EnterAnim")
      if self._active then
      end
    end)
    self._levelList:PlayEnterAnim()
    self._animation:Play("uieff_UISeasonMainS8_in")
  end
  local seasonID = GameGlobal.GetUIModule(SeasonModule):GetSeasonID()
  if UISeasonHelper._GetSeasonCfg(seasonID, "SceneState") ~= UIStateType.UISeasonS8 then
    local effect = self:GetGameObject("Scale")
    effect:SetActive(false)
  end
  self:_RefreshThirdBtnVisible()
  self:_RefreshActionPointTip()
end

function UISeasonMainS8:_OnOnceMissonControllerCosed()
  self:_RefreshThirdBtnVisible()
end

function UISeasonMainS8:AttachEvents()
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
  self:AttachEvent(GameEventType.OnSeasonMainBottomEftPlay, self._PlayBtmEft)
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self._OnModeChanged)
  self:AttachEvent(GameEventType.OnEventPointProgressChange, self._TriggerGuide)
  self:AttachEvent(GameEventType.OnSeasonStoryChanged, self._OnSeasonStoryChanged)
  self:AttachEvent(GameEventType.OnSeasonBackpackClose, self._OnSeasonBackpackClose)
  self:AttachEvent(GameEventType.OnceMissonControllerClosed, self._OnOnceMissonControllerCosed)
end

function UISeasonMainS8:DisableOpenList(bDisable, reason)
  if not self._disableOpenListReasons then
    self._disableOpenListReasons = {}
  end
  self._disableOpenListReasons[reason] = bDisable
  self:_TryShowOpenList()
end

function UISeasonMainS8:IsDisableOpenList()
  if self._disableOpenListReasons then
    for key, value in pairs(self._disableOpenListReasons) do
      if value then
        return true
      end
    end
  end
  return false
end

function UISeasonMainS8:OnAfterUILayerChanged()
  self:_TryShowOpenList()
end

function UISeasonMainS8:_TryShowOpenList()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:ShowOpenList()
  end
end

function UISeasonMainS8:ShowOpenList()
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

function UISeasonMainS8:CheckShowExpressBubbleOnEnter()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local waitShowBubbles = uiSeasonModule:GetWaitShowBubbleCallbacks()
  if waitShowBubbles and 0 < #waitShowBubbles then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonTryShowEventBubble)
    uiSeasonModule:EraseFirstWaitShowBubbleCallback()
    return true
  end
end

function UISeasonMainS8:OnUIGetItemCloseInQuest(type)
  self:RefreshBuffArea()
end

function UISeasonMainS8:OnUpdate(dtMS)
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

function UISeasonMainS8:OnHide()
  self._active = false
  if self._apCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._apCountdownTimer)
    self._apCountdownTimer = nil
  end
end

function UISeasonMainS8:InitWidget()
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
  self._tradeNew = self:GetGameObject("TradeNew")
  self._tradeRed = self:GetGameObject("TradeRed")
  self._tradeLock = self:GetGameObject("TradeLock")
  self._apCountdownPr = self:GetGameObject("CountDownTipPr")
  self._apCountdownTip = self:GetUIComponent("UILocalizationText", "CountDownTip")
  self._apStopPr = self:GetGameObject("StopTipPr")
  self._thirdBtnGo = self:GetGameObject("ThirdBtn")
  self._thierdBtnNew = self:GetGameObject("ThirdNew")
end

function UISeasonMainS8:_SetTaskListNavi()
  local className, prefabName = UISeasonHelper.GetCurSeasonTaskList("Navi")
  if not string.isnullorempty(className) then
    local obj = UIWidgetHelper.SpawnObject(self, "TaskListNavi", className, prefabName)
  end
end

function UISeasonMainS8:_SetTaskListBtn()
  local className, prefabName = UISeasonHelper.GetCurSeasonTaskList("Btn")
  if not string.isnullorempty(className) then
    local obj = UIWidgetHelper.SpawnObject(self, "TaskListBtn", className, prefabName)
  end
end

function UISeasonMainS8:_RefreshThirdBtnVisible()
  if self._uiModule:IsBackTrack() then
    self._thirdBtnGo:SetActive(false)
    return
  end
  local onceMissionData = self._seasonModule:GetOnceMissionData()
  local bShow = onceMissionData:AnyComponentOpening()
  self._thirdBtnGo:SetActive(bShow)
  local bNew = onceMissionData:HasEntryNew()
  self._thierdBtnNew:SetActive(bNew)
end

function UISeasonMainS8:InitBuffLevelArea()
  self._buffLevelArea = self.buffLevelGen:SpawnObject("UISeasonBuffMainAreaS8")
  if self._buffLevelArea then
    self._buffLevelArea:SetData(self._seasonObj)
  end
end

function UISeasonMainS8:InitFinalPlotEnterArea()
  if not self.finalPlotEnterGen then
    return
  end
  self._finalPlotEnterArea = self.finalPlotEnterGen:SpawnObject("UISeasonFinalPlotEnter")
  if self._finalPlotEnterArea then
    self._finalPlotEnterArea:SetData(self._seasonObj)
  end
end

function UISeasonMainS8:SwitchTestFuncEntry(show)
  if self._testFunc ~= nil then
    self._testFunc:Switch(show)
  end
end

function UISeasonMainS8:SetShow(show)
  self.root:SetActive(show)
  self.showUI:SetActive(not show)
end

function UISeasonMainS8:PlayerIconOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self._seasonManager:SeasonCameraManager():SwitchMode(SeasonCameraMode.Follow)
end

function UISeasonMainS8:ArchieveBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  if not self._seasonModule:CheckSeasonAndComponentCloseAndJump(ECCampaignSeasonComponentID.QUEST) then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonQuest()
end

function UISeasonMainS8:CollectionBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  if not self._seasonModule:CheckSeasonCloseAndJump() then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonCollage()
end

function UISeasonMainS8:TopTipOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self:_TryStopPlayer()
  self:_HideActionPointTip()
  self:ShowDialog("UISeasonActionPointTipS8", self._actionPointCpt, go.transform.anchoredPosition, function()
    self:_RefreshActionPointTip()
  end)
end

function UISeasonMainS8:RefreshBuffArea()
  if self._buffLevelArea then
    self._buffLevelArea:RefreshInfo()
  end
end

function UISeasonMainS8:LeaveToBattle()
  self._active = false
  self._uiModule:ExitSeasonGame()
end

function UISeasonMainS8:LeaveToMain()
  self._active = false
end

function UISeasonMainS8:ShowUIOnClick()
  self:SetShow(true)
end

function UISeasonMainS8:AfterPlayEnterVideo(played)
  if UISeasonHelper.CheckEnterStory(self._seasonObj:GetSeasonID()) then
    self:AfterPlayEnterStory(false)
  else
    local cfg = Cfg.cfg_season_campaign_client[self._seasonObj:GetSeasonID()]
    UISeasonHelper.PlayStoryInSeasonScence(cfg.EnterStory, function()
      self:AfterPlayEnterStory(true)
    end)
  end
end

function UISeasonMainS8:AfterPlayEnterStory(played)
  if played then
    UISeasonHelper.AfterPlayEnterStory(self._seasonObj:GetSeasonID())
  end
  self:_PlayEnterAnim()
end

function UISeasonMainS8:ShowSerialRewards()
  self._isWaitShowSerialRewards = true
end

function UISeasonMainS8:CheckShowSerialRewards()
  if self._isWaitShowSerialRewards then
    self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
    self._isWaitShowSerialRewards = false
    return true
  end
end

function UISeasonMainS8:CheckShowCollectionRewardOnEnter()
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

function UISeasonMainS8:CalcBuffLevelOnEnter()
  local seasonModule = self:GetModule(SeasonModule)
  local componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  local curLevel, curProgress = UISeasonHelper.CalcBuffLevel(componentID)
  local oldLevel, oldProgress = seasonModule:GetRecordBuffLevel()
  if oldLevel == -1 then
    seasonModule:RecordBuffLevel(curLevel, curProgress)
  elseif curLevel ~= oldLevel then
    self:DisableOpenList(true, UISeasonMainDisableOpenListReason.BuffLevelUp)
    self:ShowDialog("UISeasonBuffLevelUpS8", oldLevel, curLevel, componentID, function()
      self:DisableOpenList(false, UISeasonMainDisableOpenListReason.BuffLevelUp)
    end)
    seasonModule:RecordBuffLevel(curLevel, curProgress)
    return true
  end
end

function UISeasonMainS8:CheckShowCollectionComposePlotOnEnter()
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

function UISeasonMainS8:OnCollectionComposePlotEnd(completedQuest)
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

function UISeasonMainS8:_OnGetCollection()
  self:_ResetCollectionInfo()
  self:_TryShowOpenList()
  self:_ResetQuestRed()
end

function UISeasonMainS8:_ResetCollectionInfo()
  local data = self._uiModule:GetCollageData()
  data:FlushAllCollages()
  local count = data:GetCollectionProgress()
  self.collectionCount:SetText(count)
  self:_ResetCollageNew()
end

function UISeasonMainS8:_ResetCollageNew()
  local data = self._uiModule:GetCollageData()
  self._collageNew:SetActive(data:CollectionHasNew())
end

function UISeasonMainS8:_ResetQuestRed()
  local cpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST)
  self._questRed:SetActive(cpt:HaveRedPoint())
end

function UISeasonMainS8:_PlayEnterVideo(onEnd)
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

function UISeasonMainS8:_OnActionPointChanged()
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("%s/%s", cur, ceil))
end

function UISeasonMainS8:_OnAutoFightSweepFinished()
  self:_OnActionPointChanged()
  self:_ResetCollectionInfo()
  self:_ResetQuestRed()
end

function UISeasonMainS8:_TryStopPlayer()
  self._seasonManager:SeasonPlayerManager():GetPlayer():Stop(false)
end

function UISeasonMainS8:_PlayEnterAnim()
  if not self._active or not self._uiModule:InSeasaonRunning() then
    return
  end
  self._animation:Play("uieff_UISeasonMainS8_in")
  self._seasonManager:SeasonCameraManager():DoEnterAnim()
  self:StartTask(function(TT)
    YIELD(TT, 400)
    if not self._active or not self._uiModule:InSeasaonRunning() then
      return
    end
    self._seasonManager:SeasonMapManager():TryResumeExpress()
    self:_TriggerGuide()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AfterSeasonSceneUIShow)
  end)
end

function UISeasonMainS8:_OnSeasonDailyResetSucc()
  if self._seasonDaily then
    self._seasonDaily:SetData()
  end
end

function UISeasonMainS8:IsPlayAnimation()
  if self._animation then
    local name = "uieff_UISeasonMainS8_in"
    if self._animation:IsPlaying(name) then
      local state = self._animation:get_Item(name)
      return true, state.length
    end
  end
  return false
end

function UISeasonMainS8:_OnModeChanged(mode)
  local atlasName, spriteName = UISeasonHelper.GetPlayIconSprite()
  if atlasName and spriteName then
    local atlas = self:GetAsset(atlasName, LoadType.SpriteAtlas)
    self._playerIcon.sprite = atlas:GetSprite(spriteName)
  end
end

function UISeasonMainS8:_TriggerGuide()
  self:_CheckGuide()
  self:_SetBackpackInfo()
end

function UISeasonMainS8:_CheckGuide()
  if self:_CheckModeValid(SeasonMapMode.Mode2) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMainS8)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMainS8)
  end
end

function UISeasonMainS8:_CheckModeValid(mode)
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

function UISeasonMainS8:_OnSeasonStoryChanged(isOpen)
  self:SetShow(not isOpen)
end

function UISeasonMainS8:_SetBackTrackUI()
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
    self:GetGameObject("bg1"):SetActive(false)
    self:GetGameObject("bg1"):SetActive(false)
    local rectTransform = self:GetUIComponent("RectTransform", "TaskListBtn")
    if rectTransform then
      rectTransform.anchoredPosition = Vector2(-101, rectTransform.anchoredPosition.y)
    end
    self._topBtn:SetBacktrackUI()
    self:GetGameObject("BackSeasonBtn"):SetActive(true)
  else
    self:GetGameObject("BackSeasonBtn"):SetActive(false)
  end
end

function UISeasonMainS8:BackSeasonBtnOnClick(go)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonAndMissionCoseAndJump() then
    self._uiModule:BackToCurSeason()
  end
end

function UISeasonMainS8:_IsBackpackOpen()
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

function UISeasonMainS8:_SetBackpackInfo()
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

function UISeasonMainS8:BackpackBtnOnClick(go)
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

function UISeasonMainS8:ThirdBtnOnClick(go)
  local onceMissionData = self._seasonModule:GetOnceMissionData()
  local bShow = onceMissionData:AnyComponentOpening()
  if not bShow then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  local mode = self._seasonManager:SeasonMapManager():Mode()
  if mode == 1 then
    local title = StringTable.Get("str_season_s7_branch_change_mode_title")
    local content = StringTable.Get("str_season_s7_branch_change_mode_message")
    self:ShowDialog("UISeasonConfirm2", title, content, function()
      self._modeSwitch:Switch2Modle2(function()
        self:_MoveToEvnentPointById(8008301)
      end)
    end)
    return
  end
  self:_MoveToEvnentPointById(8008301)
end

function UISeasonMainS8:_MoveToEvnentPointById(eventId)
  local mgr = self._seasonModule.uiModule:SeasonManager()
  local eventPoint = mgr:SeasonMapManager():GetEventPoint(eventId)
  mgr:SeasonInputManager():GetInput():SetClickUnLockZone(eventPoint:IsUnlock())
  mgr:SeasonInputManager():GetInput():GetClickEffect():Click()
  mgr:SeasonInputManager():GetInput():SetCurClickEventPoint(eventPoint)
  eventPoint:AutoMoveToMe()
end

function UISeasonMainS8:_OnSeasonBackpackClose()
  self:_SetBackpackInfo()
end

function UISeasonMainS8:_HideActionPointTip()
  self._apCountdownPr:SetActive(false)
  self._apStopPr:SetActive(false)
  if self._apCountdownTimer then
    GameGlobal.Timer():CancelEvent(self._apCountdownTimer)
    self._apCountdownTimer = nil
  end
end

function UISeasonMainS8:_RefreshActionPointTip()
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
    self._apCountdownTip:SetText(StringTable.Get("str_season_s7_ticket_refresh_time", t))
  end
  if not self._apCountdownTimer then
    self._apCountdownPr:SetActive(true)
    self._apStopPr:SetActive(false)
    self._apCountdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_RefreshActionPointTip()
    end)
  end
end
