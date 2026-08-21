_class("UICN7N36MainController", UIController)
UICN7N36MainController = UICN7N36MainController

function UICN7N36MainController:Constructor()
  self._componentState = {}
  self._button = {}
  self._showSpine = false
end

function UICN7N36MainController:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N7, ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN, ECampaignCN7ComponentID.ECAMPAIGN_N7_POWER2ITEM, ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION, ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY, ECampaignCN7ComponentID.ECAMPAIGN_N7_SHARED, ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST, ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._line_componentInfo = self._campaign:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  self._game_componentInfo = self._campaign:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  self._game_component = self._campaign:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  self._battlePassCampaign = UIActivityCampaign:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._battlePassCampaign._id, nil, nil)
    return
  end
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_N7)
  local roleModule = GameGlobal.GetModule(RoleModule)
  self.pstid = roleModule:GetPstId()
end

function UICN7N36MainController:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UICN7N36MainController:OnShow(uiParams)
  self._isOpen = true
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
  self:_GetComponents()
  self:_OnValue()
  self:_SetTimer()
  self:_PlayAnimIN()
  self:_CheckGuide()
end

function UICN7N36MainController:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  if self._clearNewTask then
    GameGlobal.TaskManager():KillTask(self._clearNewTask)
    self._clearNewTask = nil
  end
end

function UICN7N36MainController:AfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshButtonState()
  self:_CheckRedPointAll()
end

function UICN7N36MainController:_CheckCampaignClose()
  return not self._campaign:CheckCampaignOpen()
end

function UICN7N36MainController:_GetComponents()
  self:InitTopButton()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._moneyValue = self:GetUIComponent("UILocalizationText", "MoneyValue")
  self._shopRedPoint = self:GetGameObject("ShopRedPoint")
  self._loginAwardRedPoint = self:GetGameObject("LoginAwardRedPoint")
  self._battlePassBtnRedPoint = self:GetGameObject("BattlePassBtnRedPoint")
  self._gameRedPoint = self:GetGameObject("GameRedPoint")
  self._activityIntroBtn = self:GetGameObject("ActivityIntroBtn")
  self._button[ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY] = self:GetUIComponent("Button", "ShopBtn")
  self._button[ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN] = self:GetUIComponent("Button", "LoginAwardBtn")
  self._atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._lineNew = self:GetGameObject("LineNew")
  self._shopNew = self:GetGameObject("ShopNew")
  self._gameNew = self:GetGameObject("GameNew")
  self._endObj = self:GetGameObject("End")
  self._unlockObj = self:GetGameObject("unlock")
  self._comingObj = self:GetGameObject("coming")
  self._lockObj = self:GetGameObject("Lock")
  self._photoObj = self:GetGameObject("Photo")
  self._visitObj = self:GetGameObject("visit")
  self._lIneEndMaskObj = self:GetGameObject("LIneEndMask")
  self._lockTxt = self:GetUIComponent("UILocalizationText", "LockTxt")
  self._comingTxt = self:GetUIComponent("UILocalizationText", "ComingTxt")
  self._visitTxt = self:GetUIComponent("UILocalizationText", "VisitTxt")
  self._visitIcon = self:GetUIComponent("Image", "VisitIcon")
  self.StateObj = {}
  self.StateObj.endObj = self._endObj
  self.StateObj.unlockObj = self._unlockObj
  self.StateObj.comingObj = self._comingObj
  self.StateObj.lockObj = self._lockObj
  self.StateObj.photoObj = self._photoObj
  self.StateObj.visitObj = self._visitObj
  self:CheckNew()
end

function UICN7N36MainController:CheckNew()
  local save_key1 = self.pstid .. "UICN7N36MainLobbyEntry_LineNew"
  local save_key2 = self.pstid .. "UICN7N36MainLobbyEntry_ShopNew"
  local save_key3 = self.pstid .. "UICN7N36MainLobbyEntry_GamesNew"
  local lineOpen = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  local gameOpen = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  if LocalDB.HasKey(save_key1) then
    self._lineNew:SetActive(false)
  elseif lineOpen then
    self._lineNew:SetActive(true)
  end
  if LocalDB.HasKey(save_key2) then
    self._shopNew:SetActive(false)
  else
    self._shopNew:SetActive(true)
  end
  if LocalDB.HasKey(save_key3) then
    self._gameNew:SetActive(false)
  elseif gameOpen then
    self._gameNew:SetActive(true)
  end
end

function UICN7N36MainController:InitTopButton()
  self._SafeArea = self:GetGameObject("SafeArea")
  local btns = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._backBtn = btns:SpawnObject("UINewCommonTopButton")
  self._backBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end, nil, nil)
end

