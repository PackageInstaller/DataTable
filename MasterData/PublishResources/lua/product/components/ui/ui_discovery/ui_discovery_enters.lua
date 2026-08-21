_class("UIDiscoveryEnters", UICustomWidget)
UIDiscoveryEnters = UIDiscoveryEnters

function UIDiscoveryEnters:Constructor()
  self._data = nil
  self._scaleMax = nil
  self._uiCanvasGroup = nil
  self._strLockBtnResEctypeOnClick = "btnResEctypeOnClick"
  self._loginModule = GameGlobal.GetModule(LoginModule)
end

function UIDiscoveryEnters:OnShow()
  self._animTime = 1
  self._txtLockColor = Color(0.6549019607843137, 0.6549019607843137, 0.6549019607843137, 1)
  self._txtColor = Color(1, 1, 1, 1)
  self._atlas = self:GetAsset("UIDiscovery.spriteatlas", LoadType.SpriteAtlas)
  self._imgRedPetStory = self:GetGameObject("imgRedPetStory")
  self._imgRedWorldBoss = self:GetGameObject("imgRedWorldBoss")
  self._towerRedPoint = self:GetGameObject("TowerRedPoint")
  self._eliminateRedPoint = self:GetGameObject("eliminateRedPoint")
  self._imgSailingRedPoint = self:GetGameObject("sailingRedPoint")
  self._imgRedPetStory:SetActive(false)
  self._imgRedWorldBoss:SetActive(false)
  self._towerRedPoint:SetActive(false)
  self._imgSailingRedPoint:SetActive(false)
  self._eliminateRedPoint:SetActive(false)
  self:ShowBtns()
  self:AttachEvent(GameEventType.CloseResInstance, self.CloseResInstance)
  self:AttachEvent(GameEventType.GuideUnLock, self.PlayUnlockAnim)
  self:AttachEvent(GameEventType.ModuleUnlocked, self.OnModuleUnlocked)
end

function UIDiscoveryEnters:OnHide()
  self:UnLock(self._strLockBtnResEctypeOnClick)
  self:DetachEvent(GameEventType.CloseResInstance, self.CloseResInstance)
  self:DetachEvent(GameEventType.GuideUnLock, self.PlayUnlockAnim)
end

function UIDiscoveryEnters:Flush(data, scaleMax, uiCanvasGroup, latestCampObj)
  self._data = data
  self._scaleMax = scaleMax
  self._uiCanvasGroup = uiCanvasGroup
  self._latestCampObj = latestCampObj
  self:FlushRedExtMission()
  self:_RefreshFunctionActive()
  self:_CheckWorldBossRed()
  self:_CheckSailingMissionRed()
end

function UIDiscoveryEnters:ShowBtns()
  self._unLockData = {}
  self:ResBtn()
  self:MazeBtn()
  self:ExtraBtn()
  self:TowerBtn()
  self:WorldBtn()
  self:SailingBtn()
  self:EliminateBtn()
end

function UIDiscoveryEnters:ResBtn()
  self._resImg = self:GetUIComponent("Image", "resImg")
  self._resTxt = self:GetUIComponent("UILocalizationText", "resTxt")
  local go = self:GetGameObject("resImgLock")
  local img = self:GetUIComponent("Image", "resImgLock")
  local tex = self._resTxt
  local data = UIDiscoveryEnterUnlockClsBase:New(GameModuleID.MD_ResDungeon, go, tex, img)
  local isLock = not data:IsUnlock()
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei01"
    txtColor = self._txtLockColor
  else
    sprite = "map_ditu_icon4"
    txtColor = self._txtColor
  end
  self._resImg.sprite = self._atlas:GetSprite(sprite)
  self._resTxt.color = txtColor
  self._unLockData[GameModuleID.MD_ResDungeon] = data
end

function UIDiscoveryEnters:MazeBtn()
  self._mazeImg = self:GetUIComponent("Image", "mazeImg")
  self._mazeTxt = self:GetUIComponent("UILocalizationText", "mazeTxt")
  local go = self:GetGameObject("mazeImgLock")
  local img = self:GetUIComponent("Image", "mazeImgLock")
  local tex = self._mazeTxt
  local data = UIDiscoveryEnterUnlockClsBase:New(GameModuleID.MD_Maze, go, tex, img)
  local isLock = not data:IsUnlock()
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei05"
    txtColor = self._txtLockColor
  else
    sprite = "map_ditu_icon3"
    txtColor = self._txtColor
  end
  self._mazeImg.sprite = self._atlas:GetSprite(sprite)
  self._mazeTxt.color = txtColor
  self._unLockData[GameModuleID.MD_Maze] = data
