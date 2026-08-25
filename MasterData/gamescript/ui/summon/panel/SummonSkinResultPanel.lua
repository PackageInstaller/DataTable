local SummonSkinResultPanel, Super = System.NewClass("SummonSkinResultPanel", UIBasePanel)
SummonSkinResultPanel.uiResCls = UI_Summon_Skin_Result_PanelResource
SummonSkinResultPanel.assumedOpenAnimTime = 0
SummonSkinResultPanel.closeWithoutAnim = true
local DRAW_STEP = {
  MarchIn = "MarchIn",
  Idle = "Idle",
  InsertKey = "InsertKey",
  Result = "Result",
  Finish = "Finish"
}
local DRAW_STEP_ORDER = {
  [DRAW_STEP.MarchIn] = 1,
  [DRAW_STEP.Idle] = 2,
  [DRAW_STEP.InsertKey] = 3,
  [DRAW_STEP.Result] = 4,
  [DRAW_STEP.Finish] = 5
}
local MINI_ITEM_QUALITY_LEVEL = 3

function SummonSkinResultPanel:ctor(drawFunc)
  Super.ctor(self)
  self.drawFunc = drawFunc
  self._rewardLevel = nil
  self._reqDraw = nil
  self._insertKeyFinished = nil
  self._curStep = nil
  self._skinItemTid = nil
  self.skipMarchIn = ClientDataUtils.GetClientSubData(cd.ClientSubKey.PlayedSkinSummon)
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.PlayedSkinSummon, cd.NumberTrue)
end

function SummonSkinResultPanel:OnBind(binder)
  self.binder = binder
  self:InitTimelineRoot()
  self:SetSummonWord()
  self:PlayEnterSound()
  self:SetLayerVisible(false)
  self:BindDrawEvents()
  self:StartDrawAnim()
  GyroscopeManager.Instance:HideBg()
  UpdateBeat.Instance:Add(self.UpdateHideOtherVideo, self)
  LateUpdateBeat.Instance:Add(self.UpdateHideOtherVideo, self)
end

function SummonSkinResultPanel:StartDrawAnim()
  self.drawSkinQueue = Z1Queue()
  self.drawSkinQueue:Insert(DRAW_STEP.MarchIn, function()
    self._curStep = DRAW_STEP.MarchIn
    if not self.skipMarchIn then
      self:PlayMarchInTimeline()
      self:PrepareIdleTimeline()
    else
      self:PrepareIdleTimeline()
      self:RunStep(DRAW_STEP.Idle)
    end
  end)
  self.drawSkinQueue:Insert(DRAW_STEP.Idle, function()
    self._curStep = DRAW_STEP.Idle
    self:PlayIdleTimeline()
    self:PrepareInsertKeyTimeline()
  end)
  self.drawSkinQueue:Insert(DRAW_STEP.InsertKey, function()
    self._curStep = DRAW_STEP.InsertKey
    self:PlayInsertKeyTimeline()
  end)
  self.drawSkinQueue:Insert(DRAW_STEP.Result, function()
    self._curStep = DRAW_STEP.Result
    self:StopIdleTimeline()
    self:PlayResultTimeline(self._rewardLevel)
  end)
  self.drawSkinQueue:Insert(DRAW_STEP.Finish, function()
    self._curStep = DRAW_STEP.Finish
    self:ShowSkinRewards()
  end)
end

function SummonSkinResultPanel:ShowSkinRewards()
  if self._skinItemTid then
    UIAsyncLoadMgr.Instance:PrecreatePanel(Urls.SummonNewItemPanel)
    UIManager.Instance:Reopen(Urls.SummonSkinResultNextPanel, self._skinItemTid, System.fn(self, self.Close))
  else
    self:Close()
  end
end

function SummonSkinResultPanel:RunStep(step)
  if not (self.drawSkinQueue and self._curStep) or not step then
    return
  end
  if step == DRAW_STEP.Result and (not self._rewardLevel or not self._insertKeyFinished) then
    return
  end
  local curOrder = DRAW_STEP_ORDER[self._curStep]
  local stepOrder = DRAW_STEP_ORDER[step]
  if 1 == stepOrder - curOrder then
    self.drawSkinQueue:Next()
  end
end

