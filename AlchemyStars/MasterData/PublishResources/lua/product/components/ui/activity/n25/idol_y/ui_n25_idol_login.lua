_class("UIN25IdolLogin", UIController)
UIN25IdolLogin = UIN25IdolLogin

function UIN25IdolLogin:Constructor()
end

function UIN25IdolLogin:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolLogin:OnShow(uiParams)
  self:AttachEvent(GameEventType.N25IdolStartPlayGame, self.OnStartPlayGame)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._uiShow = self:GetUIComponent("RectTransform", "uiShow")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._redCollection = self:View():GetUIComponent("UISelectObjectPath", "redCollection")
  self._redCollectionSpawn = nil
  self._txtEndDuration = self:GetUIComponent("UILocalizationText", "txtEndDuration")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._reddot = N25IdolCollectionReddot:New()
  self:EnterFullScreenBg(false)
  self:InitCommonTopButton()
  self:FlushButtonTextFont()
  self:FlushCollectionRedDot()
  self:FlushEndDuration()
  self:_CheckGuide()
  self:EnterTag()
end

function UIN25IdolLogin:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN25IdolLogin)
end

function UIN25IdolLogin:OnHide()
end

function UIN25IdolLogin:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN25IdolLogin:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._uiShow.gameObject:SetActive(isEnter)
end

function UIN25IdolLogin:InitCommonTopButton()
  local function fnSumupTest()
    self:ShowDialog("UIN25IdolSumUp")
  end
  
  fnSumupTest = nil
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    local lockName = "UIN25IdolLogin:_backAnim"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self:UnLock(lockName)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN25MainController, UIStateType.UIMain, nil, self._campaign._id)
    end)
  end, fnSumupTest, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN25IdolLogin:FlushButtonTextFont()
  local btns = {
    self:GetUIComponent("RectTransform", "btnStartNewGame"),
    self:GetUIComponent("RectTransform", "btnLoadArchiving"),
    self:GetUIComponent("RectTransform", "btnCollection")
  }
  local isZhTw = false
  local language = Localization.GetCurLanguage()
  if LanguageType.zh == language then
    isZhTw = true
  elseif LanguageType.tw == language then
    isZhTw = true
  else
    isZhTw = false
  end
  if isZhTw then
    for k, v in pairs(btns) do
      local txt = self:GetChildComponent(v, "UILocalizationText", "Text")
      local txtTMP = self:GetChildComponent(v, "UILocalizedTMP", "TextTMP")
      txt.fontSize = 53
      txtTMP.fontSize = 53
    end
  else
    for k, v in pairs(btns) do
      local txt = self:GetChildComponent(v, "UILocalizationText", "Text")
      local txtTMP = self:GetChildComponent(v, "UILocalizedTMP", "TextTMP")
      txt.fontSize = 40
      txtTMP.fontSize = 40
      if txt.preferredWidth > txt.transform.sizeDelta.x then
        txt.fontSize = 35
        txtTMP.fontSize = 35
      else
        txt.fontSize = 40
        txtTMP.fontSize = 40
      end
    end
  end
end

function UIN25IdolLogin:FlushCollectionRedDot()
  if self._reddot == nil then
    self._reddot = N25IdolCollectionReddot:New()
  end
  local showRedDot = false
  showRedDot = showRedDot or self._reddot:GetEndCGReddot()
  showRedDot = showRedDot or self._reddot:GetMemoryReddot()
  showRedDot = showRedDot or self._reddot:GetAchieveReddot()
  if self._redCollection.gameObject.activeSelf ~= showRedDot then
    self._redCollection.gameObject:SetActive(showRedDot)
  end
  if showRedDot and self._redCollectionSpawn == nil then
    self._redCollectionSpawn = self._redCollection:SpawnOneObject("ManualLoad0")
  end
end

function UIN25IdolLogin:FlushEndDuration()
  local endTime = self._idolComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local stamp = endTime - curTime
  stamp = math.max(stamp, 0)
  local day, hour, min, second = UIActivityHelper.Time2Str(stamp)
  local txtValue = StringTable.Get("str_n25_idol_y_end_duration", day, hour)
  self._txtEndDuration:SetText(txtValue)
