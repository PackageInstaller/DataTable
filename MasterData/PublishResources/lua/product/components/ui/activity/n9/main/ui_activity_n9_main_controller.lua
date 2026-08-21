_class("UIActivityN9MainController", UIController)
UIActivityN9MainController = UIActivityN9MainController

function UIActivityN9MainController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN9MainController:_SetRemainingTime(widgetName, extraId, descId, endTime, customTimeStr)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetExtraText("txtDesc", nil, extraId)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_UpdateRemainingTime()
  end)
end

function UIActivityN9MainController:_PlayAnim(widgetName, animName, time, callback)
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

function UIActivityN9MainController:_InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
end

function UIActivityN9MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N9
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP, ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM, ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT, ECampaignN9ComponentID.ECAMPAIGN_N9_STORY, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityN9MainController:OnShow(uiParams)
  self:_AttachEvents()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._isOpen = true
  self:_InitWidget()
  self:_SetSpine()
  self:_UpdateRemainingTime()
  self:_SetEffect()
  self:_Refresh()
  self.imgRT = uiParams[1]
  if self.imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self.imgRT
    self:_PlayAnim("_anim", "uieff_Main_In", 1667, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityN9MainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN9MainController:_Refresh()
  self:_SetBattlePassBtn()
  self:_SetExchangeBtn()
  self:_SetLoginRewardBtn()
  self:_SetLineMissionBtn()
  self:_SetHardLevelBtn()
  self:_SetSubjectBtn()
end

function UIActivityN9MainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN9MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n9_kv_1_spine_idle")
end

function UIActivityN9MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local lineComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_LINE_MISSION, 1)
  local endTime = lineComponent:GetComponentInfo().m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n9_main_remaintime_desc", nil, endTime, true)
    return
  end
  local exchangeItemComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_EXCHANGE_ITEM, 1)
  endTime = exchangeItemComponent:GetComponentInfo().m_close_time
  stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n9_main_time_desc", nil, endTime)
    return
  end
end

function UIActivityN9MainController:_SetBattlePassBtn()
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
    obj:SetData(campaign, useStateUI)
  end
  local obj = self:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIActivityN9MainController:_SetExchangeBtn()
  local componentId = ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP
  local obj = self:_SpawnObject("_exchangeBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetCostItemIconText()
  if icon then
    obj:SetIcon("icon", icon)
  end
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#545454>%s</color><color=#fff0ad>%s</color>", preZero, tostring(count))
  obj:SetText("text", fmtStr)
  obj:SetData(self._campaign, function()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      self:SwitchState(UIStateType.UIActivityN9MainController)
    end)
  end)
end

function UIActivityN9MainController:_SetLoginRewardBtn()
  local componentId = ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN
  local obj = self:_SpawnObject("_loginRewardBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  obj:SetData(self._campaign, function()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, self._campaignType, componentId)
  end)
end

function UIActivityN9MainController:_SetLineMissionBtn()
  local componentId = ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON
  local componentId2 = ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM
  local componentId3 = ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId, componentId2, componentId3) and self._campaign:CheckComponentRed(componentId, componentId2, componentId3)
  end)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("_remainingTimePool_lock", nil, unlockTime, true)
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
    self:SwitchState(UIStateType.UIActivityN9LineMissionController)
  end)
end

function UIActivityN9MainController:_SetHardLevelBtn()
  local componentId = ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_hardLevelBtn", "UIActivityCommonComponentEnterLock")
  local roleId = self:_GetRoleId()
  obj:SetNew("new", function()
    return component:ComponentIsOpen() and not LocalDB.HasKey("UIActivityN9HardLevel" .. roleId)
  end)
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("_remainingTimePool_lock", nil, unlockTime, true)
  local tb = {
    {
      "icon_lock",
      "time_lock",
      "bg_lock"
    },
    {"icon_lock", "bg_lock"},
    {
      "state_unlock"
    },
    {
      "bg_lock",
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIN9HardLevel, {
      false,
      false,
      nil
    })
  end)
end

function UIActivityN9MainController:_SetSubjectBtn()
  local componentId = ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_subjectBtn", "UIActivityCommonComponentEnterLock")
  local roleId = self:_GetRoleId()
  obj:SetNew("new", function()
    return component:ComponentIsOpen() and not LocalDB.HasKey("UIActivityN9Subject" .. roleId)
  end)
  obj:SetRed("red", function()
    local red = UIN9Const.HasNewOpenSubjectLevel(component:GetComponentInfo())
    return red
  end)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("_remainingTimePool_lock", nil, unlockTime, true)
  local tb = {
    {
      "icon_lock",
      "time_lock",
      "bg_lock"
    },
    {"icon_lock", "bg_lock"},
    {
      "state_unlock"
    },
    {
      "bg_lock",
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    if not self._campaign:CheckComponentOpen(componentId) then
      ToastManager.ShowToast(StringTable.Get("str_activity_error_110"))
      return
    end
    self:ShowDialog("UIN9SubjectMainController", function()
      self:_SetSubjectBtn()
    end)
  end)
end

function UIActivityN9MainController:ShowBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(true)
end

function UIActivityN9MainController:HideBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(false)
end

function UIActivityN9MainController:InfoBtnOnClick(go)
  UIActivityHelper.ShowActivityIntro("UIN9Intro")
end

function UIActivityN9MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN9MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN9MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN9MainController:_GetRoleId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return pstId
end

function UIActivityN9MainController:_SetEffect()
  self:_SetMainTex()
end

function UIActivityN9MainController:_SetMainTex()
  local rawImage = self:GetUIComponent("RawImage", "TitleImg_RawImage")
  local obj = self:GetGameObject("TitleImg")
  local meshRender = obj:GetComponent(typeof(UnityEngine.MeshRenderer))
  meshRender.material:SetTexture("_MainTex", rawImage.material:GetTexture("_MainTex"))
end

function UIActivityN9MainController:_SetSpineEffect(widgetName)
end

function UIActivityN9MainController:_HandelSpineMaterial(material)
end

function UIActivityN9MainController:_HandelRawImageMaterial(widgetName)
end

function UIActivityN9MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN9MainController)
end