end

function UIDiscoveryEnters:ExtraBtn()
  self._extraImg = self:GetUIComponent("Image", "extraImg")
  self._extTxt = self:GetUIComponent("UILocalizationText", "extTxt")
  local go = self:GetGameObject("extraImgLock")
  local img = self:GetUIComponent("Image", "extraImgLock")
  local tex = self._extTxt
  local data = UIDiscoveryEnterUnlockClsExtra:New(nil, go, tex, img)
  local isLock = not data:IsUnlock()
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei07"
    txtColor = self._txtLockColor
  else
    sprite = "map_ditu_icon10"
    txtColor = self._txtColor
  end
  self._extraImg.sprite = self._atlas:GetSprite(sprite)
  self._extTxt.color = txtColor
  self._unLockData[GameModuleID.MD_ExtMission] = data
  self._unLockData[GameModuleID.MD_CAMPAIGNREVIEW] = data
end

function UIDiscoveryEnters:TowerBtn()
  self._towerImg = self:GetUIComponent("Image", "towerImg")
  self._towerTxt = self:GetUIComponent("UILocalizationText", "towerTxt")
  local go = self:GetGameObject("towerImgLock")
  local img = self:GetUIComponent("Image", "towerImgLock")
  local tex = self._towerTxt
  local data = UIDiscoveryEnterUnlockClsBase:New(GameModuleID.MD_Tower, go, tex, img)
  local questModule = self:GetModule(QuestModule)
  local showRedPoint = false
  local allQuests = questModule:GetQuestByQuestType(QuestType.QT_Tower)
  if allQuests then
    for _, quest in pairs(allQuests) do
      local questInfo = quest:QuestInfo()
      if questInfo.status == QuestStatus.QUEST_Completed then
        showRedPoint = true
        break
      end
    end
  end
  self._towerRedPoint:SetActive(showRedPoint)
  local isLock = not data:IsUnlock()
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei03"
    txtColor = self._txtLockColor
  else
    sprite = "map_ditu_icon8"
    txtColor = self._txtColor
  end
  self._towerImg.sprite = self._atlas:GetSprite(sprite)
  self._towerTxt.color = txtColor
  self._unLockData[GameModuleID.MD_Tower] = data
end

function UIDiscoveryEnters:WorldBtn()
  self._worldImg = self:GetUIComponent("Image", "worldImg")
  self._worldTxt = self:GetUIComponent("UILocalizationText", "worldTxt")
  local worldBossModule = self:GetModule(WorldBossModule)
  local str = ""
  if not worldBossModule:AwardMultiOpen() or not isLock then
  end
  self._awardMulti = self:GetUIComponent("UILocalizationText", "AwardMulti")
  self._awardMulti:SetText(str)
  local go = self:GetGameObject("worldImgLock")
  local img = self:GetUIComponent("Image", "worldImgLock")
  local tex = self._worldTxt
  local data = UIDiscoveryEnterUnlockClsBase:New(GameModuleID.MD_WorldBoss, go, tex, img)
  local isLock = not data:IsUnlock()
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei06"
    txtColor = self._txtLockColor
  else
    sprite = "world_tiaozhan_icon7"
    txtColor = self._txtColor
  end
  self._worldImg.sprite = self._atlas:GetSprite(sprite)
  self._worldTxt.color = txtColor
  self._unLockData[GameModuleID.MD_WorldBoss] = data
end

function UIDiscoveryEnters:SailingBtn()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local unlock = roleModule:CheckModuleUnlock(GameModuleID.MD_SAILINGMISSION)
  local imgSailingTr = self:GetUIComponent("RectTransform", "sailingImg")
  imgSailingTr.gameObject:SetActive(unlock)
  local imgSailingLockTr = self:GetUIComponent("RectTransform", "sailingImgLock")
  imgSailingLockTr.gameObject:SetActive(not unlock)
  local txtSailingTxt = self:GetUIComponent("UILocalizationText", "sailingTxt")
  if unlock then
    txtSailingTxt.color = self._txtColor
  else
    txtSailingTxt.color = self._txtLockColor
  end
