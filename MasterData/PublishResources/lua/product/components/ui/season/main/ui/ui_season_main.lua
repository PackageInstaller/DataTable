local UISeasonMainDisableOpenListReason = {
  QuestPlot = 1,
  ShowBubble = 2,
  BuffLevelUp = 3,
  PlayEnterAnim = 4
}
_enum("UISeasonMainDisableOpenListReason", UISeasonMainDisableOpenListReason)
_class("UISeasonMain", UIController)
UISeasonMain = UISeasonMain

function UISeasonMain:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
  local module = GameGlobal.GetModule(SeasonModule)
  module:ForceRequestCurSeasonData(TT)
  self._seasonObj = module:GetCurSeasonObj()
  if not self._seasonObj then
    res:SetSucc(false)
    Log.error("无法获取到赛季数据")
    return
  end
  res:SetSucc(true)
  self._actionPointCpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.ACTION_POINT)
  self._componentInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
end

function UISeasonMain:OnShow(uiParams)
  self.showTestFuncEntry = true
  self._disableOpenListReasons = {}
  self:InitWidget()
  self._black:SetActive(false)
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiModule:SeasonManager()
  local topBtn = self.topBtns:SpawnObject("UISeasonTopBtn")
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
  topBtn:SetData(function()
    self._active = false
    self._uiModule:ExitSeasonTo(UIStateType.UIS1Main)
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
  self._ovalArea = self.ovalAreaPool:SpawnObject("UISeasonMainOvalArea")
  self._seasonMap = self.mapAreaPool:SpawnObject("UISeasonMapArea")
  self._seasonDaily = self._daily:SpawnObject("UISeasonDaily")
  self._seasonDaily:SetData(true)
  self:InitBuffLevelArea()
  self:InitFinalPlotEnterArea()
  self._active = true
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("<color=#ff9d32>%s</color>/%s", cur, ceil))
  local actionPointID = self._actionPointCpt:GetItemId()
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  if Cfg.cfg_top_tips[actionPointID] then
    self._topTipIcon.sprite = atlas:GetSprite(Cfg.cfg_top_tips[actionPointID].Icon)
  end
  self:SetShow(true)
  self:AttachEvents()
  self._levelList = self.levelListPool:SpawnObject("UISeasonMainLevelList")
  self._levelList:SetData(self._seasonObj)
  local infos = self._componentInfo.m_stage_info
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
end

function UISeasonMain:AttachEvents()
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
end

function UISeasonMain:DisableOpenList(bDisable, reason)
  if not self._disableOpenListReasons then
    self._disableOpenListReasons = {}
  end
  self._disableOpenListReasons[reason] = bDisable
  self:_TryShowOpenList()
end

function UISeasonMain:IsDisableOpenList()
  if self._disableOpenListReasons then
    for key, value in pairs(self._disableOpenListReasons) do
      if value then
        return true
      end
    end
  end
  return false
end

function UISeasonMain:OnAfterUILayerChanged()
  self:_TryShowOpenList()
end

function UISeasonMain:_TryShowOpenList()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:ShowOpenList()
  end
end

function UISeasonMain:ShowOpenList()
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

function UISeasonMain:CheckShowExpressBubbleOnEnter()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local waitShowBubbles = uiSeasonModule:GetWaitShowBubbleCallbacks()
  if waitShowBubbles and 0 < #waitShowBubbles then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonTryShowEventBubble)
    uiSeasonModule:EraseFirstWaitShowBubbleCallback()
    return true
  end
end

function UISeasonMain:OnUIGetItemCloseInQuest(type)
  self:RefreshBuffArea()
end

function UISeasonMain:OnUpdate(dtMS)
  if (IsPc() or IsUnityEditor()) and GameGlobal.EngineInput().GetKeyDown(UnityEngine.KeyCode.BackQuote) then
    self.showTestFuncEntry = not self.showTestFuncEntry
    self:SwitchTestFuncEntry(self.showTestFuncEntry)
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