function SummonSkinResultPanel:UpdateHideOtherVideo()
  if not self._curStep then
    return
  end
  local stepOrder = DRAW_STEP_ORDER[self._curStep]
  if self._curStep ~= DRAW_STEP.Idle and self.idleTimelinePlayer then
    self:PauseTimeline(self.idleTimelinePlayer)
  end
  if stepOrder < DRAW_STEP_ORDER[DRAW_STEP.InsertKey] and self.insertKeyTimePlayer then
    self:PauseTimeline(self.insertKeyTimePlayer)
  end
  if self._curStep ~= DRAW_STEP.Result and self.resultTimelinePlayer then
    self:PauseTimeline(self.resultTimelinePlayer)
    self.resultTimelinePlayer:HideVideoPlayers()
    if not self._resultTimelineTicker then
      self._resultTimelineTicker = self.binder:BindTimer(0.03, 0, nil, function()
        self._resultTimelineTicker = nil
        self:PauseTimeline(self.resultTimelinePlayer)
      end)
    end
  end
end

function SummonSkinResultPanel:SetSummonWord()
  self.binder:SetActive(self.ui.Text_Summon, false)
  self.binder:SetText(self.ui.Text_Summon, LT.Text("TapToSummon"))
  self._summonWordTicker = self.binder:BindTimer(0.1, 0, nil, function()
    self._summonWordTicker = nil
    if self._curStep == DRAW_STEP.Idle then
      self.ui.Text_Summon:SetActive(true)
    end
  end)
end

function SummonSkinResultPanel:PlayEnterSound()
  AudioManager.Instance:PostSoundEvent("SET_STATE_ANIM_FASHION_MARCHIN")
  if not self.skipMarchIn then
    AudioManager.Instance:PostSoundEvent("PLAY_ANIM_FASHION_MARCHIN")
  end
end

function SummonSkinResultPanel:BindDrawEvents()
  self.binder:SetActive(self.ui.Btn_Skip, true)
  self.binder:BindTimer(0.5, 0, nil, function()
    self.binder:BindButtonClick(self.ui.Mask, function()
      self:OnTouchToDraw()
    end)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Skip, function()
    self:OnBtnSkip()
  end)
  self.binder:BindEvent(EventMgr.Instance.TurntableRewardLevel, function(level)
    self:OnTurntableRewardLevel(level)
  end)
  self.binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(datas)
    self:OnSyncReward(datas)
  end)
end

function SummonSkinResultPanel:OnUnbind()
  AudioManager.Instance:PostSoundEvent("SET_STATE_ANIM_FASHION_SUM")
  LateUpdateBeat.Instance:Remove(self.UpdateHideOtherVideo, self)
  UpdateBeat.Instance:Remove(self.UpdateHideOtherVideo, self)
  GyroscopeManager.Instance:ShowBg()
  self:DisposeTimeline()
  self:SetLayerVisible(true)
  if self.drawSkinQueue then
    self.drawSkinQueue:OnDestroy()
    self.drawSkinQueue = nil
  end
end

function SummonSkinResultPanel:Close()
  self:DisposeTimeline()
  self.binder:BindTimer(0.01, 0, nil, function()
    Super.Close(self)
    EventMgr.Instance.CheckShowRewardEvent:Dispatch()
  end)
end

function SummonSkinResultPanel:DisposeTimeline()
  if self.idleTimelinePlayer then
    self.idleTimelinePlayer:Stop()
  end
  if self.resultTimelinePlayer then
    if self.resultTimelinePlayer.amPlayer then
      self.resultTimelinePlayer.amPlayer:RevertHideTracks()
    end
    self.resultTimelinePlayer:Stop()
  end
  if self.insertKeyTimePlayer then
    self.insertKeyTimePlayer:Stop()
  end
  if self.marchInTimelinePlayer then
    self.marchInTimelinePlayer:Stop()
  end
end

function SummonSkinResultPanel:InitTimelineRoot()
  local uiNodeTf = self.ui.uiNode.transform
  self.SummonSkinMarchInTimeline = CS.UnityEngine.GameObject("SummonSkinMarchInTimeline")
  self.SummonSkinMarchInTimeline.transform.parent = uiNodeTf
  self.SummonSkinIdleTimeline = CS.UnityEngine.GameObject("SummonSkinIdleTimeline")
  self.SummonSkinIdleTimeline.transform.parent = uiNodeTf
  self.SummonSkinInsertKeyTimeline = CS.UnityEngine.GameObject("SummonSkinInsertKeyTimeline")
  self.SummonSkinInsertKeyTimeline.transform.parent = uiNodeTf
  self.SummonSkinResultTimeline = CS.UnityEngine.GameObject("SummonSkinResultTimeline")
  self.SummonSkinResultTimeline.transform.parent = uiNodeTf
  self.binder:onDestroy(function()
    if IsNil(self.SummonSkinMarchInTimeline) then
      return
    end
    CS.UnityEngine.GameObject.Destroy(self.SummonSkinMarchInTimeline)
    CS.UnityEngine.GameObject.Destroy(self.SummonSkinIdleTimeline)
    CS.UnityEngine.GameObject.Destroy(self.SummonSkinInsertKeyTimeline)
    CS.UnityEngine.GameObject.Destroy(self.SummonSkinResultTimeline)
  end)
