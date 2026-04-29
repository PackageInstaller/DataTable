_class("UIN27LotteryMain", UIController)
UIN27LotteryMain = UIN27LotteryMain

function UIN27LotteryMain:Constructor()
  self._anywhere_none = 0
  self._anywhere_uiShow = 1
  self._anywhere_coinTips = 2
  self._anywhere_luckDraw = 3
  self._anywhere_delivering = 4
  self._anywhere_delivered = 5
  self._anywhere_unlockpool = 6
  self._anywhereType = 0
  self._stationCount = 6
  self._stationID = 0
  self._stationState_locked = 1
  self._stationState_doing = 2
  self._stationState_completed = 3
  self._speedState_51 = 1
  self._speedState_idle_51 = 2
  self._speedState_134 = 3
  self._speedState_idle_134 = 4
  self._speedState_stop = 5
  self._speedState_idle_stop = 6
  self._speedState = 1
  self._speedText = 0
  self._speedStateTask = nil
  self._itemCoinAmount = 0
  self._lottery = {
    structName = "UIN27LotteryMain::EntryPerformance",
    lockPerformance = false,
    lotteryType = nil,
    lotteryAward = nil,
    openNewPlot = false,
    openNewPool = false,
    idPerformanceTask = nil
  }
end

function UIN27LotteryMain:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._lotteryComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_LOTTERY)
  self._lotteryInfo = self._lotteryComponent:ComponentInfo()
end

