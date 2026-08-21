_class("UIN6MainController_Review", UIController)
UIN6MainController_Review = UIN6MainController_Review

function UIN6MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N6, ECampaignReviewN6ComponentID.BUILD, ECampaignReviewN6ComponentID.QUEST, ECampaignReviewN6ComponentID.LINE_MISSION, ECampaignReviewN6ComponentID.STORY, ECampaignReviewN6ComponentID.POINT_PROGRESS)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self._buildComponent = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.BUILD)
  self._buildComponentInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.BUILD)
  self._questComponent = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.QUEST)
  self._questComponentInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.QUEST)
  self._lineMissionComponet = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.LINE_MISSION)
  self._lineMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.LINE_MISSION)
  self._storyComponent = self._localProcess:GetComponent(ECampaignReviewN6ComponentID.STORY)
  self._storyComponentInfo = self._localProcess:GetComponentInfo(ECampaignReviewN6ComponentID.STORY)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local missionEndTime = 0
  if self._lineMissionCompInfo then
    missionEndTime = self._lineMissionCompInfo.m_close_time
  end
  local componentId = self._buildComponent:GetComponentCfgId(self._campaign._id, self._buildComponentInfo.m_component_id)
  self._buildingDatas = UIActivityN6ReviewBuildingDatas:New(componentId, self._localProcess)
  self._plotId = nil
  local plotIdList = cfg_campaign.FirstEnterStoryID
  if plotIdList and 0 < #plotIdList then
    self._plotId = plotIdList[1]
  end
  self._playPlot = self:IsFirstEnter()
  self:RefreshData()
end

function UIN6MainController_Review:IsFirstEnter()
  local key = self:GetFirstEnterKey()
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIN6MainController_Review:SetFirstEnter()
  local key = self:GetFirstEnterKey()
  local value = UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UIN6MainController_Review:GetFirstEnterKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "N6MainController_Review"
  return key
end

function UIN6MainController_Review:RefreshData()
  local itemModule = GameGlobal.GetModule(ItemModule)
  self._itemCount = itemModule:GetItemCount(UIActivityNPlusSixConst.GetCoinItemId())
  self._showFinalPlot = false
  if self._storyComponent then
    self._showFinalPlot = self._storyComponent:ComponentIsOpen()
  end
end

function UIN6MainController_Review:IsShowFinalPlotRed()
  if not self._storyComponentInfo then
    return false
  end
  if not self._storyComponent:ComponentIsOpen() then
    return false
  end
  local list = self._storyComponentInfo.m_recieved_reward_story
  if not list then
    return true
  end
  if table.count(list) <= 0 then
    return true
  end
  return false
end

function UIN6MainController_Review:IsShowBuildingRed()
  if not self:IsBuildingComponentEnable() then
    return false
  end
  if self._questComponent:HaveRedPoint() then
    return true
  end
  if self._buildComponent:HaveEventRedPoint() then
    return true
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  if self._buildingDatas:HaveCanBuilding(itemModule:GetItemCount(UIActivityNPlusSixConst.GetCoinItemId())) then
    return true
  end
  if self._buildingDatas:IsFirstEnterBuilding() then
    return true
  end
  return false
end

function UIN6MainController_Review:IsShowLevelRed()
  return self._campaign:CheckComponentRed(ECampaignReviewN6ComponentID.LINE_MISSION)
end

function UIN6MainController_Review:IsBuildingComponentEnable()
  if not self._buildComponent then
    return false
  end
  return self._buildComponent:ComponentIsOpen()
end

function UIN6MainController_Review:IsQuestComponentEnable()
  if not self._questComponent then
    return false
  end
  return self._questComponent:ComponentIsOpen()
end

function UIN6MainController_Review:IsMissionComponentEnable()
  if not self._lineMissionComponet then
    return false
  end
  return self._lineMissionComponet:ComponentIsOpen()
end

function UIN6MainController_Review:IsStoryComponentEnable()
  if not self._storyComponent then
    return false
  end
  return self._storyComponent:ComponentIsOpen()
end

