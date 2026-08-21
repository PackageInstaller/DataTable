_class("UIN13MainControllerReview", UIController)
UIN13MainControllerReview = UIN13MainControllerReview

function UIN13MainControllerReview:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN13MainControllerReview:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N13)
  else
    self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_REVIEW_N13)
  self._line_mission_cpt = self._campaign:GetComponent(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION)
  self._build_cpt = self._campaign:GetComponent(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD)
  self._line_mission_info = self._campaign:GetComponentInfo(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION)
  self._build_info = self._campaign:GetComponentInfo(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._battlePassCampaign._id, nil, nil)
    return
  end
  self._componentId = ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD
  self._component = self._campaign:GetComponent(self._componentId)
  self._buildManager = UIBuildComponentManager:New(self._component)
  self.playerID = GameGlobal.GameLogic():GetOpenId()
end

function UIN13MainControllerReview:OnShow(uiParams)
  self:_AttachEvent()
  self:_OnValue(uiParams)
  self:_GetComponent()
  self:_OnShow()
end

function UIN13MainControllerReview:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIN13MainControllerReview:_AttachEvent()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN13MainControllerReview:_OnValue(uiParams)
  self._rt = uiParams[1]
  self._componentState = {}
  self._btnImg = {}
  self._reds = {}
  self._news = {}
  self._objs = {}
  self._showSpine = false
  self._garden_lock_true = false
  self._isOpen = true
end

function UIN13MainControllerReview:_GetComponent()
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._sakuragari_token_i = self:GetUIComponent("UILocalizationText", "_sakuragari_token_i")
  self._sakuragari_token_ii = self:GetUIComponent("UILocalizationText", "_sakuragari_token_ii")
  self._login_state = self:GetGameObject("_login_state")
  self._line_state_i = self:GetGameObject("_line_state_i")
  self._line_state_ii = self:GetGameObject("_line_state_ii")
  self._sakuragari_state_i = self:GetGameObject("_sakuragari_state_i")
  self._sakuragari_state_ii = self:GetGameObject("_sakuragari_state_ii")
  self._garden_lock = self:GetGameObject("_garden_lock")
  self._btnImg[ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION] = self:GetUIComponent("Image", "_normal_level")
  self._reds[ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION] = self:GetGameObject("_redPoint_level")
  self._redsBuild = self:GetGameObject("_redPoint_sakuragar")
  self._objs["0"] = self:GetGameObject("_need_hide_i")
  self._objs["1"] = self:GetGameObject("_need_hide_ii")
  self._objs["2"] = self:GetGameObject("_need_hide_iii")
  self._objs["3"] = self:GetGameObject("_need_hide_iiii")
  self._screenCut = self:GetUIComponent("RawImage", "ScreenCut")
end

function UIN13MainControllerReview:_OnAfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshMoney()
end

function UIN13MainControllerReview:_RefreshMoney()
  local type = EnumN13Review.B
  local count = UIActivityN13Helper.GetCoinItemCount(type)
  self._sakuragari_token_i:SetText(string.format("%07d", count))
  self._sakuragari_token_ii:SetText(count)
end

function UIN13MainControllerReview:_RefreshComponentState()
  for key, value in pairs(ECampaignReviewN13ComponentID) do
    self._componentState[value] = self:_GetComponentState(value)
    if not self._btnImg[value] or self._componentState[value] then
    else
    end
  end
end

function UIN13MainControllerReview:_RefRemainTime()
  local str = "str_n13_active_remaining_time"
  local remainTime = 0
  local sakuragariTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = self._campaign:GetSample().end_time
  remainTime = endtime - curtime
  sakuragariTime = self._build_info.m_close_time - curtime
  return remainTime
end

function UIN13MainControllerReview:_OnShow()
  if self._rt then
    self._screenCut.texture = self._rt
    self._animation:Play("uieff_n13_main_in")
    self:StartTask(function(TT)
      local lockName = "UIN13MainControllerReview:_OnShow"
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
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:_ShowBgSpine(true, "uieff_n13_main_hide")
  end)
  self:_SetTimer()
  self:_ClearNewFlag()
end

function UIN13MainControllerReview:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN13MainControllerReview:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  if animationName then
    self._animation:Play(animationName)
  else
    for _, need_hide in pairs(self._objs) do
      need_hide:SetActive(not showSpine)
    end
  end
end

function UIN13MainControllerReview:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIN13MainControllerReview:_SetRemainingTimer()
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

function UIN13MainControllerReview:_RefAllState(remain_time)
  self:_RefSakuragariState(remain_time)
  self:_RefLineState(remain_time)
  self:_RefRedState(remain_time)
end

function UIN13MainControllerReview:_RefSakuragariState(remain_time)
  local remainTime = 0
  local startTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  startTime = self._build_info.m_unlock_time - curtime
  remainTime = self._build_info.m_close_time - curtime
  if remainTime < 0 then
    self._sakuragari_state_i:SetActive(true)
    self._sakuragari_state_ii:SetActive(false)
    return
  end
  local start = self._build_info.m_b_unlock
  self._sakuragari_state_i:SetActive(not start)
  self._sakuragari_state_ii:SetActive(not start)
end

function UIN13MainControllerReview:_RefLineState(remain_time)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._line_mission_info.m_close_time - curtime
  local lock = 0 < remainTime
  if remainTime < 0 and not lock then
    self._line_state_i:SetActive(true)
    self._line_state_ii:SetActive(false)
    return
  end
  local start = self._line_mission_info.m_b_unlock
  self._line_state_i:SetActive(not start)
  self._line_state_ii:SetActive(not start)
end

function UIN13MainControllerReview:_RefRedState(remain_time)
  local red_level = self._campaign:CheckComponentRed(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION)
  self._reds[ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION]:SetActive(red_level)
  local unlock, all = self._buildManager:CalcBuildUnlockProgress()
  local value = LocalDB.GetInt(self.playerID .. "UIN13BuildPlotControllerReviewExtOnClickTrue")
  local red_sakuragari = self._campaign:CheckComponentRed(ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD)
  if red_sakuragari or unlock == all and value ~= 1 then
    self._redsBuild:SetActive(true)
  else
    self._redsBuild:SetActive(false)
  end
end

function UIN13MainControllerReview:_ClearNewFlag()
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

function UIN13MainControllerReview:BgBtnOnClick()
  if self._showSpine then
    self:_ShowBgSpine(false, "uieff_n13_main_show")
  end
end

function UIN13MainControllerReview:NormalLevelBtnOnClick(go)
  if not self._componentState[ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_LINE_MISSION] then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_over"))
    return
  end
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN13LineMissionControllerReview, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN13MainControllerReview:SakuragariBtnOnClick(go)
  if not self._build_info.m_b_unlock then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_lock"))
    return
  end
  if not self._componentState[ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD] then
    ToastManager.ShowToast(StringTable.Get("str_n13_activity_over"))
    return
  end
  UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignReviewN13ComponentID.ECAMPAIGN_REVIEW_ReviewN13_BUILD, function()
    self:SwitchState(UIStateType.UIN13BuildControllerReview)
  end, false)
end