end

function UIDiscoveryEnters:btnPetStoryOnClick(go)
  local data = self._unLockData[GameModuleID.MD_ExtMission]
  if not data:IsUnlock() then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_fanwaijuben_tips"))
    return
  end
  self:SwitchState(UIStateType.UIExtraSelect)
end

function UIDiscoveryEnters:EliminateBtn()
  self._eliminateImg = self:GetUIComponent("Image", "eliminateImg")
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_ANIPOP)
  local sprite, txtColor
  if isLock then
    sprite = "map_ditu_hei09"
    txtColor = self._txtLockColor
  else
    self._eliminateRedPoint:SetActive(EliminateHelper.CheckAwardRed())
    sprite = "map_ditu_icon12"
    txtColor = self._txtColor
  end
  self._eliminateImg.sprite = self._atlas:GetSprite(sprite)
  self._eliminateTxt = self:GetUIComponent("UILocalizationText", "eliminateTxt")
  self._eliminateTxt.color = txtColor
  local go = self:GetGameObject("eliminateImgLock")
  local img = self:GetUIComponent("Image", "eliminateImgLock")
  local tex = self._eliminateTxt
  local data = {}
  data.go = go
  data.img = img
  data.tex = tex
  self._unLockData[GameModuleID.MD_ANIPOP] = data
end

function UIDiscoveryEnters:btnFairyLandOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {"FairyLand"}, true)
  local data = self._unLockData[GameModuleID.MD_Maze]
  if not data:IsUnlock() then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_mijingtansuo_tips"))
    return
  end
  self:CloseUIStage()
  self:ShowDialog("UIMazeEnter")
end

function UIDiscoveryEnters:CloseUIStage()
  if GameGlobal.UIStateManager():IsShow("UIStage") then
    GameGlobal.UIStateManager():CloseDialog("UIStage")
  end
end

function UIDiscoveryEnters:btnResEctypeOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {"ResEctype"}, true)
  local data = self._unLockData[GameModuleID.MD_ResDungeon]
  if not data:IsUnlock() then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_ziyuanben_tips"))
    return
  end
  self:CloseUIStage()
  self:StartTask(function(TT)
    local resDungeonModule = self:GetModule(ResDungeonModule)
    local result = resDungeonModule:GetOpenStatus(TT)
    if result ~= {} then
      self:Lock(self._strLockBtnResEctypeOnClick)
      local duration = 0.5
      self.openResScale = self._data.mapScale
      self:TglShowHideOnClick()
      self._uiCanvasGroup:DOFade(0, duration)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryCameraMove, Vector2(0, 0), 0.3, 0.394, function()
      end, nil, true, true)
      YIELD(TT, duration * 500)
      self:UnLock(self._strLockBtnResEctypeOnClick)
      self:ShowDialog("UIResEntryController")
    end
  end, self)
end

function UIDiscoveryEnters:TglShowHideOnClick()
  self:FlushRedExtMission()
end

function UIDiscoveryEnters:CloseResInstance()
  self._uiCanvasGroup.alpha = 1
  local node = self._data:GetCurPosNode()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryCameraMove, node.pos, 1, self.openResScale)
  self:TglShowHideOnClick()
end

function UIDiscoveryEnters:btnTowerOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {"Tower"}, true)
  local module = GameGlobal.GetModule(RoleModule)
  local data = self._unLockData[GameModuleID.MD_Tower]
  if not data:IsUnlock() then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_jianta_tips"))
    return
  end
  self:SwitchState(UIStateType.UITower)
end

function UIDiscoveryEnters:btnActivityEntryOnClick(go)
  if self._activityEntryFunc then
    self._activityEntryFunc()
  end
end

function UIDiscoveryEnters:FlushRedExtMission()
  local petStoryModule = self:GetModule(ExtMissionModule)
  local awardRed = petStoryModule:UI_IsExtAwardRed()
  local newChapter = petStoryModule:UI_IsExtNewChapter()
  local isRedPetStory = newChapter or awardRed
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  local reviewData = uiModule:GetReviewData()
  local isRedReview = not reviewData:IsLocked() and (reviewData:HasCollectableItem() or reviewData:HasUnlockableItem())
  self._imgRedPetStory:SetActive(isRedPetStory or isRedReview)
