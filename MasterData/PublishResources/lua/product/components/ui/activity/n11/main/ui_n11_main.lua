_class("UIN11Main", UIController)
UIN11Main = UIN11Main

function UIN11Main:Constructor(ui_root_transform)
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

function UIN11Main:LoadDataOnEnter(TT, res, uiParams)
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN11Data()
  self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N11, res)
  self.isShow = true
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self:LoadDataOnEnter_BattlePass(TT)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self.mCampaign._id, nil, nil)
    return
  end
end

function UIN11Main:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN11Main:OnShow(uiParams)
  N11Data.SetPrefsMain()
  self.atlas = self:GetAsset("UIN11.spriteatlas", LoadType.SpriteAtlas)
  self.dictSprite = {
    [1] = {
      n = "n11_zjm_tbsjb",
      d = "n11_zjm_tbsjb_close"
    },
    [2] = {
      n = "n11_zjm_shop",
      d = "n11_zjm_shop_close"
    },
    [3] = {
      n = "n11_zjm_sign",
      d = "n11_zjm_sign_close"
    },
    [4] = {
      n = "n11_zjm_stage",
      d = "n11_zjm_stage_close"
    },
    [5] = {
      n = "n11_zjm_hard",
      d = "n11_zjm_hard_close"
    }
  }
  self.imgRT = uiParams[1]
  self.playFrom0 = uiParams[2]
  self.rt = self:GetUIComponent("RawImage", "rt")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil, false, function()
    if self.isShow then
      self.isShow = false
      self:ShowHideUI()
    end
  end)
  self.anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.txtStageLeftTime = self:GetUIComponent("RollingText", "txtStageLeftTime")
  local economics = self:GetUIComponent("UISelectObjectPath", "economics")
  local uiCampaignEconomic = economics:SpawnObject("UICampaignEconomic")
  uiCampaignEconomic:Flush()
  self.btnStageNormal = self:GetUIComponent("Button", "btnStageNormal")
  self.btnStageHard = self:GetUIComponent("Button", "btnStageHard")
  self.cdStageHard = self:GetGameObject("cdStageHard")
  self.txtStageHardOpenTime = self:GetUIComponent("RollingText", "txtStageHardOpenTime")
  self.redBattlePass = self:GetGameObject("redBattlePass")
  self.redAward = self:GetGameObject("redAward")
  self.redStageNormal = self:GetGameObject("redStageNormal")
  self.newStageHard = self:GetGameObject("newStageHard")
  self.imgBattlePass = self:GetUIComponent("Image", "btnBattlePass")
  self.imgBattlePass.alphaHitTestMinimumThreshold = 0.1
  self.mrBattlePass = self:GetUIComponent("MeshRenderer", "mrBattlePass")
  self.imgShop = self:GetUIComponent("Image", "btnShop")
  self.imgShop.alphaHitTestMinimumThreshold = 0.1
  self.mrShop = self:GetUIComponent("MeshRenderer", "mrShop")
  self.imgLoginAward = self:GetUIComponent("Image", "btnLoginAward")
  self.imgLoginAward.alphaHitTestMinimumThreshold = 0.1
  self.imgStageNormal = self:GetUIComponent("Image", "btnStageNormal")
  self.imgStageNormal.alphaHitTestMinimumThreshold = 0.1
  self.imgStageHard = self:GetUIComponent("Image", "btnStageHard")
  self.imgStageHard.alphaHitTestMinimumThreshold = 0.1
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 60000)
  if self.playFrom0 then
  else
    local state = self.anim:get_Item("uieff_N11_Main_In")
    state.normalizedTime = 0.184
  end
  self.anim:Play()
  self:Flush()
  self:_CheckGuide()
end

function UIN11Main:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  self:CancelTimerEventNormal()
  self:CancelTimerEventHard()
  self.data = nil
  self.btnStageNormal = nil
  self.btnStageHard = nil
end

function UIN11Main:CancelTimerEventNormal()
  if self.teNormal then
    GameGlobal.Timer():CancelEvent(self.teNormal)
  end
end

function UIN11Main:CancelTimerEventHard()
  if self.teHard then
    GameGlobal.Timer():CancelEvent(self.teHard)
  end
end

function UIN11Main:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self.data then
    local cType, cId = self.data:GetCampaignTypeId()
    if cId == campaign_id then
      self:Flush()
    end
  end
  self:FlushRedPointBattlePass()
