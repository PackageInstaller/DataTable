_class("UIS7MainController", UIController)
UIS7MainController = UIS7MainController

function UIS7MainController:Constructor()
  self._isReview = false
  self._canShare = self:GetModule(ShareModule):CanShare()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIS7MainController:_SetRemainingTime(widgetName, extraId, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:GetGameObject():SetActive(endTime ~= nil)
  if endTime == nil then
    return
  end
  obj:SetExtraText(nil, nil, extraId)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function(isFirst)
    if not isFirst then
      self:_Refresh()
    end
  end)
end

function UIS7MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIS7MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIS7Main then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_Shot(function()
      self:_PlayAnim("out", function()
        self:CloseDialog()
        UIBgmHelper.PlayMainBgm()
      end)
    end)
  end
end

function UIS7MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("hide")
end

function UIS7MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("show")
end

function UIS7MainController:_SetBg(phase)
end

function UIS7MainController:_SetSpine()
  local phase = UISeasonPhaseHelper.CheckPhase()
  if phase == self._spinePhase then
    return
  end
  self._spinePhase = phase
  local spineName = UISeasonPhaseHelper.GetPhaseSpine(phase)
  UIWidgetHelper.SetSpineLoad(self, "_spine", spineName)
end

function UIS7MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieffanim_UIS7MainController_in",
      duration = 1800
    },
    out = {
      animName = "uieffanim_UIS7MainController_out",
      duration = 500
    },
    hide = {
      animName = "uieffanim_UIS7MainController_hide",
      duration = 500
    },
    show = {
      animName = "uieffanim_UIS7MainController_show",
      duration = 500
    },
    title = {
      animName = "UIS7MainController_Season_loop"
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
end

function UIS7MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIS7MainController)
end

function UIS7MainController:LoadDataOnEnter(TT, res, uiParams)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local reqRes = self._seasonModule:ForceRequestCurSeasonData(TT)
  self._seasonId = self._seasonModule:GetCurSeasonID()
  if reqRes and not reqRes:GetSucc() then
    self._seasonModule:CheckErrorCode(reqRes.m_result, self._seasonId, nil, nil)
    res:SetSucc(false)
    return
  end
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  uiModule:SetSeasonNew()
  uiModule:ClearBackTrack()
end

function UIS7MainController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_PlayAnim("in", function()
    self:_CheckGuide()
  end)
  self.mazeBtnGo = self:GetGameObject("UISeaonMazeBtnPool")
  self.onceMissionBtnGo = self:GetGameObject("OnceMissionBtn")
  self._thierdBtnNew = self:GetGameObject("ThirdNew")
  local obj = UIWidgetHelper.SpawnObject(self, "Title", "UIS7Title")
  self:_Refresh(true)
  self:_AttachEvents()
end

function UIS7MainController:OnHide()
  self:_DetachEvents()
end

function UIS7MainController:_Refresh(first)
  self._component_quest = self._seasonModule:GetCurSeasonQuestComponent()
  self._component_exchange = self._seasonModule:GetCurSeasonExchangeComponent()
  self._component_action = self._seasonModule:GetCurSeasonActionPointComponent()
  self:_CalcTime()
  self:_SetBtn_Collage(first)
  self:_SetBtn_Exchange(first)
  self:_SetBtn_Medal(first)
  self:_SetBtn_Quest(first)
  self:_SetBtn_Go(first)
  self:_SetBtn_SeasonMaze()
end

function UIS7MainController:RefreshMazeBtnRed()
  local red = self._sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  self.mazeRed:SetActive(red)
end

function UIS7MainController:_CheckMazeOpen()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return false
  end
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  if self._sample == nil then
    return false
  end
  if not self._sample.is_open then
    return false
  end
  return true
end

function UIS7MainController:_CheckOnceMissionOpen()
  local seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
  if seasonUIModule:IsBackTrack() then
    return false
  end
  local onceMissionData = self._seasonModule:GetOnceMissionData()
  local bShow = onceMissionData:AnyComponentOpening()
  local bNew = onceMissionData:HasEntryNew()
  self._thierdBtnNew:SetActive(bNew)
  return bShow
end

function UIS7MainController:_CalcTime()
  local function getActionComponentTime(component)
    local time = 0
    
    local cfg = component and component:GetActionPointConfig()
    if cfg then
      local loginModule = self:GetModule(LoginModule)
      time = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    end
    return time or 0
  end
  
  local function getComponentCloseTime(component)
    return component and component:GetComponentInfo().m_close_time or 0
  end
  
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local time_action = getActionComponentTime(self._component_action)
  local time_exchange = getComponentCloseTime(self._component_exchange)
  local extra, time
  if curTime < time_action then
    extra, time = "str_season_s7_main_time_cd_action", time_action
  elseif curTime < time_exchange then
    extra, time = "str_season_s7_main_time_cd_exchange", time_exchange
  end
  self:_SetRemainingTime("_time", extra, nil, time)
end

function UIS7MainController:_SetBtn_Collage(first)
  local obj = UIWidgetHelper.SpawnObject(self, "CollageBtn", "UIS7CollageBtn")
  obj:SetData(self._seasonId, first)
end

function UIS7MainController:_SetBtn_Exchange(first)
  local obj = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIS7ExchangeBtn")
  obj:SetData(self._seasonId, self._component_exchange, first)
end

function UIS7MainController:_SetBtn_Medal(first)
  local obj = UIWidgetHelper.SpawnObject(self, "MedalBtn", "UIS7MedalBtn")
  obj:SetData(self._seasonId, first)
end

function UIS7MainController:_SetBtn_Quest(first)
  local obj = UIWidgetHelper.SpawnObject(self, "QuestBtn", "UIS7QuestBtn")
  obj:SetData(self._seasonId, self._component_quest, first)
end

function UIS7MainController:_SetBtn_Go(first)
  self.mazeBtnGo:SetActive(self:_CheckMazeOpen())
  self.onceMissionBtnGo:SetActive(self:_CheckOnceMissionOpen())
  local obj = UIWidgetHelper.SpawnObject(self, "GoBtn", "UIS7GoBtn")
  obj:SetData(self._seasonId, self._component_action, first)
end

function UIS7MainController:_SetBtn_SeasonMaze(first)
  local obj = UIWidgetHelper.SpawnObject(self, "UISeaonMazeBtnPool", "UISeaonMazeBtnItem")
  obj:SetData(self._seasonId, self._component_action, first, function()
    self:_Refresh()
  end)
end

function UIS7MainController:_Shot(callback)
  UIWidgetHelper.BlurHelperShot(self, "shot", self:GetName(), function(cache_rt)
    UIWidgetHelper.SetRawImageTexture(self, "rt", cache_rt)
    self:_AfterShot()
    callback()
  end)
end

function UIS7MainController:_AfterShot()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(false)
end

function UIS7MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIS7MainController:StoryBtnOnClick(go)
end

function UIS7MainController:IntroBtnOnClick(go)
  UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.S1Main)
end

function UIS7MainController:MazeBtnOnClick(go)
  self:ShowDialog("UISeasonMazeEnterController", function()
    if self.cb then
      self.cb()
    end
  end)
end

function UIS7MainController:OnceMissionBtnOnClick(go)
  local uiName = GameGlobal.GetUIModule(SeasonModule):GetCurOnceMissionUI()
  self:ShowDialog(uiName, nil, nil, nil, true)
end

function UIS7MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS7MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS7MainController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIS7MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