function UIN6MainController_Review:OnShow(uiParams)
  self._levelUnOpen = self:GetGameObject("LevelUnOpen")
  self._loginUnOpen = self:GetGameObject("LoginUnOpen")
  self._atlas = self:GetAsset("NPlusSix.spriteatlas", LoadType.SpriteAtlas)
  self._topBgLoader = self:GetUIComponent("RawImageLoader", "TopBg")
  self._bottomBgLoader = self:GetUIComponent("RawImageLoader", "BottomBg")
  self._levelBtnBg = self:GetUIComponent("Image", "LevelBtnBg")
  self._buildingBtnBg = self:GetUIComponent("Image", "BuildingBtnBg")
  self._eventBtnBg = self:GetUIComponent("Image", "EventBtnBg")
  self._bgLoader = self:GetUIComponent("RawImageLoader", "BG")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._finalPlotBtn = self:GetGameObject("FinalPlotBtn")
  self._finalPlotRed = self:GetGameObject("FinalPlotRed")
  self._buildingRed = self:GetGameObject("BuildingRed")
  self._eventRed = self:GetGameObject("EventRed")
  self._levelRed = self:GetGameObject("LevelRed")
  self._unLockTips = self:GetGameObject("UnLockTips")
  self._timeUnLockBtn = self:GetGameObject("TimeUnLockBtn")
  self._buildingUnLock = self:GetGameObject("BuildingUnLock")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._buildingLockTips = self:GetGameObject("BuildingLockTips")
  self._buildingLockTipsLabel = self:GetUIComponent("UILocalizationText", "BuildingLockTipsLabel")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._finalPlotRed:SetActive(false)
  self._buildingRed:SetActive(false)
  self._eventRed:SetActive(false)
  self:AttachEvent(GameEventType.NPlusSixMainRefresh, self.HandleRefreshEvent)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  local iconName = UIActivityNPlusSixConst.GetItemIconName()
  if iconName then
    self._iconLoader:LoadImage(iconName)
  end
  local rt = uiParams[1]
  local dragonFly = self:GetGameObject("uieff_n6_in")
  if rt then
    dragonFly:SetActive(true)
    local bg = self:GetUIComponent("RawImage", "eff_smoke_In")
    local mat = bg.material
    mat:SetTexture("_MainTex", rt)
  else
    dragonFly:SetActive(false)
  end
  if self._playPlot and self._plotId and self._plotId > 0 then
    self:Lock("nplussixplaystory")
    GameGlobal.Timer():AddEvent(1033, function()
      self:UnLock("nplussixplaystory")
      self:ShowDialog("UIStoryController", self._plotId, function()
        self:_TriggerGuide(false)
      end)
    end)
  else
    self:_TriggerGuide(true)
  end
  self:SetFirstEnter()
  self:RefreshUI()
  self:RefreshButtonStatus()
end

function UIN6MainController_Review:RefreshButtonStatus()
  self._levelUnOpen:SetActive(not self:IsMissionComponentEnable())
end

function UIN6MainController_Review:_TriggerGuide(needYield)
  self:StartTask(function(TT)
    self:Lock("UIN6MainController_Review")
    if needYield then
      YIELD(TT, 533)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN6MainController_Review)
    self:_CheckBuildingGuide()
    self:UnLock("UIN6MainController_Review")
  end, self)
end

function UIN6MainController_Review:_CheckBuildingGuide()
  if self._lineMissionCompInfo.m_cur_mission > 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN6MainController_ReviewBuilding)
  end
end

function UIN6MainController_Review:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DetachEvent(GameEventType.NPlusSixMainRefresh, self.HandleRefreshEvent)
end

function UIN6MainController_Review:OnUpdate(deltaTimeMS)
  if self:IsBuildingComponentEnable() then
    self._unLockTips:SetActive(false)
    self._timeUnLockBtn:SetActive(false)
    self._buildingUnLock:SetActive(false)
  else
    self._unLockTips:SetActive(true)
    self._timeUnLockBtn:SetActive(true)
    self._buildingUnLock:SetActive(true)
  end
  self:RefreshButtonStatus()
end

function UIN6MainController_Review:CloseCoro(TT)
  self:Lock("UIN6MainController_Review_CloseCoro")
  self:SwitchState(UIStateType.UIActivityReview)
  self:UnLock("UIN6MainController_Review_CloseCoro")
end

