_class("UIS3MainController", UIController)
UIS3MainController = UIS3MainController

function UIS3MainController:Constructor()
  self._isReview = false
  self._canShare = self:GetModule(ShareModule):CanShare()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIS3MainController:_SetRemainingTime(widgetName, descId, endTime)
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

function UIS3MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIS3MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIS3Main then
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

function UIS3MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("hide")
end

function UIS3MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("show")
end

function UIS3MainController:_SetBg(phase)
end

function UIS3MainController:_SetSpine()
  local phase = UISeasonPhaseHelper.CheckPhase()
  if phase == self._spinePhase then
    return
  end
  self._spinePhase = phase
  local trMainBg = self:GetUIComponent("RectTransform", "_mainBg")
  local spineName = UISeasonPhaseHelper.GetPhaseSpine(phase)
  UIWidgetHelper.SetSpineLoad(self, "_spine", spineName)
end

function UIS3MainController:_PlayAnim(idx, callback)
  local tb = {
    ["in"] = {
      animName = "uianim_UIS3MainController_in",
      duration = 500
    },
    out = {
      animName = "uianim_UIS3MainController_out",
      duration = 500
    },
    hide = {
      animName = "uianim_UIS3MainController_hide",
      duration = 600
    },
    show = {
      animName = "uianim_UIS3MainController_show",
      duration = 500
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[idx].animName, tb[idx].duration, callback)
end

function UIS3MainController:_CheckGuide()
end

function UIS3MainController:LoadDataOnEnter(TT, res, uiParams)
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

function UIS3MainController:OnShow(uiParams)
  self:_SetCommonTopButton()
  self:_SetSpine()
  local mat = self:GetAsset("s3_zjm_logo-5.mat", LoadType.Mat)
  local eftImg = self:GetUIComponent("RawImage", "Logo_5")
  eftImg.material:SetTexture("_MainTex", mat.mainTexture)
  local isRt = UIWidgetHelper.SetRawImageTexture(self, "rt", uiParams[1])
  self:_PlayAnim("in", function()
    self:_CheckGuide()
  end)
  self:_Refresh(true)
  self:_AttachEvents()
end

function UIS3MainController:OnHide()
  self:_DetachEvents()
  AudioHelperController.PlayBGMById(SeasonCriAudio.BGMMain)
end

function UIS3MainController:_Refresh(first)
  self._component_quest = self._seasonModule:GetCurSeasonQuestComponent()
  self._component_exchange = self._seasonModule:GetCurSeasonExchangeComponent()
  self._component_action = self._seasonModule:GetCurSeasonActionPointComponent()
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  
  local function getComponentCloseTime(component)
    return component and component:GetComponentInfo().m_close_time or 0
  end
  
  local time_action
  local time_exchange = getComponentCloseTime(self._component_exchange)
  local cfgPoint
  if self._component_action ~= nil then
    cfgPoint = self._component_action:GetActionPointConfig()
  end
  if cfgPoint ~= nil then
    local loginModule = self:GetModule(LoginModule)
    time_action = loginModule:GetTimeStampByTimeStr(cfgPoint.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  else
    time_action = getComponentCloseTime(self._component_action)
  end
  local desc, time
  if curTime < time_action then
    desc, time = "str_season_s3_main_time_cd_action", time_action
  elseif curTime < time_exchange then
    desc, time = "str_season_s3_main_time_cd_exchange", time_exchange
  end
  self:_SetRemainingTime("_remainingTime", desc, time)
  self:_SetBtn_Collage()
  self:_SetBtn_Exchange()
  self:_SetBtn_Medal()
  self:_SetBtn_Quest()
  self:_SetBtn_Go()
end

function UIS3MainController:_SetBtn_Collage()
  local obj = UIWidgetHelper.SpawnObject(self, "CollageBtn", "UIS3CollageBtn")
  obj:SetData(self._seasonId)
end

function UIS3MainController:_SetBtn_Exchange()
  local obj = UIWidgetHelper.SpawnObject(self, "ExchangeBtn", "UIS3ExchangeBtn")
  obj:SetData(self._seasonId, self._component_exchange)
end

function UIS3MainController:_SetBtn_Medal()
  local obj = UIWidgetHelper.SpawnObject(self, "MedalBtn", "UIS3MedalBtn")
  obj:SetData(self._seasonId)
end

function UIS3MainController:_SetBtn_Quest()
  local obj = UIWidgetHelper.SpawnObject(self, "QuestBtn", "UIS3QuestBtn")
  obj:SetData(self._seasonId, self._component_quest)
end

function UIS3MainController:_SetBtn_Go()
  local obj = UIWidgetHelper.SpawnObject(self, "GoBtn", "UIS3GoBtn")
  obj:SetData(self._seasonId, self._component_action)
end

function UIS3MainController:_Shot(callback)
  UIWidgetHelper.BlurHelperShot(self, "shot", self:GetName(), function(cache_rt)
    UIWidgetHelper.SetRawImageTexture(self, "rt", cache_rt)
    self:_AfterShot()
    callback()
  end)
end

function UIS3MainController:_AfterShot()
  self:GetGameObject("rt"):SetActive(true)
  self:GetGameObject("shot"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(false)
  self:GetGameObject("_spine"):SetActive(false)
end

function UIS3MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIS3MainController:StoryBtnOnClick(go)
end

function UIS3MainController:IntroBtnOnClick(go)
  if not self._seasonModule:CheckSeasonAndMissionCoseAndJump() then
    return
  end
  UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.S1Main)
end

function UIS3MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS3MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._AfterUILayerChanged)
end

function UIS3MainController:_CheckActivityClose(id)
  if self._seasonId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIS3MainController:_AfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end