end

function UIN11Main:Flush()
  self.rt.texture = self.imgRT
  self:FlushBtnMainTexture()
  self:FlushStateBattlePass()
  self:FlushStateShop()
  self:FlushStateAward()
  self:FlushRedPointBattlePass()
  self:FlushRedPointAward()
  self:FlushCDActivity()
  self:FlushNormalStage()
  self:FlushCDHard()
end

function UIN11Main:FlushBtnMainTexture()
  self.reqBattlePass = ResourceManager:GetInstance():SyncLoadAsset("n11_zjm_tbsjb_zi" .. ".mat", LoadType.Mat)
  self.materialBattlePass = self.reqBattlePass.Obj
  self.mrBattlePass.material:SetTexture("_MainTex", self.materialBattlePass:GetTexture("_MainTex"))
  self.reqShop = ResourceManager:GetInstance():SyncLoadAsset("n11_zjm_shop_zi" .. ".mat", LoadType.Mat)
  self.materialShop = self.reqShop.Obj
  self.mrShop.material:SetTexture("_MainTex", self.materialShop:GetTexture("_MainTex"))
end

function UIN11Main:FlushStateBattlePass()
  local open = self._battlepassCampaign:CheckCampaignOpen()
  if open then
    self.imgBattlePass.sprite = self:GetSpriteN(1)
  else
    self.imgBattlePass.sprite = self:GetSpriteD(1)
  end
end

function UIN11Main:FlushStateShop()
  local s = self.data:GetStateShop()
  if s == UISummerOneEnterBtnState.Normal then
    self.imgShop.sprite = self:GetSpriteN(2)
  else
    self.imgShop.sprite = self:GetSpriteD(2)
  end
end

function UIN11Main:FlushStateAward()
  local s = self.data:GetStateAward()
  if s == UISummerOneEnterBtnState.Normal then
    self.imgLoginAward.sprite = self:GetSpriteN(3)
  else
    self.imgLoginAward.sprite = self:GetSpriteD(3)
  end
end

function UIN11Main:GetSpriteN(idx)
  local n = self.atlas:GetSprite(self.dictSprite[idx].n)
  return n
end

function UIN11Main:GetSpriteD(idx)
  local d = self.atlas:GetSprite(self.dictSprite[idx].d)
  return d
end

function UIN11Main:FlushRedPointBattlePass()
  local bShow = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.redBattlePass:SetActive(bShow)
end

function UIN11Main:FlushRedPointAward()
  local red = self.data:CheckRedAward()
  self.redAward:SetActive(red)
end

function UIN11Main:FlushRedPointStageNormal()
  if not self.data then
    return
  end
  local red = self.data:CheckRedNormal()
  self.redStageNormal:SetActive(red)
end

function UIN11Main:FlushNewStageHard()
  if not self.data then
    return
  end
  local new = self.data:CheckNewHard()
  self.newStageHard:SetActive(new)
end

function UIN11Main:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cHardInfo = self.data:GetComponentInfoHard()
  local cs = self.data:GetCampaignSample()
  if nowTimestamp < cHardInfo.m_close_time then
    UIN11Main.FlushCDText(self.txtStageLeftTime, cHardInfo.m_close_time, self.strsLeftTime)
  elseif nowTimestamp < cs.end_time then
    UIN11Main.FlushCDText(self.txtStageLeftTime, cs.end_time, self.strsTakeAwardLeftTime)
  else
    self.txtStageLeftTime:RefreshText(StringTable.Get("str_n11_end"))
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIN11Main:RegisterTimeEvent(seconds, componentId)
  if componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON then
    self:CancelTimerEventNormal()
  elseif componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD then
    self:CancelTimerEventHard()
  else
    Log.warn("### RegisterTimeEvent componentId=", componentId)
    return
  end
  if seconds < 60 then
    seconds = 60
  end
  local ms = seconds * 1000
  local te = GameGlobal.Timer():AddEvent(ms, function()
    self:StartTask(function(TT)
      if self.data then
        self.data:RequestCampaign(TT)
        if componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON then
          self:FlushNormalStage()
        elseif componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD then
          self:FlushCDHard()
        end
      end
    end, self)
  end)
  if componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON then
    self.teNormal = te
  elseif componentId == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD then
    self.teHard = te
  end
end

