local GuideEvent = CommonDefine.GuideEvent
local GuideBattle = CommonDefine.GuideBattle
local GuideGameObjType = CommonDefine.GuideGameObjType
local GuideManager, Super = System.NewClass("GuideManager", Manager)

function GuideManager:ctor()
  Super.ctor(self)
  self.closeTriggerName = nil
  self.closeTriggerGear = nil
  self.focusTriggerGear = nil
  self.curGearRect = nil
  self.touchCloseDelay = 1
  self.touchCloseEnabled = nil
  self.touchDelayTimer = nil
  self.triggeredGuideList = {}
  self.battleTriggeredGuideList = {}
  self._isDisbled = Vue.ref(false)
  self.battleId = nil
  self.lockBattleEndTurn = false
  self._guideStoryId = nil
  self._lastGuideStoryId = nil
  self._eventName2FuncDict = {
    [GuideBattle.Bout] = System.fn(self, self._OnBattleEventBout),
    [GuideBattle.Begin] = System.fn(self, self._OnBattleEventBegin),
    [GuideBattle.GuideEndLock] = System.fn(self, self._OnBattleEventGuideEndLock),
    [GuideBattle.OnDeadResistRecord] = System.fn(self, self._OnBattleEventOnDeadResistRecord),
    [GuideBattle.GuideCondKeeperSkillEnergyFull] = System.fn(self, self._OnBattleEventCommonFunc),
    [GuideBattle.GuideCondBoutFirstCard] = System.fn(self, self._OnBattleEventCommonFunc),
    [GuideBattle.GuideCondAfterUseUltiSkill] = System.fn(self, self._OnBattleEventGuideCondAfterUseUltiSkill),
    [GuideBattle.GuideCondillustratePanelClose] = System.fn(self, self._OnBattleEventCommonFunc),
    [GuideBattle.GuideCondAvgEnd] = System.fn(self, self._OnBattleEventCommonFunc)
  }
  self._guideObj2FuncDict = {
    [GuideGameObjType.GuideCompOceanModeSwtichToDefence] = System.fn(self, self._ShowGuideCompOceanSwitchEntry),
    [GuideGameObjType.GuideCompOceanModeSwtichToFrantic] = System.fn(self, self._ShowGuideCompOceanSwitchEntry),
    [GuideGameObjType.GuideCompIntroduceEnemyIntention] = System.fn(self, self._ShowGuideCompIntroduceEnemyIntention),
    [GuideGameObjType.GuideCompBloodSchoolSkill] = System.fn(self, self._ShowGuideCompBloodSchoolSkill),
    [GuideGameObjType.GuideCompDimensionSchoolSkill] = System.fn(self, self._ShowGuideCompDimensionSchoolSkill),
    [GuideGameObjType.GuideCompAwakerUltiSkill_1] = System.fn(self, self._ShowGuideCompAwakerUltiSkill),
    [GuideGameObjType.GuideCompAwakerUltiSkill_2] = System.fn(self, self._ShowGuideCompAwakerUltiSkill),
    [GuideGameObjType.GuideCompAwakerUltiSkill_3] = System.fn(self, self._ShowGuideCompAwakerUltiSkill),
    [GuideGameObjType.GuideCompAwakerUltiSkill_4] = System.fn(self, self._ShowGuideCompAwakerUltiSkill),
    [GuideGameObjType.CommonillustratePanel] = System.fn(self, self._ShowGuideCompCommonillustratePanel)
  }
end

function GuideManager:Awake(binder)
  self:_OnBindEvent(binder)
  self:_OnBindToRaw(binder)
end

function GuideManager:_OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.GuideStageEnterEvent, System.fn(self, self._OnGuideStageEnterEvent))
  binder:BindEvent(EventMgr.Instance.GuideEvent, System.fn(self, self._OnGuideEvent))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self._OnStoryEnd))
  binder:BindEvent(EventMgr.Instance.GuideBattleEvent, System.fn(self, self._OnGuideBattleEvent))
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self._OnTouchBeginEvent))
  binder:BindEvent(EventMgr.Instance.OnWorldExit, System.fn(self, self._OnWorldExit))
  binder:BindEvent(EventMgr.Instance.BattleStart, System.fn(self, self._OnBattleStart))
  binder:BindEvent(EventMgr.Instance.BattleFinish, System.fn(self, self._OnBattleFinish))
