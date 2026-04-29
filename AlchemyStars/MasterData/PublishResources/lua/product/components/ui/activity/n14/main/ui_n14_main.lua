_class("UIN14Main", UIController)
UIN14Main = UIN14Main

function UIN14Main:Constructor(ui_root_transform)
  self.strsLeftTime = {
    "str_n14_left_time_d_h",
    "str_n14_left_time_h_m",
    "str_n14_left_time_m"
  }
  self.strsTakeAwardLeftTime = {
    "str_n14_take_award_left_time_d_h",
    "str_n14_take_award_left_time_h_m",
    "str_n14_take_award_left_time_m"
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
end

function UIN14Main:LoadDataOnEnter(TT, res, uiParams)
  if not self.data then
    self.data = N14Data:New()
  end
  self.mCampaign = self.data:GetCampaignModule()
  self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N14, res)
  self.isShow = true
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self:LoadDataOnEnter_BattlePass(TT)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self.mCampaign._id, nil, nil)
    return
  end
end

function UIN14Main:LoadDataOnEnter_BattlePass(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN14Main:OnShow(uiParams)
  N14Data.SetPrefsMain()
  self.atlas = self:GetAsset("UIN14.spriteatlas", LoadType.SpriteAtlas)
  self.dictSprite = {
    [1] = {
      n = "n13_zjm_btn05",
      d = "n13_zjm_btn05"
    },
    [2] = {
      n = "n14_zjm_shop",
      d = "n14_zjm_shop"
    },
    [3] = {
      n = "n13_zjm_btn07",
      d = "n13_zjm_btn07"
    },
    [4] = {
      n = "n14_zjm_xxg",
      d = "n14_zjm_xxg"
    },
    [5] = {
      n = "n14_zjm_hard",
      d = "n14_zjm_hard"
    },
    [6] = {
      n = "n14_zjm_game",
      d = "n14_zjm_game"
    }
  }
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
  local UICampaignCommonEconomic = economics:SpawnObject("UICampaignCommonEconomic")
  UICampaignCommonEconomic:Flush("")
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
  self.maskLoginAward = self:GetGameObject("maskLoginAward")
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
  self:Flush()
  self:_CheckGuide()
end

function UIN14Main:OnHide()
  self:DetachEvent(GameEventType.QuestUpdate, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.OnCloseMinigame, self.OnMiniGameClose)
  self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON)
  self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD)
  self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME)
  self.data = nil
  self.btnStageNormal = nil
  self.btnStageHard = nil
end

function UIN14Main:CancelTimerEvent(nState)
  if nState == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON then
    if self.teNormal then
      GameGlobal.Timer():CancelEvent(self.teNormal)
      self.teNormal = nil
    end
  elseif nState == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD then
    if self.teHard then
      GameGlobal.Timer():CancelEvent(self.teHard)
      self.teHard = nil
    end
  elseif nState == ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME and self.teMini then
    GameGlobal.Timer():CancelEvent(self.teMini)
    self.teMini = nil
  end
end

function UIN14Main:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self.data then
    self:Flush()
  end
end

function UIN14Main:Flush()
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

function UIN14Main:SetModeState(mode, isOpen)
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

function UIN14Main:FlushStateBattlePass()
  local open = self.data:GetActivityCampaign():CheckCampaignOpen()
  self.imgBattlePass.sprite = self:GetSpriteN(1)
end

function UIN14Main:FlushStateShop()
  local s = self.data:GetStateShop()
  self.imgShop.sprite = self:GetSpriteN(2)
end

function UIN14Main:FlushStateAward()
  local s = self.data:GetStateAward()
  self.imgLoginAward.sprite = self:GetSpriteN(3)
  self.maskLoginAward:SetActive(s ~= UISummerOneEnterBtnState.Normal)
end

function UIN14Main:FlushStateMinigame()
  local s = self.data:GetStateMiniGame()
  self.imgCatchFish.sprite = self:GetSpriteN(6)
end

function UIN14Main:GetSpriteN(idx)
  local n = self.atlas:GetSprite(self.dictSprite[idx].n)
  return n
end

function UIN14Main:GetSpriteD(idx)
  local d = self.atlas:GetSprite(self.dictSprite[idx].d)
  return d
end

function UIN14Main:FlushRedPointBattlePass()
  local bShow = UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  self.redBattlePass:SetActive(bShow)
end

function UIN14Main:FlushRedPointAward()
  local red = self.data:CheckRedAward()
  self.redAward:SetActive(red)
end

function UIN14Main:FlushRedPointStageNormal()
  if not self.data then
    return
  end
  local red = self.data:CheckRedNormal()
  self.redStageNormal:SetActive(red)
end

function UIN14Main:FlushNewStageHard()
  if not self.data then
    return
  end
  local new = self.data:GetStateHard() == UISummerOneEnterBtnState.Normal and not N14Data.HasPrefsHard()
  self.newStageHard:SetActive(new)
end