end

function SummonSkinResultPanel:SetLayerVisible(visible)
end

function SummonSkinResultPanel:OnTouchToDraw()
  if self._reqDraw then
    return
  end
  if self._curStep ~= DRAW_STEP.Idle then
    return
  end
  self.ui.Text_Summon:SetActive(false)
  if self.drawFunc then
    self._reqDraw = true
    self.drawFunc()
    self:RunStep(DRAW_STEP.InsertKey)
  end
end

function SummonSkinResultPanel:OnBtnSkip()
  self:SkipToDraw()
  if self._skinItemTid and self._curStep ~= DRAW_STEP.Finish then
    self:ShowSkinRewards()
  else
    self:Close()
  end
end

function SummonSkinResultPanel:SkipToDraw()
  if self._reqDraw then
    return
  end
  if self.drawFunc then
    self._reqDraw = true
    self.drawFunc()
  end
end

function SummonSkinResultPanel:OnTurntableRewardLevel(level)
  self._rewardLevel = math.min(MINI_ITEM_QUALITY_LEVEL, level)
  self:PrepareResultTimeline(self._rewardLevel)
  self:RunStep(DRAW_STEP.Result)
end

function SummonSkinResultPanel:ShowTimelineTrackByLevel(level)
  for showLevel, trackName in ipairs({
    "Effect_Orange",
    "Effect_Purple",
    "Effect_Blue"
  }) do
    if showLevel ~= level and self.resultTimelinePlayer and self.resultTimelinePlayer.amPlayer then
      self.resultTimelinePlayer.amPlayer:HideTrack(trackName)
    end
  end
end

function SummonSkinResultPanel:PlayRewardSound(level)
  if 1 == level then
    AudioManager.Instance:PostSoundEvent("PLAY_ANIM_FASHION_SSR")
    AudioManager.Instance:PostSoundEvent("SET_STATE_ANIM_FASHION_SSR")
  elseif 2 == level then
    AudioManager.Instance:PostSoundEvent("PLAY_ANIM_FASHION_SR")
    AudioManager.Instance:PostSoundEvent("SET_STATE_ANIM_FASHION_SR")
  else
    AudioManager.Instance:PostSoundEvent("PLAY_ANIM_FASHION_R")
    AudioManager.Instance:PostSoundEvent("SET_STATE_ANIM_FASHION_R")
  end
end

function SummonSkinResultPanel:OnSyncReward(datas)
  local isTurnReward = false
  for _, data in ipairs(datas) do
    if data.reason == cd.ItemReason.Turntable then
      isTurnReward = true
      local itemCfg = ItemDataUtils.GetItemConfig(data.tid)
      if itemCfg.Type == cd.ItemType.SkinItem then
        self._skinItemTid = data.tid
      end
    end
  end
  if not isTurnReward then
    return
  end
end

function SummonSkinResultPanel:AddBindings(timelinePlayer)
end

function SummonSkinResultPanel:PauseTimeline(timelinePlayer)
  if timelinePlayer then
    timelinePlayer:Pause()
    timelinePlayer:HideVideoPlayers()
  end
end

function SummonSkinResultPanel:PlayTimeline(timelinePlayer)
  if timelinePlayer then
    timelinePlayer:Seek(0)
    timelinePlayer:Resume()
    timelinePlayer:ShowVideoPlayers()
  end
end

function SummonSkinResultPanel:PlayMarchInTimeline()
  if not self.marchInTimelinePlayer then
    self.marchInTimelinePlayer = PortraitTimelinePlayer(self.SummonSkinMarchInTimeline)
  end
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = "TimelineRoot/ClotherLottery/ClotherLottery_Result_MarchIn.prefab"
  
  function timelineConfig.OnBeforePlay()
    self:AddBindings(self.marchInTimelinePlayer)
  end
  
  function timelineConfig.onComplete()
    self:RunStep(DRAW_STEP.Idle)
  end
  
  self.marchInTimelinePlayer:Play(timelineConfig)
