_class("UIN13MainController", UIController)
UIN13MainController = UIN13MainController

function UIN13MainController:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN13MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N13)
  else
    self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N13)
  self._line_mission_cpt = self._campaign:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION)
  self._pet_try_cpt = self._campaign:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM)
  self._login_cpt = self._campaign:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN)
  self._build_cpt = self._campaign:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD)
  self._physical_power_cpt = self._campaign:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM)
  self._line_mission_info = self._campaign:GetComponentInfo(ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION)
  self._pet_try_info = self._campaign:GetComponentInfo(ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM)
  self._login_info = self._campaign:GetComponentInfo(ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN)
  self._build_info = self._campaign:GetComponentInfo(ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD)
  self._physical_power_info = self._campaign:GetComponentInfo(ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM)
  self._battlePassCampaign = UIActivityCampaign:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._battlePassCampaign._id, nil, nil)
    return
  end
end

function UIN13MainController:OnShow(uiParams)
  self:_AttachEvent()
  self:_OnValue(uiParams)
  self:_GetComponent()
  self:_OnShow()
end

function UIN13MainController:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIN13MainController:_AttachEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN13MainController:_OnValue(uiParams)
  self._rt = uiParams[1]
  self._componentState = {}
  self._btnImg = {}
  self._reds = {}
  self._news = {}
  self._objs = {}
  self._showSpine = false
  self._garden_lock_true = false
  self._isOpen = true
  self:_CheckGuide()
end

function UIN13MainController:_GetComponent()
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._remainTime = self:GetUIComponent("UILocalizationText", "_remainTime")
  self._sakuragari_token_i = self:GetUIComponent("UILocalizationText", "_sakuragari_token_i")
  self._sakuragari_token_ii = self:GetUIComponent("UILocalizationText", "_sakuragari_token_ii")
  self._login_state = self:GetGameObject("_login_state")
  self._line_state_i = self:GetGameObject("_line_state_i")
  self._line_state_ii = self:GetGameObject("_line_state_ii")
  self._line_state_iii = self:GetGameObject("_line_state_iii")
  self._sakuragari_state_i = self:GetGameObject("_sakuragari_state_i")
  self._sakuragari_state_ii = self:GetGameObject("_sakuragari_state_ii")
  self._sakuragari_state_iii = self:GetGameObject("_sakuragari_state_iii")
  self._sakuragari_state_iiii = self:GetGameObject("_sakuragari_state_iiii")
  self._garden_remainTime = self:GetUIComponent("UILocalizationText", "_garden_remainTime")
  self._garden_lock = self:GetGameObject("_garden_lock")
  self._btnImg[ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN] = self:GetUIComponent("Image", "_login_award")
  self._btnImg[ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION] = self:GetUIComponent("Image", "_normal_level")
  self._btnImg[ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM] = self:GetUIComponent("Image", "_sakuragari")
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN] = self:GetGameObject("_redPoint_login")
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION] = self:GetGameObject("_redPoint_level")
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM] = self:GetGameObject("_redPoint_sakuragar")
  self._redBp = self:GetGameObject("_redPoint_bp")
  self._news[ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM] = self:GetGameObject("_newPoint_sakuragar")
  self._objs["0"] = self:GetGameObject("_need_hide_i")
  self._objs["1"] = self:GetGameObject("_need_hide_ii")
  self._objs["2"] = self:GetGameObject("_need_hide_iii")
  self._objs["3"] = self:GetGameObject("_need_hide_iiii")
  self._screenCut = self:GetUIComponent("RawImage", "ScreenCut")
end

function UIN13MainController:_OnAfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshMoney()
end

function UIN13MainController:_RefreshMoney()
  local count = UIActivityN13Helper.GetCoinItemCount()
  self._sakuragari_token_i:SetText(string.format("%07d", count))
  self._sakuragari_token_ii:SetText(count)
end

function UIN13MainController:_RefreshComponentState()
  for key, value in pairs(ECampaignN13ComponentID) do
    self._componentState[value] = self:_GetComponentState(value)
    if not self._btnImg[value] or self._componentState[value] then
    else
    end
  end
end

function UIN13MainController:_RefRemainTime()
  local str = "str_n13_active_remaining_time"
  local remainTime = 0
  local sakuragariTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = self._campaign:GetSample().end_time
  remainTime = endtime - curtime
  sakuragariTime = self._build_info.m_close_time - curtime
  if 0 < sakuragariTime then
    str = "str_n13_garden_remaining_time"
    self._remainTime:SetText(StringTable.Get(str, N13ToolFunctions.GetRemainTime(sakuragariTime)))
  else
    self._remainTime:SetText(StringTable.Get(str, N13ToolFunctions.GetRemainTime(remainTime)))
  end
  return remainTime
end