function UIN27LotteryMain:OnShow(uiParams)
  self._spineBeijing = self:GetUIComponent("SpineLoader", "spineBeijing")
  self._spineQiche = self:GetUIComponent("SpineLoader", "spineQiche")
  self._spineRen = self:GetUIComponent("SpineLoader", "spineRen")
  self._txtSpeed = self:GetUIComponent("UILocalizationText", "txtSpeed")
  self._rootSpeed = self._txtSpeed.transform.parent
  self._uiLuckDraw1 = self:GetUIComponent("RectTransform", "uiLuckDraw1")
  self._uiLuckDraw10 = self:GetUIComponent("RectTransform", "uiLuckDraw10")
  self._uiLuckDraw10Animation = self:GetUIComponent("Animation", "uiLuckDraw10")
  self._uiWidget1 = self:GetUIComponent("RectTransform", "uiWidget1")
  self._uiWidget2 = self:GetUIComponent("RectTransform", "uiWidget2")
  self._uiDelivering = self:GetUIComponent("RectTransform", "uiDelivering")
  self._uiDelivered = self:GetUIComponent("RectTransform", "uiDelivered")
  self._uiUnlockPool = self:GetUIComponent("RectTransform", "uiUnlockPool")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._anCMAnimation = self:GetUIComponent("Animation", "anCMAnimation")
  self._usCombo = self:GetUIComponent("RectTransform", "usCombo")
  self._zhCombo = self:GetUIComponent("RectTransform", "zhCombo")
  self._txtPostTips = self:GetUIComponent("UILocalizationText", "txtPostTips")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._newWorkBook = self:GetUIComponent("RectTransform", "newWorkBook")
  self._txtCoinShadow = self:GetUIComponent("UILocalizationText", "txtCoinShadow")
  self._txtCoinBg = self:GetUIComponent("UILocalizationText", "txtCoinBg")
  self._txtCoin = self:GetUIComponent("UILocalizationText", "txtCoin")
  self._iconCoin = self:GetUIComponent("RawImageLoader", "iconCoin")
  self._rootCoinTips = self:GetUIComponent("RectTransform", "rootCoinTips")
  self._rootCoinTipsAnim = self:GetUIComponent("Animation", "rootCoinTips")
  self._txtStationName = self:GetUIComponent("UILocalizationText", "txtStationName")
  self._txtWaypointName = self:GetUIComponent("UILocalizationText", "txtWaypointName")
  self._rootStation = self:GetUIComponent("RectTransform", "rootStation")
  self._btnPageLeft = self:GetUIComponent("RectTransform", "btnPageLeft")
  self._btnPageRight = self:GetUIComponent("RectTransform", "btnPageRight")
  self._btnReviewPageLeft = self:GetUIComponent("RectTransform", "btnReviewPageLeft")
  self._btnReviewPageRight = self:GetUIComponent("RectTransform", "btnReviewPageRight")
  self._txtRewardRemain = self:GetUIComponent("UILocalizationText", "txtRewardRemain")
  self._txtRewardTotal = self:GetUIComponent("UILocalizationText", "txtRewardTotal")
  self._uiPageLocked = self:GetUIComponent("RectTransform", "uiPageLocked")
  self._uiSingle = self:GetLotteryButton("uiLotterySingle")
  self._uiMultiple = self:GetLotteryButton("uiLotteryMultiple")
  self._awardScrollView = self:GetUIComponent("ScrollRect", "awardScrollView")
  self._awardContent = self:GetUIComponent("UISelectObjectPath", "awardContent")
  self._uiPoolEmpty = self:GetUIComponent("RectTransform", "uiPoolEmpty")
  self._reviewRoot = self:GetUIComponent("RectTransform", "reviewRoot")
  self._reviewRootAnim = self:GetUIComponent("Animation", "reviewRoot")
  self._reviewScrollView = self:GetUIComponent("ScrollRect", "reviewScrollView")
  self._reviewContent = self:GetUIComponent("UISelectObjectPath", "reviewContent")
  self._reviewRoot.gameObject:SetActive(false)
  self._atlas = self:GetAsset("UIN27Lottery.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self._stations = nil
  self._plots = nil
  self:CreateStation()
  self:CreatePlot()
  self:SpineInitialization()
  self:EnterFullScreenBg(false)
  self:SwitchCoinTips(false, false)
  self:SwitchLuckDraw(false)
  self:SwitchDelivery(false, false)
  self:SwitchUnlockPool(false)
  self:DiffLanguage()
  self:InitCommonTopButton()
  self:FlushStationState()
  self:FlushPlotState(true)
  self:TurnPage(self._stationID)
  self:TurnPagePlayerHead(self._stationID)
  self:PlayInAnimation()
  self:PlaySpeedAnimation()
end

function UIN27LotteryMain:OnHide()
  self:ClosePerformance()
  self:CloseSpeedAnimation()
end

function UIN27LotteryMain:CreateStation()
  local playerHead = self:GetChildComponent(self._rootStation, "RectTransform", "playerHead")
  local playerHeadAnim = self:GetChildComponent(self._rootStation, "Animation", "playerHead")
  local imgHeadRt = self:GetChildComponent(playerHead, "RectTransform", "imgHead")
  self._stations = {
    playerHead = playerHead,
    playerHeadAnim = playerHeadAnim,
    imgHeadRt = imgHeadRt
  }
  self._stationCount = #self._lotteryInfo.m_jackpots
  for i = 1, self._stationCount do
    local rootName = string.format("station%d", i)
    local root = self:GetChildComponent(self._rootStation, "UISelectObjectPath", rootName)
    local spawn = root:SpawnOneObject("ManualLoad0")
    self._stations[i] = {
      structName = "UIN27LotteryMain::station",
      root = root,
      spawn = spawn,
      imgBackground = self:GetChildComponent(spawn, "Image", "offset/imgBackground"),
      imgUnlocked = self:GetChildComponent(spawn, "Image", "offset/imgUnlocked"),
      imgDoing = self:GetChildComponent(spawn, "Image", "offset/imgDoing"),
      imgCompleted = self:GetChildComponent(spawn, "Image", "offset/imgCompleted"),
      cfg = Cfg.cfg_n27_lottery_jackpot[i],
      state = self._stationState_locked,
      remain = 0,
      total = 0
    }
    local current = self._stations[i]
    current.imgBackground.sprite = self._atlas:GetSprite(current.cfg.IconNormal)
    current.imgUnlocked.sprite = self._atlas:GetSprite(current.cfg.IconHighlight)
    current.imgDoing.sprite = self._atlas:GetSprite(current.cfg.IconHighlight)
    local unlockID = self._lotteryInfo.m_unlock_jackpots[i]
    if unlockID ~= nil then
      self._stationID = i
    end
    if self._stations[i].cfg == nil then
      Log.exception("没有奖池配置 cfg_n27_lottery_jackpot：id = ", i)
    end
  end
end

function UIN27LotteryMain:CreatePlot()
  local allPlot = Cfg.cfg_n27_lottery_plot({})
  self._plots = {}
  local count = 0
  for k, v in pairs(allPlot) do
    local plot = {
      structName = "UIN27LotteryMain::plot",
      state = UIN27LotteryPlotState.locked,
      cfg = v
    }
    count = count + 1
    table.insert(self._plots, plot)
  end
  table.sort(self._plots, function(a, b)
    return a.cfg.PlotLevel < b.cfg.PlotLevel
  end)
  self._plots.count = count
  self._plots.costCount = self._lotteryInfo.m_cost_count
  self._plots.multiCount = self._lotteryInfo.m_multi_lottery
  self._plots.manualBrowse = false
  self._plots.completed = 0
  self._plots.curPlot = nil
end

function UIN27LotteryMain:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN27LotteryMain:GetLotteryButton(lotteryName)
  local root = self:GetUIComponent("RectTransform", lotteryName)
  return {
    structName = "UIN27LotteryMain::LotteryButton",
    root = root,
    button = root:GetComponent("Button"),
    iconCoin = self:GetChildComponent(root, "RawImageLoader", "iconCoin"),
    txtCostShadow = self:GetChildComponent(root, "UILocalizationText", "txtLotteryCostShadow"),
    txtCost = self:GetChildComponent(root, "UILocalizationText", "txtLotteryCost"),
    txtCostLack = self:GetChildComponent(root, "UILocalizationText", "txtLotteryCostLack")
  }
end

function UIN27LotteryMain:GetSpriteAtlas()
  return self._atlas
end

function UIN27LotteryMain:SpineInitialization()
  self:SetSpineDefaultMix(self._spineBeijing)
  self:SetSpineDefaultMix(self._spineQiche)
  self:SetSpineDefaultMix(self._spineRen)
end

function UIN27LotteryMain:SetSpineDefaultMix(curSpine)
  local skeleton
  if curSpine ~= nil then
    skeleton = curSpine.CurrentSkeleton or curSpine.CurrentMultiSkeleton
  end
  if skeleton ~= nil then
    skeleton.AnimationState.Data.DefaultMix = 0
  end
end

function UIN27LotteryMain:PlaySpine(curSpine, trackIndex, animName, loop)
  local skeleton
  if curSpine ~= nil then
    skeleton = curSpine.CurrentSkeleton or curSpine.CurrentMultiSkeleton
  end
  if skeleton ~= nil then
    skeleton.AnimationState:SetAnimation(trackIndex, animName, loop)
  end
end

function UIN27LotteryMain:TestSpineOnClick()
  local parent = self._spineBeijing.transform.parent
  local child = parent.transform:Find("TestSpine/txt")
  local txt = child:GetComponent("UILocalizationText")
  local name = txt.text
  local child = parent.transform:Find("TestSpine/txtChe")
  local txtChe = child:GetComponent("UILocalizationText")
  local nameChe = txtChe.text
  local child = parent.transform:Find("TestSpine/txtRen")
  local txtRen = child:GetComponent("UILocalizationText")
  local nameRen = txtRen.text
  if string.len(name) ~= 0 then
    self:PlaySpine(self._spineBeijing, 0, name, true)
  end
  if string.len(nameChe) ~= 0 then
    self:PlaySpine(self._spineQiche, 0, nameChe, true)
  end
  if string.len(nameRen) ~= 0 then
    self:PlaySpine(self._spineRen, 0, nameRen, true)
  end
end

function UIN27LotteryMain:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self.BackCbTask ~= nil then
      CutsceneManager.ExcuteCutsceneIn_Shot()
      self:StartTask(self.BackCbTask, self)
      return
    end
    CutsceneManager.ExcuteCutsceneIn_Shot()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN27Controller, UIStateType.UIMain, nil, self._campaign._id)
  end, function()
    self:ShowDialog("UIIntroLoader", "UIN27LotteryIntro", MaskType.MT_BlurMask)
  end, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN27LotteryMain:BackCbTask(TT)
  self:Lock("UIN27LotteryMain:BackCb")
  self._animation:Play("uieffanim_UIN27LotteryMain_out")
  YIELD(TT, 167)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CampaignSwitchState(true, UIStateType.UIN27Controller, UIStateType.UIMain, nil, self._campaign._id)
  YIELD(TT, 200)
  self:UnLock("UIN27LotteryMain:BackCb")
end

function UIN27LotteryMain:PlayInAnimation()
  local lockName = "UIN27LotteryMain:PlayInAnimation-1"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieffanim_UIN27LotteryMain_in")
    YIELD(TT, 1033)
    self:UnLock(lockName)
  end)
  local lockName = "UIN27LotteryMain:PlayInAnimation-2"
  self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 600)
    self._stations.playerHeadAnim:Play("uieffanim_UIN27LotteryMain_playerHead_scale")
    YIELD(TT, 400)
    self:UnLock(lockName)
  end)
  self:PageAwardPlayIn()
