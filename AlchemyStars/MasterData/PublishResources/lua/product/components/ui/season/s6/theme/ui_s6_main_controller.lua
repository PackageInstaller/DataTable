_class("UIS6MainController", UIController)
UIS6MainController = UIS6MainController

function UIS6MainController:Constructor()
  self._isReview = false
  self._canShare = self:GetModule(ShareModule):CanShare()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIS6MainController:_SetRemainingTime(widgetName, extraId, descId, endTime)
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

function UIS6MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIS6MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIS6Main then
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

function UIS6MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("hide")
end

function UIS6MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("show")
end

function UIS6MainController:_SetBg(phase)
end

function UIS6MainController:_SetSpine()
  local phase = UISeasonPhaseHelper.CheckPhase()
  if phase == self._spinePhase then
    return
  end
  self._spinePhase = phase
  local spineName = UISeasonPhaseHelper.GetPhaseSpine(phase)
  UIWidgetHelper.SetSpineLoad(self, "_spine", spineName)
end

function UIS6MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieffanim_UIS6MainController_in",
      duration = 1800
    },
    out = {
      animName = "uieffanim_UIS6MainController_out",
      duration = 500
    },
    hide = {
      animName = "uieffanim_UIS6MainController_hide",
      duration = 500
    },
    show = {
      animName = "uieffanim_UIS6MainController_show",
      duration = 500
    },
    title = {
      animName = "UIS6MainController_Season_loop"
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
end

function UIS6MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIS6MainController)
end

function UIS6MainController:LoadDataOnEnter(TT, res, uiParams)
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

function UIS6MainController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_SetSpine()
  local isRt = UIWidgetHelper.SetRawImageTexture(self, "rt", uiParams[1])
  self:_PlayAnim("in", function()
    self:_CheckGuide()
    self:_PlayAnim("title")
  end)
  self.mazeBtnGo = self:GetGameObject("UISeaonMazeBtnPool")
  self.onceMissionBtnGo = self:GetGameObject("OnceMissionBtn")
  self._thierdBtnNew = self:GetGameObject("ThirdNew")
  local obj = UIWidgetHelper.SpawnObject(self, "Title", "UIS6Title")
  self:_Refresh(true)
  self:_AttachEvents()
end

function UIS6MainController:OnHide()
  self:_DetachEvents()
end

function UIS6MainController:_Refresh(first)
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

function UIS6MainController:RefreshMazeBtnRed()
  local red = self._sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  self.mazeRed:SetActive(red)
end

function UIS6MainController:_CheckMazeOpen()
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

function UIS6MainController:_CheckOnceMissionOpen()
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

function UIS6MainController:_CalcTime()
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
    extra, time = "str_season_s6_main_time_cd_action", time_action
  elseif curTime < time_exchange then
    extra, time = "str_season_s6_main_time_cd_exchange", time_exchange
  end
  self:_SetRemainingTime("_time", extra, nil, time)
end

function UIS6MainController:_SetBtn_Collage(first)
  local obj = UIWidgetHelper.SpawnObject(self, "CollageBtn", "UIS6CollageBtn")
  obj:SetData(self._seasonId, first)
end

function UIS6MainController:_SetBtn_Exchange(first)
  local obj = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIS6ExchangeBtn")
  obj:SetData(self._seasonId, self._component_exchange, first)
end

function UIS6MainController:_SetBtn_Medal(first)
  local obj = UIWidgetHelper.SpawnObject(self, "MedalBtn", "UIS6MedalBtn")
  obj:SetData(self._seasonId, first)
end

function UIS6MainController:_SetBtn_Quest(first)
  local obj = UIWidgetHelper.SpawnObject(self, "QuestBtn", "UIS6QuestBtn")
  obj:SetData(self._seasonId, self._component_quest, first)
end

function UIS6MainController:_SetBtn_Go(first)
  self.mazeBtnGo:SetActive(self:_CheckMazeOpen())
  self.onceMissionBtnGo:SetActive(self:_CheckOnceMissionOpen())
  local obj = UIWidgetHelper.SpawnObject(self, "GoBtn", "UIS6GoBtn")
  obj:SetData(self._seasonId, self._component_action, first)
end

function UIS6MainController:_SetBtn_SeasonMaze(first)
  local obj = UIWidgetHelper.SpawnObject(self, "UISeaonMazeBtnPool", "UISeaonMazeBtnItem")
  obj:SetData(self._seasonId, self._component_action, first, function()
    self:_Refresh()
  end)
end

function UIS6MainController:_Shot(callback)
  UIWidgetHelper.BlurHelperShot(self, "shot", self:GetName(), function(cache_rt)
    UIWidgetHelper.SetRawImageTexture(self, "rt", cache_rt)
    self:_AfterShot()
    callback()
  end)
end

function UIS6MainController:_AfterShot()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(false)
end

function UIS6MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIS6MainController:StoryBtnOnClick(go)
end

function UIS6MainController:IntroBtnOnClick(go)
  UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.S1Main)
end

function UIS6MainController:MazeBtnOnClick(go)
  self:ShowDialog("UISeasonMazeEnterController", function()
    if self.cb then
      self.cb()
    end
  end)
end

function UIS6MainController:OnceMissionBtnOnClick(go)
  local uiName = GameGlobal.GetUIModule(SeasonModule):GetCurOnceMissionUI()
  self:ShowDialog(uiName, nil, nil, nil, true)
end

function UIS6MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS6MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS6MainController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIS6MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
