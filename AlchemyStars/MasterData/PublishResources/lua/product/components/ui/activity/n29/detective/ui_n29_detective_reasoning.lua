_class("UIN29DetectiveReasoning", UIController)
UIN29DetectiveReasoning = UIN29DetectiveReasoning

function UIN29DetectiveReasoning:Constructor()
end

function UIN29DetectiveReasoning:LoadDataOnEnter(TT, res, uiParams)
  self._localDb = UIN29DetectiveLocalDb:New()
  self._idStage = uiParams[1]
  local allStage = self._localDb:GetAllStage()
  self._cfgStage = allStage[self._idStage]
  self._idEndStage = 0
  self._idNextStage = 0
  for k, v in pairs(allStage) do
    if self._idEndStage == self._idStage then
      self._idNextStage = k
    end
    self._idEndStage = k
  end
  self._idProgress = 0
  self._options = {checkCount = 0, needCount = 0}
end

function UIN29DetectiveReasoning:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._plotMask = self:GetUIComponent("RectTransform", "plotMask")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._uiProgress = self:GetUIComponent("UISelectObjectPath", "uiProgress")
  self._uiQuestion = self:GetUIComponent("RectTransform", "uiQuestion")
  self._txtQuestion = self:GetUIComponent("UILocalizationText", "txtQuestion")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._uiOptions = self:GetUIComponent("RectTransform", "uiOptions")
  self._btnMerge = self:GetUIComponent("RectTransform", "btnMerge")
  self._uiSuccess = self:GetUIComponent("RectTransform", "uiSuccess")
  self._uiFailed = self:GetUIComponent("RectTransform", "uiFailed")
  self._uiSpine = self:GetUIComponent("SpineLoader", "uiSpine")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._uiSuccess.gameObject:SetActive(false)
  self._uiFailed.gameObject:SetActive(false)
  self._plotMask.gameObject:SetActive(false)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:EnterFullScreenBg(false)
  self:InitCommonTopButton()
  self:CreateProgress()
  self:CreateOptions()
  self:UpdateProgress()
  self:UpdateQuestion()
  self:CheckAutoSaved()
  self:CheckGuide()
  self:PlaySpine(self._uiSpine, 0, "Story_norm", true)
  self:InAnimation()
end

function UIN29DetectiveReasoning:OnHide()
  self:KillTask(self._idTaskInAnimation)
  self:KillTask(self._idTaskFragmentMerge)
end

function UIN29DetectiveReasoning:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN29DetectiveReasoning:BtnClueOnClick(go)
  local detectiveComponent = self._localDb:DetectiveComponent()
  local componentInfo = detectiveComponent:GetComponentInfo()
  self:ShowDialog("UIActivityN29DetectiveBagController", true, componentInfo.cur_info, true)
end

function UIN29DetectiveReasoning:BtnMergeOnClick(go)
  if self._options.checkCount ~= self._options.needCount then
    return
  end
  local allReasoning = Cfg.cfg_n29_detective_reasoning({})
  local data = self._progressPool[self._idProgress]
  local cfgReasoning = allReasoning[data.id]
  local lookup = {}
  for k, v in pairs(cfgReasoning.ClueTrueOptions) do
    lookup[v] = v
  end
  local trueCount = 0
  for k, v in pairs(self._uiOptionsPool) do
    local id = cfgReasoning.ClueOptions[k]
    if v:IsCheck() and lookup[id] ~= nil then
      trueCount = trueCount + 1
    end
  end
  self:KillTask(self._idTaskFragmentMerge)
  self._idTaskFragmentMerge = self:StartTask(self.FragmentMergeTask, self, trueCount == self._options.checkCount)
end

function UIN29DetectiveReasoning:TglClueOnClick(id, go)
  self:UpdateCheckCount()
  if self._options.checkCount > self._options.needCount then
    local option = self._uiOptionsPool[id]
    option:SetCheck(false)
  end
  self:UpdateQuestion()
end

function UIN29DetectiveReasoning:BtnClueDetailsOnClick(uiOption, go)
  local allReasoning = Cfg.cfg_n29_detective_reasoning({})
  local data = self._progressPool[self._idProgress]
  local cfgReasoning = allReasoning[data.id]
  local idClue = cfgReasoning.ClueOptions[uiOption:ID()]
  self:ShowDialog("UIN29DetectiveReasoningClueDetails", idClue, uiOption:IsCheck())
end