function UIN6MainController_Review:HandleRefreshEvent()
  GameGlobal.TaskManager():StartTask(self.RequestComponentData, self)
end

function UIN6MainController_Review:RequestComponentData(TT)
  self:Lock("UIN6MainController_Review_RequestComponentData")
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  res.m_result = 0
  res.m_call_err = CallResultType.Normal
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N6, ECampaignReviewN6ComponentID.BUILD, ECampaignN6ComponentID.LINE_MISSION, ECampaignN6ComponentID.STORY)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self:RefreshData()
  self:RefreshUI()
  self:UnLock("UIN6MainController_Review_RequestComponentData")
end

function UIN6MainController_Review:RefreshUI()
  self._scoreLabel.text = self:GetItemCountStr(self._itemCount)
  self._finalPlotBtn:SetActive(self._showFinalPlot)
  if self._showFinalPlot then
    self._desLabel:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get("str_n_plus_six_activity_des2")))
  else
    self._desLabel:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get("str_n_plus_six_activity_des1")))
  end
  self:RefreshImageStyle()
  self:RefreshRed()
end

function UIN6MainController_Review:RefreshImageStyle()
  if self._buildingDatas:IsAllBuildingComplete() then
    self._bgLoader:LoadImage("n6_home_bg_complete")
    self._spine:LoadSpine("event_n6_2_spine_idle")
    self._topBgLoader:LoadImage("n6_home_bg1_kv2")
    self._bottomBgLoader:LoadImage("n6_home_bg2_kv2")
    self._levelBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_battle1")
    self._buildingBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_rebuild1")
    self._eventBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_book1")
  else
    self._bgLoader:LoadImage("n6_home_bg")
    self._spine:LoadSpine("event_n6_1_spine_idle")
    self._topBgLoader:LoadImage("n6_home_bg1")
    self._bottomBgLoader:LoadImage("n6_home_bg2")
    self._levelBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_battle")
    self._buildingBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_rebuild")
    self._eventBtnBg.sprite = self._atlas:GetSprite("n6_home_btn_book")
  end
end

function UIN6MainController_Review:GetItemCountStr(count)
  local dight = 0
  local tmpCount = count
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  for i = 1, 7 - dight do
    pre = pre .. "0"
  end
  if 0 < count then
    return string.format("<color=#5e5e5e>%s</color><color=#f2c641>%s</color>", pre, count)
  else
    return string.format("<color=#5e5e5e>%s</color>", pre)
  end
end

function UIN6MainController_Review:RefreshRed()
  self._finalPlotRed:SetActive(self:IsShowFinalPlotRed())
  self._buildingRed:SetActive(self:IsShowBuildingRed())
  self._levelRed:SetActive(self:IsShowLevelRed())
end

function UIN6MainController_Review:PlayButtonAnim(btnName, animName, callback)
  GameGlobal.TaskManager():StartTask(function(TT)
    self:Lock("PlayButtonAnim" .. btnName)
    local animation = self:GetUIComponent("Animation", btnName)
    animation:Play(animName)
    YIELD(TT, 264)
    if callback then
      callback()
    end
    self:UnLock("PlayButtonAnim" .. btnName)
  end, self)
end