function UIN11Main:FlushNormalStage()
  self.btnStageNormal.interactable = false
  self.imgStageNormal.sprite = self:GetSpriteD(4)
  local cNormalInfo = self.data:GetComponentInfoNormal()
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = self.data:GetStateNormal()
  if state == UISummerOneEnterBtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON)
  elseif state == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventNormal()
  elseif state == UISummerOneEnterBtnState.Normal then
    self.btnStageNormal.interactable = true
    self.imgStageNormal.sprite = self:GetSpriteN(4)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON)
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointStageNormal()
end

function UIN11Main.FlushCDText(uiText, time, strs, isUILocalizationText)
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  
  local function SetText(str)
    if isUILocalizationText then
      uiText:SetText(str)
    else
      uiText:RefreshText(str)
    end
  end
  
  if 1 <= d then
    SetText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
  elseif 1 <= h then
    SetText(StringTable.Get(strs[2], math.floor(h), math.floor(m)))
  elseif 1 <= m then
    SetText(StringTable.Get(strs[3], math.floor(m)))
  else
    SetText(StringTable.Get(strs[3], "<1"))
  end
end

function UIN11Main:FlushCDHard()
  self.btnStageHard.interactable = false
  self.cdStageHard:SetActive(false)
  self.imgStageHard.sprite = self:GetSpriteD(5)
  local stateHard = self.data:GetStateHard()
  local cHardInfo = self.data:GetComponentInfoHard()
  if not cHardInfo then
    Log.fatal("### cHardInfo nil.")
    return
  end
  if stateHard == UISummerOneEnterBtnState.NotOpen then
    self.cdStageHard:SetActive(true)
    UIN11Main.FlushCDText(self.txtStageHardOpenTime, cHardInfo.m_unlock_time, self.strsWillOpen)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_unlock_time)
    local secondsLeft = leftSeconds % 60
    self:RegisterTimeEvent(secondsLeft, ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD)
  elseif stateHard == UISummerOneEnterBtnState.Locked then
    self.cdStageHard:SetActive(true)
    local cfgv = Cfg.cfg_campaign_mission[cHardInfo.m_need_mission_id]
    local lvName = StringTable.Get(cfgv.Name)
    self.txtStageHardOpenTime:RefreshText(StringTable.Get("str_activity_summer_i_will_open_after_clearance", lvName))
  elseif stateHard == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEventHard()
  else
    self.btnStageHard.interactable = true
    self.imgStageHard.sprite = self:GetSpriteN(5)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD)
  end
  self:FlushNewStageHard()
end

function UIN11Main:bgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIN11Main:btnIntroOnClick(go)
  self:ShowDialog("UIN11Intro")
end

function UIN11Main:btnBattlePassOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN11Main:btnLoginAwardOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N11, ECampaignN11ComponentID.ECAMPAIGN_N11_CUMULATIVE_LOGIN)
end

function UIN11Main:btnShopOnClick(go)
  local cType, cId = self.data:GetCampaignTypeId()
  ClientCampaignShop.OpenCampaignShop(cType, cId)
end

function UIN11Main:btnStageNormalOnClick(go)
  local state = self.data:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    self:SwitchState(UIStateType.UIActivityN11LineMissionController)
  else
    self:_ShowBtnErrorMsg(state)
  end
end

function UIN11Main:btnStageHardOnClick(go)
  local stateHard = self.data:GetStateHard()
  if stateHard == UISummerOneEnterBtnState.Locked then
    local cHardInfo = self.data:GetComponentInfoHard()
    if cHardInfo then
      local cfgv = Cfg.cfg_campaign_mission[cHardInfo.m_need_mission_id]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        local msg = StringTable.Get("str_activity_summer_i_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
    end
  elseif stateHard == UISummerOneEnterBtnState.Normal then
    if not N11Data.HasPrefsHard() then
      N11Data.SetPrefsHard()
    end
    self:SwitchState(UIStateType.UIActivtiyN11HardLevelController)
  else
    self:_ShowBtnErrorMsg(stateHard)
  end
end

function UIN11Main:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UISummerOneEnterBtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UISummerOneEnterBtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIN11Main:ShowHideUI()
  local goSafeArea = self:GetGameObject("SafeArea")
  if self.isShow then
    self.anim:Play("uieff_n11_main_show")
  else
    self.anim:Play("uieff_n11_main_hide")
  end
end

function UIN11Main:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN11Main)
end
