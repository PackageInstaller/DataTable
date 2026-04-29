_class("UIActivityN8MainController", UIController)
UIActivityN8MainController = UIActivityN8MainController

function UIActivityN8MainController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN8MainController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetExtraText("txtDesc", nil, descId)
  obj:SetData(endTime, nil, function()
    self:_UpdateRemainingTime()
  end)
end

function UIActivityN8MainController:_PlayAnim(widgetName, animName, time, callback)
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

function UIActivityN8MainController:_InitWidget()
  self._anim = self:GetUIComponent("Animation", "_anim")
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._showBtn = self:GetGameObject("_showBtn")
end

function UIActivityN8MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N8
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM, ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS, ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityN8MainController:OnShow(uiParams)
  self._isOpen = true
  self:_AttachEvents()
  self:_InitWidget()
  self:_SetSpine()
  self:_SetEffect()
  self:_UpdateRemainingTime()
  self:_Refresh()
  self.imgRT = uiParams[1]
  if self.imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self.imgRT
    self:_PlayAnim("_anim", "uieff_N8_Main_In", 1000, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityN8MainController:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN8MainController:Destroy()
  self._lineMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._lineMatReq)
  self._personMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._personMatReq)
  self._bpMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._bpMatReq)
  self._loginMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._loginMatReq)
  self._battleMatReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._battleMatReq)
end

function UIActivityN8MainController:_Refresh()
  self:_SetLineMissionBtn()
  self:_SetPersonProgressBtn()
  self:_SetBattlePassBtn()
  self:_SetLoginRewardBtn()
  self:_SetBattleSimulatorBtn()
end

function UIActivityN8MainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN8MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n8_kv_spine_idle")
end

function UIActivityN8MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local lineComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_LINE_MISSION, 1)
  local endTime = lineComponent:GetComponentInfo().m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n8_main_time_desc", endTime)
    return
  end
  local personProgressComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  endTime = personProgressComponent:GetComponentInfo().m_close_time
  stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n8_main_time_reward_desc", endTime)
    return
  end
end

function UIActivityN8MainController:_SetLineMissionBtn()
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION
  local componentId2 = ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM
  local obj = self:_SpawnObject("_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed_RedDotModule("red", RedDotType.RDT_N8_LINEMISSION)
  self._lineMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._lineMatReq)
  local tb = {
    {"bg_lock"},
    {"bg_lock"},
    {"bg_unlock"},
    {"bg_lock"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIActivityN8LineMissionController)
  end)
end

function UIActivityN8MainController:_SetPersonProgressBtn()
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS
  local obj = self:_SpawnObject("_personProgressBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed_RedDotModule("red", RedDotType.RDT_N8_SIMULATOR_PRESTIGE)
  self._personMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._personMatReq)
  local tb = {
    {"bg_lock"},
    {"bg_lock"},
    {"bg_unlock"},
    {"bg_lock"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIActivityN8PersonProgressController")
  end)
  local iconText = self:_SpawnObject("_personProgressIconTextPool", "UIActivityN8PersonProgressIconText")
  iconText:SetData(self._campaign, "_icon")
end

function UIActivityN8MainController:_SetBattlePassBtn()
  local campaignType = ECampaignType.CAMPAIGN_TYPE_BATTLEPASS
  local widgetName = "_battlePassBtn"
  local className = "UIActivityCommonCampaignEnter"
  local useStateUI = false
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo_Local(campaignType)
  local open_sample = campaign:CheckCampaignOpen()
  if open_sample then
    local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
    local obj = pool:SpawnObject(className)
    self._bpMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._bpMatReq)
    obj:SetData(campaign, useStateUI)
  end
  local obj = self:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIActivityN8MainController:_SetLoginRewardBtn()
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN
  local obj = self:_SpawnObject("_loginRewardBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed_RedDotModule("red", RedDotType.RDT_N8_LOGIN_AWARD)
  self._loginMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._loginMatReq)
  local tb = {
    {"bg_lock"},
    {"bg_lock"},
    {"bg_unlock"},
    {"bg_lock"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, self._campaignType, componentId)
  end)
end

function UIActivityN8MainController:_SetBattleSimulatorBtn()
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR
  local obj = self:_SpawnObject("_battleSimulatorBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed_RedDotModule("red", RedDotType.RDT_N8_SIMULATOR_FUNCTION)
  self._battleMatReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_01.mat", self._battleMatReq)
  local component = self._campaign:GetComponent(componentId)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("remainingTimePool", nil, unlockTime, true)
  local tb = {
    {
      "closed",
      "lock",
      "lockWitchTime"
    },
    {"closed", "lock"},
    {},
    {"closed"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIActivityN8BattleSimulatorController)
  end)
end

function UIActivityN8MainController:ShowBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  self._anim:Play("uieff_N8_Main_Show")
end

function UIActivityN8MainController:HideBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  self._anim:Play("uieff_N8_Main_Hide")
end

function UIActivityN8MainController:InfoBtnOnClick(go)
  self:ShowDialog("UIActivityIntroController", "UIActivityN8MainController")
end

function UIActivityN8MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN8MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN8MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN8MainController:_SetEffect()
  self:_SetMask()
  self:_HandelRawImageMaterial("_effect_Image")
  self:_HandelRawImageMaterial("_effect_TitleImg")
  self:_SetSpineEffect("_spine")
end

function UIActivityN8MainController:_SetMask()
  local scr = self:GetUIComponent("RectTransform", "_effect_SafeArea")
  local obj = self:GetUIComponent("RectTransform", "_effect_Mask")
  obj.localScale = Vector2(scr.rect.size.x, scr.rect.size.y)
end

function UIActivityN8MainController:_SetSpineEffect(widgetName)
  local obj = self:GetGameObject(widgetName)
  local spineSkeMultipleTex = obj:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  spineSkeMultipleTex.UseInstanceMaterials = true
  
  function spineSkeMultipleTex.OnInstanceMaterialCreated(material)
    self:_HandelSpineMaterial(material)
  end
  
  spineSkeMultipleTex:UpdateMesh()
end

function UIActivityN8MainController:_HandelSpineMaterial(material)
  material:SetFloat("_StencilComp", 3)
  material:SetFloat("_StencilRef", 10)
end

function UIActivityN8MainController:_HandelRawImageMaterial(widgetName)
  local obj = self:GetUIComponent("RawImage", widgetName)
  if obj.material ~= obj.defaultGraphicMaterial then
    obj.material:SetFloat("_StencilComp", 3)
    obj.material:SetFloat("_Stencil", 10)
  end
end

function UIActivityN8MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN8MainController)
end