end

function UIDiscoveryEnters:_CheckWorldBossRed()
  self:Lock("UIDiscoveryEnters:_CheckWorldBossRed")
  GameGlobal.TaskManager():StartTask(self._OnCheckWorldBossRed, self)
end

function UIDiscoveryEnters:_OnCheckWorldBossRed(TT)
  local worldBossModule = self:GetModule(WorldBossModule)
  if worldBossModule:CurSeasonEnd() then
    self._imgRedWorldBoss:SetActive(false)
    self:UnLock("UIDiscoveryEnters:_CheckWorldBossRed")
    return
  end
  local missionId = worldBossModule.m_world_boss_data.boss_mission_id
  local recordMissionId = LocalDB.GetInt("UIWorldBossMissionId" .. self._loginModule:GetRoleShowID(), 0)
  local redPointData = worldBossModule:GetWorldBossRedPoint()
  local show = redPointData:MainLobbyHaveRedPoint()
  show = show or missionId ~= recordMissionId
  show = show or worldBossModule:QuestHaveRedPoint()
  self._imgRedWorldBoss:SetActive(show)
  self:UnLock("UIDiscoveryEnters:_CheckWorldBossRed")
end

function UIDiscoveryEnters:_RefreshFunctionActive()
  local btn = self:GetGameObject("btnActivityEntry")
  btn:SetActive(false)
  if self._latestCampObj then
    local sampleInfo = self._latestCampObj:GetSampleInfo()
    local campConfig = Cfg.cfg_campaign[sampleInfo.id]
    if campConfig and campConfig.EntranceIcon2 then
      function self._activityEntryFunc()
        local campaign = UIActivityCampaign:New()
        
        campaign._id = sampleInfo.id
        UIActivityHelper.PlayFirstPlot_Campaign(campaign, function()
          if self:_IsSwitchStateWithCutscene(sampleInfo.camp_type) then
            CutsceneManager.ExcuteCutsceneIn(campConfig.MainUI, function()
              self:SwitchState(campConfig.MainUI, true)
            end)
          elseif self:_IsSwitchStateWithCacheRT(sampleInfo.camp_type) then
            self:_GetRenderTexture(function(cache_rt)
              self:SwitchState(campConfig.MainUI, cache_rt, true)
            end)
          else
            self:SwitchState(campConfig.MainUI, true)
          end
        end)
      end
      
      local img = self:GetUIComponent("RawImageLoader", "imgCampaign")
      img:LoadImage(campConfig.EntranceIcon2)
      local iconSize = campConfig.EntranceIcon2Size
      if iconSize then
        local layout = self:GetUIComponent("LayoutElement", "btnActivityEntry")
        layout.preferredWidth = iconSize[1]
        layout.preferredHeight = iconSize[2]
        img.transform.sizeDelta = Vector2(iconSize[3], iconSize[4])
      end
      btn:SetActive(true)
    elseif not campConfig then
      Log.fatal("[Campaign] can't find campaign config by id:", sampleInfo.id)
    end
  end
end

function UIDiscoveryEnters:_IsSwitchStateWithCacheRT(campType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_SUMMER_I] = true,
    [ECampaignType.CAMPAIGN_TYPE_N8] = true,
    [ECampaignType.CAMPAIGN_TYPE_N9] = true,
    [ECampaignType.CAMPAIGN_TYPE_N11] = true,
    [ECampaignType.CAMPAIGN_TYPE_N12] = true,
    [ECampaignType.CAMPAIGN_TYPE_N13] = true,
    [ECampaignType.CAMPAIGN_TYPE_N17] = true,
    [ECampaignType.CAMPAIGN_TYPE_N18] = true,
    [ECampaignType.CAMPAIGN_TYPE_INLAND_N12] = true,
    [ECampaignType.CAMPAIGN_TYPE_MAIN_MISSION] = true,
    [ECampaignType.CAMPAIGN_TYPE_N43] = true
  }
  return tb[campType]
end