end

function UIN27LotteryMain:PageAwardPlayIn()
  local lockName = "UIN27LotteryMain:PageAwardPlayIn"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardPool[k]
      ui:SetActive(false)
    end
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardPool[k]
      ui:SetActive(true)
      ui:PlayAnimation("uieffanim_UIN27LotteryAward_in")
      YIELD(TT, 50)
    end
    self:UnLock(lockName)
  end)
end

function UIN27LotteryMain:PageAwardPlayOut(cbFinish)
  local lockName = "UIN27LotteryMain:PageAwardPlayOut"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardPool[k]
      ui:SetActive(true)
      ui:PlayAnimation("uieffanim_UIN27LotteryAward_out")
    end
    YIELD(TT, 133)
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardPool[k]
      ui:SetActive(false)
    end
    self:UnLock(lockName)
    if cbFinish then
      cbFinish()
    end
  end)
end

function UIN27LotteryMain:PageAwardReviewPlayIn()
  if not self._reviewRoot.gameObject.activeSelf then
    return
  end
  local lockName = "UIN27LotteryMain:PageAwardReviewPlayIn"
  for k, v in pairs(self._awardDataPool) do
    local ui = self._awardReviewPool[k]
    ui:SetActive(false)
  end
  local inLine = 5
  local dataCount = #self._awardDataPool
  local rows = math.ceil(dataCount / inLine)
  self:StartTask(function(TT)
    self:Lock(lockName)
    for i = 1, rows do
      local lockRowName = lockName .. i
      self:StartTask(function(TT)
        self:Lock(lockRowName)
        for j = 1, inLine do
          local k = (i - 1) * inLine + j
          local ui = self._awardReviewPool[k]
          if ui == nil then
            break
          end
          ui:SetActive(true)
          ui:PlayAnimation("uieffanim_UIN27LotteryAward2_in")
          YIELD(TT, 50)
        end
        self:UnLock(lockRowName)
      end)
      YIELD(TT, 25)
    end
    self:UnLock(lockName)
  end)
end

function UIN27LotteryMain:PageAwardReviewPlayOut(cbFinish)
  if not self._reviewRoot.gameObject.activeSelf then
    if cbFinish ~= nil then
      cbFinish()
    end
    return
  end
  local lockName = "UIN27LotteryMain:PageAwardReviewPlayOut"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardReviewPool[k]
      ui:SetActive(true)
      ui:PlayAnimation("uieffanim_UIN27LotteryAward2_out")
    end
    YIELD(TT, 133)
    for k, v in pairs(self._awardDataPool) do
      local ui = self._awardReviewPool[k]
      ui:SetActive(false)
    end
    self:UnLock(lockName)
    if cbFinish ~= nil then
      cbFinish()
    end
  end)
end

function UIN27LotteryMain:PlaySpeedAnimation(speedState)
  self._speedState = speedState
  if self._speedState == nil then
    self._speedState = self._speedState_51
    self._speedText = 0
  end
  if self._speedStateTask ~= nil then
    return
  end
  self._speedStateTask = self:StartTask(function(TT)
    while true do
      if self._speedState == self._speedState_51 then
        local deltaTime = 0
        local period = 850
        local speed = (51 - self._speedText) / period
        while deltaTime < period do
          self._txtSpeed:SetText(math.floor(self._speedText))
          YIELD(TT)
          local dt = GameGlobal:GetInstance():GetDeltaTime()
          deltaTime = deltaTime + dt
          self._speedText = self._speedText + speed * dt
        end
        self._speedState = self._speedState_idle_51
      elseif self._speedState == self._speedState_idle_51 then
        local in51 = true
        local deltaTime = 0
        while self._speedState == self._speedState_idle_51 do
          if in51 then
            self._speedText = 51
            self._txtSpeed:SetText(self._speedText)
            if 1266 <= deltaTime then
              deltaTime = 0
              in51 = not in51
            end
          else
            self._speedText = 50
            self._txtSpeed:SetText(self._speedText)
            if 800 <= deltaTime then
              deltaTime = 0
              in51 = not in51
            end
          end
          YIELD(TT)
          deltaTime = deltaTime + GameGlobal:GetInstance():GetDeltaTime()
        end
      elseif self._speedState == self._speedState_134 then
        local deltaTime = 0
        local period = 700
        local speed = (134 - self._speedText) / period
        while deltaTime < period do
          self._txtSpeed:SetText(math.floor(self._speedText))
          YIELD(TT)
          local dt = GameGlobal:GetInstance():GetDeltaTime()
          deltaTime = deltaTime + dt
          self._speedText = self._speedText + speed * dt
        end
        self._speedState = self._speedState_idle_134
      elseif self._speedState == self._speedState_idle_134 then
        local in134 = true
        local deltaTime = 0
        while self._speedState == self._speedState_idle_134 do
          if in134 then
            self._speedText = 134
            self._txtSpeed:SetText(self._speedText)
          else
            self._speedText = 135
            self._txtSpeed:SetText(self._speedText)
          end
          if 100 <= deltaTime then
            deltaTime = 0
            in134 = not in134
          end
          YIELD(TT)
          deltaTime = deltaTime + GameGlobal:GetInstance():GetDeltaTime()
        end
      elseif self._speedState == self._speedState_stop then
        local deltaTime = 0
        local period = 750
        local speed = (0 - self._speedText) / period
        while deltaTime < period do
          self._txtSpeed:SetText(math.floor(self._speedText))
          YIELD(TT)
          local dt = GameGlobal:GetInstance():GetDeltaTime()
          deltaTime = deltaTime + dt
          self._speedText = self._speedText + speed * dt
        end
        self._speedState = self._speedState_idle_stop
      elseif self._speedState == self._speedState_idle_stop then
        self._speedText = 0
        self._txtSpeed:SetText(self._speedText)
        YIELD(TT)
      end
    end
  end)
end

function UIN27LotteryMain:CloseSpeedAnimation()
  if self._speedStateTask ~= nil then
    local task = GameGlobal.TaskManager():FindTask(self._speedStateTask)
    if task ~= nil and task.state ~= TaskState.Stop then
      GameGlobal.TaskManager():KillTask(self._speedStateTask)
    end
  end
  self._speedStateTask = nil
end

function UIN27LotteryMain:EnterFullScreenBg(isEnter)
  self._uiWidget1.gameObject:SetActive(not isEnter)
  self._uiWidget2.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
  if isEnter then
    self._anywhereType = self._anywhere_uiShow
  else
    self._anywhereType = self._anywhere_none
  end
end