function UICN7N36MainController:HideBtnOnClick()
  local lockName = "UICN7N36MainController:AnimHide"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UICN7N36MainController_hide")
    YIELD(TT, 600)
    self:UnLock(lockName)
    self.hide = true
  end)
end

function UICN7N36MainController:_OnValue()
  self:_RefreshMoney()
end

function UICN7N36MainController:_OnItemCountChanged()
  self:_RefreshMoney()
end

function UICN7N36MainController:_RefreshMoney()
  if self._campaign then
    local lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
    if lotteryComponentInfo then
      local curCount = ClientCampaignDrawShop.GetMoney(lotteryComponentInfo.m_cost_item_id)
      self._moneyValue:SetText(curCount)
    end
  end
end

function UICN7N36MainController:_RefreshComponentState()
  self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN] = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
  self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY] = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
  self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION] = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST] = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
end

function UICN7N36MainController:_RefreshButtonState()
end

function UICN7N36MainController:_CheckRedPointAll()
  self._shopRedPoint:SetActive(self._localProcess:ShopRedPoint())
  self._loginAwardRedPoint:SetActive(self._localProcess:AccumulateLoginReddot())
  self._battlePassBtnRedPoint:SetActive(self._localProcess:BattlePassRedPoint(self._battlePassCampaign))
  local questHasRed = self._campaign:CheckComponentRed(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self._gameRedPoint:SetActive(questHasRed)
end

function UICN7N36MainController:_Close()
  self:SwitchState(UIStateType.UIMain)
end

function UICN7N36MainController:_ShowActivityIntro(show)
  self._activityIntroBtn:SetActive(show)
end

function UICN7N36MainController:_SetRemainTime(pre_remaining, remaintime)
  self._remainTime:SetText(pre_remaining .. self:_GetRemainTime(remaintime))
end

function UICN7N36MainController:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UICN7N36MainController:_SetRemainingTimer()
  if not self._isOpen then
    return
  end
  local remaintime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sample = self._campaign:GetSample()
  if not sample then
    self._endObj:SetActive(true)
    self._lIneEndMaskObj:SetActive(true)
    self._remainTime:SetText(StringTable.Get("str_activity_finished"))
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    return true
  end
  local endtime = sample.end_time
  if self._line_componentInfo then
    remaintime = self._line_componentInfo.m_close_time - curtime
  end
  self:_ShowActivityIntro(0 < endtime - curtime)
  local pre_remaining = ""
  if 0 < remaintime then
    pre_remaining = StringTable.Get("str_activity_drop_time")
  else
    local sample = self._campaign:GetSample()
    remaintime = sample and sample.end_time - curtime or 0
    pre_remaining = StringTable.Get("str_activity_remaining_time")
  end
  self:_SetRemainTime(pre_remaining, remaintime)
  self:RefreshGameState(curtime)
  self:SetLineState()
  if remaintime <= 0 then
    self._remainTime:SetText(StringTable.Get("str_activity_finished"))
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    return true
  end
end

function UICN7N36MainController:_GetRemainTime(time)
  return self:_GetTime(time)
end

function UICN7N36MainController:_GetTime(seconds)
  if seconds < 0 then
    seconds = 0
  end
  local dayStr = "str_activity_day"
  local hourStr = "str_activity_hour"
  local minusStr = "str_activity_minus"
  local lessOneMinusStr = "str_activity_less_one_minus"
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get(dayStr, day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get(hourStr, hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get(hourStr, hour)
    end
    local minus = math.floor(seconds / 60)
    if 0 < minus then
      timeStr = timeStr .. StringTable.Get(minusStr, minus)
    end
  else
    timeStr = StringTable.Get(lessOneMinusStr)
  end
  return timeStr
end

function UICN7N36MainController:ActivityIntroBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UICN7N36IntroController", "UICN7N36MainController")
end

function UICN7N36MainController:ShopBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local open = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
  if not open then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UICN7N36ShopController")
  local key = self.pstid .. "UICN7N36MainLobbyEntry_ShopNew"
  LocalDB.SetString(key, "new")
  self:CheckNew()
end

function UICN7N36MainController:BattlePassBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  UIActivityBattlePassHelper.OpenMainController()
end

function UICN7N36MainController:LoginAwardBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN] then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UICN7N36TotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_INLAND_N7, ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
end

function UICN7N36MainController:BgOnClick(go)
  if self.hide then
    local lockName = "UICN7N36MainController:AnimShow"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._animation:Play("uieff_UICN7N36MainController_show")
      YIELD(TT, 300)
      self:UnLock(lockName)
    end)
    self.hide = false
  end
end

function UICN7N36MainController:LineBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._componentState[ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION] then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UICN7N36Line", 1, true)
  local key = self.pstid .. "UICN7N36MainLobbyEntry_LineNew"
  LocalDB.SetString(key, "new")
  self:CheckNew()
end

function UICN7N36MainController:GameBtnOnClick(go)
  local End = self:CheckActivityEnd()
  if End then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:_ForceRefresh()
  local remaintime = 0
  local opentime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local open = self._game_component:ComponentIsOpen()
  local endtime = self._campaign:GetSample().end_time
  if self._game_componentInfo then
    remaintime = self._game_componentInfo.m_close_time - curtime
    opentime = curtime - self._game_componentInfo.m_unlock_time
  end
  if remaintime < 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  elseif opentime < 0 then
    local time = math.abs(opentime)
    local timeStr = self:_GetTime(time)
    ToastManager.ShowToast(StringTable.Get("str_activity_lock_time_tips", timeStr))
    return
  elseif not open and 0 <= opentime then
    ToastManager.ShowToast(StringTable.Get("str_xiaolinjia_entry_6"))
    return
  end
  self:ShowDialog("UIXiaoLinJiaMainController")
  local key = self.pstid .. "UICN7N36MainLobbyEntry_GamesNew"
  LocalDB.SetString(key, "new")
  self:CheckNew()
end

function UICN7N36MainController:_PlayAnimIN()
  local lockName = "UICN7N36MainController:AnimIN"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UICN7N36MainController_in")
    YIELD(TT, 1000)
    self:UnLock(lockName)
  end)