function UISeasonMain:OnHide()
  self._active = false
  if self._afterEnterAnimTimer then
    GameGlobal.Timer():CancelEvent(self._afterEnterAnimTimer)
    self._afterEnterAnimTimer = nil
  end
end

function UISeasonMain:InitWidget()
  self._animation = self:GetUIComponent("Animation", "SafeArea")
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
  self._bottomEftAnim = self:GetUIComponent("Animation", "eff_scale")
end

function UISeasonMain:InitBuffLevelArea()
  self._buffLevelArea = self.buffLevelGen:SpawnObject("UISeasonBuffMainArea")
  if self._buffLevelArea then
    self._buffLevelArea:SetData(self._seasonObj)
  end
end

function UISeasonMain:InitFinalPlotEnterArea()
  if not self.finalPlotEnterGen then
    return
  end
  self._finalPlotEnterArea = self.finalPlotEnterGen:SpawnObject("UISeasonFinalPlotEnter")
  if self._finalPlotEnterArea then
    self._finalPlotEnterArea:SetData(self._seasonObj)
  end
end

function UISeasonMain:SwitchTestFuncEntry(show)
  if self._testFunc ~= nil then
    self._testFunc:Switch(show)
  end
end

function UISeasonMain:SetShow(show)
  self.root:SetActive(show)
  self.showUI:SetActive(not show)
end

function UISeasonMain:PlayerIconOnClick(go)
  self._seasonManager:SeasonCameraManager():SwitchMode(SeasonCameraMode.Follow)
end

function UISeasonMain:ArchieveBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonQuest()
end

function UISeasonMain:CollectionBtnOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self:_TryStopPlayer()
  UISeasonHelper.ShowCurSeasonCollage()
end

function UISeasonMain:TopTipOnClick(go)
  if self._seasonManager:LockUI() then
    return
  end
  self:_TryStopPlayer()
  self:ShowDialog("UISeasonActionPointTip", self._actionPointCpt, go.transform.anchoredPosition)
end

function UISeasonMain:RefreshBuffArea()
  if self._buffLevelArea then
    self._buffLevelArea:RefreshInfo()
  end
end

function UISeasonMain:LeaveToBattle()
  self._active = false
  self._uiModule:ExitSeasonGame()
end

function UISeasonMain:LeaveToMain()
  self._active = false
end

function UISeasonMain:ShowUIOnClick()
  self:SetShow(true)
end

function UISeasonMain:AfterPlayEnterVideo(played)
  if UISeasonHelper.CheckEnterStory(self._seasonObj:GetSeasonID()) then
    self:AfterPlayEnterStory(false)
  else
    local cfg = Cfg.cfg_season_campaign_client[self._seasonObj:GetSeasonID()]
    UISeasonHelper.PlayStoryInSeasonScence(cfg.EnterStory, function()
      self:AfterPlayEnterStory(true)
    end)
  end
end

function UISeasonMain:AfterPlayEnterStory(played)
  if played then
    UISeasonHelper.AfterPlayEnterStory(self._seasonObj:GetSeasonID())
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMain)
  self:_PlayEnterAnim()
end

function UISeasonMain:ShowSerialRewards()
  self._isWaitShowSerialRewards = true
end

function UISeasonMain:CheckShowSerialRewards()
  if self._isWaitShowSerialRewards then
    self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
    self._isWaitShowSerialRewards = false
    return true
  end
end

function UISeasonMain:CheckShowCollectionRewardOnEnter()
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

function UISeasonMain:CalcBuffLevelOnEnter()
  local seasonModule = self:GetModule(SeasonModule)
  local componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  local curLevel, curProgress = UISeasonHelper.CalcBuffLevel(componentID)
  local oldLevel, oldProgress = seasonModule:GetRecordBuffLevel()
  if oldLevel == -1 then
    seasonModule:RecordBuffLevel(curLevel, curProgress)
  elseif curLevel ~= oldLevel then
    self:DisableOpenList(true, UISeasonMainDisableOpenListReason.BuffLevelUp)
    self:ShowDialog("UISeasonBuffLevelUp", oldLevel, curLevel, componentID, function()
      self:DisableOpenList(false, UISeasonMainDisableOpenListReason.BuffLevelUp)
    end)
    seasonModule:RecordBuffLevel(curLevel, curProgress)
    return true
  end
