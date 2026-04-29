_class("UIN48MainController", UIShareController)
UIN48MainController = UIN48MainController

function UIN48MainController:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN48MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N48)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._campaign_chess = UIActivityCampaign:New()
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N48)
  self._line_mission_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("line"))
  self._hard_mission_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("black"))
  self._black_mission_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("black"))
  self._pet_try_cpt = self._process:GetComponent(ECampaignN48ComponentID.ECAMPAIGN_N48_LEVEL_FIXTEAM)
  self._login_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("login"))
  self._raffle_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("shop"))
  self._physical_power_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("power"))
  self._line_mission_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("line"))
  self._hard_mission_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("black"))
  self._pet_try_info = self._process:GetComponentInfo(ECampaignN48ComponentID.ECAMPAIGN_N48_LEVEL_FIXTEAM)
  self._login_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("login"))
  self._raffle_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("shop"))
  self._physical_power_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("power"))
  self._battlePassCampaign = UIActivityCampaign:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  self._chess_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("game"))
  self._chess_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("game"))
end

function UIN48MainController:OnShow(uiParams)
  self:_AttachEvent()
  self:_InitParams(uiParams)
  self:_InitWidget()
  self:_RefView()
  self:_CheckGuide()
  self:_PlayAudio()
  self:_PlayAnim("uieffanim_UIN48MainController_in")
end

function UIN48MainController:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIN48MainController:_AttachEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN48MainController:_InitParams(uiParams)
  self.isFromSub = uiParams[1] or false
  self.rt = uiParams[2]
  self._componentState = {}
  self._reds = {}
  self._news = {}
  self._objs = {}
  self._showSpine = false
  self._isOpen = true
end

function UIN48MainController:_InitWidget()
  self._anim = self:GetUIComponent("Animation", "UIN48MainController")
  self._remainTime = self:GetUIComponent("UILocalizationText", "_remainTime")
  self._raffle_token_ii = self:GetUIComponent("UILocalizationText", "_raffle_token_ii")
  self._login_state = self:GetGameObject("_login_state")
  self._line_state_i = self:GetGameObject("_line_state_i")
  self._line_state_ii = self:GetGameObject("_line_state_ii")
  self._line_state_iii = self:GetGameObject("_line_state_iii")
  self._line_state_iiii = self:GetGameObject("_line_state_iiii")
  self._line_remainTime = self:GetUIComponent("UILocalizationText", "_line_remainTime")
  self._hard_state_i = self:GetGameObject("_hard_state_i")
  self._hard_state_ii = self:GetGameObject("_hard_state_ii")
  self._hard_state_iii = self:GetGameObject("_hard_state_iii")
  self._hard_state_iiii = self:GetGameObject("_hard_state_iiii")
  self._hard_remain_time = self:GetUIComponent("UILocalizationText", "_hard_remain_time")
  self._raffle_state_i = self:GetGameObject("_raffle_state_i")
  self._raffle_state_ii = self:GetGameObject("_raffle_state_ii")
  self._raffle_state_iii = self:GetGameObject("_raffle_state_iii")
  self._raffle_state_iiii = self:GetGameObject("_raffle_state_iiii")
  self._raffle_remainTime = self:GetUIComponent("UILocalizationText", "_raffle_remainTime")
  self._chess_state_i = self:GetGameObject("_chess_state_i")
  self._chess_state_ii = self:GetGameObject("_chess_state_ii")
  self._chess_state_iii = self:GetGameObject("_chess_state_iii")
  self._chess_state_iiii = self:GetGameObject("_chess_state_iiii")
  self._chess_remain_time = self:GetUIComponent("UILocalizationText", "_chess_remainTime")
  self._reds[UIActivityN48Helper.GetComponentId("login")] = self:GetGameObject("_redPoint_login")
  self._reds[UIActivityN48Helper.GetComponentId("line")] = self:GetGameObject("_redPoint_level")
  self._reds[UIActivityN48Helper.GetComponentId("shop")] = self:GetGameObject("_redPoint_raffle")
  self._reds[UIActivityN48Helper.GetComponentId("black")] = self:GetGameObject("_redPoint_hard")
  self._reds[ECampaignType.CAMPAIGN_TYPE_BATTLEPASS] = self:GetGameObject("_redPoint_battlePass")
  self._reds[UIActivityN48Helper.GetComponentId("game")] = self:GetGameObject("red")
  self._news[UIActivityN48Helper.GetComponentId("shop")] = self:GetGameObject("_newPoint_raffle")
  self._news[UIActivityN48Helper.GetComponentId("game")] = self:GetGameObject("new")
  self._news[UIActivityN48Helper.GetComponentId("black")] = self:GetGameObject("_hard_new")
  self._news[UIActivityN48Helper.GetComponentId("login")] = self:GetGameObject("_loginNew")
  self._news[ECampaignType.CAMPAIGN_TYPE_BATTLEPASS] = self:GetGameObject("_battleNew")
  self._news[UIActivityN48Helper.GetComponentId("line")] = self:GetGameObject("_lineNew")
  self._objs["0"] = self:GetGameObject("_need_hide_i")
  self._objs["1"] = self:GetGameObject("_need_hide_ii")
  self._objs["2"] = self:GetGameObject("_need_hide_iii")
  self._objs["3"] = self:GetGameObject("_need_hide_iiii")
  self._objs["4"] = self:GetGameObject("cover")