end

function UICN7N36MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN7N36MainController)
end

function UICN7N36MainController:RefreshGameState(curtime)
  local open = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  local sample = self._campaign:GetSample()
  local ActivityTime = sample and sample.end_time - curtime or 0
  local gameRemainTime, openTime = 0, 0
  if self._game_componentInfo then
    gameRemainTime = self._game_componentInfo.m_close_time - curtime
    openTime = curtime - self._game_componentInfo.m_unlock_time
  end
  if ActivityTime <= 0 or gameRemainTime <= 0 then
    self._endObj:SetActive(true)
    return
  end
  if openTime <= 0 then
    local time = math.abs(openTime)
    local timeStr = self:_GetTime(time)
    self._lockObj:SetActive(true)
    self:SetOtherFalse("lockObj")
    self._lockTxt:SetText(StringTable.Get("str_xiaolinjia_entry_13", timeStr))
    self:_ForceRefresh()
    return
  elseif not open then
    self:_ForceRefresh()
    self._lockObj:SetActive(true)
    self._lockTxt:SetText(StringTable.Get("str_xiaolinjia_entry_6"))
    return
  end
  self:OtherState()
end

function UICN7N36MainController:OtherState()
  local passAll, passHide, passCurrent, diffTime, curUnlockMissionId, curNextUnlockMissionId = UIXiaoLinJiaMainController.GetMainActivityEntryState(self._game_component)
  local componentID = self._game_component:GetComponentCfgId()
  local cfg = Cfg.cfg_xiaolinjia_mission({ComponentID = componentID})
  if passHide then
    self:SetOtherFalse()
  elseif passAll then
    self._photoObj:SetActive(true)
    self:SetOtherFalse("photoObj")
  elseif 5 < curUnlockMissionId then
    self._unlockObj:SetActive(true)
    self:SetOtherFalse("unlockObj")
  elseif passCurrent then
    self._comingObj:SetActive(true)
    self:SetOtherFalse("comingObj")
    local timeStr = self:_GetTime(diffTime)
    self._comingTxt:SetText(StringTable.Get("str_xiaolinjia_entry_10", timeStr))
  else
    self._visitObj:SetActive(true)
    self:SetOtherFalse("visitObj")
    local visitStr = "str_xiaolinjia_entry_" .. curUnlockMissionId
    local Head
    for _, v in ipairs(cfg) do
      if v.ID == curUnlockMissionId then
        Head = v.ClosingHeadIcon
      end
    end
    self._visitIcon.sprite = self._atlas:GetSprite(Head)
    self._visitTxt:SetText(StringTable.Get(visitStr))
  end
end

function UICN7N36MainController:SetOtherFalse(GameObject)
  for key, value in pairs(self.StateObj) do
    if key ~= GameObject then
      value:SetActive(false)
    end
  end
end

function UICN7N36MainController:CheckActivityEnd()
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sample = self._campaign:GetSample()
  if not sample then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return true
  end
  local endtime = sample.end_time
  local remaintime = sample and endtime - curtime or 0
  if remaintime <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return true
  else
    return false
  end
end

function UICN7N36MainController:SetLineState()
  local open = self:_GetComponentState(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  self._lIneEndMaskObj:SetActive(not open)
end

function UICN7N36MainController:_ForceRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
  end, self)
end
