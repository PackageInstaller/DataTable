_class("UIActivityNPlusSixEventItem", UICustomWidget)
UIActivityNPlusSixEventItem = UIActivityNPlusSixEventItem

function UIActivityNPlusSixEventItem:OnShow()
  self._go = self:GetGameObject("Go")
  self._tran = self:GetUIComponent("RectTransform", "Go")
  self._btnTran = self:GetUIComponent("RectTransform", "Btn")
  self._spineLoader = self:GetUIComponent("SpineLoader", "Spine")
  self._selectEffect = self:GetGameObject("SelectEffect")
  self:HideSelectEffect()
  self:AttachEvent(GameEventType.NPlusSixEventInfoItemClick, self.OnEventInfoItemClick)
  self._isPlayEffect = false
end

function UIActivityNPlusSixEventItem:OnHide()
  self:DetachEvent(GameEventType.NPlusSixEventInfoItemClick, self.OnEventInfoItemClick)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityNPlusSixEventItem:OnEventInfoItemClick(eventId)
  if not self._eventData then
    return
  end
  if eventId == self._eventData:GetEventId() then
    self:ShowSelectEffect()
  else
    self:HideSelectEffect()
  end
end

function UIActivityNPlusSixEventItem:HideSelectEffect()
  self._selectEffect:SetActive(false)
end

function UIActivityNPlusSixEventItem:ShowSelectEffect()
  self._selectEffect:SetActive(true)
end

function UIActivityNPlusSixEventItem:Refresh(campaign, eventData)
  self._campaign = campaign
  self._localProcess = self._campaign:GetLocalProcess()
  self._buildComponent = self._localProcess:GetComponent(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  self._buildComponentInfo = self._localProcess:GetComponentInfo(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  self._eventData = eventData
  if not self._eventData then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._tran.anchoredPosition = Vector2(self._eventData:GetPosX(), self._eventData:GetPosY())
  self._btnTran.sizeDelta = Vector2(self._eventData:GetTriggerAreaWidth(), self._eventData:GetTriggerAreaHeight())
  self._btnTran.anchoredPosition = Vector2(self._eventData:GetTriggerAreaPosX(), self._eventData:GetTriggerAreaPosY())
  self._spineLoader:LoadSpine(self._eventData:GetSpineName())
  self._spineLoader:SetAnimation(0, self._eventData:GetIdleAnimName(), true)
  self:PlayIdleEffect()
end

function UIActivityNPlusSixEventItem:PlayIdleEffect()
  if self._isPlayEffect then
    return
  end
  self._isPlayEffect = true
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  local go = self:GetGameObject("Spine")
  local spineSke = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
  spineSke.material:SetColor("_Black", Color(0, 0, 0, 0))
  local isStageOne = true
  local timer = 0
  local startValue1 = 0
  local endValue1 = 0.7
  local length1 = 1.5
  local speed1 = (endValue1 - startValue1) / length1
  local startValue2 = 0.7
  local endValue2 = 0
  local length2 = 1.5
  local speed2 = (endValue2 - startValue2) / length2
  self._timerHandler = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
    timer = timer + UnityEngine.Time.deltaTime
    local value = 0
    if isStageOne then
      value = startValue1 + timer * speed1
    else
      value = startValue2 + timer * speed2
    end
    spineSke.material:SetColor("_Black", Color(value, value, value, 0))
    if isStageOne then
      if timer > length1 then
        isStageOne = false
        timer = 0
      end
    elseif timer > length2 then
      isStageOne = true
      timer = 0
    end
  end)
end

function UIActivityNPlusSixEventItem:BtnOnClick()
  GameGlobal.TaskManager():StartTask(self.HandleEvent, self)
end

function UIActivityNPlusSixEventItem:HandleEvent(TT)
  self:Lock("UIActivityNPlusSixEventItem_HandleEvent")
  local componetInfo = self._buildComponent:ComponentInfo()
  local num = componetInfo.event_info.today_complete_event_num
  local componentId = self._buildComponent:GetComponentCfgId(self._campaign._id, componetInfo.m_component_id)
  local cfg = Cfg.cfg_component_bulid_event_extra[componentId]
  if cfg and cfg.DayMaxEventNum and num >= cfg.DayMaxEventNum then
    ToastManager.ShowToast(StringTable.Get("str_n_plus_six_today_event_num_reach_max"))
    self:UnLock("UIActivityNPlusSixEventItem_HandleEvent")
    return
  end
  local res = AsyncRequestRes:New()
  local result = self._buildComponent:HandleCompleteEvent(TT, res, self._eventData:GetEventId())
  if result:GetSucc() then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6RandomItemDisapper)
    local completeName = self._eventData:GetCompleteAnimName()
    if completeName and completeName ~= "" then
      self._spineLoader:SetAnimation(0, completeName, false)
      YIELD(TT, self._eventData:GetCompleteAnimLength())
    end
    self:ShowDialog("UIActivityNPlusSixEventCompleteController", self._eventData)
    self._isPlayEffect = false
    self._go:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixEventComplete)
  else
    Log.error("HandleCompleteEvent error")
  end
  self:UnLock("UIActivityNPlusSixEventItem_HandleEvent")
end