function UIN27LotteryMain:SwitchCoinTips(inShowTips, playAnimation)
  self._rootCoinTips.gameObject:SetActive(inShowTips)
  self._btnAnywhere.gameObject:SetActive(inShowTips)
  if inShowTips then
    self._anywhereType = self._anywhere_coinTips
  else
    self._anywhereType = self._anywhere_none
  end
  local lockName = "UIN27LotteryMain:SwitchCoinTips"
  if inShowTips and playAnimation then
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._rootCoinTipsAnim:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnRT_imgCoinTips_in")
      YIELD(TT, 300)
      self:UnLock(lockName)
    end)
  elseif playAnimation then
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._rootCoinTips.gameObject:SetActive(true)
      self._rootCoinTipsAnim:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnRT_imgCoinTips_out")
      YIELD(TT, 300)
      self._rootCoinTips.gameObject:SetActive(false)
      self:UnLock(lockName)
    end)
  end
end

function UIN27LotteryMain:SwitchLuckDraw(inShowDraw, lotteryType, hideWidget)
  self:EnterFullScreenBg(inShowDraw)
  hideWidget = false
  self:EnterFullScreenBg(false)
  self._btnAnywhere.gameObject:SetActive(inShowDraw)
  if inShowDraw then
    self._uiLuckDraw1.gameObject:SetActive(lotteryType == ECampaignLotteryType.E_CLT_SINGLE)
    self._uiLuckDraw10.gameObject:SetActive(lotteryType == ECampaignLotteryType.E_CLT_MULTI)
    self._anywhereType = self._anywhere_luckDraw
  else
    self._uiWidget1.gameObject:SetActive(not hideWidget)
    self._uiWidget2.gameObject:SetActive(not hideWidget)
    self._uiLuckDraw1.gameObject:SetActive(false)
    self._uiLuckDraw10.gameObject:SetActive(false)
    self._anywhereType = self._anywhere_none
  end
  if inShowDraw and lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    self._uiLuckDraw10Animation:Play("uieffanim_UIN27LotteryMain_uiLuckDraw10_uiNumber")
  end
end

function UIN27LotteryMain:SwitchDelivery(inShowDelivering, inShowDelivered)
  self._uiDelivering.gameObject:SetActive(inShowDelivering)
  self._uiDelivered.gameObject:SetActive(inShowDelivered)
  self._txtPostTips.gameObject:SetActive(false)
  self._btnAnywhere.gameObject:SetActive(inShowDelivering or inShowDelivered)
  if inShowDelivering then
    self._anywhereType = self._anywhere_delivering
  elseif inShowDelivered then
    self._anywhereType = self._anywhere_delivered
  else
    self._anywhereType = self._anywhere_none
  end
  if inShowDelivering then
  elseif inShowDelivered then
    self._animation:Play("uieffanim_UIN27LotteryMain_uiWidget_uiDelivered_in")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15RaffleSucc)
  end
end

function UIN27LotteryMain:SwitchUnlockPool(inShowPool)
  self._uiUnlockPool.gameObject:SetActive(inShowPool)
  self._btnAnywhere.gameObject:SetActive(inShowPool)
  if inShowPool then
    self._anywhereType = self._anywhere_unlockpool
  else
    self._anywhereType = self._anywhere_none
  end
  if inShowPool then
    self:ShowDialog("UIN27LotteryUnlockPool")
  else
    local uiStateManager = GameGlobal.UIStateManager()
    local uiController = uiStateManager:GetController("UIN27LotteryUnlockPool")
    if uiController ~= nil then
      uiController:CloseDialog()
    end
  end
end

function UIN27LotteryMain:DiffLanguage()
  local language = Localization.GetCurLanguage()
  if LanguageType.zh == language then
    self._usCombo.gameObject:SetActive(false)
    self._zhCombo.gameObject:SetActive(true)
  else
    self._usCombo.gameObject:SetActive(true)
    self._zhCombo.gameObject:SetActive(false)
  end
end

function UIN27LotteryMain:FlushStationState()
  local completed = 0
  for i = 1, self._stationCount do
    local current = self._stations[i]
    local state = 0
    local remain = 0
    local total = 0
    state, remain, total = self:GetStationState(i)
    completed = completed + total - remain
    current.state = state
    current.remain = remain
    current.total = total
    current.imgUnlocked.gameObject:SetActive(current.state == self._stationState_locked)
    current.imgDoing.gameObject:SetActive(current.state == self._stationState_doing)
    current.imgCompleted.gameObject:SetActive(current.state == self._stationState_completed)
  end
  self._plots.completed = completed
  local icon, count = self._lotteryComponent:GetLotteryCostItemIconText()
  self._itemCoinAmount = count
  self._txtCoinShadow:SetText(string.format("%.7d", self._itemCoinAmount))
  self._txtCoinBg:SetText(string.format("%.7d", self._itemCoinAmount))
  self._txtCoin:SetText(self._itemCoinAmount)
  self._iconCoin:LoadImage(icon)
  local lotteryCost = self._lotteryInfo.m_cost_count
  self._uiSingle.iconCoin:LoadImage(icon)
  self._uiSingle.txtCostShadow:SetText(lotteryCost)
  self._uiSingle.txtCost:SetText(lotteryCost)
  self._uiSingle.txtCostLack:SetText(lotteryCost)
  self._uiSingle.txtCostLack.gameObject:SetActive(count < lotteryCost)
  local lotteryCost = self._lotteryInfo.m_cost_count * self._lotteryInfo.m_multi_lottery
  self._uiMultiple.iconCoin:LoadImage(icon)
  self._uiMultiple.txtCostShadow:SetText(lotteryCost)
  self._uiMultiple.txtCost:SetText(lotteryCost)
  self._uiMultiple.txtCostLack:SetText(lotteryCost)
  self._uiMultiple.txtCostLack.gameObject:SetActive(count < lotteryCost)
end

function UIN27LotteryMain:PlotReadClearDB()
  local dbKey = "UIN27LotteryMain.dbPlot"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. dbKey
  LocalDB.SetString(key, "")
end