function UIN29DetectiveReasoning:OnActivityCloseEvent(id)
  local campaignModule = self:GetModule(CampaignModule)
  local idCampaign = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N29)
  if idCampaign == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN29DetectiveReasoning:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIN29DetectiveReasoning:PlaySpine(curSpine, trackIndex, animName, loop)
  local skeleton
  if curSpine ~= nil then
    skeleton = curSpine.CurrentSkeleton or curSpine.CurrentMultiSkeleton
  end
  if skeleton ~= nil then
    skeleton.AnimationState:SetAnimation(trackIndex, animName, loop)
  end
end

function UIN29DetectiveReasoning:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIN29DetectiveReasoning:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIN29DetectiveLogin)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, true, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN29DetectiveReasoning:CreateProgress()
  self._progressPool = {}
  self._uiProgressPool = {}
  if self._cfgStage.ReasoningRule == nil then
    return
  end
  for k, v in pairs(self._cfgStage.ReasoningRule) do
    local element = {
      structName = "UIN29DetectiveReasoning::RuleElement",
      id = v,
      finish = false
    }
    table.insert(self._progressPool, element)
  end
  local count = #self._progressPool
  self._uiProgressPool = self._uiProgress:SpawnObjects("UIN29DetectiveReasoningProgress", count)
  self._idProgress = 1
end

function UIN29DetectiveReasoning:CreateOptions()
  local countOptions = 4
  self._uiOptionsPool = {}
  for i = 1, countOptions do
    local engine = self:GetChildComponent(self._uiOptions, "UISelectObjectPath", i)
    local parent = UICustomWidgetPool:New(self, engine)
    local option = parent:SpawnObject("UIN29DetectiveReasoningOption")
    option:SetID(i)
    option:SetCheck(false)
    table.insert(self._uiOptionsPool, option)
  end
end

function UIN29DetectiveReasoning:UpdateProgress()
  for k, v in pairs(self._progressPool) do
    local ui = self._uiProgressPool[k]
    ui:Flush(v.finish)
  end
end

function UIN29DetectiveReasoning:UpdateQuestion()
  if self._idProgress == 0 then
    return
  end
  local allReasoning = Cfg.cfg_n29_detective_reasoning({})
  local allItem = Cfg.cfg_component_detective_item({})
  local data = self._progressPool[self._idProgress]
  local cfgReasoning = allReasoning[data.id]
  if cfgReasoning == nil or cfgReasoning.ClueOptions == nil or cfgReasoning.ClueTrueOptions == nil then
    Log.error("cfg_n29_detective_reasoning 缺少配置! id --> ", data.id)
    return
  end
  local checkCount = 0
  local needCount = #cfgReasoning.ClueTrueOptions
  local uiCount = #self._uiOptionsPool
  local dataCount = #cfgReasoning.ClueOptions
  for i = 1, dataCount do
    local id = cfgReasoning.ClueOptions[i]
    local cfg = allItem[id]
    local ui = self._uiOptionsPool[i]
    ui:SetTitle(StringTable.Get(cfg.QuizName))
    ui:View().gameObject:SetActive(true)
    if ui:IsCheck() then
      checkCount = checkCount + 1
    end
  end
  for i = dataCount + 1, uiCount do
    local ui = self._uiOptionsPool[i]
    ui:SetCheck(false)
    ui:View().gameObject:SetActive(false)
  end
  local stringCount = string.format("%d/%d", checkCount, needCount)
  self._txtQuestion:SetText(StringTable.Get(cfgReasoning.Question))
  self._txtCount:SetText(StringTable.Get("str_n29_detective_reasoning_count", stringCount))
  self._btnMerge.gameObject:SetActive(needCount <= checkCount)
  self._options.checkCount = checkCount
  self._options.needCount = needCount
  for k, v in pairs(self._uiOptionsPool) do
    if not v:IsCheck() then
      v:SetInteractable(self._options.checkCount < self._options.needCount)
    end
  end
end

function UIN29DetectiveReasoning:UpdateCheckCount()
  local allReasoning = Cfg.cfg_n29_detective_reasoning({})
  local data = self._progressPool[self._idProgress]
  local cfgReasoning = allReasoning[data.id]
  local checkCount = 0
  local needCount = #cfgReasoning.ClueTrueOptions
  for k, v in pairs(self._uiOptionsPool) do
    if v:IsCheck() then
      checkCount = checkCount + 1
    end
  end
  self._options.checkCount = checkCount
  self._options.needCount = needCount
  for k, v in pairs(self._uiOptionsPool) do
    if not v:IsCheck() then
      v:SetInteractable(self._options.checkCount < self._options.needCount)
    end
  end
