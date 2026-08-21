_class("UIN5MainController_Review", UIController)
UIN5MainController_Review = UIN5MainController_Review

function UIN5MainController_Review:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._lineMissionRedPoint = self:GetUIComponent("UISelectObjectPath", "_lineMissionRedPoint")
end

function UIN5MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaignModule = campaignModule
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N5)
  self._reviewData:ReqDetailInfo(TT, res)
  self._campaign = self._reviewData:GetDetailInfo()
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN5MainController_Review:OnShow(uiParams)
  self._timePhase = nil
  self:_GetComponents()
  local progressPool = self:GetUIComponent("UISelectObjectPath", "_progress")
  local progress = progressPool:SpawnObject("UIN5ReviewProgress")
  progress:SetData(self._reviewData)
  CutsceneManager.ExcuteCutsceneOut()
end

function UIN5MainController_Review:HideBtnOnClick()
  local root = self:GetGameObject("_root")
  root:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
end

function UIN5MainController_Review:ShowBtnOnClick()
  local root = self:GetGameObject("_root")
  root:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
end

function UIN5MainController_Review:OnHide()
  self:_DetachEvents()
end

function UIN5MainController_Review:LineMissionBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("UIN5MainControllerReviewPlayAnimation")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5NormalClick)
    if self:_CheckCampaignClose() or not self:_GetComponentState(ECampaignReviewN5ComponentID.ECAMPAIGN_REVIEW_ReviewN5_LINE_MISSION) then
      ToastManager.ShowToast(StringTable.Get("str_activity_common_end"))
      self:UnLock("UIN5MainControllerReviewPlayAnimation")
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5CloseDoor)
    self._campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN5SimpleLevelReview, UIStateType.UIMain, nil, self._campaign._id)
    self:UnLock("UIN5MainControllerReviewPlayAnimation")
  end, self)
end

function UIN5MainController_Review:_CheckCampaignClose()
  return not self._campaign:CheckCampaignOpen()
end

function UIN5MainController_Review:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN5MainController_Review:_AttachEvents()
end

function UIN5MainController_Review:_DetachEvents()
end

function UIN5MainController_Review:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIN5MainController_Review:_CheckRedPointAll()
end

function UIN5MainController_Review:_CheckRedPoint(obj, ...)
  obj:SetActive(false)
end