end

function UIN48MainController:_OnAfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshMoney()
end

function UIN48MainController:_RefreshMoney()
  local itemId = self._raffle_cpt:GetCostItemId()
  local count = ClientCampaignDrawShop.GetMoney(itemId)
  self._raffle_token_ii:SetText(count)
end

function UIN48MainController:_RefreshComponentState()
  for key, value in pairs(ECampaignN48ComponentID) do
    self._componentState[value] = self._campaign:CheckComponentOpen(value)
  end
end

function UIN48MainController:_RefRemainTime()
  local str = "str_N48_remain_time_activity"
  local remainTime = 0
  local raffleTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = self._line_mission_info.m_close_time
  remainTime = endtime - curtime
  raffleTime = self._raffle_info.m_close_time - curtime
  if 0 < raffleTime then
    str = "str_n48_shop_close_time_tips"
    self._remainTime:SetText(StringTable.Get(str, N48ToolFunctions.GetRemainTime(raffleTime)))
  else
    self._remainTime:SetText(StringTable.Get(str, N48ToolFunctions.GetRemainTime(remainTime)))
  end
  return raffleTime
end

function UIN48MainController:_RefView()
  self:_SetCommonTopButton()
  self:_SetTimer()
  self:_ClearNewFlag()
end

function UIN48MainController:_SetCommonTopButton()
  local shareComponent = self._process:GetComponent(ECampaignN48ComponentID.ECAMPAIGN_N14_SHARED)
  self:InitShare(shareComponent, "_shareTip")
  
  local function closeCallback()
    self:SwitchState(UIStateType.UIMain)
  end
  
  local function hideCallback()
    self:_HideUI(true)
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtn", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback, nil, nil)
end

function UIN48MainController:_HideUI(showSpine, animationName)
  self._showSpine = true
  self:_PlayAnim("uieffanim_UIN48MainController_hide")
end

function UIN48MainController:_RefAllState(remain_time)
  self:_RefLoginState(remain_time)
  self:_RefRaffleState(remain_time)
  self:_RefLineState(remain_time)
  self:_RefRedState(remain_time)
  self:_RefHardLineState(remain_time)
  self:_RefChessState(remain_time)
end

function UIN48MainController:_RefLoginState()
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._login_info.m_close_time - curtime
  self._login_state:SetActive(not (0 < remainTime))
end

function UIN48MainController:_RefChessState(remain_time)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  startTime = self._chess_info.m_unlock_time - curtime
  if startTime <= 0 and not self._chessCo then
    self._chessCo = self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      self._process = self._campaign:GetLocalProcess()
      self._chess_cpt = self._process:GetComponent(UIActivityN48Helper.GetComponentId("game"))
      self._chess_info = self._process:GetComponentInfo(UIActivityN48Helper.GetComponentId("game"))
      self:_RefreshComponentState()
    end)
  end
  remainTime = self._chess_info.m_close_time - curtime
  if remainTime < 0 then
    self._chess_state_i:SetActive(true)
    self._chess_state_ii:SetActive(false)
    self._chess_state_iii:SetActive(false)
    self._chess_state_iiii:SetActive(true)
    return
  end
  local start = self._chess_info.m_b_unlock or startTime < 0
  self._chess_state_i:SetActive(not start)
  self._chess_state_ii:SetActive(not start)
  self._chess_state_iii:SetActive(start)
  self._chess_state_iiii:SetActive(false)
  local status, time = UIActivityN48Helper.CheckComponentStatus(self._chess_cpt)
  if status == ActivityN48ComponentStatus.Close then
  elseif status == ActivityN48ComponentStatus.ActivityEnd then
  elseif status == ActivityN48ComponentStatus.TimeLock then
    self._chess_state_iii:SetActive(true)
    self._chess_remain_time:SetText(StringTable.Get("str_n48_main_btn_unlock_time", N48ToolFunctions.GetRemainTime(startTime), "", ""))
  elseif status == ActivityN48ComponentStatus.MissionLock then
  else
    self._chess_state_iii:SetActive(true)
    self._chess_remain_time:SetText(StringTable.Get("str_n48_remain_time_in_activity", N48ToolFunctions.GetRemainTime(remainTime)))
  end
