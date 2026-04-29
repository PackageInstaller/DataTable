_class("UISeasonMazeEnterController", UIController)
UISeasonMazeEnterController = UISeasonMazeEnterController

function UISeasonMazeEnterController:LoadDataOnEnter(TT, res)
  local module = GameGlobal.GetModule(SeasonMazeModule)
  local sample = module:GetCurSample()
  if not sample or not sample:IsShow(GetSvrTimeNow()) then
    res:SetSucc(false)
    module:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    return
  end
  local res = module:ReqCurSeasonMazeDetailInfo(TT)
  if not res:GetSucc() then
    module:CheckErrorCode(res)
    return
  end
  res:SetSucc(true)
end

function UISeasonMazeEnterController:OnShow(uiParams)
  self:InitWidget()
  self:InitUI()
  self:RefershBtnsNew()
  self.guideModule = GameGlobal.GetModule(GuideModule)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.RefreshScoreTaskRed)
  if type(uiParams[1]) == "function" then
    self.closeCb = uiParams[1]
  else
    self.isFromEnter = true
  end
  self:StartTask(self._EnterTask, self)
end

function UISeasonMazeEnterController:_EnterTask(TT)
  self:Lock("UISeasonMazeEnterController_EnterAni")
  YIELD(TT, 500)
  self:UnLock("UISeasonMazeEnterController_EnterAni")
  if not self.view then
    return
  end
  self:_TryPlayStartStory(TT, function()
    self:_CheckGuide()
  end)
  self._guideTimeHandle = UIActivityHelper.StartTimerEvent(self._guideTimeHandle, function()
    self:_CheckGuide2()
  end)
end

function UISeasonMazeEnterController:_TryPlayStartStory(TT, onFinish)
  local wait = false
  if self._startStoryID then
    local mazeID = self._seasonMazeModule:CurSeasonMazeID()
    local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. mazeID .. "_StartStory"
    local watched = LocalDB.GetInt(key, 0) == 1
    if not watched then
      LocalDB.SetInt(key, 1)
      wait = true
      Log.info("播放赛季秘境开场剧情:", self._startStoryID)
      self:ShowDialog("UIStoryController", self._startStoryID, onFinish)
      return
    end
  end
  Log.info("无需播放开场剧情:", self._startStoryID)
  onFinish()
end

function UISeasonMazeEnterController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeEnterController)
  self:_CheckGuide2()
end

function UISeasonMazeEnterController:_CheckGuide2()
  if self.guideModule:IsGuideDone(900202) then
    if self._guideTimeHandle then
      UIActivityHelper.CancelTimerEvent(self._guideTimeHandle)
      self._guideTimeHandle = nil
    end
    return
  end
  if self.guideModule:IsGuideDone(900201) then
    local cmpInfo = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeComponent():GetComponentInfo()
    local check1 = cmpInfo.hard_num and #cmpInfo.hard_num > 1 and cmpInfo.hard_num[1].vic_count > 0
    local check2 = cmpInfo.hard_num[1].fail_info and #cmpInfo.hard_num[1].fail_info == 1
    if check1 or check2 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeEnterController2)
      if self._guideTimeHandle then
        UIActivityHelper.CancelTimerEvent(self._guideTimeHandle)
        self._guideTimeHandle = nil
      end
    end
  end
end

function UISeasonMazeEnterController:InitWidget()
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.titleText = self:GetUIComponent("RawImageLoader", "TitleText")
  self.restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self.scoreText = self:GetUIComponent("UILocalizationText", "ScoreText")
  self.bossRedPoint = self:GetUIComponent("UISelectObjectPath", "BossRedPoint")
  self.handBookRedPoint = self:GetGameObject("HandBookRedPoint")
  self.enterMazeRedPoint = self:GetUIComponent("UISelectObjectPath", "EnterMazeRedPoint")
  self.mazeDiffText = self:GetUIComponent("UILocalizationText", "MazeDiffText")
  self.mazeScoreRedPoint = self:GetGameObject("MazeScoreRedPoint")
  self.enterMazeBtnObj = self:GetGameObject("EnterMazeBtn")
  self.continueMazeBtnObj = self:GetGameObject("ContinueMazeBtn")
  self.stopMazeBtnObj = self:GetGameObject("StopMazeBtn")
  self.bossNewObj = self:GetGameObject("BossNew")
  self.bookNewObj = self:GetGameObject("BookNew")
  self.scoreNewObj = self:GetGameObject("ScoreNew")
  self.adventureNewObj = self:GetGameObject("AdventureNew")
  self.bOSSBtnObj = self:GetGameObject("BOSSBtn")
  self.bOSSBtnObj:SetActive(false)
  self.banPetNewObj = self:GetGameObject("BanPetNew")
  self.banPetBtnObj = self:GetGameObject("BanPetBtn")
  self.banPetBtnObj:SetActive(true)
  if UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_HandBook_New") then
    self.bookNewObj:SetActive(false)
  else
    self.bookNewObj:SetActive(true)
  end
  if UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_Processs_New") then
    self.scoreNewObj:SetActive(false)
  else
    self.scoreNewObj:SetActive(true)
  end
  self.bossNewObj:SetActive(false)
  if not LocalDB.HasKey("UISeasonMazeEnterController_Boss_New") then
    self.bossNewObj:SetActive(true)
  elseif LocalDB.GetInt("UISeasonMazeEnterController_Boss_New") == 1 then
    self.bossNewObj:SetActive(true)
  end
  self.banPetNewObj:SetActive(false)
  if UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_BanPet_New") then
    self.banPetNewObj:SetActive(false)
  else
    self.banPetNewObj:SetActive(true)
  end