end

function GuideManager:_OnWorldExit()
  self:ClearGuideData()
end

function GuideManager:_OnBattleStart()
  self:ClearGuideData()
end

function GuideManager:_OnBattleFinish()
  self:ClearGuideData()
end

function GuideManager:_OnStoryEnd(storyId)
  if storyId == self._guideStoryId then
    self:OnGuideDataClear()
  end
end

function GuideManager:_OnTouchBeginEvent()
  if self.touchCloseEnabled then
    EventMgr.Instance.GuideEvent:Dispatch(GuideEvent.GuideTouchEvent)
  end
end

function GuideManager:_OnGuideEvent(eventName, eventData)
  self:CheckCloseGuide(eventName, eventData)
  self:CheckTriggerGuide(eventName, eventData)
end

function GuideManager:_OnGuideStageEnterEvent(stageId)
  self:OnStageEnter(stageId)
end

function GuideManager:_OnGuideBattleEvent(eventName, eventData)
  if eventData and type(eventData) == "table" then
    Logger.Info("[Guide]BattleEvent", eventName, table.tostring(eventData, " ", " "))
  else
    Logger.Info("[Guide]BattleEvent", eventName, eventData)
  end
  self.lockBattleEndTurn = false
  local onBattleEventFunc = self._eventName2FuncDict[eventName]
  if onBattleEventFunc then
    onBattleEventFunc(eventName, eventData)
  else
    self:CheckCloseGuide(eventName, eventData)
    self:CheckTriggerGuide(eventName, eventData)
  end
end

function GuideManager:_OnBindToRaw(binder)
  binder:BindToRaw(function(_, isDisbled)
    if not isDisbled and 0 ~= DataCenter.guideData.guideId then
      self:ShowGuide()
    end
  end, function()
    return self._isDisbled.value
  end)
  binder:BindToRaw(function()
    local key1 = CommonDefine.LocalSaveKey.TriggeredGuideList
    self.triggeredGuideList = MobileFileDataManager.Instance:GetPlayerFileValue(key1, {})
    local key2 = CommonDefine.LocalSaveKey.BattleTriggeredGuideList
    self.battleTriggeredGuideList = MobileFileDataManager.Instance:GetPlayerFileValue(key2, {})
  end, function()
    return DataCenter.playerData.DRole.uid
  end)
end

function GuideManager:ClearBattleTriggeredGuideList()
  self.battleTriggeredGuideList = {}
  self:SaveBattleTriggeredGuideList()
end

function GuideManager:SaveBattleTriggeredGuideList()
  local saveKey = CommonDefine.LocalSaveKey.BattleTriggeredGuideList
  MobileFileDataManager.Instance:SetPlayerFileValue(saveKey, self.battleTriggeredGuideList)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function GuideManager:StartGuide(guideId, subGuideId, guideInfo)
  local cfg = DT.GuideConfig[guideId]
  local guideCfg = cfg.data_list[1]
  if not guideCfg.CanRepeat and table.contains(self.triggeredGuideList or {}, guideId) then
    return false
  end
  if guideCfg.BattleOnlyOnce and table.contains(self.battleTriggeredGuideList or {}, guideId) then
    return false
  end
  self:SetGuideStoryId(nil)
  print("-----------------start guide", guideId, subGuideId, table.tostring(cfg))
  DataCenter.guideData.guideId = guideId
  DataCenter.guideData.subGuideId = subGuideId
  self.closeTriggerName = guideInfo.CloseState
  self.closeTriggerGear = guideInfo.Gear
  self:ResetTouchDelay()
  if not self._isDisbled.value then
    self:ShowGuide()
    return true
  end
  return false
end

