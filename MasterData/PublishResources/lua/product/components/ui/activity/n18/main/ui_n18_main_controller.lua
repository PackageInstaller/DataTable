_class("UIN18MainController", UIController)
UIN18MainController = UIN18MainController

function UIN18MainController:Constructor(ui_root_transform)
  self.strsLeftTime = {
    "str_n18_left_time_d_h",
    "str_n18_left_time_h_m",
    "str_n18_left_time_m"
  }
  self.strsTakeAwardLeftTime = {
    "str_n18_take_award_left_time_d_h",
    "str_n18_take_award_left_time_h_m",
    "str_n18_take_award_left_time_m"
  }
  self.strsWillOpen = {
    "str_n14_will_open_after_d_h",
    "str_n14_will_open_after_h_m",
    "str_n14_will_open_after_m"
  }
  self.lanActivityTip = {
    "str_activity_common_state_notstart",
    "str_activity_common_end"
  }
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN18MainController:LoadDataOnEnter(TT, res, uiParams)
  if not self.data then
    self.data = N18Data:New()
  end
  self.mCampaign = self.data:GetCampaignModule()
  self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N18, res)
  self.isShow = true
  self:LoadDataOnEnter_BattlePass(TT)
end

function UIN18MainController:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN18MainController:OnShow(uiParams)
  N18Data.SetPrefsMain()
  self.atlas = self:GetAsset("UIN18.spriteatlas", LoadType.SpriteAtlas)
  self._useColor = {
    Color(1, 1, 1, 1),
    Color(0.36470588235294116, 0.36470588235294116, 0.36470588235294116, 0.8470588235294118)
  }
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
  self.animTopBtns = self._backBtns:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.txtStageLeftTime = self:GetUIComponent("RollingText", "txtStageLeftTime")
  local economics = self:GetUIComponent("UISelectObjectPath", "economics")
  local UIN18CampaignEconomic = economics:SpawnObject("UIN18CampaignEconomic")
  UIN18CampaignEconomic:Flush("")
  self.btnStageNormal = self:GetUIComponent("Button", "btnStageNormal")
  self.btnStageHard = self:GetUIComponent("Button", "btnStageHard")
  self.cdStageHard = self:GetGameObject("cdStageHard")
  self.txtStageHardOpenTime = self:GetUIComponent("RollingText", "txtStageHardOpenTime")
  self.txtminigameOpenTime = self:GetUIComponent("RollingText", "txtminigameOpenTime")
  self.redBattlePass = self:GetGameObject("redBattlePass")
  self.redAward = self:GetGameObject("redAward")
  self.redStageNormal = self:GetGameObject("redStageNormal")
  self.redCatchFish = self:GetGameObject("redCatchFish")
  self.lockStage = self:GetGameObject("lockStage")
  self.hardLockStage = self:GetGameObject("hardLockStage")
  self.newStageHard = self:GetGameObject("newStageHard")
  self.newCatchFish = self:GetGameObject("newCatchFish")
  self.lockImage = self:GetGameObject("lockImage")
  self._spineLoader = self:GetGameObject("spine")
  self.imgBattlePass = self:GetUIComponent("Image", "btnBattlePass")
  self.imgShop = self:GetUIComponent("Image", "btnShop")
  self.imgLoginAward = self:GetUIComponent("Image", "btnLoginAward")
  self.imgStageNormal = self:GetUIComponent("Image", "btnStageNormal")
  self.imgStageHard = self:GetUIComponent("Image", "btnStageHard")
  self.imgCatchFish = self:GetUIComponent("Image", "btnCatchFish")
  self._masktable = {
    self:GetGameObject("MaskStageNormal"),
    self:GetGameObject("MaskStageHard"),
    self:GetGameObject("MaskCatchFish")
  }
  self._modRawImagetable = {
    self:GetUIComponent("RawImage", "Normal"),
    self:GetUIComponent("RawImage", "Hard"),
    self:GetUIComponent("RawImage", "CatchFish")
  }
  self._modImagetable = {
    self:GetUIComponent("Image", "btnStageNormal"),
    self:GetUIComponent("Image", "btnStageHard"),
    self:GetUIComponent("Image", "btnCatchFish")
  }
  self._modTexttable = {
    self:GetUIComponent("UILocalizationText", "StageNormalText"),
    self:GetUIComponent("UILocalizationText", "StageHardText")
  }
  self:AttachEvent(GameEventType.QuestUpdate, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.OnCloseMinigame, self.OnMiniGameClose)
  self.teActivity = UIActivityHelper.StartTimerEvent(self.teActivity, function()
    self:FlushCDActivity()
  end, 60000)
  self.mask_big_root = self:GetGameObject("maskBigRoot")
  self.mask_big_root:SetActive(false)
  self.mask_big = self:GetUIComponent("MeshRenderer", "maskBig")
  self.mask_big2 = self:GetUIComponent("MeshRenderer", "maskBig2")
  self.reqBg = ResourceManager:GetInstance():SyncLoadAsset("n18_zjm_bg1" .. ".mat", LoadType.Mat)
  self.bgAsset = self.reqBg.Obj
  self.mask_big.material:SetTexture("_MainTex1", self.bgAsset:GetTexture("_MainTex"))
  self.mask_big2.material:SetTexture("_MainTex1", self.bgAsset:GetTexture("_MainTex"))
  self.anim = self:GetUIComponent("Animation", "anim")
  self.rt = self:GetUIComponent("RawImage", "rt")
  self:Flush()
  if self:_SetImgRT(uiParams[1]) then
    self.mask_big_root:SetActive(true)
    self:_CheckGuide()
    UIWidgetHelper.PlayAnimation(self, "anim", "eff_UIN18MainController_in", 500, function()
      self.rt.gameObject:SetActive(false)
    end)
  else
    self.rt.gameObject:SetActive(false)
  end