function UIN6MainController_Review:LevelBtnOnClick()
  if not self:IsMissionComponentEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n_plus_six_mission_component_close_tips"))
    return
  end
  self:PlayButtonAnim("LevelBtn", "uieff_N6_Main_Btn", function()
    self._campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN6LineMissionReview, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN6MainController_Review:BuildingBtnOnClick()
  if not self:IsBuildingComponentEnable() then
    return
  end
  self:PlayButtonAnim("BuildingBtn", "uieff_N6_Main_Btn", function()
    self:ShowDialog("UIActivityN6ReviewBuildingMainController", self._buildingDatas)
  end)
end

function UIN6MainController_Review:FinalPlotBtnOnClick()
  if not self:IsStoryComponentEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n_plus_six_final_plot_component_close_tips"))
    return
  end
  local componentId = self._storyComponent:GetComponentCfgId(self._campaign._id, self._storyComponentInfo.m_component_id)
  local cfg_component_story = Cfg.cfg_component_story[componentId]
  if not cfg_component_story then
    Log.error("cfg_component_story is nil")
    return
  end
  local storyIdList = cfg_component_story.StoryID
  if storyIdList == nil or table.count(storyIdList) <= 0 then
    Log.error("story list is nil")
  end
  self:ShowDialog("UIStoryController", storyIdList[1], function()
    GameGlobal.TaskManager():StartTask(self.CompleteFinalPlot, self, storyIdList[1])
  end)
end

function UIN6MainController_Review:CompleteFinalPlot(TT, storyId)
  self:Lock("UIN6MainController_Review_CompleteFinalPlot")
  local request = AsyncRequestRes:New()
  local rewards = self._storyComponent:HandleStoryTake(TT, request, storyId)
  if request:GetSucc() then
    if rewards and table.count(rewards) > 0 then
      self:ShowRewards(rewards)
    end
  else
    Log.error("CompleteFinalPlot")
  end
  self._finalPlotRed:SetActive(self:IsShowFinalPlotRed())
  self:UnLock("UIN6MainController_Review_CompleteFinalPlot")
end

function UIN6MainController_Review:ShowRewards(rewards)
  local petIdList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if petModule:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    self:ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards)
    end)
    return
  end
  self:ShowDialog("UIGetItemController", rewards)
end

function UIN6MainController_Review:TimeUnLockBtnOnClick()
  self:ShowBuildingLockTips()
end

function UIN6MainController_Review:BuildingLockTipsOnClick()
  self._buildingLockTips:SetActive(false)
end

function UIN6MainController_Review:GetBuildingUnLockTimeStr()
  local seconds = 0
  if self._buildComponentInfo then
    local openTime = self._buildComponentInfo.m_unlock_time
    local nowTime = self._timeModule:GetServerTime() / 1000
    seconds = openTime - nowTime
    if seconds < 0 then
      seconds = 0
    end
  end
  local timeStr = ""
  if 86400 <= seconds then
    local day = math.ceil(seconds / 3600 / 24)
    timeStr = StringTable.Get("str_n_plus_six_day", day)
  elseif 3600 <= seconds then
    local hour = math.ceil(seconds / 3600)
    timeStr = StringTable.Get("str_n_plus_six_hour", hour)
  else
    local minus = math.ceil(seconds / 60)
    if minus <= 0 then
      minus = 1
    end
    timeStr = StringTable.Get("str_n_plus_six_minus", minus)
  end
  return timeStr
end

function UIN6MainController_Review:ShowBuildingLockTips()
  self._buildingLockTips:SetActive(true)
  local seconds = 0
  if self._buildComponentInfo then
    local openTime = self._buildComponentInfo.m_unlock_time
    local nowTime = self._timeModule:GetServerTime() / 1000
    seconds = openTime - nowTime
    if seconds < 0 then
      seconds = 0
    end
  end
  local timeStr = ""
  if 86400 <= seconds then
    local day = math.ceil(seconds / 3600 / 24)
    timeStr = StringTable.Get("str_n_plus_six_day", day)
  elseif 3600 <= seconds then
    local hour = math.ceil(seconds / 3600)
    timeStr = StringTable.Get("str_n_plus_six_hour", hour)
  else
    local minus = math.ceil(seconds / 60)
    if minus <= 0 then
      minus = 1
    end
    timeStr = StringTable.Get("str_n_plus_six_minus", minus)
  end
  self._buildingLockTipsLabel.text = StringTable.Get("str_n_plus_six_unlock_rebuilding_time_tips", timeStr)
end

function UIN6MainController_Review:ShowBtnOnClick()
  local topBtn = self:GetGameObject("TopBtn")
  topBtn:SetActive(true)
  self._showBtn:SetActive(false)
  local anim = self:GetUIComponent("Animation", "Anim")
  anim:Play("uieff_N6_Main_Show")
end

function UIN6MainController_Review:HideBtnOnClick()
  local topBtn = self:GetGameObject("TopBtn")
  topBtn:SetActive(false)
  self._showBtn:SetActive(true)
  local anim = self:GetUIComponent("Animation", "Anim")
  anim:Play("uieff_N6_Main_Hide")
end

function UIN6MainController_Review:OnComponentStepChange(campaign_id, component_id, component_step)
end