function GuideManager:ShowGuide()
  local guideCfg = GuideUtils.GetCurGuideCfg()
  if guideCfg.AvgDialog and self._lastGuideStoryId == guideCfg.AvgDialog then
    return
  end
  local showFunc = guideCfg.GuideGameObj and self._guideObj2FuncDict[guideCfg.GuideGameObj]
  if showFunc then
    showFunc(guideCfg)
  elseif guideCfg.Content then
    AudioManager.Instance:PostSoundEvent("UI_NPC_GUIDE")
    UIManager.Instance:Reopen(Urls.GuideView)
  end
  if guideCfg.AvgDialog then
    self:SetGuideStoryId(guideCfg.AvgDialog)
    AvgStoryManager.Instance:StartStoryById(guideCfg.AvgDialog, nil, nil, function()
      if bg.battleRender and bg.battleRender.boutMgr then
        EventMgr.Instance.GuideBattleEvent:Dispatch(GuideBattle.GuideCondAvgEnd, {
          bg.battleRender.battleTid,
          bg.battleRender.boutMgr:GetBoutNum()
        })
      end
    end)
  end
end

function GuideManager:CloseGuide()
  UIManager.Instance:CloseByUrl(Urls.GuideView)
  UIManager.Instance:CloseByUrl(Urls.NewbieGuideBattleView)
  self:OnGuideDataClear()
end

function GuideManager:OnGuideDataClear()
  if not table.contains(self.triggeredGuideList, DataCenter.guideData.guideId) then
    table.insert(self.triggeredGuideList, DataCenter.guideData.guideId)
    local key = CommonDefine.LocalSaveKey.TriggeredGuideList
    MobileFileDataManager.Instance:SetPlayerFileValue(key, self.triggeredGuideList)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  end
  if not table.contains(self.battleTriggeredGuideList, DataCenter.guideData.guideId) then
    table.insert(self.battleTriggeredGuideList, DataCenter.guideData.guideId)
    self:SaveBattleTriggeredGuideList()
  end
  self:ClearGuideData()
end

function GuideManager:ClearGuideData()
  DataCenter.guideData.guideId = 0
  DataCenter.guideData.subGuideId = 0
  self.closeTriggerName = nil
  self.closeTriggerGear = nil
  self.focusTriggerGear = nil
  self.curGearRect = nil
  self:SetGuideStoryId(nil)
end

function GuideManager:OnStageEnter(stageId)
  self.stageId = stageId
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.TriggerState then
      return
    end
    if guideInfo.Stage == stageId and not guideInfo.Gear and not guideInfo.GearDone then
      return true
    end
  end)
end

function GuideManager:OnStageGearAppear(stageId, gearId)
  self.stageId = stageId
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.TriggerState then
      return
    end
    if guideInfo.Stage == stageId and guideInfo.Gear == gearId then
      return true
    end
  end)
end

function GuideManager:OnStageGearDone(stageId, gearId)
  self.stageId = stageId
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.TriggerState then
      return
    end
    if guideInfo.Stage == stageId and guideInfo.GearDone == gearId then
      return true
    end
  end)
end

function GuideManager:LoopCheckToStartGuide(checkFunc)
  local guideCfg = DT.GuideConfig
  for guideId, guideInfo in pairs(guideCfg) do
    local guideList = guideInfo.data_list
    for subGuideId, guideitem in ipairs(guideList) do
      if checkFunc(guideitem) then
        return self:StartGuide(guideId, subGuideId, guideitem)
      end
    end
  end
  return false
end

function GuideManager:ResetTouchDelay()
  self.touchCloseEnabled = false
  if self.touchDelayTimer then
    TimerManager.Instance:StopTimer(self.touchDelayTimer)
  end
  self.touchDelayTimer = TimerManager.Instance:CreateTimer(self.touchCloseDelay, 0, nil, function()
    self.touchCloseEnabled = true
  end)
end

function GuideManager:GetGearRect()
  return self.curGearRect
end

function GuideManager:GetCurStageId()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  return stageData and stageData.stageId
end

function GuideManager:IsBattleHaveGuide()
  local battleTid = bg.battleRender and bg.battleRender.battleTid
  if not battleTid then
    return
  end
  for guideId, guideInfo in pairs(DT.GuideConfig) do
    local guideList = guideInfo.data_list
    for subGuideId, guideitem in ipairs(guideList) do
      if guideitem.BattleIndex == battleTid then
        return true
      end
    end
  end
end

function GuideManager:SetDisabled(isDisbled)
  self._isDisbled.value = isDisbled
end

function GuideManager:SetGearRect(rect)
  self.curGearRect = rect
end