function UIN27LotteryMain:PlotReadLoadDB()
  local dbKey = "UIN27LotteryMain.dbPlot"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. dbKey
  local content = LocalDB.GetString(key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  local plotRead = {}
  for k, v in pairs(dbData) do
    plotRead[v] = v
  end
  return plotRead
end

function UIN27LotteryMain:PlotReadSaveDB(plots)
  local dbKey = "UIN27LotteryMain.dbPlot"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. dbKey
  local content = ""
  for i = 1, plots.count do
    local v = plots[i]
    if v.state == UIN27LotteryPlotState.read then
      content = content .. string.format("%d, ", v.cfg.ID)
    end
  end
  LocalDB.SetString(key, content)
end

function UIN27LotteryMain:FlushPlotState(readPlotDB)
  local completed = self._plots.completed
  if readPlotDB then
    local plotRead = self:PlotReadLoadDB()
    for i = 1, self._plots.count do
      local v = self._plots[i]
      if plotRead[v.cfg.ID] ~= nil then
        v.state = UIN27LotteryPlotState.read
      elseif completed >= v.cfg.PlotLevel then
        v.state = UIN27LotteryPlotState.new
      end
    end
  end
  local newState = false
  for i = 1, self._plots.count do
    local v = self._plots[i]
    if completed >= v.cfg.PlotLevel then
      self._plots.curPlot = v
    end
    if v.state == UIN27LotteryPlotState.new then
      newState = true
    end
  end
  self._newWorkBook.gameObject:SetActive(newState)
end

function UIN27LotteryMain:TurnPage(stationID)
  stationID = math.max(stationID, 1)
  stationID = math.min(stationID, self._stationCount)
  local preStationID = self._stationID
  self._stationID = stationID
  self:FlushCurrentPage()
  self:FlushCurrentPageAward()
  self:FlushCurrentPageAwardReview()
  self:PlayIdleSpine()
  local pre = self._stations[preStationID]
  local cur = self._stations[self._stationID]
  if cur.state == self._stationState_locked then
    self._rootSpeed.gameObject:SetActive(false)
    self._spineQiche.gameObject:SetActive(false)
    self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_5", true)
  end
  local lockName = "UIN27LotteryMain:TurnPageAnimation_uiPageLocked"
  if pre.state ~= self._stationState_locked and cur.state == self._stationState_locked then
    self._uiPageLocked.gameObject:SetActive(true)
    self._uiSingle.button.gameObject:SetActive(true)
    self._uiMultiple.button.gameObject:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._anCMAnimation:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnCM_uiPageLocked_in")
      YIELD(TT, 367)
      self._uiPageLocked.gameObject:SetActive(true)
      self._uiSingle.button.gameObject:SetActive(false)
      self._uiMultiple.button.gameObject:SetActive(false)
      self:UnLock(lockName)
    end)
  elseif pre.state == self._stationState_locked and cur.state ~= self._stationState_locked then
    self._uiPageLocked.gameObject:SetActive(true)
    self._uiSingle.button.gameObject:SetActive(true)
    self._uiMultiple.button.gameObject:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._anCMAnimation:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnCM_uiPageLocked_out")
      YIELD(TT, 367)
      self._uiPageLocked.gameObject:SetActive(false)
      self._uiSingle.button.gameObject:SetActive(true)
      self._uiMultiple.button.gameObject:SetActive(true)
      self:UnLock(lockName)
    end)
  end
  local lockName = "UIN27LotteryMain:TurnPageAnimation_uiPoolEmpty"
  if pre.remain ~= 0 and cur.remain == 0 then
    self._uiPoolEmpty.gameObject:SetActive(false)
    self._uiSingle.button.gameObject:SetActive(true)
    self._uiMultiple.button.gameObject:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(lockName)
      YIELD(TT, 250)
      self._uiPoolEmpty.gameObject:SetActive(true)
      self._anCMAnimation:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnCM_uiPoolEmpty_in")
      YIELD(TT, 167)
      self._uiSingle.button.gameObject:SetActive(false)
      self._uiMultiple.button.gameObject:SetActive(false)
      self:UnLock(lockName)
    end)
  elseif pre.remain == 0 and cur.remain ~= 0 then
    self._uiSingle.button.gameObject:SetActive(true)
    self._uiMultiple.button.gameObject:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._anCMAnimation:Play("uieffanim_UIN27LotteryMain_uiWidget2_AnCM_uiPoolEmpty_out")
      YIELD(TT, 167)
      self._uiSingle.button.gameObject:SetActive(true)
      self._uiMultiple.button.gameObject:SetActive(true)
      self:UnLock(lockName)
    end)
  end
end

function UIN27LotteryMain:TurnPagePlayerHead(stationID)
  stationID = math.max(stationID, 1)
  stationID = math.min(stationID, self._stationCount)
  local current = self._stations[stationID]
  self._stations.playerHead.localPosition = current.root.transform.localPosition
  self._stations.imgHeadRt.anchoredPosition = Vector2(0, 12)
  self._stations.playerHeadAnim:Stop()
end

function UIN27LotteryMain:FlushCurrentPage()
  local current = self._stations[self._stationID]
  local isShowLeft = self._stationID > 1
  local isShowRight = self._stationID < self._stationCount
  self._btnPageLeft.gameObject:SetActive(isShowLeft)
  self._btnReviewPageLeft.gameObject:SetActive(isShowLeft)
  self._btnPageRight.gameObject:SetActive(isShowRight)
  self._btnReviewPageRight.gameObject:SetActive(isShowRight)
  self._txtStationName:SetText(StringTable.Get(current.cfg.StationName))
  self._txtWaypointName:SetText(StringTable.Get(current.cfg.Name))
  self._txtRewardRemain:SetText(current.remain)
  self._txtRewardTotal:SetText(current.total)
  self._uiPoolEmpty.gameObject:SetActive(current.remain == 0)
  if current.state == self._stationState_locked then
    self._txtWaypointName:SetText(StringTable.Get("str_n27_lottery_name_unknown"))
    self._uiPageLocked.gameObject:SetActive(true)
    self._uiSingle.button.interactable = false
    self._uiMultiple.button.interactable = false
  elseif current.state == self._stationState_doing then
    self._uiPageLocked.gameObject:SetActive(false)
    self._uiSingle.button.interactable = true
    self._uiMultiple.button.interactable = true
  elseif current.state == self._stationState_completed then
    self._uiPageLocked.gameObject:SetActive(false)
    self._uiSingle.button.interactable = true
    self._uiMultiple.button.interactable = true
  end
  if current.remain == 0 then
  elseif current.remain < self._lotteryInfo.m_multi_lottery then
    self._uiMultiple.button.interactable = false
  end
  if current.remain == 0 then
    self._uiSingle.button.gameObject:SetActive(false)
    self._uiMultiple.button.gameObject:SetActive(false)
  elseif current.state == self._stationState_locked then
    self._uiSingle.button.gameObject:SetActive(false)
    self._uiMultiple.button.gameObject:SetActive(false)
  else
    self._uiSingle.button.gameObject:SetActive(true)
    self._uiMultiple.button.gameObject:SetActive(true)
  end
end