end

function UIN18MainController:_PlayAnimIn()
  self:StartTask(function(TT)
    self.mask_big_root:SetActive(true)
    local lockName = self:GetName() .. "_PlayAnimIn()"
    self:Lock(lockName)
    self.anim:Play("eff_UIN18MainController_in")
    YIELD(TT, 1700)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN18MainController)
    self:UnLock(lockName)
  end, self)
end

function UIN18MainController:_PlayAnimOut(cb)
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimOut()"
    self:Lock(lockName)
    self.anim:Play("eff_UIN18MainController_out")
    YIELD(TT, 500)
    self:UnLock(lockName)
    cb()
  end, self)
end

function UIN18MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    self.rt.texture = imgRT
    return true
  end
  return false
end

function UIN18MainController:OnHide()
  self:DetachEvent(GameEventType.QuestUpdate, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.OnCloseMinigame, self.OnMiniGameClose)
  self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  self.data = nil
  self.btnStageNormal = nil
  self.btnStageHard = nil
  self.reqBg:Dispose()
  self.reqBg = nil
end

function UIN18MainController:CancelTimerEvent(nState)
  if nState == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON then
    if self.teNormal then
      GameGlobal.Timer():CancelEvent(self.teNormal)
      self.teNormal = nil
    end
  elseif nState == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD then
    if self.teHard then
      GameGlobal.Timer():CancelEvent(self.teHard)
      self.teHard = nil
    end
  elseif nState == ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME and self.teMini then
    GameGlobal.Timer():CancelEvent(self.teMini)
    self.teMini = nil
  end
end

function UIN18MainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self.data then
    self:Flush()
  end
end

function UIN18MainController:Flush()
  self:FlushStateBattlePass()
  self:FlushStateShop()
  self:FlushStateAward()
  self:FlushRedPointBattlePass()
  self:FlushRedPointAward()
  self:FlushCDActivity()
  self:FlushNormalStage()
  self:FlushHardStage()
  self:FlushMinigameStage()
end

function UIN18MainController:SetModeState(mode, isOpen)
  if self._masktable[mode] then
    self._masktable[mode]:SetActive(not isOpen)
  end
  if self._modRawImagetable[mode] then
    self._modRawImagetable[mode].color = isOpen and self._useColor[1] or self._useColor[2]
  end
  if self._modImagetable[mode] then
    self._modImagetable[mode].color = isOpen and self._useColor[1] or self._useColor[2]
  end
end

function UIN18MainController:FlushStateBattlePass()
  local open = self.data:GetActivityCampaign():CheckCampaignOpen()
end

function UIN18MainController:FlushStateShop()
  local s = self.data:GetStateShop()
end

function UIN18MainController:FlushStateAward()
  local s = self.data:GetStateCumulativeLogin()
end

function UIN18MainController:FlushStateMinigame()
  local s = self.data:GetStateMiniGame()
end

function UIN18MainController:FlushRedPointBattlePass()
  local bShow = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.redBattlePass:SetActive(bShow)
end

function UIN18MainController:FlushRedPointAward()
  local red = self.data:CheckRedCumulativeLogin()
  self.redAward:SetActive(red)
end

