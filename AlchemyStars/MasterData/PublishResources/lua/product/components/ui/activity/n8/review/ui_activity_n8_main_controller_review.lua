_class("UIActivityN8MainController_Review", UIController)
UIActivityN8MainController_Review = UIActivityN8MainController_Review

function UIActivityN8MainController_Review:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN8MainController_Review:_PlayAnim(widgetName, animName, time, callback)
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

function UIActivityN8MainController_Review:_InitWidget()
  self._anim = self:GetUIComponent("Animation", "_anim")
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._showBtn = self:GetGameObject("_showBtn")
end

function UIActivityN8MainController_Review:CloseCoro(TT)
  self:Lock("UIActivityN8MainController_Review_CloseCoro")
  self:SwitchState(UIStateType.UIActivityReview)
  self:UnLock("UIActivityN8MainController_Review_CloseCoro")
end

function UIActivityN8MainController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_REVIEW_N8
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityN8MainController_Review:OnShow(uiParams)
  self._isOpen = true
  self:_AttachEvents()
  self:_InitWidget()
  self:_SetSpine()
  self:_SetEffect()
  self:_Refresh()
  self.imgRT = uiParams[1]
  if self.imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self.imgRT
    self:_PlayAnim("_anim", "UIActivityN8MainController_Review_in", 1000, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityN8MainController_Review:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN8MainController_Review:Destroy()
  self._lineMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._lineMatReq)
  self._personMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._personMatReq)
  self._bpMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._bpMatReq)
  self._loginMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._loginMatReq)
  self._battleMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._battleMatReq)
end

function UIActivityN8MainController_Review:_Refresh()
  self:_SetLineMissionBtn()
end

function UIActivityN8MainController_Review:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN8MainController_Review:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n8_kv_spine_idle")
end

function UIActivityN8MainController_Review:_SetLineMissionBtn()
  local componentId = ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION
  local obj = self:_SpawnObject("_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  self._lineMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._lineMatReq)
  local tb = {
    {"bg_lock"},
    {"bg_lock"},
    {"bg_unlock"},
    {"bg_lock"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIActivityN8LineMissionController_Review)
  end)
end

function UIActivityN8MainController_Review:ShowBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  self._anim:Play("uieff_N8_Main_Show")
end

function UIActivityN8MainController_Review:HideBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  self._anim:Play("uieff_N8_Main_Hide")
end

function UIActivityN8MainController_Review:InfoBtnOnClick(go)
  self:ShowDialog("UIActivityIntroController", "UIActivityN8MainController_Review")
end

function UIActivityN8MainController_Review:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN8MainController_Review:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN8MainController_Review:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN8MainController_Review:_SetEffect()
  self:_SetSpineEffect("_spine")
end

function UIActivityN8MainController_Review:_SetSpineEffect(widgetName)
  local obj = self:GetGameObject(widgetName)
  local spineSkeMultipleTex = obj:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  spineSkeMultipleTex.UseInstanceMaterials = true
  
  function spineSkeMultipleTex.OnInstanceMaterialCreated(material)
    self:_HandelSpineMaterial(material)
  end
  
  spineSkeMultipleTex:UpdateMesh()
end

function UIActivityN8MainController_Review:_HandelSpineMaterial(material)
  material:SetFloat("_StencilComp", 3)
end

function UIActivityN8MainController_Review:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN8MainController_Review)
end
