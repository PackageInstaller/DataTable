_class("UIActivityN9MainController_Review", UIController)
UIActivityN9MainController_Review = UIActivityN9MainController_Review

function UIActivityN9MainController_Review:_PlayAnim(widgetName, animName, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  self:Lock(animName)
  anim:Play(animName)
  self:StartTask(function(TT)
    YIELD(TT, time)
    self:UnLock(animName)
    if callback then
      callback()
    end
  end, self)
end

function UIActivityN9MainController_Review:_InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
end

function UIActivityN9MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_REVIEW_N9
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {})
  self:_SetProgressData(TT, res)
end

function UIActivityN9MainController_Review:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_InitWidget()
  self:_SetSpine()
  self:_Refresh()
  self.imgRT = uiParams[1]
  if self.imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self.imgRT
    self:_PlayAnim("_anim", "uieffanim_ActivityN9Main_in", 2000, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityN9MainController_Review:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN9MainController_Review:_Refresh()
  self:_SetProgressUI()
  self:_SetLineMissionBtn()
end

function UIActivityN9MainController_Review:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN9MainController_Review:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n9_kv_1_spine_idle")
end

function UIActivityN9MainController_Review:_SetProgressData(TT, res)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(self._campaignType)
  self._reviewData:ReqDetailInfo(TT, res)
end

function UIActivityN9MainController_Review:_SetProgressUI()
  local progress = UIReviewProgressConst.SpawnObject(self, "_progress", self._reviewData)
end

function UIActivityN9MainController_Review:_SetLineMissionBtn()
  local componentId = ECampaignReviewN9ComponentID.ECAMPAIGN_REVIEW_ReviewN9_LINE_MISSION
  local component = self._campaign:GetComponent(componentId)
  local obj = UIWidgetHelper.SpawnObject(self, "_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local tb = {
    {"state_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIActivityN9LineMissionController_Review)
  end)
end

function UIActivityN9MainController_Review:ShowBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(true)
end

function UIActivityN9MainController_Review:HideBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(false)
end

function UIActivityN9MainController_Review:InfoBtnOnClick(go)
  UIActivityHelper.ShowActivityIntro("UIN9Intro")
end

function UIActivityN9MainController_Review:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN9MainController_Review:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN9MainController_Review:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN9MainController_Review:_GetRoleId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return pstId
end

function UIActivityN9MainController_Review:_CheckGuide()
end
