_class("UIN15MainControllerReview", UIController)
UIN15MainControllerReview = UIN15MainControllerReview

function UIN15MainControllerReview:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN15MainControllerReview:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N15)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_REVIEW_N15)
  self._line_mission_cpt = self._campaign:GetComponent(ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION)
  self._line_mission_info = self._campaign:GetComponentInfo(ECampaignReviewN15ComponentID.ECAMPAIGN_REVIEW_ReviewN15_LINE_MISSION)
end

function UIN15MainControllerReview:OnShow(uiParams)
  self:_InitParams(uiParams)
  self:_InitWidget()
  self:_RefView()
  self:_PlayAudio()
end

function UIN15MainControllerReview:OnHide()
  self._isOpen = false
end

function UIN15MainControllerReview:_InitParams(uiParams)
  self._componentState = {}
  self._reds = {}
  self._news = {}
  self._objs = {}
  self._showSpine = false
  self._isOpen = true
end

function UIN15MainControllerReview:_InitWidget()
  self._line_state_i = self:GetGameObject("_line_state_i")
  self._line_state_ii = self:GetGameObject("_line_state_ii")
  self._line_state_iii = self:GetGameObject("_line_state_iii")
  self._objs["0"] = self:GetGameObject("_need_hide_i")
  self._objs["1"] = self:GetGameObject("_need_hide_ii")
  self._objs["2"] = self:GetGameObject("_need_hide_iii")
  self._objs["3"] = self:GetGameObject("_need_hide_iiii")
  self._objs["4"] = self:GetGameObject("cover")
end

function UIN15MainControllerReview:_RefView()
  local back_btn = self:GetUIComponent("UISelectObjectPath", "_backBtn")
  self._commonTopBtn = back_btn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:_ShowBgSpine(true)
  end)
  self:_ClearNewFlag()
end

function UIN15MainControllerReview:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  if animationName then
    self._animation:Play(animationName)
  else
    for _, need_hide in pairs(self._objs) do
      need_hide:SetActive(not showSpine)
    end
  end
end

function UIN15MainControllerReview:_RefAllState(remain_time)
  self:_RefRaffleState(remain_time)
  self:_RefLineState(remain_time)
  self:_RefRedState(remain_time)
end

function UIN15MainControllerReview:_RefRaffleState(remain_time)
end

function UIN15MainControllerReview:_RefLineState(remain_time)
  local remainTime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  remainTime = self._line_mission_info.m_close_time - curtime
  local lock = 0 < remainTime
  self._line_state_i:SetActive(not lock)
  self._line_state_ii:SetActive(not lock)
  self._line_state_iii:SetActive(not lock)
end

function UIN15MainControllerReview:_RefRedState(remain_time)
end

function UIN15MainControllerReview:_ClearNewFlag()
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

function UIN15MainControllerReview:BgBtnOnClick()
  if self._showSpine then
    self:_ShowBgSpine(false)
  end
end

function UIN15MainControllerReview:NormalLevelBtnOnClick(go)
  self._campaignModule:CampaignSwitchState(true, UIStateType.UIN15LineMissionControllerReview, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN15MainControllerReview:_PlayAudio()
  self:StartTask(function(TT)
    YIELD(TT, 125)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15SwitchState)
  end, self)
end