end

function UIN29DetectiveReasoning:CheckAutoSaved()
  if self._idStage == self._idEndStage then
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      res:SetSucc(true)
      local detectiveComponent = self._localDb:DetectiveComponent()
      detectiveComponent:HandleAutoSave(TT, res)
    end)
  end
end

function UIN29DetectiveReasoning:FragmentMergeTask(TT, result)
  local lockName = "UIN29DetectiveReasoning:FragmentMergeTask"
  self:Lock(lockName)
  local spineAnim, popupResult, animName
  if result then
    spineAnim = "Story_serious"
    popupResult = self._uiSuccess
    animName = "uieff_UIN29DetectiveReasoning_success"
  else
    spineAnim = "Story_doubt"
    popupResult = self._uiFailed
    animName = "uieff_UIN29DetectiveReasoning_failed"
  end
  self:PlaySpine(self._uiSpine, 0, spineAnim, true)
  popupResult.gameObject:SetActive(true)
  self._animation:Play(animName)
  YIELD(TT, 4000)
  if result then
    local ui = self._uiProgressPool[self._idProgress]
    ui:PlaySwitch(TT)
    YIELD(TT, 333)
  else
    YIELD(TT, 500)
  end
  local startAfterPlot = false
  if result then
    local element = self._progressPool[self._idProgress]
    element.finish = true
    self._idProgress = self._idProgress + 1
    if self._idProgress > #self._progressPool then
      startAfterPlot = true
      self._idProgress = self._idProgress - 1
    end
    for k, v in pairs(self._uiOptionsPool) do
      v:SetCheck(false)
    end
  end
  self:UpdateProgress()
  self:UpdateQuestion()
  self:UnLock(lockName)
  if startAfterPlot then
    self:Lock(lockName)
    local lstFragment = self._cfgStage.FragmentList
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    local detectiveComponent = self._localDb:DetectiveComponent()
    detectiveComponent:HandleSubmitItem(TT, res, self._idStage, {}, lstFragment, {})
    if not res:GetSucc() then
      Log.error("Editor --> 【N29侦探】提交推论碎片失败 ret = ", res:GetResult())
    end
    popupResult.gameObject:SetActive(false)
    local uiStateManager = GameGlobal.UIStateManager()
    local uiName = "UIN29DetectiveFragmentPopup"
    for k, v in pairs(lstFragment) do
      self:ShowDialog(uiName, v, lockName)
      while not uiStateManager:IsShow(uiName) do
        YIELD(TT)
      end
      while uiStateManager:IsShow(uiName) do
        YIELD(TT)
      end
      YIELD(TT, 500)
    end
    self._plotMask.gameObject:SetActive(true)
    local idPlot = self._cfgStage.AfterReasoningPlot
    local isEndPlot = self._idStage == self._idEndStage
    self._localDb:AfterReasoningPlot(idPlot, isEndPlot, function()
      self:SwitchState(UIStateType.UIActivityN29DetectiveMapController, self._idNextStage)
    end, function()
      self._localDb:PlayEndingPlot(true)
    end)
    self:UnLock(lockName)
  else
    self:Lock(lockName)
    self._uiSuccess.gameObject:SetActive(false)
    self._uiFailed.gameObject:SetActive(false)
    self:PlaySpine(self._uiSpine, 0, "Story_norm", true)
    self._animation:Play("uieff_UIN29DetectiveReasoning_Question_in")
    YIELD(TT, 367)
    self:UnLock(lockName)
    for k, v in pairs(self._uiOptionsPool) do
      v:PlaySwing()
      YIELD(TT, 350)
    end
  end
end

function UIN29DetectiveReasoning:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN29DetectiveReasoning)
end

function UIN29DetectiveReasoning:GetOptionGo(index)
  if not self._uiOptionsPool then
    return
  end
  local option = self._uiOptionsPool[index]
  if option then
    return option:GetCheckBtnGo()
  end
end

function UIN29DetectiveReasoning:InAnimation()
  self:KillTask(self._idTaskInAnimation)
  local lockName = "UIN29DetectiveReasoning:InAnimation"
  self._idTaskInAnimation = self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 333)
    self._animation:Play("uieff_UIN29DetectiveReasoning_Question_in")
    YIELD(TT, 367)
    self:UnLock(lockName)
    for k, v in pairs(self._uiOptionsPool) do
      v:PlaySwing()
      YIELD(TT, 350)
    end
  end)