end

function SummonSkinResultPanel:PrepareIdleTimeline()
  if self.idleTimelinePlayer then
    return
  end
  self.idleTimelinePlayer = PortraitTimelinePlayer(self.SummonSkinIdleTimeline)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = "TimelineRoot/ClotherLottery/ClotherLottery_Idle.prefab"
  
  function timelineConfig.OnBeforePlay()
    self:AddBindings(self.idleTimelinePlayer)
  end
  
  timelineConfig.looping = 1000
  
  function timelineConfig.onComplete()
  end
  
  self.idleTimelinePlayer:Play(timelineConfig)
  self:PauseTimeline(self.idleTimelinePlayer)
end

function SummonSkinResultPanel:StopMarchInTimeline()
  if self.marchInTimelinePlayer then
    self.marchInTimelinePlayer:Stop()
  end
  self.ui.MarchInTimeline:SetActive(false)
end

function SummonSkinResultPanel:PlayIdleTimeline()
  if not self.idleTimelinePlayer then
    self:PrepareIdleTimeline()
  end
  if self._curStep == DRAW_STEP.Idle and not self._summonWordTicker then
    self.binder:SetActive(self.ui.Text_Summon, true)
  end
  self:PlayTimeline(self.idleTimelinePlayer)
end

function SummonSkinResultPanel:StopIdleTimeline()
  if self.idleTimelinePlayer then
    self.idleTimelinePlayer:Stop()
  end
  self.ui.IdleTimeline:SetActive(false)
end

function SummonSkinResultPanel:PrepareInsertKeyTimeline()
  if not self.insertKeyTimePlayer then
    self.insertKeyTimePlayer = PortraitTimelinePlayer(self.SummonSkinInsertKeyTimeline)
    self.insertKeyTimePlayer.isSync = true
  end
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = "TimelineRoot/ClotherLottery/ClotherLottery_Result.prefab"
  
  function timelineConfig.OnBeforePlay()
    self:AddBindings(self.insertKeyTimePlayer)
  end
  
  function timelineConfig.onComplete()
    self._insertKeyFinished = true
    self.insertKeyTimePlayer:Pause()
  end
  
  self.insertKeyTimePlayer:Play(timelineConfig)
  self:PauseTimeline(self.insertKeyTimePlayer)
end

function SummonSkinResultPanel:PlayInsertKeyTimeline()
  if not self.insertKeyTimePlayer then
    self:PrepareInsertKeyTimeline()
  end
  self:PlayTimeline(self.insertKeyTimePlayer)
  self.binder:BindTimer(6, 0, nil, function()
    self._insertKeyFinished = true
    self:RunStep(DRAW_STEP.Result)
  end)
end

function SummonSkinResultPanel:PrepareResultTimeline(level)
  if not self.resultTimelinePlayer then
    self.resultTimelinePlayer = PortraitTimelinePlayer(self.SummonSkinResultTimeline)
    self.resultTimelinePlayer.isSync = true
  end
  local resultTimeline = {
    [1] = "TimelineRoot/ClotherLottery/ClotherLottery_Result_Orange.prefab",
    [2] = "TimelineRoot/ClotherLottery/ClotherLottery_Result_Purple.prefab",
    [3] = "TimelineRoot/ClotherLottery/ClotherLottery_Result_Blue.prefab"
  }
  local assetPath = resultTimeline[level]
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = assetPath
  
  function timelineConfig.OnBeforePlay()
    self:AddBindings(self.resultTimelinePlayer)
  end
  
  function timelineConfig.onComplete()
    self:SetLayerVisible(true)
    self:RunStep(DRAW_STEP.Finish)
  end
  
  self.resultTimelinePlayer:Play(timelineConfig)
  self:PlayRewardSound(self._rewardLevel)
end

function SummonSkinResultPanel:PlayResultTimeline(level)
  if not self.resultTimelinePlayer then
    self:PrepareResultTimeline(level)
  end
  if self._resultTimelineTicker then
    self.binder:StopTimer(self._resultTimelineTicker)
    self._resultTimelineTicker = nil
  end
  self:PlayTimeline(self.resultTimelinePlayer)
end

return SummonSkinResultPanel
