_class("UIN25IdolGame", UIController)
UIN25IdolGame = UIN25IdolGame

function UIN25IdolGame:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  if self._isConcert then
    obj:SetData(function()
      self:_Back()
    end, nil, nil, true, nil)
  else
    obj:SetData(function()
      self:_Back()
    end, function()
      self:ShowDialog("UIIntroLoader", "UIN25IdolGameIntro", MaskType.MT_BlurMask)
    end, nil, true, function()
      self:_HideUI()
    end)
  end
end

function UIN25IdolGame:_Back()
  local lockName = "UIN25IdolGame:_Back"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    if self._apEvent then
      self._apEvent:CloseAnim(TT)
    end
    self:SwitchState(UIStateType.UIN25IdolLogin)
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function UIN25IdolGame:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:GetGameObject("_uiElements"):SetActive(false)
end

function UIN25IdolGame:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
end

function UIN25IdolGame:_SetBg()
  local url = "n25_ychjq_di07"
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIN25IdolGame:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("geerdi_n23_spine_idle")
end

function UIN25IdolGame:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N25
  self._componentId = ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId
  })
  self._component = self._campaign:GetComponent(self._componentId)
  self._componentInfo = self._campaign:GetComponentInfo(self._componentId)
end

function UIN25IdolGame:OnShow(uiParams)
  self._isConcert = false
  self._froceActOpened = false
  self._froceConcertOpened = false
  self:_AttachEvents()
  self._isOpen = true
  self:_SetBg()
  self:_SetSpine()
  self:_Refresh()
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGame_in", 600, function()
    UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolGame_Dialog_in")
    self:_CheckGuide()
  end)
end

function UIN25IdolGame:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIN25IdolGame:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN25IdolGame)
end

function UIN25IdolGame:_Refresh()
  self._state = UIN25IdolGameHelper.CheckState(self._component, self._froceActOpened, self._froceConcertOpened, function()
    self:_RefreshUI()
  end)
  if self._state == IdolGameState.Weekend then
    self._froceActOpened = true
  elseif self._state < IdolGameState.Weekend then
    self._froceActOpened = false
  end
  if self._state == IdolGameState.Concert then
    self._froceConcertOpened = true
  elseif self._state < IdolGameState.Concert then
    self._froceConcertOpened = false
  end
end

function UIN25IdolGame:_RefreshUI()
  self:_SetConcert()
  self:_SetSchedule()
  self:_SetTrainPoint()
  self:_SetDialog()
  self:_SetActRed()
  self:_SetCommonTopButton()
end

function UIN25IdolGame:_SetActRed()
  local redGo = self:GetGameObject("actRed")
  local show = self._component:UI_GetActRed()
  redGo:SetActive(show)
end

function UIN25IdolGame:_SetSchedule()
  self._apEvent = UIWidgetHelper.SpawnObject(self, "_schedule", "UIN25IdolApEvent")
  self._apEvent:SetData(self._component)
end

function UIN25IdolGame:_SetConcert()
  local apGo = self:GetGameObject("_schedule")
  local BtnsGroup = self:GetGameObject("BtnsGroup")
  local obj = UIWidgetHelper.SpawnObject(self, "Concert", "UIN25IdolConcertItem")
  obj:SetData(self._component, function(pos, argsTable)
    self:_SetCommonTips(pos, argsTable)
  end)
  local fansEnough = false
  self._isConcert, fansEnough = self._component:UI_CheckConcert()
  local ConcertEnter = self:GetGameObject("ConcertEnter")
  ConcertEnter:SetActive(self._isConcert)
  apGo:SetActive(not self._isConcert)
  BtnsGroup:SetActive(not self._isConcert)
end

function UIN25IdolGame:_SetTrainPoint()
  local objs = UIWidgetHelper.SpawnObjects(self, "_trainPoint", "UIN25IdolCommonTrainPoint", 3)
  for i, v in ipairs(objs) do
    local uiType = 1
    local trainType = i
    local value = self._component:UI_GetTrainPoint(trainType)
    local tips = true
    v:SetData(uiType, trainType, value, function(pos, argsTable)
      self:_SetCommonTips(pos, argsTable)
    end)
  end
  self._trainPoint = objs
end

function UIN25IdolGame:_SetCommonTips(pos, argsTable)
  local className = "UIN25IdolCommonTips"
  local prefabName = "UIN25Idol_Common_Tips.prefab"
  UIWidgetHelper.SetActivityCommonTips(self, "_tipsPool", className, prefabName, pos, argsTable)
end

function UIN25IdolGame:_SetDialog(anim)
  local stage = self._component:UI_GetCurrentConcertId()
  local strIds = {
    "str_n25_idol_game_spine_talk_",
    "str_n25_idol_game_spine_talk_concert_"
  }
  local idx = self._isConcert and 2 or 1
  local key = strIds[idx] .. stage .. "_"
  local tb = UIActivityHelper.GetStringTableArray(key)
  table.shuffle(tb)
  local strId = tb[1]
  local name = StringTable.Get("str_n25_idol_game_spine_talk_name")
  local text = StringTable.Get(strId)
  text = HelperProxy:GetInstance():ReplacePlayerName(text)
  UIWidgetHelper.SetLocalizationText(self, "_txtName", name)
  UIWidgetHelper.SetLocalizationText(self, "_txtDialog", text)
  if anim then
    UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolGame_Dialog_in")
  end
end

function UIN25IdolGame:SpineBtnOnClick(go)
  self:_SetDialog(true)
end

function UIN25IdolGame:TrainingBtnOnClick(go)
  self:ShowDialog("UIN25IdolGameTraining")
end

function UIN25IdolGame:ActBtnOnClick(go)
  CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
    self:ShowDialog("UIN25IdolAct", false)
  end)
  self._component:UI_SetActRed()
end

function UIN25IdolGame:ConcertBtnOnClick(go)
  CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
    self:ShowDialog("UIN25IdolConcert")
  end)
end

function UIN25IdolGame:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIN25IdolGame:_AttachEvents()
  self:AttachEvent(GameEventType.N25IdolGameNextDay, self._Refresh)
end

function UIN25IdolGame:_DetachEvents()
  self:DetachEvent(GameEventType.N25IdolGameNextDay, self._Refresh)
end
