_class("UIActivityN11MainController_Review", UIController)
UIActivityN11MainController_Review = UIActivityN11MainController_Review

function UIActivityN11MainController_Review:Constructor(ui_root_transform)
  self.strsLeftTime = {
    "str_n11_left_time_d_h",
    "str_n11_left_time_h_m",
    "str_n11_left_time_m"
  }
  self.strsTakeAwardLeftTime = {
    "str_n11_take_award_left_time_d_h",
    "str_n11_take_award_left_time_h_m",
    "str_n11_take_award_left_time_m"
  }
  self.strsWillOpen = {
    "str_n11_will_open_after_d_h",
    "str_n11_will_open_after_h_m",
    "str_n11_will_open_after_m"
  }
end

function UIActivityN11MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N11)
  self.mCampaign = self:GetModule(CampaignModule)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not self._campaign then
    return
  end
  self.isShow = true
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIActivityN11MainController_Review:OnShow(uiParams)
  self.atlas = self:GetAsset("UIN11.spriteatlas", LoadType.SpriteAtlas)
  self.dictSprite = {
    [4] = {
      n = "n11_zjm_stage",
      d = "n11_zjm_stage_close"
    }
  }
  self.imgRT = uiParams[1]
  self.playFrom0 = uiParams[2]
  self.rt = self:GetUIComponent("RawImage", "rt")
  self.btnStageNormal = self:GetUIComponent("Button", "btnStageNormal")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._redStageNormal = self:GetGameObject("redStageNormal")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self.isShow = false
    self:ShowHideUI()
  end)
  self.anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.imgStageNormal = self:GetUIComponent("Image", "btnStageNormal")
  self.imgStageNormal.alphaHitTestMinimumThreshold = 0.1
  if self.playFrom0 then
  else
    local state = self.anim:get_Item("uieff_N11_Main_In")
    state.normalizedTime = 0.184
  end
  self.anim:Play()
  self:Flush()
end

function UIActivityN11MainController_Review:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self.btnStageNormal = nil
  self.btnStageHard = nil
end

function UIActivityN11MainController_Review:CancelTimerEventNormal()
  if self.teNormal then
    GameGlobal.Timer():CancelEvent(self.teNormal)
  end
end

function UIActivityN11MainController_Review:Flush()
  self.rt.texture = self.imgRT
  self:FlushNormalStage()
end

function UIActivityN11MainController_Review:GetSpriteN(idx)
  local n = self.atlas:GetSprite(self.dictSprite[idx].n)
  return n
end

function UIActivityN11MainController_Review:GetSpriteD(idx)
  local d = self.atlas:GetSprite(self.dictSprite[idx].d)
  return d
end

function UIActivityN11MainController_Review:FlushRedPointStageNormal()
  local red = false
  self._redStageNormal:SetActive(red)
end

function UIActivityN11MainController_Review:RegisterTimeEvent(seconds, componentId)
  if componentId == ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION then
    self:CancelTimerEventNormal()
  else
    Log.warn("### RegisterTimeEvent componentId=", componentId)
    return
  end
  if seconds < 60 then
    seconds = 60
  end
  local ms = seconds * 1000
  self._te = GameGlobal.Timer():AddEvent(ms, function()
    self:StartTask(function(TT)
      if self._campaign and componentId == ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION then
        self:FlushNormalStage()
      end
    end, self)
  end)
end

function UIActivityN11MainController_Review:FlushNormalStage()
  self.btnStageNormal.interactable = false
  self.imgStageNormal.sprite = self:GetSpriteD(4)
  local cNormalInfo = self._campaign:GetComponentInfo(ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION)
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = UISummerOneEnterBtnState.Normal
  if state == UISummerOneEnterBtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignReviewN11ComponentID.ECAMPAIGN_REVIEW_ReviewN11_LINE_MISSION)
  elseif state == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventNormal()
  elseif state == UISummerOneEnterBtnState.Normal then
    self.btnStageNormal.interactable = true
    self.imgStageNormal.sprite = self:GetSpriteN(4)
    self:FlushRedPointStageNormal()
  else
    Log.fatal("### state=", state)
  end
end

function UIActivityN11MainController_Review:BgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIActivityN11MainController_Review:BtnIntroOnClick(go)
  self:ShowDialog("UIN11Intro")
end

function UIActivityN11MainController_Review:BtnStageNormalOnClick(go)
  self:SwitchState(UIStateType.UIActivityN11LineMissionController_Review)
end

function UIActivityN11MainController_Review:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UISummerOneEnterBtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UISummerOneEnterBtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIActivityN11MainController_Review:ShowHideUI()
  local goSafeArea = self:GetGameObject("SafeArea")
  if self.isShow then
    self.anim:Play("uieff_n11_main_show")
  else
    self.anim:Play("uieff_n11_main_hide")
  end
end
