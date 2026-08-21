_class("UIActivityN20MainController", UIController)
UIActivityN20MainController = UIActivityN20MainController

function UIActivityN20MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._activityConst = UIActivityN20Const:New()
  self._activityConst:LoadData(TT, res)
end

function UIActivityN20MainController:OnShow()
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceRefresh)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.ForceRefresh)
  self:AttachEvent(GameEventType.N20RefreshRedAndNew, self.ForceRefresh)
  self:AttachEvent(GameEventType.N20RefreshShopBtnStatus, self.ForceRefresh)
  self._topBtn = self:GetGameObject("TopBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false, function()
    self:SetUIActivity(false)
  end)
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._lineLevelRed = self:GetGameObject("LineLevelRed")
  self._lineLevelNew = self:GetGameObject("LineLevelNew")
  self._avgRed = self:GetGameObject("AVGRed")
  self._avgNew = self:GetGameObject("AVGNew")
  self._hardLevelRed = self:GetGameObject("HardLevelRed")
  self._hardLevelNew = self:GetGameObject("HardLevelNew")
  self._gameRed = self:GetGameObject("GameRed")
  self._gameNew = self:GetGameObject("GameNew")
  self._loginRed = self:GetGameObject("LoginRed")
  self._shopRed = self:GetGameObject("ShopRed")
  self._eventRed = self:GetGameObject("EventRed")
  self._lineLevelLock = self:GetGameObject("LineLevelLock")
  self._lineLevelLockTips = self:GetUIComponent("UILocalizationText", "LineLevelLockTips")
  self._lineLevelImg = self:GetUIComponent("Image", "LineLevel")
  self._lineLevelIcon = self:GetUIComponent("RawImage", "LineLevelIcon")
  self._hardLevelLock = self:GetGameObject("HardLevelLock")
  self._hardLevelLockTips = self:GetUIComponent("RollingText", "HardLevelLockTips")
  self._hardLevelLockTipsText = self:GetUIComponent("UILocalizationText", "HardLevelLockTips")
  self._hardLevelImg = self:GetUIComponent("Image", "HardLevel")
  self._hardLevelIcon = self:GetUIComponent("RawImage", "HardLevelIcon")
  self._AVGLock = self:GetGameObject("AVGLock")
  self._AVGLockTips = self:GetUIComponent("RollingText", "AVGLockTips")
  self._AVGLockTipsText = self:GetUIComponent("UILocalizationText", "AVGLockTips")
  self._AVGImg = self:GetUIComponent("Image", "AVG")
  self._AVGIconIcon = self:GetUIComponent("RawImage", "AVGIcon")
  self._gameLock = self:GetGameObject("GameLock")
  self._gameLockTips = self:GetUIComponent("UILocalizationText", "GameLockTips")
  self._gameImg = self:GetUIComponent("Image", "Game")
  self._gameIcon = self:GetUIComponent("RawImage", "GameIcon")
  self._shopIconLoader = self:GetUIComponent("RawImageLoader", "ShopIcon")
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._gameMask = self:GetGameObject("GameMask")
  self._lineLevelMask = self:GetGameObject("LineLevelMask")
  self._hardLevelMask = self:GetGameObject("HardLevelMask")
  self._AVGMask = self:GetGameObject("AVGMask")
  self._shopMask = self:GetGameObject("ShopMask")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._isLoadData = false
  self._avgHasLoadedData = false
  self._miniGameHasLoadedData = false
  self._normalLevelHasLoadedData = false
  self._hardLevelHasLoadedData = false
  self:InitUI()
  self._activityConst:ClearMainEntryNew()
end

function UIActivityN20MainController:OnHide()
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceRefresh)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.ForceRefresh)
  self:DetachEvent(GameEventType.N20RefreshRedAndNew, self.ForceRefresh)
  self:DetachEvent(GameEventType.N20RefreshShopBtnStatus, self.ForceRefresh)
  if self._guideTask then
    GameGlobal.TaskManager():KillTask(self._guideTask)
    self._guideTask = nil
  end
end

function UIActivityN20MainController:OnUpdate(deltaTimeMS)
  if self._isLoadData then
    return
  end
  self:RefreshUI()
end

function UIActivityN20MainController:InitUI()
  self._gameMask:SetActive(self._activityConst:IsMiniGameEnable())
  self._lineLevelMask:SetActive(self._activityConst:IsNormalMissionEnable())
  self._hardLevelMask:SetActive(self._activityConst:IsHardMissionEnable())
  self._AVGMask:SetActive(self._activityConst:IsAVGEnable())
  self._shopMask:SetActive(self._activityConst:IsShopEnable())
  self:RefreshShopBtnStatus()
  self:RefreshRedAnNew()
  self:RefreshUI()
  self:_CheckGuide()