end

function UISeasonMain:CheckShowCollectionComposePlotOnEnter()
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

function UISeasonMain:OnCollectionComposePlotEnd(completedQuest)
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

function UISeasonMain:_OnGetCollection()
  self:_ResetCollectionInfo()
  self:_TryShowOpenList()
end

function UISeasonMain:_ResetCollectionInfo()
  local data = self._uiModule:GetCollageData()
  data:FlushAllCollages()
  local count = data:GetCollectionProgress()
  self.collectionCount:SetText(count)
  self:_ResetCollageNew()
end

function UISeasonMain:_ResetCollageNew()
  local data = self._uiModule:GetCollageData()
  self._collageNew:SetActive(data:CollectionHasNew())
end

function UISeasonMain:_ResetQuestRed()
  local cpt = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST)
  self._questRed:SetActive(cpt:HaveRedPoint())
end

function UISeasonMain:_PlayEnterVideo(onEnd)
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

function UISeasonMain:_OnActionPointChanged()
  local cur, ceil = self._actionPointCpt:GetItemCount()
  self._pointCount:SetText(string.format("<color=#ff9d32>%s</color>/%s", cur, ceil))
end

function UISeasonMain:_OnAutoFightSweepFinished()
  self:_OnActionPointChanged()
  self:_ResetCollectionInfo()
  self:_ResetQuestRed()
end

function UISeasonMain:_TryStopPlayer()
  self._seasonManager:SeasonPlayerManager():GetPlayer():Stop(false)
end

function UISeasonMain:_PlayEnterAnim()
  self._animation:Play("uieffanim_UISeasonMain_in")
  self._seasonManager:SeasonCameraManager():DoEnterAnim()
  self:DisableOpenList(true, UISeasonMainDisableOpenListReason.PlayEnterAnim)
  if self._afterEnterAnimTimer then
    GameGlobal.Timer():CancelEvent(self._afterEnterAnimTimer)
    self._afterEnterAnimTimer = nil
  end
  local enterAnimTime = 1000
  self._afterEnterAnimTimer = GameGlobal.Timer():AddEvent(enterAnimTime, function()
    self:_OnEnterAnimEnd()
  end)
end

function UISeasonMain:_OnEnterAnimEnd()
  self:DisableOpenList(false, UISeasonMainDisableOpenListReason.PlayEnterAnim)
end

function UISeasonMain:_OnSeasonDailyResetSucc()
  if self._seasonDaily then
    self._seasonDaily:SetData()
  end
end

function UISeasonMain:_OnDiffChanged(curDiff)
  self._bottomEftAnim:Stop()
  if curDiff == UISeasonLevelDiff.Normal then
    self:_PlayBtmEftOut()
  else
    if curDiff == UISeasonLevelDiff.Hard then
      self:_PlayBtmEftIn()
    else
    end
  end
end

function UISeasonMain:_PlayBtmEft(isIn)
  if isIn then
    self:_PlayBtmEftIn()
  else
    self:_PlayBtmEftOut()
  end
end

function UISeasonMain:_PlayBtmEftIn()
  self._bottomEftAnim:Stop()
  self._bottomEftAnim:PlayQueued("uieff_UISeasonMain_bowen_in")
end

function UISeasonMain:_PlayBtmEftOut()
  self._bottomEftAnim:Stop()
  self._bottomEftAnim:Play("uieff_UISeasonMain_bowen_out")
  self._bottomEftAnim:PlayQueued("uieff_UISeasonMain_bowen_loop")
end

function UISeasonMain:IsPlayAnimation()
  if self._animation then
    local name = "uieffanim_UISeasonMain_in"
    if self._animation:IsPlaying(name) then
      local state = self._animation:get_Item(name)
      return true, state.length
    end
  end
  return false
end