end

function UIN29DetectiveReasoning:KillTask(taskId)
  local task = GameGlobal.TaskManager():FindTask(taskId)
  if task and task.state ~= TaskState.Stop then
    GameGlobal.TaskManager():KillTask(taskId)
  end
end

_class("UIN29DetectiveReasoningProgress", UICustomWidget)
UIN29DetectiveReasoningProgress = UIN29DetectiveReasoningProgress

function UIN29DetectiveReasoningProgress:OnShow(uiParams)
  self._uiConnect = self:GetUIComponent("RectTransform", "uiConnect")
  self._uiQuestion = self:GetUIComponent("RectTransform", "uiQuestion")
  self._uiResolved = self:GetUIComponent("RectTransform", "uiResolved")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN29DetectiveReasoningProgress:Flush(isResolved)
  self._uiQuestion.gameObject:SetActive(not isResolved)
  self._uiResolved.gameObject:SetActive(isResolved)
end

function UIN29DetectiveReasoningProgress:PlaySwitch(TT)
  self._uiQuestion.gameObject:SetActive(true)
  self._uiResolved.gameObject:SetActive(true)
  self._animation:Play("uieff_UIN29DetectiveReasoningProgress_switch")
  YIELD(TT, 167)
  self._uiQuestion.gameObject:SetActive(false)
end

_class("UIN29DetectiveReasoningOption", UICustomWidget)
UIN29DetectiveReasoningOption = UIN29DetectiveReasoningOption

function UIN29DetectiveReasoningOption:OnShow(uiParams)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._tglClue = self:GetUIComponent("Toggle", "tglClue")
  self._unselect = self:GetUIComponent("RectTransform", "unselect")
  self._select = self:GetUIComponent("RectTransform", "select")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._gtlClueGo = self:GetGameObject("tglClue")
  self._tglClueEvent = self._tglClue:GetComponent("UIEventTriggerListener")
  
  function self._tglClueEvent.onDoubleClick()
    self:TglClueOnDoubleClick(self._tglClue.gameObject)
  end
end

function UIN29DetectiveReasoningOption:OnHide()
  self._tglClueEvent.onDoubleClick = nil
end

function UIN29DetectiveReasoningOption:SetID(id)
  self._id = id
end

function UIN29DetectiveReasoningOption:SetTitle(name)
  self._txtName:SetText(name)
end

function UIN29DetectiveReasoningOption:SetCheck(isCheck)
  self._tglClue.isOn = isCheck
  self._unselect.gameObject:SetActive(not isCheck)
  self._select.gameObject:SetActive(isCheck)
  local state = self._animation:get_Item("uieff_UIN29DetectiveReasoningOption_swing")
  state.speed = self:IsCheck() and 0 or 1
end

function UIN29DetectiveReasoningOption:ID()
  return self._id
end

function UIN29DetectiveReasoningOption:IsCheck()
  return self._tglClue.isOn
end

function UIN29DetectiveReasoningOption:SetInteractable(enable)
  self._tglClue.interactable = enable
end

function UIN29DetectiveReasoningOption:TglClueOnClick(go)
  if self._tglClue.interactable then
    self._unselect.gameObject:SetActive(not self:IsCheck())
    self._select.gameObject:SetActive(self:IsCheck())
    self:RootUIOwner():TglClueOnClick(self._id, go)
    local state = self._animation:get_Item("uieff_UIN29DetectiveReasoningOption_swing")
    state.speed = self:IsCheck() and 0 or 1
  end
end

function UIN29DetectiveReasoningOption:TglClueOnDoubleClick(go)
  if self._tglClue.interactable then
    self._unselect.gameObject:SetActive(not self:IsCheck())
    self._select.gameObject:SetActive(self:IsCheck())
    self:RootUIOwner():TglClueOnClick(self._id, go)
    local state = self._animation:get_Item("uieff_UIN29DetectiveReasoningOption_swing")
    state.speed = self:IsCheck() and 0 or 1
  end
end

function UIN29DetectiveReasoningOption:BtnClueDetailsOnClick(go)
  self:RootUIOwner():BtnClueDetailsOnClick(self, go)
end

function UIN29DetectiveReasoningOption:GetCheckBtnGo()
  return self._gtlClueGo
end

function UIN29DetectiveReasoningOption:PlaySwing()
  self._animation:Play("uieff_UIN29DetectiveReasoningOption_swing")
end