end

function UISeasonMazeEnterController:OnHide()
  if self._timerHandler then
    UIActivityHelper.CancelTimerEvent(self._guideTimeHandle)
    self._guideTimeHandle = nil
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UISeasonMazeEnterController:InitUI()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._progressComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.TOTAL_PROCESS)
  self._endTime = self._sample.end_time
  self.backBtns:SetData(function()
    if self:Manager():CurUIStateType() == UIStateType.UISeasonMazeMain then
      self:SwitchState(UIStateType.UIMain)
    else
      if GameGlobal.UIStateManager():IsShow("UIS5MainController") then
        GameGlobal.UIStateManager():CloseDialog("UIS5MainController")
      end
      self:CloseDialog()
    end
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp1, 1)
  end, nil, false, nil, false, nil)
  self:OnRefreshTime()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:OnRefreshTime()
  end)
  local hasSave = true
  if self._componentInfo.hard == 0 or self._componentInfo.hard == nil then
    hasSave = false
  end
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self.mazePets = self.uiSeasonMazeModule:GetSeasonMazePets()
  if self.mazePets == nil or table.count(self.mazePets) == 0 then
    hasSave = false
  end
  if self._componentInfo.hard ~= 0 and (self.mazePets == nil or table.count(self.mazePets) == 0) then
    self:Lock("UISeasonMazeEnterController:StopMazeBtnOnClick")
    self:StartTask(self.NotPet_StopSeasonMaze, self)
  end
  if hasSave then
    self.enterMazeBtnObj:SetActive(false)
    self.continueMazeBtnObj:SetActive(true)
    self.stopMazeBtnObj:SetActive(true)
    self.mazeDiffText:SetText(StringTable.Get("str_season_maze_difficulty_num", self._componentInfo.hard))
  else
    self.enterMazeBtnObj:SetActive(true)
    self.continueMazeBtnObj:SetActive(false)
    self.stopMazeBtnObj:SetActive(false)
  end
  local itemID = self._progressComponent:GetItemId()
  local itemModule = GameGlobal.GetModule(ItemModule)
  self._scoreItemCount = itemModule:GetItemCount(itemID)
  self.scoreText:SetText(self._scoreItemCount)
  self:RefreshScoreTaskRed()
  if self._sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    self.adventureNewObj:SetActive(true)
  else
    self.adventureNewObj:SetActive(false)
  end
  local mazeID = self._seasonMazeModule:CurSeasonMazeID()
  local cfg = Cfg.cfg_season_maze_client[mazeID]
  self._startStoryID = cfg.StartStory
  self:GetGameObject("PlotBtn"):SetActive(self._startStoryID ~= nil)
  self.cmptId = self._seasonMazeObj:GetMazeComponent():GetComponentCfgId()
  self.cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  self.cfgs = self:_SortCfg(self.cfgs)
  local highHard = self._componentInfo.hard_num[#self.cfgs]
  if highHard ~= nil and 0 < highHard.vic_count then
    if not LocalDB.HasKey("UISeasonMazeEnterController_Boss_New") then
      self.bOSSBtnObj:SetActive(true)
      LocalDB.SetInt("UISeasonMazeEnterController_Boss_New", 1)
    elseif LocalDB.GetInt("UISeasonMazeEnterController_Boss_New") == 1 or LocalDB.GetInt("UISeasonMazeEnterController_Boss_New") == 2 then
      self.bOSSBtnObj:SetActive(true)
    end
  end
end

function UISeasonMazeEnterController:_SortCfg(items)
  table.sort(items, function(a, b)
    return a.Hard < b.Hard
  end)
  return items
end

function UISeasonMazeEnterController:RefreshScoreTaskRed()
  if UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_Processs_New") then
    local red = self._progressComponent:HasCanGetReward()
    self.mazeScoreRedPoint:SetActive(red)
  else
    self.mazeScoreRedPoint:SetActive(false)
  end
end

function UISeasonMazeEnterController:RefershBtnsNew()
  if UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_HandBook_New") then
    local hasCollageNew = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeCollageDataMgr():HasNewCollage()
    self.handBookRedPoint:SetActive(hasCollageNew)
  else
    self.handBookRedPoint:SetActive(false)
  end
end

function UISeasonMazeEnterController:OnRefreshTime()
  if self.restTimeText then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      local str = StringTable.Get("str_season_maze_less_adven_time") .. UIActivityHelper.GetFormatTimerStr(endTime - curTime)
      self.restTimeText:SetText(str)
    else
      self.restTimeText:SetText(StringTable.Get("str_activity_error_109"))
    end
    self:RefershBtnsNew()
  end
end

function UISeasonMazeEnterController:BOSSBtnOnClick(go)
  self:ShowDialog("UISeasonMazeWorldBossRankingList")
  self.bossNewObj:SetActive(false)
  LocalDB.SetInt("UISeasonMazeEnterController_Boss_New", 2)
end

function UISeasonMazeEnterController:HandBookBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    return
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_HandBook_New") then
    self.bookNewObj:SetActive(false)
    UIActivityHelper.SetLocalDB("UISeasonMazeEnterController_HandBook_New")
  end
  self:ShowDialog("UISeasonMazeCollage")
end

function UISeasonMazeEnterController:EnterMazeBtnOnClick(go)
  self:_ClearNewFlag()
  if self:CheckSeasonMazeClosed() then
    return
  end
  self:ShowDialog("UISeasonMazeSelectDifficultyPopup")
end

function UISeasonMazeEnterController:_ClearNewFlag()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._componentInfo.m_campaign_id)
    if res:GetSucc() then
    end
  end, self)
  self.adventureNewObj:SetActive(false)
