_class("UIS4MainController", UIController)
UIS4MainController = UIS4MainController

function UIS4MainController:Constructor()
  self._isReview = false
  self._canShare = self:GetModule(ShareModule):CanShare()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIS4MainController:_SetRemainingTime(widgetName, extraId, descId, endTime)
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

function UIS4MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIS4MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIS4Main then
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

function UIS4MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("hide")
end

function UIS4MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("show")
end

function UIS4MainController:_SetBg(phase)
end

function UIS4MainController:_SetSpine()
  local phase = UISeasonPhaseHelper.CheckPhase()
  if phase == self._spinePhase then
    return
  end
  self._spinePhase = phase
  local spineName = UISeasonPhaseHelper.GetPhaseSpine(phase)
  UIWidgetHelper.SetSpineLoad(self, "_spine", spineName)
end

function UIS4MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uieffanim_UIS4MainController_in",
      duration = 200
    },
    out = {
      animName = "uieffanim_UIS4MainController_out",
      duration = 500
    },
    hide = {
      animName = "uieffanim_UIS4MainController_hide",
      duration = 500
    },
    show = {
      animName = "uieffanim_UIS4MainController_show",
      duration = 500
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
end

function UIS4MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIS4MainController)
end

function UIS4MainController:LoadDataOnEnter(TT, res, uiParams)
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

function UIS4MainController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_SetSpine()
  local isRt = UIWidgetHelper.SetRawImageTexture(self, "rt", uiParams[1])
  self:_PlayAnim("in", function()
    self:_CheckGuide()
  end)
  local obj = UIWidgetHelper.SpawnObject(self, "Title", "UIS4Title")
  self:_Refresh(true)
  self:_AttachEvents()
end

function UIS4MainController:OnHide()
  self:_DetachEvents()
  AudioHelperController.PlayBGMById(SeasonCriAudio.BGMMain)
end

function UIS4MainController:_Refresh(first)
  self._component_quest = self._seasonModule:GetCurSeasonQuestComponent()
  self._component_exchange = self._seasonModule:GetCurSeasonExchangeComponent()
  self._component_action = self._seasonModule:GetCurSeasonActionPointComponent()
  self:_CalcTime()
  self:_SetBtn_Collage(first)
  self:_SetBtn_Exchange(first)
  self:_SetBtn_Medal(first)
  self:_SetBtn_Quest(first)
  self:_SetBtn_Go(first)
end

function UIS4MainController:_CalcTime()
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
    extra, time = "str_season_s4_main_time_cd_action", time_action
  elseif curTime < time_exchange then
    extra, time = "str_season_s4_main_time_cd_exchange", time_exchange
  end
  self:_SetRemainingTime("_time", extra, nil, time)
end

function UIS4MainController:_SetBtn_Collage(first)
  local obj = UIWidgetHelper.SpawnObject(self, "CollageBtn", "UIS4CollageBtn")
  obj:SetData(self._seasonId, first)
end

function UIS4MainController:_SetBtn_Exchange(first)
  local obj = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIS4ExchangeBtn")
  obj:SetData(self._seasonId, self._component_exchange, first)
end

function UIS4MainController:_SetBtn_Medal(first)
  local obj = UIWidgetHelper.SpawnObject(self, "MedalBtn", "UIS4MedalBtn")
  obj:SetData(self._seasonId, first)
end

function UIS4MainController:_SetBtn_Quest(first)
  local obj = UIWidgetHelper.SpawnObject(self, "QuestBtn", "UIS4QuestBtn")
  obj:SetData(self._seasonId, self._component_quest, first)
end

function UIS4MainController:_SetBtn_Go(first)
  local obj = UIWidgetHelper.SpawnObject(self, "GoBtn", "UIS4GoBtn")
  obj:SetData(self._seasonId, self._component_action, first)
end

function UIS4MainController:_Shot(callback)
  UIWidgetHelper.BlurHelperShot(self, "shot", self:GetName(), function(cache_rt)
    UIWidgetHelper.SetRawImageTexture(self, "rt", cache_rt)
    self:_AfterShot()
    callback()
  end)
end

function UIS4MainController:_AfterShot()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(false)
end

function UIS4MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIS4MainController:StoryBtnOnClick(go)
end

function UIS4MainController:IntroBtnOnClick(go)
  UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.S1Main)
end

function UIS4MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS4MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS4MainController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIS4MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
