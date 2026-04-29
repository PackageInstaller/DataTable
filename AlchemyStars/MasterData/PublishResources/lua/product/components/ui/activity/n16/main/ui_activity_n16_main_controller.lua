_class("UIActivityN16MainController", UIController)
UIActivityN16MainController = UIActivityN16MainController

function UIActivityN16MainController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN16MainController:_SetRemainingTime(widgetName, extraId, descId, endTime, customTimeStr)
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

function UIActivityN16MainController:_PlayAnim(widgetName, animName, time, callback)
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

function UIActivityN16MainController:_InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
end

function UIActivityN16MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N16
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN16ComponentID.ECAMPAIGN_N16_SHOP, ECampaignN16ComponentID.ECAMPAIGN_N16_CUMULATIVE_LOGIN, ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_COMMON, ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD, ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_FIXTEAM, ECampaignN16ComponentID.ECAMPAIGN_N16_ACTION_POINT, ECampaignN16ComponentID.ECAMPAIGN_N16_STORY, ECampaignN16ComponentID.ECAMPAIGN_N16_ANSWER_GAME)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityN16MainController:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN16.spriteatlas", LoadType.SpriteAtlas)
  self:_AttachEvents()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._isOpen = true
  self:_InitWidget()
  self:_SetSpine()
  self:_UpdateRemainingTime()
  self:_SetEffect()
  self:_Refresh()
  self.imgRT = uiParams[1]
  local entermodel = "uieffanim_N16_main_show"
  if self.imgRT ~= nil then
    entermodel = "uieffanim_N16_main_show"
    self:_PlayAnim("_anim", entermodel, 1667, function()
      self:_CheckGuide()
    end)
    CutsceneManager.ExcuteCutsceneOut()
  else
    entermodel = "uieffanim_N16_main_in"
    self:_PlayAnim("_anim", entermodel, 1667, function()
      self:_CheckGuide()
    end)
  end
end

function UIActivityN16MainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN16MainController:_Refresh()
  self:_SetBattlePassBtn()
  self:_SetExchangeBtn()
  self:_SetLoginRewardBtn()
  self:_SetLineMissionBtn()
  self:_SetHardLevelBtn()
  self:_SetSubjectBtn()
end

function UIActivityN16MainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN16MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n16_kv_1_spine_idle")
end

function UIActivityN16MainController:_UpdateRemainingTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local lineComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_LINE_MISSION, 1)
  local endTime = lineComponent:GetComponentInfo().m_close_time
  local stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n16_main_remaintime_desc", nil, endTime, true)
    return
  end
  local exchangeItemComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_EXCHANGE_ITEM, 1)
  endTime = exchangeItemComponent:GetComponentInfo().m_close_time
  stamp = endTime - curTime
  if 0 < stamp then
    self:_SetRemainingTime("_remainingTimePool", "str_activity_n16_main_time_desc", nil, endTime)
    return
  end
end

function UIActivityN16MainController:_SetBattlePassBtn()
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

function UIActivityN16MainController:_SetExchangeBtn()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_SHOP
  self.exchangeobj = self:_SpawnObject("_exchangeBtn", "UIActivityCommonComponentEnter")
  self.exchangeobj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetCostItemIconText()
  if icon then
    self.exchangeobj:SetIcon("icon", icon)
  end
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#4c4c4c>%s</color><color=#d1b24c>%s</color>", preZero, tostring(count))
  self.exchangeobj:SetText("text", fmtStr)
  self.exchangeobj:SetData(self._campaign, function()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      self:SwitchState(UIStateType.UIActivityN16MainController)
    end)
  end)
end

function UIActivityN16MainController:_RefeshCount()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_SHOP
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetCostItemIconText()
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#4c4c4c>%s</color><color=#d1b24c>%s</color>", preZero, tostring(count))
  self.exchangeobj:SetText("text", fmtStr)
end

function UIActivityN16MainController:_SetLoginRewardBtn()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_CUMULATIVE_LOGIN
  local obj = self:_SpawnObject("_loginRewardBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId) and self._campaign:CheckComponentRed(componentId)
  end)
  obj:SetData(self._campaign, function()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, self._campaignType, componentId)
  end)
end

