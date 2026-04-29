_class("UIN37MainController", UIController)
UIN37MainController = UIN37MainController

function UIN37MainController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime)
end

function UIN37MainController:_SetCommonTopButton()
  local function closeCallback()
    self:_Back()
  end
  
  local function hideCallback()
    self:_HideUI()
  end
  
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(closeCallback, nil, nil, false, hideCallback)
end

function UIN37MainController:_Back()
  if self:Manager():CurUIStateType() == UIStateType.UIN37MainController then
    self:SwitchState(UIStateType.UIMain)
  else
    UIWidgetHelper.PlayAnimation(self, "_anim", "uianim_UIN37MainController_out", 600, function()
      self:CloseDialog()
    end)
    self:_PlayBtnAnim("_lineLevelBtn", "out")
    self:_PlayBtnAnim("_hardLevelBtn", "out")
    self:_PlayBtnAnim("_exchangeBtn", "out")
  end
end

function UIN37MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uianim_UIN37MainController_hide", 600, nil)
  self:_PlayBtnAnim("_lineLevelBtn", "hide")
  self:_PlayBtnAnim("_hardLevelBtn", "hide")
  self:_PlayBtnAnim("_exchangeBtn", "hide")
end

function UIN37MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uianim_UIN37MainController_show", 600, nil)
  self:_PlayBtnAnim("_lineLevelBtn", "show")
  self:_PlayBtnAnim("_hardLevelBtn", "show")
  self:_PlayBtnAnim("_exchangeBtn", "show")
end

function UIN37MainController:_SetBg()
  local url = "n37_zjm_BG"
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIN37MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n37_kv_1_spine_idle")
end

function UIN37MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UIN37MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN37MainController)
end

function UIN37MainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = UIN37Helper.GetCampaignType()
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._campaign:ClearCampaignNew(TT)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN37MainController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_SetCommonTopButton()
  self:_SetBg()
  self:_SetSpine()
  self:_SetTexture("title01", "N37_zjm_title.mat")
  self:_SetTexture("title02", "N37_zjm_title.mat")
  local stop = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_time", "str_n37_sample_remain_time", stop, true)
  self:_Refresh()
  self:_CheckGuide()
end

function UIN37MainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIN37MainController:Destroy()
end

function UIN37MainController:_Refresh()
  UIN37Helper.SetBattlePassBtn(self, "_battlePassBtn", self._bp_campaign)
  self:_SetLoginBtn()
  self:_SetLineLevelBtn()
  self:_SetHardLevelBtn()
  UIN37Helper.SetExchangeBtn(self, "_exchangeBtn", self._campaign)
end

function UIN37MainController:_SetLoginBtn()
  local cmptId, component, componentInfo = UIN37Helper.GetComponent(self._campaign, "login")
  local obj = UIWidgetHelper.SpawnObject(self, "_loginBtn", "UIActivityCommonComponentEnter")
  local btnName = "LoginBtn"
  
  local function newCallback()
    local new = not UIN37Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return self._campaign:CheckComponentOpen(cmptId) and self._campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("_red", redCallback)
  
  local function clickCallback()
    UIN37Helper.LocalDB_Set(btnName, "New")
    local campaignType = UIN37Helper.GetCampaignType()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, campaignType, cmptId)
  end
  
  obj:SetData(self._campaign, clickCallback)
end