function UIN27LotteryMain:FlushCurrentPageAward()
  self._awardDataPool = {}
  local jackpot = self._lotteryInfo.m_jackpots[self._stationID]
  if jackpot ~= nil then
    for k, v in pairs(jackpot) do
      table.insert(self._awardDataPool, v)
    end
  end
  table.sort(self._awardDataPool, function(a, b)
    if a.m_lottery_count > 0 and b.m_lottery_count == 0 then
      return true
    elseif a.m_lottery_count == 0 and b.m_lottery_count > 0 then
      return false
    end
    if a.m_is_big_reward and not b.m_is_big_reward then
      return true
    elseif not a.m_is_big_reward and b.m_is_big_reward then
      return false
    end
    return a.m_award_id < b.m_award_id
  end)
  local dataCount = #self._awardDataPool
  self._awardPool = self._awardContent:SpawnObjects("UIN27LotteryAward", dataCount)
  for k, v in pairs(self._awardDataPool) do
    local ui = self._awardPool[k]
    ui:Flush(self, v)
  end
  self._awardScrollView.horizontalNormalizedPosition = 0
  UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._awardScrollView.content.transform)
end

function UIN27LotteryMain:FlushCurrentPageAwardReview()
  if not self._reviewRoot.gameObject.activeSelf then
    return
  end
  local dataCount = #self._awardDataPool
  self._awardReviewPool = self._reviewContent:SpawnObjects("UIN27LotteryAward", dataCount)
  for k, v in pairs(self._awardDataPool) do
    local ui = self._awardReviewPool[k]
    ui:Flush(self, v)
  end
  self._reviewScrollView.verticalNormalizedPosition = 1
  UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._reviewScrollView.content.transform)
end

function UIN27LotteryMain:PlayIdleSpine()
  self._rootSpeed.gameObject:SetActive(true)
  self._spineQiche.gameObject:SetActive(true)
  self._spineRen.gameObject:SetActive(false)
  local cur = self._stations[self._stationID]
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_3", true)
  self:PlaySpine(self._spineQiche, 0, "idle", true)
  self:PlaySpeedAnimation(self._speedState_51)
end

function UIN27LotteryMain:GetStationState(stationID)
  local jackpot = self._lotteryInfo.m_jackpots[stationID]
  if jackpot == nil then
    return self._stationState_locked, 0, 0
  end
  local remain = 0
  local total = 0
  local bigCount = 0
  for k, v in pairs(jackpot) do
    remain = remain + v.m_lottery_count
    total = total + v.m_lottery_limit_count
    if 0 < v.m_lottery_count and v.m_is_big_reward then
      bigCount = bigCount + 1
    end
  end
  local unlockID = self._lotteryInfo.m_unlock_jackpots[stationID]
  if unlockID == nil then
    return self._stationState_locked, remain, total
  end
  if bigCount == 0 then
    return self._stationState_completed, remain, total
  else
    return self._stationState_doing, remain, total
  end
  return self._stationState_doing, remain, total
end

function UIN27LotteryMain:BtnAnywhereOnClick(go)
  if self._anywhereType == self._anywhere_uiShow then
    self:EnterFullScreenBg(false)
  elseif self._anywhereType == self._anywhere_coinTips then
    self:SwitchCoinTips(false, true)
  elseif self._anywhereType == self._anywhere_luckDraw then
    self:SwitchLuckDraw(false, nil, true)
    self:ClosePerformance()
    self:PlayIdleSpine()
    self:PopupLuckDrawReward()
  elseif self._anywhereType == self._anywhere_delivering then
    self:SwitchDelivery(false, false)
    self:PopupDeliveryStory()
  elseif self._anywhereType == self._anywhere_delivered then
    self:SwitchDelivery(false, false)
    self:PopupDeliveryStory()
  elseif self._anywhereType == self._anywhere_unlockpool then
    self:SwitchUnlockPool(false)
    self:EntryPerformance()
    local unlockCount = #self._lotteryInfo.m_unlock_jackpots
    local unlockID = self._lotteryInfo.m_unlock_jackpots[unlockCount]
    self:StartTask(self.TurnPageAnimationTask, self, unlockID)
  end
end

function UIN27LotteryMain:BtnRewardReviewOnClick(go)
  self._reviewRoot.gameObject:SetActive(true)
  self:FlushCurrentPageAwardReview()
  for k, v in pairs(self._awardDataPool) do
    local ui = self._awardReviewPool[k]
    ui:SetActive(false)
  end
  local lockName = "UIN27LotteryMain:BtnRewardReviewOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._reviewRootAnim:Play("uieffanim_UIN27LotteryMain_uiWidget_uiRewardReview_in")
    YIELD(TT, 200)
    self:PageAwardReviewPlayIn()
    self:UnLock(lockName)
  end)
end

function UIN27LotteryMain:BtnWorkBookOnClick(go)
  self._plots.manualBrowse = true
  self:ShowDialog("UIN27LotteryPlot", self._plots, function()
    self:PlotReadSaveDB(self._plots)
    self:FlushPlotState(false)
  end)
end

function UIN27LotteryMain:BtnWorkBookOnClick_TestCase(go)
  if false then
    self:PlotReadClearDB()
    return
  end
  for i = 1, self._plots.count do
    local v = self._plots[i]
    v.state = UIN27LotteryPlotState.new
  end
  self._plots.manualBrowse = true
  self:ShowDialog("UIN27LotteryPlot", self._plots, function()
    self:PlotReadSaveDB(self._plots)
    self:FlushPlotState(false)
  end)
end

function UIN27LotteryMain:BtnCoinTipsOnClick(go)
  self:SwitchCoinTips(true, true)
end

function UIN27LotteryMain:BtnPageLeftOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._stationID - 1)
end

function UIN27LotteryMain:BtnPageRightOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._stationID + 1)
end

function UIN27LotteryMain:BtnReviewPageLeftOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._stationID - 1)
end

function UIN27LotteryMain:BtnReviewPageRightOnClick(go)
  self:StartTask(self.TurnPageAnimationTask, self, self._stationID + 1)
end