end

function UISeasonMazeEnterController:NotPet_StopSeasonMaze(TT)
  local cpt = self._component
  local res = AsyncRequestRes:New()
  cpt:HandleSeasonMazeClearing(TT, res)
  if res:GetSucc() then
    self:UnLock("UISeasonMazeEnterController:StopMazeBtnOnClick")
    self.enterMazeBtnObj:SetActive(true)
    self.continueMazeBtnObj:SetActive(false)
    self.stopMazeBtnObj:SetActive(false)
  else
    self:_LogError("赛季秘境结算失败:", res:GetResult())
    self:UnLock("UISeasonMazeEnterController:StopMazeBtnOnClick")
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeEnterController:Task_StopSeasonMaze(TT)
  self:ShowDialog("UISeasonMazeCompleteResult", function()
    self.enterMazeBtnObj:SetActive(true)
    self.continueMazeBtnObj:SetActive(false)
    self.stopMazeBtnObj:SetActive(false)
  end)
end

function UISeasonMazeEnterController:BackSeasonBtnOnClick(go)
  if self:Manager():CurUIStateType() == UIStateType.UISeasonMazeMain or self.isFromEnter then
    UISeasonHelper.ShowCurSeasonMainController()
  else
    self:CloseDialog()
  end
end

function UISeasonMazeEnterController:StopMazeBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    return
  end
  
  local function okFunc()
    self:Task_StopSeasonMaze()
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_season_maze_enter_maze_enter_give_up"), okFunc, nil)
end

function UISeasonMazeEnterController:ContinueMazeBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    return
  end
  GameGlobal.GetModule(SeasonMazeModule):UIModule():Enter()
end

function UISeasonMazeEnterController:MazeScoreTextBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    return
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_Processs_New") then
    self.scoreNewObj:SetActive(false)
    UIActivityHelper.SetLocalDB("UISeasonMazeEnterController_Processs_New")
  end
  self:ShowDialog("UISeasonMazeScoreTask")
end

function UISeasonMazeEnterController:CheckSeasonMazeClosed()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime > endTime then
    local res = AsyncRequestRes:New()
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    self._seasonMazeModule:CheckSeasonMazeClose(res)
    return true
  else
    return false
  end
end

function UISeasonMazeEnterController:PlotBtnOnClick()
  if self._startStoryID then
    self:ShowDialog("UIStoryController", self._startStoryID)
  end
end

function UISeasonMazeEnterController:BanPetBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBanPetController")
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_BanPet_New") then
    self.banPetNewObj:SetActive(false)
    UIActivityHelper.SetLocalDB("UISeasonMazeEnterController_BanPet_New")
  end
end