function UIN37MainController:_SetLineLevelBtn()
  local cmptId, component, componentInfo = UIN37Helper.GetComponent(self._campaign, "line")
  local obj = UIWidgetHelper.SpawnObject(self, "_lineLevelBtn", "UIActivityCommonComponentEnterLock")
  obj:SetLockStateCallback(nil, nil, function()
    ToastManager.ShowToast(StringTable.Get("str_n37_sample_end"))
  end)
  local btnName = "LineLevelBtn"
  
  local function newCallback()
    local new = not UIN37Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return component:HaveRedPoint()
  end
  
  obj:SetRed("_red", redCallback)
  local tb = {
    {"state_lock", "time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  local state = UIStateType.UIN37LineMissionController
  
  local function clickCallback()
    UIN37Helper.LocalDB_Set(btnName, "New")
    self._campaign._campaign_module:CampaignSwitchState(true, state, UIStateType.UIMain, nil, self._campaign._id)
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UIN37MainController:_SetHardLevelBtn()
  local cmptId, component, componentInfo = UIN37Helper.GetComponent(self._campaign, "hard")
  local cmptId2, component2, componentInfo2 = UIN37Helper.GetComponent(self._campaign, "black")
  local obj = UIWidgetHelper.SpawnObject(self, "_hardLevelBtn", "UIActivityCommonComponentEnterLock")
  obj:SetLockStateCallback(nil, nil, function()
    ToastManager.ShowToast(StringTable.Get("str_n37_sample_end"))
  end)
  local btnName = "HardLevelBtn"
  
  local function newCallback()
    local new = not UIN37Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("_new", newCallback)
  
  local function redCallback()
    return component:HaveRedPoint() or component2:HaveRedPoint()
  end
  
  obj:SetRed("_red", redCallback)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("_timePool_lock", nil, unlockTime, true)
  local tb = {
    {"state_lock", "time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  local state = UIStateType.UIN37HardLevelMain
  
  local function clickCallback()
    UIN37Helper.LocalDB_Set(btnName, "New")
    self._campaign._campaign_module:CampaignSwitchState(true, state, UIStateType.UIMain, nil, self._campaign._id)
  end
  
  obj:SetData(self._campaign, cmptId, clickCallback)
end

function UIN37MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIN37MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN37Intro")
end

function UIN37MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN37MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
end

function UIN37MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN37MainController:_OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    self:_Refresh()
  end
end

function UIN37MainController:_PlayBtnAnim(widgetName, name)
  local tb = {
    _lineLevelBtn = {
      ["in"] = {
        animName = "uianim_UIN37_LineLevelBtn_in",
        duration = 1167
      },
      out = {
        animName = "uianim_UIN37_LineLevelBtn_out",
        duration = 600
      },
      show = {
        animName = "uianim_UIN37_LineLevelBtn_show",
        duration = 633
      },
      hide = {
        animName = "uianim_UIN37_LineLevelBtn_out",
        duration = 600
      }
    },
    _hardLevelBtn = {
      ["in"] = {
        animName = "uianim_UIN37_hardLevelBtn_in",
        duration = 1167
      },
      out = {
        animName = "uianim_UIN37_hardLevelBtn_out",
        duration = 600
      },
      show = {
        animName = "uianim_UIN37_hardLevelBtn_show",
        duration = 633
      },
      hide = {
        animName = "uianim_UIN37_hardLevelBtn_out",
        duration = 600
      }
    },
    _exchangeBtn = {
      ["in"] = {
        animName = "uianim_UIN37_exchangeBtn_in",
        duration = 1167
      },
      out = {
        animName = "uianim_UIN37_exchangeBtn_out",
        duration = 600
      },
      show = {
        animName = "uianim_UIN37_exchangeBtn_show",
        duration = 633
      },
      hide = {
        animName = "uianim_UIN37_exchangeBtn_out",
        duration = 600
      }
    }
  }
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local objs = pool and pool:GetAllSpawnList()
  local obj = (objs or {})[1]
  if obj then
    local cfg = tb[widgetName][name]
    UIWidgetHelper.PlayAnimation(obj, "_anim", cfg.animName, cfg.duration)
  end
end

function UIN37MainController:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local meshRenderer = self:GetUIComponent("MeshRenderer", targetWidget)
    meshRenderer.sharedMaterial:SetTexture("_MainTex", srcMat:GetTexture("_MainTex"))
  end
end

function UIN37MainController:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIN37MainController:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
