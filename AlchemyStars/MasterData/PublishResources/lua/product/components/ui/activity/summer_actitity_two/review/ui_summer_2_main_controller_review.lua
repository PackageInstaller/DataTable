_class("UISummer2MainControllerReview", UIController)
UISummer2MainControllerReview = UISummer2MainControllerReview

function UISummer2MainControllerReview:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N4, ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._localProcess = self._campaign:GetLocalProcess()
  local storyComponent = self._localProcess:GetComponent(ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY)
  local storyInfo = self._localProcess:GetComponentInfo(ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._activeTitle1 = StringTable.Get(cfg_campaign.CampaignName)
  self._activeTitle2 = StringTable.Get(cfg_campaign.CampaignSubtitle)
end

function UISummer2MainControllerReview:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._title1Label = self:GetUIComponent("UILocalizationText", "Title1")
  self._title1ShadowLabel = self:GetUIComponent("UILocalizationText", "Title1Shadow")
  self._title2Label = self:GetUIComponent("UILocalizationText", "Title2")
  self._title2ShadowLabel = self:GetUIComponent("UILocalizationText", "Title2Shadow")
  self._title1Label.text = self._activeTitle1
  self._title1ShadowLabel.text = self._activeTitle1
  self._title2Label.text = self._activeTitle2
  self._title2ShadowLabel.text = self._activeTitle2
  self._shot = self:GetUIComponent("RawImage", "shot")
  self._rt = uiParams[1]
  self._shot.gameObject:SetActive(self._rt ~= nil)
  if self._rt then
    self._shot.texture = self._rt
  end
end

function UISummer2MainControllerReview:HideBtnOnClick()
  local btnPanel1 = self:GetGameObject("BtnPanel1")
  btnPanel1:SetActive(false)
  local btnPanel2 = self:GetGameObject("BtnPanel2")
  btnPanel2:SetActive(false)
  local btnPanel3 = self:GetGameObject("BtnPanel3")
  btnPanel3:SetActive(false)
  local showBtn = self:GetGameObject("showBtn")
  showBtn:SetActive(true)
end

function UISummer2MainControllerReview:ShowBtnOnClick()
  local btnPanel1 = self:GetGameObject("BtnPanel1")
  btnPanel1:SetActive(true)
  local btnPanel2 = self:GetGameObject("BtnPanel2")
  btnPanel2:SetActive(true)
  local btnPanel3 = self:GetGameObject("BtnPanel3")
  btnPanel3:SetActive(true)
  local showBtn = self:GetGameObject("showBtn")
  showBtn:SetActive(false)
end

function UISummer2MainControllerReview:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "Spine", "summer_bg_tu2_spine_idle")
  self._spine.skeleton.color = Color(1, 1, 1, 0)
end

function UISummer2MainControllerReview:_PlayIn(TT)
  self:Lock("UISummer2MainControllerReview_PlayIn")
  self._playin = true
  YIELD(TT, 667)
  self._playin = false
  self:UnLock("UISummer2MainControllerReview_PlayIn")
end

function UISummer2MainControllerReview:OnUpdateOld(deltaTimeMS)
  if self._playin and self._spine then
    local obj = self:GetUIComponent("SpineLoader", "Spine")
    self._spine.skeleton.color = obj.color
  end
end

function UISummer2MainControllerReview:CloseCoro(TT)
  self:Lock("UISummerActivityTwoMainController_CloseCoro")
  self:SwitchState(UIStateType.UIActivityReview)
  self:UnLock("UISummerActivityTwoMainController_CloseCoro")
end

function UISummer2MainControllerReview:PlotBtnOnClick()
  self:ShowDialog("UISummerActivityTwoPlotDetailController", ECampaignType.CAMPAIGN_TYPE_REVIEW_N4, ECampaignReviewN4ComponentID.ECAMPAIGN_REVIEW_ReviewN4_STORY)
end