end

function UIN25IdolLogin:BtnUiShowOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN25IdolLogin:BtnIntroOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN25IdolLoginIntro", MaskType.MT_BlurMask)
end

function UIN25IdolLogin:BtnStartNewGameOnClick(go)
  local idolInfo = self._idolComponent:GetComponentInfo()
  local breakInfo = idolInfo.break_info
  if breakInfo.note_time ~= 0 then
    self:ShowDialog("UIN25IdolBreakLoad")
  else
    self:DispatchEvent(GameEventType.N25IdolStartPlayGame, IdolStartType.IdolStartType_New)
  end
end

function UIN25IdolLogin:BtnLoadArchivingOnClick(go)
  self:ShowDialog("UIN25IdolLoading")
end

function UIN25IdolLogin:BtnCollectionOnClick(go)
  self:ShowDialog("UIN25IdolCollection")
end

function UIN25IdolLogin:OnStartPlayGame(start_type, process_type)
  if process_type == nil then
    process_type = IdolProcessType.IdolProcessType_None
  end
  self:Lock("UIN25IdolLogin:OnStartPlayGameTask")
  self:StartTask(self.OnStartPlayGameTask, self, start_type, process_type)
end

function UIN25IdolLogin:OnStartPlayGameTask(TT, start_type, process_type)
  local res = AsyncRequestRes:New()
  self._idolComponent:HandleIdolStartPlay(TT, res, start_type, process_type)
  if not res:GetSucc() then
    if res:GetResult() == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    else
      local errorContent = string.format("成为偶像开始游戏失败，code=%d", res:GetResult())
      ToastManager.ShowToast(errorContent)
    end
  else
    if start_type == IdolStartType.IdolStartType_New then
      self._idolComponent:UI_ResetActRed()
    end
    self:ShowDialog("UIN25IdolGame")
  end
  self:UnLock("UIN25IdolLogin:OnStartPlayGameTask")
end

function UIN25IdolLogin:OnCollectionBack(...)
  self:Lock("UIN25IdolLogin:OnCollectionBack")
  self:StartTask(self.OnCollectionBackTask, self, ...)
end

function UIN25IdolLogin:OnCollectionBackTask(TT)
  local res = UIStateSwitchReq:New()
  res:SetSucc(true)
  self:LoadDataOnEnter(TT, res)
  self:OnShow()
  self._animation:Play("uieff_UIN25IdolLogin_back")
  self:UnLock("UIN25IdolLogin:OnCollectionBack")
end

function UIN25IdolLogin:EnterTag()
  local idol_open_state = 0
  local idol_open_state_key = "UIN25IdolOpenStateKey_fk"
  local cInfo = self._idolComponent:GetComponentInfo()
  local unlockTime = cInfo.m_unlock_time
  local secondsPerDay = 86400
  local state = self:ComponentState(cInfo)
  if state == UISummerOneEnterBtnState.NotOpen then
  elseif state == UISummerOneEnterBtnState.Normal then
    local nowTimestamp = UICommonHelper.GetNowTimestamp()
    local curStage = math.floor((nowTimestamp - unlockTime) / secondsPerDay) + 1
    local timeTips
    if curStage <= 1 then
      idol_open_state = 1
    elseif curStage <= 2 then
      idol_open_state = 2
    else
      idol_open_state = 3
    end
    local key = idol_open_state_key
    LocalDB.SetInt(key, idol_open_state)
  elseif state == UISummerOneEnterBtnState.Closed then
  end
end

function UIN25IdolLogin:ComponentState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UISummerOneEnterBtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UISummerOneEnterBtnState.Closed
  elseif cInfo.m_b_unlock then
    return UISummerOneEnterBtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UISummerOneEnterBtnState.Locked
    else
      return UISummerOneEnterBtnState.Normal
    end
  end
end