function UIN13MainController:_OnShow()
  if self._rt then
    self._screenCut.texture = self._rt
    self._animation:Play("uieff_n13_main_in")
    self:StartTask(function(TT)
      local lockName = "UIN13MainController:_OnShow"
      self:Lock(lockName)
      YIELD(TT, 600)
      self._screenCut.gameObject:SetActive(false)
      YIELD(TT, 600)
      self._objs["0"]:SetActive(true)
      self:UnLock(lockName)
    end)
  else
    self._screenCut.gameObject:SetActive(false)
    self._objs["0"]:SetActive(true)
  end
  local back_btn = self:GetUIComponent("UISelectObjectPath", "_backBtn")
  self._commonTopBtn = back_btn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    self:_ShowBgSpine(true, "uieff_n13_main_hide")
  end)
  self:_SetTimer()
  self:_ClearNewFlag()
end

function UIN13MainController:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN13MainController:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  if animationName then
    self._animation:Play(animationName)
  else
    for _, need_hide in pairs(self._objs) do
      need_hide:SetActive(not showSpine)
    end
  end
end

function UIN13MainController:_RefAllState(remain_time)
  self:_RefLoginState(remain_time)
  self:_RefSakuragariState(remain_time)
  self:_RefLineState(remain_time)
  self:_RefRedState(remain_time)
end

function UIN13MainController:_RefLoginState(remain_time)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._login_info.m_close_time - curtime
  self._login_state:SetActive(not (0 < remainTime))
end

function UIN13MainController:_RefSakuragariState(remain_time)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  startTime = self._build_info.m_unlock_time - curtime
  remainTime = self._build_info.m_close_time - curtime
  if remainTime < 0 then
    self._sakuragari_state_i:SetActive(true)
    self._sakuragari_state_ii:SetActive(false)
    self._sakuragari_state_iii:SetActive(false)
    self._sakuragari_state_iiii:SetActive(true)
    return
  end
  local start = self._build_info.m_b_unlock
  self._sakuragari_state_i:SetActive(not start)
  self._sakuragari_state_ii:SetActive(not start)
  self._sakuragari_state_iii:SetActive(not start)
  self._sakuragari_state_iiii:SetActive(false)
  if self._build_info and not start then
    local cfgv = Cfg.cfg_campaign_mission[self._build_info.m_need_mission_id]
    if cfgv then
      self._garden_remainTime:SetText(StringTable.Get("str_n13_pass_level_unlock", cfgv.Name))
    else
      self._garden_remainTime:SetText(StringTable.Get("str_n13_garden_remaining_open_time", N13ToolFunctions.GetRemainTime(startTime)))
    end
  else
    self._garden_remainTime:SetText(StringTable.Get("str_n13_garden_remaining_time", N13ToolFunctions.GetRemainTime(remainTime)))
  end
end

function UIN13MainController:_RefLineState(remain_time)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._line_mission_info.m_close_time - curtime
  local lock = 0 < remainTime
  if remainTime < 0 and not lock then
    self._line_state_i:SetActive(true)
    self._line_state_ii:SetActive(false)
    self._line_state_iii:SetActive(true)
    return
  end
  local start = self._line_mission_info.m_b_unlock
  self._line_state_i:SetActive(not start)
  self._line_state_ii:SetActive(not start)
  self._line_state_iii:SetActive(false)
end

function UIN13MainController:_RefRedState(remain_time)
  local red_level = self._campaign:CheckComponentRed(ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION)
  local red_fix = self._process:GetFixMissionRedDot()
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION]:SetActive(red_level or red_fix)
  local red_login = self._campaign:CheckComponentRed(ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN)
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN]:SetActive(red_login)
  local red_sakuragari = self._process:GetSakuragariRedDot()
  local new_sakuragari = self._process:GetSakuragariNew()
  self._news[ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM]:SetActive(new_sakuragari)
  self._reds[ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM]:SetActive(red_sakuragari and not new_sakuragari)
  local red_bp = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlePassCampaign)
end

function UIN13MainController:_ClearNewFlag()
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

function UIN13MainController:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIN13MainController:_SetRemainingTimer()
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

function UIN13MainController:BgBtnOnClick()
  if self._showSpine then
    self:_ShowBgSpine(false, "uieff_n13_main_show")
  end
end

function UIN13MainController:ActivityIntroBtnOnClick(go)
  self:ShowDialog("UIN13IntroController", "UIN13MainController", 1)
end

function UIN13MainController:BattlePassBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()
end

function UIN13MainController:LoginAwardBtnOnClick(go)
  if not self._componentState[ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN] then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_over"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_N13, ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN)
end

function UIN13MainController:NormalLevelBtnOnClick(go)
  if not self._componentState[ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION] then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_over"))
    return
  end
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN13LineMissionController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN13MainController:SakuragariBtnOnClick(go)
  if not self._build_info.m_b_unlock then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_lock"))
    return
  end
  if not self._componentState[ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD] then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_over"))
    return
  end
  UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD, function()
    self:SwitchState(UIStateType.UIN13BuildController)
  end, false)
end

function UIN13MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN13MainController)
end