end

function UIN48MainController:_RefRaffleState(remain_time)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  startTime = self._raffle_info.m_unlock_time - curtime
  remainTime = self._raffle_info.m_close_time - curtime
  if remain_time < 0 then
    self._raffle_state_i:SetActive(true)
    self._raffle_state_ii:SetActive(false)
    self._raffle_state_iii:SetActive(false)
    self._raffle_state_iiii:SetActive(true)
    return
  end
  local start = self._raffle_info.m_b_unlock
  self._raffle_state_i:SetActive(not start)
  self._raffle_state_ii:SetActive(not start)
  self._raffle_state_iii:SetActive(start)
  self._raffle_state_iiii:SetActive(false)
  if self._raffle_info and not start then
    local cfgv = Cfg.cfg_campaign_mission[self._raffle_info.m_need_mission_id]
    if cfgv then
      self._raffle_remainTime:SetText(StringTable.Get("str_n48_activity_hard_level_lock_mission_tips", cfgv.Name))
    else
      self._raffle_remainTime:SetText("")
    end
  else
    self._raffle_remainTime:SetText("")
  end
end

function UIN48MainController:_RefLineState(remain_time)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._line_mission_info.m_close_time - curtime
  local lock = 0 < remainTime
  self._line_state_i:SetActive(not lock)
  self._line_state_ii:SetActive(false)
  self._line_state_iii:SetActive(lock)
  self._line_state_iiii:SetActive(not lock)
  self._line_remainTime:SetText(StringTable.Get("str_n48_remain_time_in_activity", N48ToolFunctions.GetRemainTime(remainTime)))
end

function UIN48MainController:_RefHardLineState(remain_time)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  startTime = self._hard_mission_info.m_unlock_time - curtime
  remainTime = self._hard_mission_info.m_close_time - curtime
  if remainTime < 0 then
    self._hard_state_i:SetActive(true)
    self._hard_state_ii:SetActive(false)
    self._hard_state_iii:SetActive(false)
    self._hard_state_iiii:SetActive(true)
    return
  end
  local start = startTime < 0 and self._hard_mission_info.m_b_unlock
  self._hard_state_i:SetActive(not start)
  self._hard_state_ii:SetActive(not start)
  self._hard_state_iii:SetActive(start)
  self._hard_state_iiii:SetActive(false)
  local status, time = UIActivityN48Helper.CheckComponentStatus(self._hard_mission_cpt)
  local cfgv = Cfg.cfg_campaign_mission[self._hard_mission_info.m_need_mission_id]
  if status == ActivityN48ComponentStatus.Close then
  elseif status == ActivityN48ComponentStatus.ActivityEnd then
  elseif status == ActivityN48ComponentStatus.TimeLock then
    self._hard_state_iii:SetActive(true)
    self._hard_remain_time:SetText(StringTable.Get("str_n48_main_btn_unlock_time", N48ToolFunctions.GetRemainTime(startTime), "", ""))
  elseif status == ActivityN48ComponentStatus.MissionLock then
  else
    self._hard_state_iii:SetActive(true)
    self._hard_remain_time:SetText(StringTable.Get("str_n48_remain_time_in_activity", N48ToolFunctions.GetRemainTime(remainTime)))
  end
end