function UIN27LotteryMain:TurnPageAnimationTask(TT, stationID)
  local clipStationID = stationID
  clipStationID = math.max(clipStationID, 1)
  clipStationID = math.min(clipStationID, self._stationCount)
  if clipStationID == self._stationID then
    return
  end
  self:Lock("UIN27LotteryMain:TurnPageAnimation")
  local playerHeadAnim = ""
  if stationID > self._stationID then
    playerHeadAnim = "uieffanim_UIN27LotteryMain_playerHead_Position_R"
  else
    playerHeadAnim = "uieffanim_UIN27LotteryMain_playerHead_Position_L"
  end
  self._stations.playerHeadAnim:Play(playerHeadAnim)
  self._animation:Play("uieffanim_UIN27LotteryMain_middle")
  local awardOutFinish = 0
  local pageAwardPlayOutLength = 133
  self:PageAwardPlayOut(function()
    awardOutFinish = awardOutFinish + 1
  end)
  self:PageAwardReviewPlayOut(function()
    awardOutFinish = awardOutFinish + 1
  end)
  while awardOutFinish ~= 2 do
    YIELD(TT)
  end
  self:TurnPage(stationID)
  self:PageAwardPlayIn()
  self:PageAwardReviewPlayIn()
  YIELD(TT, 666 - pageAwardPlayOutLength)
  self:TurnPagePlayerHead(stationID)
  self:UnLock("UIN27LotteryMain:TurnPageAnimation")
end

function UIN27LotteryMain:BtnReviewCloseOnClick(go)
  local lockName = "UIN27LotteryMain:BtnReviewCloseOnClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._reviewRootAnim:Play("uieffanim_UIN27LotteryMain_uiWidget_uiRewardReview_out")
    YIELD(TT, 200)
    self._reviewRoot.gameObject:SetActive(false)
    self:UnLock(lockName)
  end)
  self:PageAwardReviewPlayOut()
end

function UIN27LotteryMain:BtnLotterySingleOnClick(go)
  self:StartTask(self.LuckDrawTask, self, ECampaignLotteryType.E_CLT_SINGLE)
end

function UIN27LotteryMain:BtnLotteryMultipleOnClick(go)
  self:StartTask(self.LuckDrawTask, self, ECampaignLotteryType.E_CLT_MULTI)
end

function UIN27LotteryMain:LuckDrawTask(TT, lotteryType)
  local current = self._stations[self._stationID]
  if current.state == self._stationState_locked then
    return
  elseif current.state == self._stationState_completed and current.remain == 0 then
    return
  elseif self._lottery.lockPerformance then
    return
  end
  local lotteryTimes = 0
  local lotteryCost = self._lotteryInfo.m_cost_count
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    lotteryTimes = 1
    lotteryCost = self._lotteryInfo.m_cost_count
  elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    lotteryTimes = self._lotteryInfo.m_multi_lottery
    lotteryCost = self._lotteryInfo.m_cost_count * self._lotteryInfo.m_multi_lottery
  end
  self:Lock("UIN27LotteryMain:LuckDraw")
  if lotteryTimes > current.remain then
    local msgLack = StringTable.Get("str_n27_lottery_reward_not_enough", lotteryTimes)
    ToastManager.ShowToast(msgLack)
    YIELD(TT, 1500)
  elseif lotteryCost > self._itemCoinAmount then
    local item_id = self._lotteryInfo.m_cost_item_id
    local itemConfig = Cfg.cfg_item[item_id]
    local msgLack
    if itemConfig ~= nil then
      local itemName = StringTable.Get(itemConfig.Name)
      msgLack = StringTable.Get("str_n27_lottery_coin_not_enough", itemName)
    else
      msgLack = string.format("缺少物品配置 cfg_item.id = %d", item_id)
    end
    ToastManager.ShowToast(msgLack)
    YIELD(TT, 1500)
  else
    local lotteryAward, openNewPool
    local res = AsyncRequestRes:New()
    lotteryAward, openNewPool = self._lotteryComponent:HandleLottery(TT, res, self._stationID, lotteryType)
    if res:GetSucc() then
      local savedPlot = self._plots.curPlot
      self:FlushStationState()
      self:FlushPlotState(true)
      self:FlushCurrentPage()
      self:FlushCurrentPageAward()
      self:FlushCurrentPageAwardReview()
      self._lottery.lockPerformance = true
      self._lottery.lotteryType = lotteryType
      self._lottery.lotteryAward = lotteryAward
      self._lottery.openNewPlot = self._plots.curPlot ~= savedPlot
      self._lottery.openNewPool = openNewPool
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
      end, function()
      end)
    end
  end
  self:UnLock("UIN27LotteryMain:LuckDraw")
  self:EntryPerformance()
end

function UIN27LotteryMain:LuckDrawTask_TestCase(TT, lotteryType)
  local current = self._stations[self._stationID]
  if current.state == self._stationState_locked then
    return
  elseif current.state == self._stationState_completed and current.remain == 0 then
    return
  end
  local award1 = LotteryAward:New()
  award1.m_item_id = 3410202
  award1.m_count = 10
  local award2 = LotteryAward:New()
  award2.m_item_id = 3410202
  award2.m_count = 100
  self:Lock("UIN27LotteryMain:LuckDraw")
  self:FlushStationState()
  self._plots.completed = 110
  self:FlushPlotState(true)
  self._lottery.lockPerformance = true
  self._lottery.lotteryType = lotteryType
  self._lottery.lotteryAward = {award1, award2}
  self._lottery.openNewPlot = true
  self._lottery.openNewPool = true
  self._plots.curPlot = self._plots[1]
  self:UnLock("UIN27LotteryMain:LuckDraw")
  self:EntryPerformance()
end

function UIN27LotteryMain:ShowAwardTips(dataItem, clickPosition)
  local deltaPosition = clickPosition - self._uiWidget1.position
  self:ShowDialog("UIN27LotteryTips", dataItem, deltaPosition)
end

function UIN27LotteryMain:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN27LotteryMain:PopupLuckDrawReward()
  local assetAwards = {}
  for k, v in pairs(self._lottery.lotteryAward) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = v.m_item_id
    roleAsset.count = v.m_count
    table.insert(assetAwards, roleAsset)
  end
  self:ShowDialog("UIN27LotteryGetItem", assetAwards, function()
    self:EntryPerformance()
  end)
end

function UIN27LotteryMain:PopupDeliveryStory()
  local current = self._plots.curPlot
  self:ShowDialog("UIStoryController", current.cfg.PlotID, function()
    self._plots.manualBrowse = false
    self:ShowDialog("UIN27LotteryPlot", self._plots, function()
      self:PlotReadSaveDB(self._plots)
      self:FlushPlotState(false)
      self:EntryPerformance()
    end)
  end)
end

function UIN27LotteryMain:EntryPerformance()
  if self._lottery.lotteryType ~= nil then
    self:DrawPerformance()
  elseif self._lottery.openNewPlot then
    self:PlotPerformance()
  elseif self._lottery.openNewPool then
    self:StationPerformance()
  else
    self._lottery.lockPerformance = false
    self:SwitchLuckDraw(false)
    self:PlayIdleSpine()
  end
end