end

function UIActivityN20MainController:RefreshUI()
  self:RefreshActivityRemainTime()
  self:RefreshBtnStatus()
end

function UIActivityN20MainController:ForceRefresh()
  self:StartTask(self.ReloadData, self)
end

function UIActivityN20MainController:ReloadData(TT)
  self:Lock("UIActivityN20MainController_ReloadData")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:RefreshShopBtnStatus()
  self:RefreshRedAnNew()
  self:UnLock("UIActivityN20MainController_ReloadData")
end

function UIActivityN20MainController:RefreshShopBtnStatus()
  local shopCom, _ = self._activityConst:GetShopComponent()
  local icon, count = shopCom:GetCostItemIconText()
  self._shopIconLoader:LoadImage(icon)
  self._shopCountLabel:SetText(UIActivityN20MainController.GetItemCountStr(count, "#8D8D8D", "#ffd146"))
end

function UIActivityN20MainController.GetItemCountStr(count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIActivityN20MainController:RefreshBtnStatus()
  if self._activityConst:IsNormalMissionEnable() then
    self._lineLevelLock:SetActive(false)
    self._lineLevelImg.color = Color(1.0, 1.0, 1.0, 1)
    self._lineLevelIcon.color = Color(1.0, 1.0, 1.0, 1)
  else
    self._lineLevelImg.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._lineLevelIcon.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._lineLevelLock:SetActive(true)
    local tips = ""
    if self._activityConst:IsNormalMissionClose() then
      tips = StringTable.Get("str_n20_activity_end")
    else
      tips = self:GetNormalLevelOpenRemainTimeStr()
    end
    self._lineLevelLockTips:SetText(tips)
  end
  if self._activityConst:IsHardMissionEnable() then
    self._hardLevelLock:SetActive(false)
    self._hardLevelImg.color = Color(1.0, 1.0, 1.0, 1)
    self._hardLevelIcon.color = Color(1.0, 1.0, 1.0, 1)
  else
    self._hardLevelImg.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._hardLevelIcon.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._hardLevelLock:SetActive(true)
    local tips = ""
    if self._activityConst:IsHardMissionClose() then
      tips = StringTable.Get("str_n20_activity_end")
    elseif self._activityConst:IsHardMissionTimeOpen() then
      if self:HardLevelLoadData() then
        tips = ""
      else
        tips = StringTable.Get("str_n20_hard_level_open_need_level")
      end
    else
      tips = self:GetHardLevelOpenRemainTimeStr()
    end
    if self._hardLevelLockTipsText.text ~= tips then
      self._hardLevelLockTips:RefreshText(tips)
    end
  end
  if self._activityConst:IsAVGEnable() then
    self._AVGLock:SetActive(false)
    self._AVGImg.color = Color(1.0, 1.0, 1.0, 1)
    self._AVGIconIcon.color = Color(1.0, 1.0, 1.0, 1)
  else
    self._AVGImg.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._AVGIconIcon.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._AVGLock:SetActive(true)
    local tips = ""
    if self._activityConst:IsAVGClose() then
      tips = StringTable.Get("str_n20_activity_end")
    elseif self._activityConst:IsAVGTimeOpen() then
      if self:AvgLoadData() then
        tips = ""
      else
        tips = StringTable.Get("str_n20_avg_open_need_level")
      end
    else
      tips = self:GetAVGOpenRemainTimeStr()
    end
    if self._AVGLockTipsText.text ~= tips then
      self._AVGLockTips:RefreshText(tips)
    end
  end
  if self._activityConst:IsMiniGameEnable() then
    self._gameLock:SetActive(false)
    self._gameImg.color = Color(1.0, 1.0, 1.0, 1)
    self._gameIcon.color = Color(1.0, 1.0, 1.0, 1)
  else
    self._gameImg.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._gameIcon.color = Color(0.41568627450980394, 0.41568627450980394, 0.41568627450980394, 1)
    self._gameLock:SetActive(true)
    local tips = ""
    if self._activityConst:IsMiniGameClose() then
      tips = StringTable.Get("str_n20_activity_end")
    else
      tips = self:GetMiniGameOpenRemainTimeStr()
    end
    self._gameLockTips:SetText(tips)
  end
end

function UIActivityN20MainController:TimeOutRequest()
  self:StartTask(self.TimeOutRequestCoro, self)
end

function UIActivityN20MainController:TimeOutRequestCoro(TT)
  self._isLoadData = true
  self:ReloadData(TT)
  self._isLoadData = false
end

function UIActivityN20MainController:AvgLoadData()
  if self._avgHasLoadedData then
    return false
  end
  self._avgHasLoadedData = true
  self:TimeOutRequest()
  return true
end

function UIActivityN20MainController:MiniGameLoadData()
  if self._miniGameHasLoadedData then
    return false
  end
  self._miniGameHasLoadedData = true
  self:TimeOutRequest()
  return true
end

function UIActivityN20MainController:NormalLevelLoadData()
  if self._normalLevelHasLoadedData then
    return false
  end
  self._normalLevelHasLoadedData = true
  self:TimeOutRequest()
  return true
end

function UIActivityN20MainController:HardLevelLoadData()
  if self._hardLevelHasLoadedData then
    return false
  end
  self._hardLevelHasLoadedData = true
  self:TimeOutRequest()
  return true
end

function UIActivityN20MainController:GetNormalLevelOpenRemainTimeStr()
  local endTime = self._activityConst:GetNormalMissionOpenTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
    self:NormalLevelLoadData()
  end
  return self._activityConst:GetTimeString(seconds)
end

function UIActivityN20MainController:GetHardLevelOpenRemainTimeStr()
  local endTime = self._activityConst:GetHardMissionOpenTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
    self:HardLevelLoadData()
  end
  return self._activityConst:GetTimeString(seconds)
end

function UIActivityN20MainController:GetAVGOpenRemainTimeStr()
  local endTime = self._activityConst:GetAVGOpenTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
    self:AvgLoadData()
  end
  return self._activityConst:GetTimeString(seconds)
end

function UIActivityN20MainController:GetMiniGameOpenRemainTimeStr()
  local endTime = self._activityConst:GetMiniGameOpenTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
    self:MiniGameLoadData()
  end
  return self._activityConst:GetTimeString(seconds)
end

function UIActivityN20MainController:RefreshActivityRemainTime()
  local endTime = self._activityConst:GetEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n20_activity_end"))
    return
  end
  local status = self._activityConst:GetStatus()
  if seconds == 0 and status == 1 then
    endTime = self._activityConst:GetActiveEndTime()
    self._activityConst:SetStatus(2)
    return
  end
  local timeStr = self._activityConst:GetTimeString(seconds)
  local timeTips = ""
  local status = self._activityConst:GetStatus()
  if status == 1 then
    timeTips = StringTable.Get("str_n20_activity_remain_time1", timeStr)
  elseif status == 2 then
    timeTips = StringTable.Get("str_n20_activity_remain_time2", timeStr)
  end
  self._timeLabel:SetText(timeTips)
end

function UIActivityN20MainController:Close()
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN20MainController:CloseCoro(TT)
  self:Lock("UIActivityN20MainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN20MainController_CloseCoro")
end

function UIActivityN20MainController:SetUIActivity(status)
  if status then
    self._anim:Play("uieffanim_N20MainController_in_02")
  else
    self._anim:Play("uieffanim_N20MainController_out")
  end
  self._showBtn:SetActive(not status)
  self._topBtn:SetActive(status)
end

function UIActivityN20MainController:RefreshRedAnNew()
  self:RefreshNormalLineMissionRedAndNew()
  self:RefreshHardLineMissionRedAndNew()
  self:RefreshAVGRedAndNew()
  self:RefreshMiniGameRedAndNew()
  self:RefreshLoginRedAndNew()
  self:RefreshShopRedAndNew()
  self:RefreshEventRedAndNew()
end

function UIActivityN20MainController:RefreshNormalLineMissionRedAndNew()
  if self._activityConst:IsShowNormalMissionNew() then
    self._lineLevelRed:SetActive(false)
    self._lineLevelNew:SetActive(true)
    return
  end
  if self._activityConst:IsShowNormalMissionRed() then
    self._lineLevelRed:SetActive(true)
    self._lineLevelNew:SetActive(false)
    return
  end
  self._lineLevelRed:SetActive(false)
  self._lineLevelNew:SetActive(false)
end

function UIActivityN20MainController:RefreshHardLineMissionRedAndNew()
  if self._activityConst:IsShowHardMissionNew() then
    self._hardLevelRed:SetActive(false)
    self._hardLevelNew:SetActive(true)
    return
  end
  if self._activityConst:IsShowHardMissionRed() then
    self._hardLevelRed:SetActive(true)
    self._hardLevelNew:SetActive(false)
    return
  end
  self._hardLevelRed:SetActive(false)
  self._hardLevelNew:SetActive(false)
end

function UIActivityN20MainController:RefreshAVGRedAndNew()
  if self._activityConst:IsShowAVGNew() then
    self._avgRed:SetActive(false)
    self._avgNew:SetActive(true)
    return
  end
  if self._activityConst:IsShowAVGRed() then
    self._avgRed:SetActive(true)
    self._avgNew:SetActive(false)
    return
  end
  self._avgRed:SetActive(false)
  self._avgNew:SetActive(false)
end

function UIActivityN20MainController:RefreshMiniGameRedAndNew()
  if self._activityConst:IsShowMiniGameNew() then
    self._gameRed:SetActive(false)
    self._gameNew:SetActive(true)
    return
  end
  if self._activityConst:IsShowMiniGameRed() then
    self._gameRed:SetActive(true)
    self._gameNew:SetActive(false)
    return
  end
  self._gameRed:SetActive(false)
  self._gameNew:SetActive(false)
end

function UIActivityN20MainController:RefreshLoginRedAndNew()
  if self._activityConst:IsShowLoginRed() then
    self._loginRed:SetActive(true)
    return
  end
  self._loginRed:SetActive(false)
end

function UIActivityN20MainController:RefreshShopRedAndNew()
  if self._activityConst:IsShowShopNew() then
    self._shopRed:SetActive(true)
    return
  end
  self._shopRed:SetActive(false)
end

function UIActivityN20MainController:RefreshEventRedAndNew()
  if self._activityConst:IsShowEventRed() then
    self._eventRed:SetActive(true)
    return
  end
  self._eventRed:SetActive(false)
end

function UIActivityN20MainController:ShowBtnOnClick()
  self:SetUIActivity(true)
end

function UIActivityN20MainController:InfoBtnOnClick()
  self:ShowDialog("UIActivityN20Intro", "UIActivityN20MainController")
end

function UIActivityN20MainController:LineLevelOnClick()
  if not self._activityConst:IsNormalMissionEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    return
  end
  self._activityConst:ClearNormalMissionNew()
  self:RefreshNormalLineMissionRedAndNew()
  self:ShowDialog("UIActivityN20NormalLevel", true)
end

function UIActivityN20MainController:AVGOnClick()
  if not self._activityConst:IsAVGEnable() then
    if self._activityConst:IsAVGClose() then
      ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    elseif self._activityConst:IsAVGTimeOpen() then
      ToastManager.ShowToast(StringTable.Get("str_n20_avg_open_need_level"))
    else
      ToastManager.ShowToast(StringTable.Get("str_n20_component_opent_tips", self:GetAVGOpenRemainTimeStr()))
    end
    return
  end
  self._activityConst:ClearAVGNew()
  self:RefreshAVGRedAndNew()
  self:SwitchState(UIStateType.UIN20AVGMain)
end

function UIActivityN20MainController:HardLevelOnClick()
  if not self._activityConst:IsHardMissionEnable() then
    if self._activityConst:IsHardMissionClose() then
      ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    elseif self._activityConst:IsHardMissionTimeOpen() then
      ToastManager.ShowToast(StringTable.Get("str_n20_hard_level_open_need_level"))
    else
      ToastManager.ShowToast(StringTable.Get("str_n20_component_opent_tips", self:GetHardLevelOpenRemainTimeStr()))
    end
    return
  end
  self._activityConst:ClearHardMissionNew()
  self:RefreshHardLineMissionRedAndNew()
  self:ShowDialog("UIActivityN20HardLevel", true)
end

function UIActivityN20MainController:GameOnClick()
  if not self._activityConst:IsMiniGameEnable() then
    if self._activityConst:IsMiniGameClose() then
      ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    else
      ToastManager.ShowToast(StringTable.Get("str_n20_component_opent_tips", self:GetMiniGameOpenRemainTimeStr()))
    end
    return
  end
  self._activityConst:ClearMiniGameNew()
  self:RefreshMiniGameRedAndNew()
  self:ShowDialog("UIN20MiniGameStageController")
end

function UIActivityN20MainController:LoginOnClick()
  if not self._activityConst:IsLoginEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N20, ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN)
end

function UIActivityN20MainController:ShopOnClick()
  if not self._activityConst:IsShopEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n20_activity_end"))
    return
  end
  self._activityConst:ClearShopNew()
  self:RefreshShopRedAndNew()
  self:ShowDialog("UIActivityN20Shop")
end

function UIActivityN20MainController:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN20MainController:_CheckGuide()
  self:Lock("UIActivityN20MainController")
  self._guideTask = self:StartTask(function(TT)
    YIELD(TT, 1567)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN20MainController)
    self:UnLock("UIActivityN20MainController")
  end)
end