function GuideManager:SetGuideStoryId(storyId)
  self._lastGuideStoryId = self._guideStoryId
  self._guideStoryId = storyId
end

function GuideManager:CheckIsLockBattleEndTurn()
  return self.lockBattleEndTurn
end

function GuideManager:CheckGuideEffect(guideInfo, triggerState, battleIndex, boutIndex)
  if not guideInfo then
    return false
  end
  return guideInfo.TriggerState == triggerState and guideInfo.BattleIndex and guideInfo.BattleIndex == battleIndex and guideInfo.BoutIndex and guideInfo.BoutIndex == boutIndex
end

function GuideManager:CheckCloseGuide(eventName, eventData)
  if eventName == GuideBattle.GuideCondOpenedEnemyIntentionView then
    EventMgr.Instance.GuideOpenedEnemyIntentionView:Dispatch()
    self:CloseGuide()
    return
  end
  if eventName == self.closeTriggerName then
    self:CloseGuide()
    return
  end
  if eventName == GuideEvent.GearTrigger and self.closeTriggerGear == tonumber(eventData) then
    self:CloseGuide()
    return
  end
end

function GuideManager:CheckTriggerGuide(eventName, eventData)
  local stageId = self:GetCurStageId()
  if eventName == GuideEvent.GearAppear then
    self:OnStageGearAppear(stageId, tonumber(eventData))
    return
  end
  if eventName == GuideEvent.GearDone then
    self:OnStageGearDone(stageId, tonumber(eventData))
    return
  end
  local battleTid = tonumber(eventData)
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.Stage and guideInfo.Stage ~= stageId then
      return
    end
    if guideInfo.BattleIndex and guideInfo.BattleIndex ~= battleTid then
      return
    end
    if guideInfo.TriggerState == eventName then
      return true
    end
  end)
end

function GuideManager:CheckGuideStageBoutValid(triggerState, battleIndex, boutIndex)
  local guideCfg = GuideCfgUtils.GetGuideCfgByTriggerState(triggerState)
  if not guideCfg then
    return false
  end
  return guideCfg.BattleIndex == battleIndex and guideCfg.BoutIndex == boutIndex
end

function GuideManager:CheckGuideTriggered()
end

function GuideManager:_OnBattleEventCommonFunc(eventName, eventData)
  local battleTid, boutNum = table.unpack(eventData)
  self:LoopCheckToStartGuide(function(guideInfo)
    do return self.CheckGuideEffect, self, guideInfo, eventName, battleTid end
    return self.CheckGuideEffect, self, guideInfo, eventName, battleTid, boutNum
  end)
end

function GuideManager:_OnBattleEventBout(_, eventData)
  local battleTid, boutNum = table.unpack(eventData)
  do return self.LoopCheckToStartGuide, self end
  return self.LoopCheckToStartGuide, self, function(guideInfo)
    if guideInfo.TriggerState and guideInfo.TriggerState ~= GuideBattle.GuideCondBoutBegin then
      return
    end
    if guideInfo.BattleIndex and guideInfo.BattleIndex == battleTid and guideInfo.BoutIndex == boutNum then
      return true
    end
  end
end

function GuideManager:_OnBattleEventBegin(_, eventData)
  local battleTid = table.unpack(eventData)
  local result = self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.TriggerState then
      return
    end
    if guideInfo.BattleIndex and guideInfo.BattleIndex == battleTid and 0 == guideInfo.BoutIndex then
      return true
    end
  end)
  if false == result then
    bg.battleRender:PopPerformQueue("Check_AVG_Timeline")
  end
end

