_class("UIS1MainController", UIController)
UIS1MainController = UIS1MainController

function UIS1MainController:Constructor()
  self._isReview = false
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIS1MainController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:GetGameObject():SetActive(endTime ~= nil)
  if endTime == nil then
    return
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function(isFirst)
    if not isFirst then
      self:_Refresh()
    end
  end)
end

function UIS1MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIS1MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIS1Main then
    self:SwitchState(UIStateType.UIMain)
  else
    self:_Shot(function()
      self:_PlayAnim(3, function()
        self:CloseDialog()
        UIBgmHelper.PlayMainBgm()
      end)
    end)
  end
end

function UIS1MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim(4)
end

function UIS1MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim(5)
end

function UIS1MainController:_SetBg(phase)
end

function UIS1MainController:_SetSpine()
  local phase = UISeasonPhaseHelper.CheckPhase()
  if phase == self._spinePhase then
    return
  end
  self._spinePhase = phase
  local spineName = UISeasonPhaseHelper.GetPhaseSpine(phase)
  UIWidgetHelper.SetSpineLoad(self, "_spine", spineName)
end

function UIS1MainController:_PlayAnim(idx, callback)
  local tb = {
    [1] = {
      animName = "uieff_UIS1_UIS1MainController",
      duration = 1000
    },
    [2] = {
      animName = "uieff_UIS1_UIS1MainController_in",
      duration = 1000
    },
    [3] = {
      animName = "uieff_UIS1_UIS1MainController_out",
      duration = 333
    },
    [4] = {
      animName = "uieff_UIS1_UIS1MainController_hide",
      duration = 500
    },
    [5] = {
      animName = "uieff_UIS1_UIS1MainController_show",
      duration = 500
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
end

function UIS1MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIS1MainController)
end

function UIS1MainController:LoadDataOnEnter(TT, res, uiParams)
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
end

function UIS1MainController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_SetSpine()
  local isRt = UIWidgetHelper.SetRawImageTexture(self, "rt", uiParams[1])
  local animIn = isRt and 1 or 2
  self:_PlayAnim(animIn, function()
    self:_CheckGuide()
  end)
  local delay = animIn == 1 and 270 or 0
  self:_Refresh(true, delay)
  self:_AttachEvents()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  uiSeasonModule:SeasonManager():SeasonMapManager():TryResumeExpress()
end

function UIS1MainController:OnHide()
  self:_DetachEvents()
  if self._gameTimer then
    GameGlobal.Timer():CancelEvent(self._gameTimer)
    self._gameTimer = nil
  end
  AudioHelperController.PlayBGMById(SeasonCriAudio.BGMMain)
end

function UIS1MainController:_Refresh(first, delay)
  self._component_quest = self._seasonModule:GetCurSeasonQuestComponent()
  self._component_exchange = self._seasonModule:GetCurSeasonExchangeComponent()
  self._component_action = self._seasonModule:GetCurSeasonActionPointComponent()
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  
  local function getComponentCloseTime(component)
    return component and component:GetComponentInfo().m_close_time or 0
  end
  
  local time_action = getComponentCloseTime(self._component_action)
  local time_exchange = getComponentCloseTime(self._component_exchange)
  local desc, time
  if curTime < time_action then
    desc, time = "str_season_s1_main_time_action", time_action
  elseif curTime < time_exchange then
    desc, time = "str_season_s1_main_time_exchange", time_exchange
  end
  self:_SetRemainingTime("_remainingTime", desc, time)
  self:_SetBtn_Collage()
  self:_SetBtn_Exchange(delay)
  self:_SetBtn_Medal()
  self:_SetBtn_Quest(delay)
  self:_SetBtn_Go()
end

function UIS1MainController:_SetBtn_Collage()
  local obj = UIWidgetHelper.SpawnObject(self, "CollageBtn", "UIS1CollageBtn")
  obj:SetData(self._seasonId)
end

function UIS1MainController:_SetBtn_Exchange(delay)
  local obj = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIS1ExchangeBtn")
  obj:SetData(self._seasonId, self._component_exchange, delay)
end

function UIS1MainController:_SetBtn_Medal()
  local obj = UIWidgetHelper.SpawnObject(self, "MedalBtn", "UIS1MedalBtn")
  obj:SetData(self._seasonId)
end

function UIS1MainController:_SetBtn_Quest(delay)
  local obj = UIWidgetHelper.SpawnObject(self, "QuestBtn", "UIS1QuestBtn")
  obj:SetData(self._seasonId, self._component_quest, delay)
end

function UIS1MainController:_SetBtn_Go()
  local obj = UIWidgetHelper.SpawnObject(self, "GoBtn", "UIS1GoBtn")
  obj:SetData(self._seasonId, self._component_action)
end

function UIS1MainController:_Shot(callback)
  UIWidgetHelper.BlurHelperShot(self, "shot", self:GetName(), function(cache_rt)
    UIWidgetHelper.SetRawImageTexture(self, "rt", cache_rt)
    self:_AfterShot()
    callback()
  end)
end

function UIS1MainController:_AfterShot()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(false)
end

function UIS1MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIS1MainController:StoryBtnOnClick(go)
end

function UIS1MainController:IntroBtnOnClick(go)
  UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.S1Main)
end

function UIS1MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS1MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS1MainController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIS1MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