function UIN18MainController:FlushRedPointStageNormal()
  if not self.data then
    return
  end
  local red = self.data:CheckRedNormal() or self.data:CheckRedLevelFixteam()
  self.redStageNormal:SetActive(red)
end

function UIN18MainController:FlushNewStageHard()
  if not self.data then
    return
  end
  local new = self.data:GetStateHard() == UIN18BtnState.Normal and not N18Data.HasPrefsHard()
  self.newStageHard:SetActive(new)
end

function UIN18MainController:FlushNewCatchFish()
  if not self.data then
    return
  end
  local new = self.data:CheckNewMiniGame() and self.data:GetStateMiniGame() == UIN18BtnState.Normal
  local red = self.data:GetStateMiniGame() == UIN18BtnState.Normal and self.data:CheckRedMiniGame()
  UIActivityHelper.SetWidgetNewAndRed(self.newCatchFish, new, self.redCatchFish, red)
end

function UIN18MainController:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cHardInfo = self.data:GetComponentInfoHard()
  local cs = self.data:GetCampaignSample()
  if nowTimestamp < cHardInfo.m_close_time then
    self:FlushCDText(self.txtStageLeftTime, cHardInfo.m_close_time, self.strsLeftTime)
  elseif nowTimestamp < cs.end_time then
    self:FlushCDText(self.txtStageLeftTime, cs.end_time, self.strsTakeAwardLeftTime)
  else
    self.txtStageLeftTime:RefreshText(StringTable.Get("str_activity_n16_main_remaintime_close"))
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIN18MainController:RegisterTimeEvent(seconds, componentId)
  self:CancelTimerEvent(componentId)
  Log.warn("### RegisterTimeEvent componentId=", componentId)
  if seconds < 60 then
    seconds = 60
  end
  local ms = seconds * 1000
  local te = GameGlobal.Timer():AddEvent(ms, function()
    self:StartTask(function(TT)
      if self.data then
        self.data:RequestCampaign(TT)
        if componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON then
          self:FlushNormalStage()
        elseif componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD then
          self:FlushHardStage()
        elseif componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME then
          self:FlushMinigameStage()
        end
      end
    end, self)
  end)
  if componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON then
    self.teNormal = te
  elseif componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD then
    self.teHard = te
  elseif componentId == ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME then
    self.teMini = te
  end
end

function UIN18MainController:FlushNormalStage()
  self.btnStageNormal.interactable = false
  local cNormalInfo = self.data:GetComponentInfoNormal()
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = self.data:GetStateNormal()
  self:SetModeState(1, state == UIN18BtnState.Normal)
  if state == UIN18BtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  elseif state == UIN18BtnState.Closed then
    self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  elseif state == UIN18BtnState.Normal then
    self.btnStageNormal.interactable = true
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointStageNormal()
end

function UIN18MainController:FlushCDText(uiText, time, strs)
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  if 1 <= d then
    uiText:RefreshText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
  elseif 1 <= h then
    uiText:RefreshText(StringTable.Get(strs[2], math.floor(h), math.floor(m)))
  elseif 1 <= m then
    uiText:RefreshText(StringTable.Get(strs[3], math.floor(m)))
  else
    uiText:RefreshText(StringTable.Get(strs[3], "<1"))
  end
end