function UIN14Main:FlushNewCatchFish()
  if not self.data then
    return
  end
  local new = self.data:CheckNewMiniGame()
  local red = self.data:GetStateMiniGame() == UISummerOneEnterBtnState.Normal and self.data:CheckRedMiniGame()
  UIActivityHelper.SetWidgetNewAndRed(self.newCatchFish, new, self.redCatchFish, red)
end

function UIN14Main:FlushCDActivity()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local cHardInfo = self.data:GetComponentInfoHard()
  local cs = self.data:GetCampaignSample()
  if nowTimestamp < cHardInfo.m_close_time then
    self:FlushCDText(self.txtStageLeftTime, cHardInfo.m_close_time, self.strsLeftTime)
  elseif nowTimestamp < cs.end_time then
    self:FlushCDText(self.txtStageLeftTime, cs.end_time, self.strsTakeAwardLeftTime)
  else
    self.txtStageLeftTime:RefreshText(StringTable.Get("str_n14_end"))
    self.teActivity = UIActivityHelper.CancelTimerEvent(self.teActivity)
  end
end

function UIN14Main:RegisterTimeEvent(seconds, componentId)
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
        if componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON then
          self:FlushNormalStage()
        elseif componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD then
          self:FlushHardStage()
        elseif componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME then
          self:FlushMinigameStage()
        end
      end
    end, self)
  end)
  if componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON then
    self.teNormal = te
  elseif componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD then
    self.teHard = te
  elseif componentId == ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME then
    self.teMini = te
  end
end

function UIN14Main:FlushNormalStage()
  self.btnStageNormal.interactable = false
  self.imgStageNormal.sprite = self:GetSpriteD(4)
  local cNormalInfo = self.data:GetComponentInfoNormal()
  if not cNormalInfo then
    Log.fatal("### cNormalInfo nil.")
    return
  end
  local state = self.data:GetStateNormal()
  self:SetModeState(1, state == UISummerOneEnterBtnState.Normal)
  if state == UISummerOneEnterBtnState.NotOpen then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_unlock_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON)
    self._modTexttable[1]:SetText(StringTable.Get(self.lanActivityTip[1]))
  elseif state == UISummerOneEnterBtnState.Closed then
    self._modTexttable[1]:SetText(StringTable.Get(self.lanActivityTip[2]))
    self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON)
  elseif state == UISummerOneEnterBtnState.Normal then
    self.btnStageNormal.interactable = true
    self.imgStageNormal.sprite = self:GetSpriteN(4)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cNormalInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON)
  else
    Log.fatal("### state=", state)
  end
  self:FlushRedPointStageNormal()
end

function UIN14Main:FlushCDText(uiText, time, strs)
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

function UIN14Main:FlushHardStage()
  self.btnStageHard.interactable = false
  self.cdStageHard:SetActive(false)
  self.imgStageHard.sprite = self:GetSpriteD(5)
  local stateHard = self.data:GetStateHard()
  local cHardInfo = self.data:GetComponentInfoHard()
  if not cHardInfo then
    Log.fatal("### cHardInfo nil.")
    return
  end
  self.hardLockStage:SetActive(stateHard ~= UISummerOneEnterBtnState.Normal)
  self:SetModeState(2, stateHard == UISummerOneEnterBtnState.Normal)
  if stateHard == UISummerOneEnterBtnState.NotOpen then
    self.cdStageHard:SetActive(true)
    self:FlushCDText(self.txtStageHardOpenTime, cHardInfo.m_unlock_time, self.strsWillOpen)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_unlock_time)
    local secondsLeft = leftSeconds % 60
    self:RegisterTimeEvent(secondsLeft, ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD)
    self._modTexttable[2].transform.gameObject:SetActive(false)
  elseif stateHard == UISummerOneEnterBtnState.Locked then
    self.cdStageHard:SetActive(true)
    local cfgv = Cfg.cfg_campaign_mission[cHardInfo.m_need_mission_id]
    local lvName = StringTable.Get(cfgv.Name)
    self.txtStageHardOpenTime:RefreshText(StringTable.Get("str_n14_activity_common_will_open_after_clearance", lvName))
  elseif stateHard == UISummerOneEnterBtnState.Closed then
    self._modTexttable[2].transform.gameObject:SetActive(true)
    self._modTexttable[2]:SetText(StringTable.Get(self.lanActivityTip[2]))
    self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD)
  else
    self.btnStageHard.interactable = true
    self.imgStageHard.sprite = self:GetSpriteN(5)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cHardInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD)
  end
  self:FlushNewStageHard()
end