function UIActivityN16MainController:_SetLineMissionBtn()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_COMMON
  local componentId2 = ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_FIXTEAM
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(componentId, componentId2) and self._campaign:CheckComponentRed(componentId, componentId2)
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
    self:SwitchState(UIStateType.UIActivityN16LineMissionController)
  end)
  local img = obj.view:GetUIComponent("Image", "bgstate")
  local isOpen = self._campaign:CheckComponentOpen(componentId)
  local spname = isOpen and "n16_zjm_di2" or "n16_zjm_di02"
  local color = isOpen and Color.New(0.796078431372549, 0.6901960784313725, 0.35294117647058826) or Color.New(0.00784313725490196, 0.00784313725490196, 0.00784313725490196)
  img.sprite = self._atlas:GetSprite(spname)
  local text = obj.view:GetUIComponent("UILocalizationText", "txt")
  local outline = text.transform:GetComponent("Outline")
  outline.enabled = isOpen
  text.color = color
end

function UIActivityN16MainController:_SetHardLevelBtn()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_hardLevelBtn", "UIActivityCommonComponentEnterLock")
  local roleId = self:_GetRoleId()
  obj:SetNew("new", function()
    return component:ComponentIsOpen() and not LocalDB.HasKey("UIActivityN16HardLevel" .. roleId)
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
    self:SwitchState(UIStateType.UIN16HardLevel, {
      false,
      false,
      nil
    })
  end)
  local img = obj.view:GetUIComponent("Image", "bgstate")
  local isOpen = self._campaign:CheckComponentOpen(componentId)
  local spname = isOpen and "n16_zjm_di01" or "n16_zjm_di1"
  local color = isOpen and Color.New(0.796078431372549, 0.6901960784313725, 0.35294117647058826) or Color.New(0.00784313725490196, 0.00784313725490196, 0.00784313725490196)
  img.sprite = self._atlas:GetSprite(spname)
  local text = obj.view:GetUIComponent("UILocalizationText", "txt")
  local outline = text.transform:GetComponent("Outline")
  outline.enabled = isOpen
  text.color = color
end

function UIActivityN16MainController:_SetSubjectBtn()
  local componentId = ECampaignN16ComponentID.ECAMPAIGN_N16_ANSWER_GAME
  local component = self._campaign:GetComponent(componentId)
  local obj = self:_SpawnObject("_subjectBtn", "UIActivityCommonComponentEnterLock")
  local roleId = self:_GetRoleId()
  obj:SetNew("new", function()
    return component:ComponentIsOpen() and not LocalDB.HasKey("UIActivityN16Subject" .. roleId)
  end)
  obj:SetRed("red", function()
    local red = UIN16Const.HasNewOpenSubjectLevel(component:GetComponentInfo())
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
    self:ShowDialog("UIN16SubjectMainController", function()
      self:_SetSubjectBtn()
    end)
  end)
end

function UIActivityN16MainController:ShowBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(true)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(true)
end

function UIActivityN16MainController:HideBtnOnClick()
  local hideBtn = self:GetGameObject("_backBtns")
  hideBtn:SetActive(false)
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  local uiElements = self:GetGameObject("_uiElements")
  uiElements:SetActive(false)
end

function UIActivityN16MainController:InfoBtnOnClick(go)
  UIActivityHelper.ShowActivityIntro("UIN16Intro")
end

function UIActivityN16MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._RefeshCount)
end

function UIActivityN16MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._RefeshCount)
end

function UIActivityN16MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN16MainController:_GetRoleId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return pstId
end

function UIActivityN16MainController:_SetEffect()
end

function UIActivityN16MainController:_SetMainTex()
  local rawImage = self:GetUIComponent("RawImage", "TitleImg_RawImage")
  local obj = self:GetGameObject("TitleImg")
  local meshRender = obj:GetComponent(typeof(UnityEngine.MeshRenderer))
  meshRender.material:SetTexture("_MainTex", rawImage.material:GetTexture("_MainTex"))
end

function UIActivityN16MainController:_SetSpineEffect(widgetName)
end

function UIActivityN16MainController:_HandelSpineMaterial(material)
end

function UIActivityN16MainController:_HandelRawImageMaterial(widgetName)
end

function UIActivityN16MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN16MainController)
end