function UIN18MainController:FlushHardStage()
  self.btnStageHard.interactable = false
  self.cdStageHard:SetActive(false)
  local stateHard = self.data:GetStateHard()
  local cHardInfo = self.data:GetComponentInfoHard()
  if not cHardInfo then
    Log.fatal("### cHardInfo nil.")
    return
  end
  self.hardLockStage:SetActive(stateHard ~= UIN18BtnState.Normal)
  self:SetModeState(2, stateHard == UIN18BtnState.Normal)
  if stateHard == UIN18BtnState.NotOpen then
    self.cdStageHard:SetActive(true)
    self:FlushCDText(self.txtStageHardOpenTime, cHardInfo.m_unlock_time, self.strsWillOpen)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_unlock_time)
    local secondsLeft = leftSeconds % 60
    self:RegisterTimeEvent(secondsLeft, ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  elseif stateHard == UIN18BtnState.Locked then
    self.cdStageHard:SetActive(true)
    local cfgv = Cfg.cfg_campaign_mission[cHardInfo.m_need_mission_id]
    local lvName = StringTable.Get(cfgv.Name)
    self.txtStageHardOpenTime:RefreshText(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
  elseif stateHard == UIN18BtnState.Closed then
    self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  else
    self.btnStageHard.interactable = true
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  end
  self:FlushNewStageHard()
end

function UIN18MainController:FlushMinigameStage()
  self:FlushStateMinigame()
  local stateMini = self.data:GetStateMiniGame()
  local cGameInfo = self.data:GetComponentInfoMinigame()
  self.lockImage:SetActive(stateMini == UIN18BtnState.NotOpen)
  self.lockStage:SetActive(stateMini ~= UIN18BtnState.Normal)
  self:SetModeState(3, stateMini == UIN18BtnState.Normal)
  self.txtminigameOpenTime.gameObject:SetActive(false)
  if not stateMini or not cGameInfo then
    return
  end
  if stateMini == UIN18BtnState.NotOpen then
    self.txtminigameOpenTime.gameObject:SetActive(true)
    self:FlushCDText(self.txtminigameOpenTime, cGameInfo.m_unlock_time, self.strsWillOpen)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cGameInfo.m_unlock_time)
    local secondsLeft = leftSeconds % 60
    self:RegisterTimeEvent(secondsLeft, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  elseif stateMini == UIN18BtnState.Locked then
    local cfgv = Cfg.cfg_campaign_mission[cGameInfo.m_need_mission_id]
    local lvName = StringTable.Get(cfgv.Name)
    self.txtminigameOpenTime.gameObject:SetActive(true)
  elseif stateMini == UIN18BtnState.Closed then
    self:CancelTimerEvent(ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  else
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cGameInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  end
  self:FlushNewCatchFish()
end

function UIN18MainController:bgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIN18MainController:btnIntroOnClick(go)
  self:ShowDialog("UIN18Intro2", "UIN18Main")
end

function UIN18MainController:btnBattlePassOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN18MainController:btnLoginAwardOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N18, ECampaignN18ComponentID.ECAMPAIGN_N18_CUMULATIVE_LOGIN)
end

function UIN18MainController:btnShopOnClick(go)
  local cType, cId = self.data:GetCampaignTypeId()
  ClientCampaignShop.OpenCampaignShop(cType, cId, function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN18Main, UIStateType.UIMain, nil, cId)
  end)
end

function UIN18MainController:btnStageNormalOnClick(go)
  local state = self.data:GetStateNormal()
  if state == UIN18BtnState.Normal then
    self:SwitchState(UIStateType.UIN18LineMissionController)
  else
    self:_ShowBtnErrorMsg(state)
  end
end

function UIN18MainController:btnStageHardOnClick(go)
  local stateHard = self.data:GetStateHard()
  if stateHard == UIN18BtnState.Locked then
    local cHardInfo = self.data:GetComponentInfoHard()
    if cHardInfo then
      local cfgv = Cfg.cfg_campaign_mission[cHardInfo.m_need_mission_id]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        local msg = StringTable.Get("str_activity_common_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
    end
  elseif stateHard == UIN18BtnState.Normal then
    if not N18Data.HasPrefsHard() then
      N18Data.SetPrefsHard()
    end
    self:SwitchState(UIStateType.UIN18HardMissionController)
  else
    self:_ShowBtnErrorMsg(stateHard)
  end
end

function UIN18MainController:BtnCatchFishOnClick(go)
  local statefish = self.data:GetStateMiniGame()
  if statefish == UIN18BtnState.Locked then
    return
  elseif statefish == UIN18BtnState.Normal then
    UIActivityHelper.PlayFirstPlot_Component(self.data:GetActivityCampaign(), ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME, function()
      GameGlobal.UIStateManager():ShowDialog("UIFindTreasureDetail", true, ECampaignType.CAMPAIGN_TYPE_N18, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
    end)
    if not N18Data.HasPrefsMiniGame() then
      N18Data.SetPrefsMiniGame()
    end
  else
    self:_ShowBtnErrorMsg(statefish)
  end
end

function UIN18MainController:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UIN18BtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UIN18BtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIN18MainController:ShowHideUI()
  local uielem = self:GetGameObject("UIElements")
  if self.isShow then
    self.anim:Play("eff_UIN18MainController_in_2")
  else
    self.anim:Play("eff_UIN18MainController_out")
  end
end

function UIN18MainController:_CheckGuide()
  self:Lock("UIN18MainControllerCheckGuide")
  self:StartTask(function(TT)
    YIELD(TT, 1700)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN18MainController)
    self:UnLock("UIN18MainControllerCheckGuide")
  end, self)
end

function UIN18MainController:OnMiniGameClose()
  local res = AsyncRequestRes:New()
  self:StartTask(function(TT)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N18, res)
    if res:GetSucc() then
      self:Flush()
    end
  end, self)
end