function UIN48MainController:_RefRedState(remain_time)
  local red_level = self._process:LineMissionRedDot()
  local new_level = self._process:GetLineMissionNew()
  self._reds[UIActivityN48Helper.GetComponentId("line")]:SetActive(red_level and not new_level)
  self._news[UIActivityN48Helper.GetComponentId("line")]:SetActive(new_level)
  local red_login = self._campaign:CheckComponentRed(UIActivityN48Helper.GetComponentId("login"))
  local red_new = self._process:GetLoginNew()
  self._news[UIActivityN48Helper.GetComponentId("login")]:SetActive(red_new)
  self._reds[UIActivityN48Helper.GetComponentId("login")]:SetActive(red_login and not red_new)
  local red_hard = self._process:DifficultyMissionRedDot()
  local new_hard = self._process:GetHardLineNew()
  self._news[UIActivityN48Helper.GetComponentId("black")]:SetActive(new_hard)
  self._reds[UIActivityN48Helper.GetComponentId("black")]:SetActive(red_hard and not new_hard)
  local red_bp = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlePassCampaign)
  local new_bp = self._process:GetBattlePassNew()
  self._news[ECampaignType.CAMPAIGN_TYPE_BATTLEPASS]:SetActive(new_bp)
  self._reds[ECampaignType.CAMPAIGN_TYPE_BATTLEPASS]:SetActive(red_bp and not new_bp)
  local red_shop = false
  local new_shop = self._process:GetLottleryNew()
  self._news[UIActivityN48Helper.GetComponentId("shop")]:SetActive(new_shop)
  self._reds[UIActivityN48Helper.GetComponentId("shop")]:SetActive(red_shop and not new_shop)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if not self._chess_info then
    return
  end
  startTime = self._chess_info.m_unlock_time - curtime
  remainTime = self._chess_info.m_close_time - curtime
  self._news[UIActivityN48Helper.GetComponentId("game")]:SetActive(new_chess and startTime < 0)
end

function UIN48MainController:_ClearNewFlag()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
    if res:GetSucc() then
    end
  end, self)
end

function UIN48MainController:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIN48MainController:_SetRemainingTimer()
  if not self._isOpen then
    return
  end
  local remaintime = self:_RefRemainTime()
  self:_RefAllState(remaintime)
  if remaintime <= 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    return true
  end
end

function UIN48MainController:BgBtnOnClick()
  if self._showSpine then
    self:_PlayAnim("uieffanim_UIN48MainController_show")
    self._showSpine = false
  end
end

function UIN48MainController:ActivityIntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN48Intro", MaskType.MT_BlurMask)
end

function UIN48MainController:BattlePassBtnOnClick(go)
  self._process:ClearBattlePassNew()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIN48MainController:LoginAwardBtnOnClick(go)
  if not self._componentState[UIActivityN48Helper.GetComponentId("login")] then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  end
  self._process:ClearLoginNew()
  self:ShowDialog("UIActivityTotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_N48, UIActivityN48Helper.GetComponentId("login"))
end

function UIN48MainController:NormalLevelBtnOnClick(go)
  if not self._componentState[UIActivityN48Helper.GetComponentId("login")] then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  end
  self._process:ClearLineMissionNew()
  UIActivityN48Helper.LocalDB_Set_CrossDay("line", "Red")
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN48LineMissionController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN48MainController:HardLevelBtnOnClick(go)
  local status, time = UIActivityN48Helper.CheckComponentStatus(self._hard_mission_cpt)
  local cfgv = Cfg.cfg_campaign_mission[self._hard_mission_info.m_need_mission_id]
  if status == ActivityN48ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  elseif status == ActivityN48ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  elseif status == ActivityN48ComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return
  elseif status == ActivityN48ComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_hard_level_lock_mission_tips", StringTable.Get(cfgv.Name)))
    return
  end
  UIActivityN48Helper.LocalDB_Set_CrossDay("hard", "Red")
  self._process:ClearHardLineNew()
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN48HardController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN48MainController:RaffleBtnOnClick(go)
  if not self._raffle_info.m_b_unlock then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  end
  if not self._componentState[UIActivityN48Helper.GetComponentId("shop")] then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self._process:ClearLottleryNew()
  UIActivityHelper.OpenCampaignShop(self._campaign)
end

function UIN48MainController:ChessBtnOnClick(go)
  local status, time = UIActivityN48Helper.CheckComponentStatus(self._chess_cpt)
  local cfgv = Cfg.cfg_campaign_mission[self._chess_info.m_need_mission_id]
  if status == ActivityN48ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    return
  elseif status == ActivityN48ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_end"))
    self:SwitchState(UIStateType.UIMain)
    return
  elseif status == ActivityN48ComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
    return
  elseif status == ActivityN48ComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get("str_n48_activity_hard_level_lock_mission_tips", StringTable.Get(cfgv.Name)))
    return
  end
  self._process:ClearChessNew()
  self:ShowDialog("UIMiniGameStageController", self._campaign, self._chess_cpt)
end

function UIN48MainController:_CheckGuide()
  self:Lock("UIN48MainControllerCheckGuide")
  self:StartTask(function(TT)
    YIELD(TT, 1600)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN48MainController)
    self:UnLock("UIN48MainControllerCheckGuide")
  end, self)
end

function UIN48MainController:_PlayAudio()
  self:StartTask(function(TT)
    YIELD(TT, 125)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N48SwitchState)
  end, self)
end

function UIN48MainController:_PlayAnim(anim)
  self._anim:Play(anim)
end