function UIDiscoveryEnters:_IsSwitchStateWithCutscene(campType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_N7] = true,
    [ECampaignType.CAMPAIGN_TYPE_N16] = true,
    [ECampaignType.CAMPAIGN_TYPE_N26] = true
  }
  return tb[campType]
end

function UIDiscoveryEnters:_GetRenderTexture(callback)
  local uiDiscovery = self:RootUIOwner()
  local shot = uiDiscovery._shot
  shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(uiDiscovery:GetName())
  local rt = shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    if callback then
      callback(cache_rt)
    end
  end)
end

function UIDiscoveryEnters:PlayUnlockAnim(functionId, type)
  local data = self._unLockData[functionId]
  if data then
    if type == 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
    elseif data:IsUnlock() then
      self:Lock("PlayUnLockAnim")
      self:PlayViewUnlock(data, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.UnLock)
        self:UnLock("PlayUnLockAnim")
      end)
    end
  end
end

function UIDiscoveryEnters:PlayViewUnlock(data, endCallBack)
  local go = data:GameObject()
  local tex = data:Text()
  tex.color = self._txtLockColor
  go:SetActive(true)
  local img = data:Image()
  img.color = Color(1, 1, 1, 1)
  self:StartTask(function(TT)
    if not GameGlobal.UIStateManager():IsShow("UIDiscoveryUnlock") then
      self:ShowDialog("UIDiscoveryUnlock")
    end
    YIELD(TT, UIConst.UIDiscoveryUnlockShowTime)
    GameGlobal.UIStateManager():CloseDialog("UIDiscoveryUnlock")
    img:DOColor(Color(1, 1, 1, 0), self._animTime)
    tex:DOColor(self._txtColor, self._animTime):OnComplete(function()
      go:SetActive(false)
      if endCallBack then
        endCallBack()
      end
    end)
  end, self)
end

function UIDiscoveryEnters:OnModuleUnlocked(functionId)
  if functionId == GameModuleID.MD_SAILINGMISSION then
    self:SailingBtn()
    self:_CheckSailingMissionRed()
  end
end

function UIDiscoveryEnters:btnWorldBossOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {"WorldBoss"}, true)
  local data = self._unLockData[GameModuleID.MD_WorldBoss]
  if not data:IsUnlock() then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_worldboss_tips"))
    return
  end
  self:_SwitchWorldBoss()
end

function UIDiscoveryEnters:_SwitchWorldBoss()
  local screenShot = self:RootUIOwner():GetScreenShotView()
  screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera("UIDiscovery")
  local rt = screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self:SwitchState(UIStateType.UIWorldBoss, cache_rt)
  end)
end

function UIDiscoveryEnters:_CheckSailingMissionRed()
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:CheckModuleUnlock(GameModuleID.MD_SAILINGMISSION) then
    return
  end
  
  local function fnChkRed()
    local sailingModule = self:GetModule(SailingMissionModule)
    local showRetPoint = sailingModule:IsShowRewardRedPoint()
    local firstUnlock = LocalDB.GetInt(UISailing:EnterKey(), 0) == 0
    self._imgSailingRedPoint:SetActive(showRetPoint or firstUnlock)
  end
  
  GameGlobal.TaskManager():StartTask(self.HandleGetSailingMissionData, self, fnChkRed)
end

function UIDiscoveryEnters:btnSailingMissionOnClick(go)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:CheckModuleUnlock(GameModuleID.MD_SAILINGMISSION) then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_sailing_mission_tips"))
    return
  end
  LocalDB.SetInt(UISailing:EnterKey(), 1)
  self:SwitchState(UIStateType.UISailingMain)
end

function UIDiscoveryEnters:HandleGetSailingMissionData(TT, callback)
  self:Lock("UISailing_GetSailingMissionData")
  local sailingModule = self:GetModule(SailingMissionModule)
  local asyncRes = sailingModule:HandleGetSailingMissionData(TT)
  local replyResult = asyncRes:GetResult()
  if replyResult == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS and callback then
    callback()
  end
  self:UnLock("UISailing_GetSailingMissionData")
end

function UIDiscoveryEnters:BtnEliminateOnClick()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_ANIPOP)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_qidihulian_tips"))
    return
  end
  self:SwitchState(UIStateType.UIEliminateController)
end