function UIN14Main:FlushMinigameStage()
  self:FlushStateMinigame()
  local stateMini = self.data:GetStateMiniGame()
  local cGameInfo = self.data:GetComponentInfoMinigame()
  self.lockImage:SetActive(stateMini == UISummerOneEnterBtnState.NotOpen)
  self.lockStage:SetActive(stateMini ~= UISummerOneEnterBtnState.Normal)
  self:SetModeState(3, stateMini == UISummerOneEnterBtnState.Normal)
  self.txtminigameOpenTime.gameObject:SetActive(false)
  if not stateMini or not cGameInfo then
    return
  end
  if stateMini == UISummerOneEnterBtnState.NotOpen then
    self.txtminigameOpenTime.gameObject:SetActive(true)
    self:FlushCDText(self.txtminigameOpenTime, cGameInfo.m_unlock_time, self.strsWillOpen)
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cGameInfo.m_unlock_time)
    local secondsLeft = leftSeconds % 60
    self:RegisterTimeEvent(secondsLeft, ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME)
  elseif stateMini == UISummerOneEnterBtnState.Locked then
    local cfgv = Cfg.cfg_campaign_mission[cGameInfo.m_need_mission_id]
    local lvName = StringTable.Get(cfgv.Name)
    self.txtminigameOpenTime.gameObject:SetActive(true)
  elseif stateMini == UISummerOneEnterBtnState.Closed then
    self:CancelTimerEvent(ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME)
  else
    local leftSeconds = UICommonHelper.CalcLeftSeconds(cGameInfo.m_close_time)
    self:RegisterTimeEvent(leftSeconds, ECampaignN14ComponentID.ECAMPAIGN_N14_MINI_GAME)
  end
  self:FlushNewCatchFish()
end

function UIN14Main:bgOnClick(go)
  if not self.isShow then
    self.isShow = true
    self:ShowHideUI()
  end
end

function UIN14Main:btnIntroOnClick(go)
  self:ShowDialog("UIActivityN14Intro", "UIN14Main")
end

function UIN14Main:btnBattlePassOnClick(go)
  UIActivityBattlePassHelper.OpenMainController()(self._battlepassCampaign)
end

function UIN14Main:btnLoginAwardOnClick(go)
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N14, ECampaignN14ComponentID.ECAMPAIGN_N14_CUMULATIVE_LOGIN)
end

function UIN14Main:btnShopOnClick(go)
  local cType, cId = self.data:GetCampaignTypeId()
  ClientCampaignShop.OpenCampaignShop(cType, cId, function()
    self:SwitchState(UIStateType.UIN14Main)
  end)
end

function UIN14Main:btnStageNormalOnClick(go)
  local state = self.data:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    self:SwitchState(UIStateType.UIActivityN14LineMissionController)
  else
    self:_ShowBtnErrorMsg(state)
  end
end

function UIN14Main:btnStageHardOnClick(go)
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
    if not N14Data.HasPrefsHard() then
      N14Data.SetPrefsHard()
    end
    self:SwitchState(UIStateType.UIActivityN14HardMissionController)
  else
    self:_ShowBtnErrorMsg(stateHard)
  end
end

function UIN14Main:BtnCatchFishOnClick(go)
  local statefish = self.data:GetStateMiniGame()
  if statefish == UISummerOneEnterBtnState.Locked then
    return
  elseif statefish == UISummerOneEnterBtnState.Normal then
    self:ShowDialog("UIN14FishingGameStageController")
    if not N14Data.HasPrefsMiniGame() then
      N14Data.SetPrefsMiniGame()
    end
    self.data:GetLocalProcess():onEnterFishingMiniGame()
  else
    self:_ShowBtnErrorMsg(statefish)
  end
end

function UIN14Main:_ShowBtnErrorMsg(btnState)
  local errType = 0
  if btnState == UISummerOneEnterBtnState.NotOpen then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
  elseif btnState == UISummerOneEnterBtnState.Closed then
    errType = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
  end
  self.mCampaign:ShowErrorToast(errType, true)
end

function UIN14Main:ShowHideUI()
  local goSafeArea = self:GetGameObject("SafeArea")
  if self.isShow then
    self._backBtns:GetGameObject():SetActive(true)
    goSafeArea:SetActive(true)
  else
    self._backBtns:GetGameObject():SetActive(false)
    goSafeArea:SetActive(false)
  end
  self._spineLoader:SetActive(true)
end

function UIN14Main:StoryOnClick(go)
  local canReviewStages = {}
  local cfgs = Cfg.cfg_n14_story_review({})
  if cfgs then
    for i = 1, #cfgs do
      local cfg = cfgs[i]
      local curStage = DiscoveryStage:New()
      curStage.id = cfg.ID
      curStage.longDesc = StringTable.Get(cfg.Des)
      curStage.name = StringTable.Get(cfg.Name)
      curStage.stageIdx = StringTable.Get(cfg.StageIndexTitle)
      curStage.fullname = StringTable.Get(cfg.FullName)
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg.ID
      local storyListCfg = cfg.StoryList
      for i = 1, #storyListCfg do
        local story = DiscoveryStory:New()
        story:Init(storyListCfg[i][1], storyListCfg[i][2])
        table.insert(slist, story)
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, false, true, StringTable.Get("str_n14_story_review_stage_title"))
end

function UIN14Main:_CheckGuide()
  self:Lock("UIN14MainCheckGuide")
  self:StartTask(function(TT)
    YIELD(TT, 1600)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN14MainController)
    self:UnLock("UIN14MainCheckGuide")
  end, self)
end

function UIN14Main:OnMiniGameClose()
  local res = AsyncRequestRes:New()
  self:StartTask(function(TT)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N14, res)
    if res:GetSucc() then
      self:Flush()
    end
  end, self)
end