function UIN27LotteryMain:ClosePerformance()
  if self._lottery.idPerformanceTask ~= nil then
    local task = GameGlobal.TaskManager():FindTask(self._lottery.idPerformanceTask)
    if task ~= nil and task.state ~= TaskState.Stop then
      GameGlobal.TaskManager():KillTask(self._lottery.idPerformanceTask)
    end
  end
  self._lottery.idPerformanceTask = nil
end

function UIN27LotteryMain:DrawPerformance()
  local lotteryType = self._lottery.lotteryType
  self._lottery.lotteryType = nil
  if lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    self._lottery.idPerformanceTask = self:StartTask(self.DrawPerformanceTask1, self)
  elseif lotteryType == ECampaignLotteryType.E_CLT_MULTI then
    self._lottery.idPerformanceTask = self:StartTask(self.DrawPerformanceTask10, self)
  end
end

function UIN27LotteryMain:PlotPerformance()
  self._lottery.openNewPlot = false
  self._lottery.idPerformanceTask = self:StartTask(self.PlotPerformanceTask, self)
end

function UIN27LotteryMain:StationPerformance()
  self._lottery.openNewPool = false
  self._lottery.idPerformanceTask = self:StartTask(self.StationPerformanceTask, self)
end

function UIN27LotteryMain:DrawPerformanceTask1(TT)
  local cur = self._stations[self._stationID]
  self:SwitchLuckDraw(true, ECampaignLotteryType.E_CLT_SINGLE)
  self:PlaySpeedAnimation(self._speedState_134)
  self:PlaySpine(self._spineQiche, 0, "jiasu", true)
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_2", true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotterySpeedUp)
  YIELD(TT, 800)
  self:PlaySpine(self._spineQiche, 0, "danchou", true)
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_2", true)
  YIELD(TT, 800)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotteryMonster)
  YIELD(TT, 1667)
  self:PlayIdleSpine()
  self:SwitchLuckDraw(false, nil, true)
  self:PopupLuckDrawReward()
end

function UIN27LotteryMain:DrawPerformanceTask10(TT)
  local cur = self._stations[self._stationID]
  self:SwitchLuckDraw(true, ECampaignLotteryType.E_CLT_MULTI)
  self:PlaySpeedAnimation(self._speedState_134)
  self:PlaySpine(self._spineQiche, 0, "jiasu", true)
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_1", true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotterySpeedUp)
  YIELD(TT, 800)
  self:PlaySpine(self._spineQiche, 0, "lianchou", true)
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_1", true)
  YIELD(TT, 600)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotteryMonster)
  YIELD(TT, 300)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotteryMonster)
  YIELD(TT, 800)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N27LotteryMonster)
  YIELD(TT, 1500)
  self:PlayIdleSpine()
  self:SwitchLuckDraw(false, nil, true)
  self:PopupLuckDrawReward()
end

function UIN27LotteryMain:PlotPerformanceTask(TT)
  local cur = self._stations[self._stationID]
  self:Lock("UIN27LotteryMain:PlotPerformance")
  self:PlaySpeedAnimation(self._speedState_stop)
  self._spineRen.gameObject:SetActive(true)
  self:PlaySpine(self._spineQiche, 0, "tingche", true)
  self:PlaySpine(self._spineBeijing, 0, cur.cfg.SpinePrefix .. "_5", true)
  self:PlaySpine(self._spineRen, 0, self._plots.curPlot.cfg.SpineIdle, true)
  YIELD(TT, 800)
  self:SwitchDelivery(true, false)
  local imgEmote = self:GetChildComponent(self._uiDelivering, "Image", "imgEmote")
  imgEmote.gameObject:SetActive(false)
  self:PlaySpine(self._spineQiche, 0, self._plots.curPlot.cfg.SpineSongli, false)
  self:PlaySpine(self._spineRen, 0, self._plots.curPlot.cfg.SpineShouli, false)
  YIELD(TT, 2167)
  imgEmote.gameObject:SetActive(false)
  self:PlaySpine(self._spineQiche, 0, "idle", true)
  self:PlaySpine(self._spineRen, 0, self._plots.curPlot.cfg.SpineIdle, true)
  self:SwitchDelivery(false, true)
  YIELD(TT, 3000)
  self:PlayIdleSpine()
  self._txtPostTips.gameObject:SetActive(true)
  self:UnLock("UIN27LotteryMain:PlotPerformance")
  self:SwitchDelivery(false, false)
  self:PopupDeliveryStory()
end

function UIN27LotteryMain:StationPerformanceTask(TT)
  self:Lock("UIN27LotteryMain:StationPerformance")
  self:SwitchUnlockPool(true)
  local uiController
  local uiStateManager = GameGlobal.UIStateManager()
  while uiController == nil do
    uiController = uiStateManager:GetController("UIN27LotteryUnlockPool")
    YIELD(TT)
  end
  self:UnLock("UIN27LotteryMain:StationPerformance")
end

function UIN27LotteryMain:OverlapSwitchState(uiStateType, overlapDuration, ...)
  local uiStateManager = GameGlobal.UIStateManager()
  uiStateManager:SwitchState(uiStateType, ...)
  local curState = uiStateManager.curState
  uiStateManager.curState = nil
  local lockName = "UIStateManager:OverlapSwitchState"
  GameGlobal.TaskManager():StartTask(function(TT)
    self:Lock(lockName)
    local deleteUIList = FastArray:New()
    if curState ~= nil then
      local temp_deleteUIList = FastArray:New()
      curState:GetCloseUIList(curState, nil, temp_deleteUIList)
      local count = temp_deleteUIList:Size()
      for i = 1, temp_deleteUIList:Size() do
        local name = temp_deleteUIList:GetAt(count - i + 1)
        deleteUIList:PushBack(name)
      end
    end
    YIELD(TT, overlapDuration)
    if curState ~= nil then
      local subTaskList = {}
      for i = 1, deleteUIList:Size() do
        local name = deleteUIList:GetAt(i)
        subTaskList[#subTaskList + 1] = GameGlobal.TaskManager():StartTask(UIControllerManager.BeforeHideUI, curState.uiControllerManager, name)
      end
      for i = 1, #subTaskList do
        JOIN(TT, subTaskList[i])
      end
      for i = 1, deleteUIList:Size() do
        local name = deleteUIList:GetAt(i)
        curState.uiControllerManager:HideUI(name)
      end
      for i = 1, deleteUIList:Size() do
        local name = deleteUIList:GetAt(i)
        curState.uiControllerManager:AfterHideUI(name)
      end
      curState:Dispose()
    end
    self:UnLock(lockName)
  end)
end