function GuideManager:_OnBattleEventGuideEndLock(_, eventData)
  local battleTid = tonumber(eventData)
  local stageId = self:GetCurStageId()
  local availCard = bg.battleRender.cardMgr:IsHaveAvailCard()
  local availAwakerSkill = bg.battleRender:IsHaveAvailAwakerSkill()
  local availKeeperSkill = bg.battleRender:HaveAvailKeeperSkill()
  local checkState = CommonDefine.GuideEndLockCheck
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.Stage and guideInfo.Stage ~= stageId then
      return
    end
    if guideInfo.BattleIndex and guideInfo.BattleIndex ~= battleTid then
      return
    end
    if guideInfo.TriggerState == checkState.TurnLockCard then
      return availCard
    elseif guideInfo.TriggerState == checkState.TurnLockExSkill then
      return availAwakerSkill
    elseif guideInfo.TriggerState == checkState.TurnLockPosse then
      return availKeeperSkill
    elseif guideInfo.TriggerState == checkState.GuideEndLock_Card_Awaker then
      return availCard or availAwakerSkill
    elseif guideInfo.TriggerState == checkState.GuideEndLock_Card_Awaker_Keeper then
      return availCard or availAwakerSkill or availKeeperSkill
    end
  end)
  self.lockBattleEndTurn = 0 ~= DataCenter.guideData.guideId
end

function GuideManager:_OnBattleEventOnDeadResistRecord(_)
  local everTriggered = ClientDataUtils.GetClientSubData(cd.ClientSubKey.EverDeadResist)
  if everTriggered then
    return
  end
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.EverDeadResist, 1)
  self:LoopCheckToStartGuide(function(guideInfo)
    if guideInfo.TriggerState == GuideBattle.GuideTime_FirstDeadResist then
      return true
    end
  end)
end

function GuideManager:_OnBattleEventGuideCondAfterUseUltiSkill(_, eventData)
  self:CloseGuide()
  local battleTid, boutNum = table.unpack(eventData)
  self:LoopCheckToStartGuide(function(guideInfo)
    do return self.CheckGuideEffect, self, guideInfo, GuideBattle.GuideCondAfterUseUltiSkill, battleTid end
    return self.CheckGuideEffect, self, guideInfo, GuideBattle.GuideCondAfterUseUltiSkill, battleTid, boutNum
  end)
end

function GuideManager:_ShowGuideCompOceanSwitchEntry(guideCfg)
  if not GuideConditionUtils.CheckOceanSkillGuideCondEffect() then
    return
  end
  UIManager.Instance:CloseByUrl(Urls.DbgTentacleModeSwitch)
  local viewData = {
    guideCfg = guideCfg,
    nodeName = "SceneRoot.Btn_Switch",
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function GuideManager:_ShowGuideCompIntroduceEnemyIntention(guideCfg)
  local viewData = {
    guideCfg = guideCfg,
    nodeName = "SceneRoot.UI_Battle_Item_Intention(Clone).E_se_guishouyitu_tubiao",
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function GuideManager:_ShowGuideCompBloodSchoolSkill(guideCfg)
  if not GuideConditionUtils.CheckBloodSkillGuideCondEffect() then
    return
  end
  local viewData = {
    guideCfg = guideCfg,
    nodeName = "SceneRoot.Image_Blood",
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function GuideManager:_ShowGuideCompDimensionSchoolSkill(guideCfg)
  if not GuideConditionUtils.CheckDimensionSkillGuideCondEffect() then
    return
  end
  local viewData = {
    guideCfg = guideCfg,
    nodeName = "SceneRoot.Btn_ChaoWei_BlackHole",
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function GuideManager:_ShowGuideCompAwakerUltiSkill(guideCfg)
  local idx = string.sub(guideCfg.GuideGameObj, -1)
  idx = tonumber(idx)
  local viewData = {
    guideCfg = guideCfg,
    nodeName = "UI_Battle_Panel_Dbg(Clone).AwakerSkill_" .. idx,
    direction = CommonDefine.GuidePos.GO_DOWN
  }
  UIManager.Instance:Reopen(Urls.NewbieGuideBattleView, viewData)
end

function GuideManager:_ShowGuideCompCommonillustratePanel(guideCfg)
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text(guideCfg.TipsTitle), LT.Text(guideCfg.Content))
end

function GuideManager:ResetTrigeredGuideId(guideId)
  if not self.triggeredGuideList then
    return
  end
  for index, _guideId in ipairs(self.triggeredGuideList) do
    if _guideId == guideId then
      table.remove(self.triggeredGuideList, index)
      local key = CommonDefine.LocalSaveKey.TriggeredGuideList
      MobileFileDataManager.Instance:SetPlayerFileValue(key, self.triggeredGuideList)
      MobileFileDataManager.Instance:OnSavePlayerFileInfo()
      break
    end
  end
end

return GuideManager
