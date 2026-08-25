local CommonQuality = CommonDefine.CommonQuality
local OpeningVideoDict = CommonDefine.SummonResultOpeningVideo
local QualityVideoDict = CommonDefine.SummonItemQualityVideo
local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonResultPanel, Super = System.NewClass("SummonResultPanel", UIBasePanel)
SummonResultPanel.uiResCls = UI_Summon_Result_PanelResource

function SummonResultPanel:ctor(result, poolId, isSingleSummon, onClose, skipOpeningVideo, summonModel)
  Super.ctor(self)
  self.summonModel = summonModel
  self.result = result
  self.poolId = poolId
  self.isSingleSummon = isSingleSummon
  self.onClose = onClose
  self.skipOpeningVideo = skipOpeningVideo
end

function SummonResultPanel:OnBind(binder)
  self.ui.Btn_Skip:SetActive(not self.skipOpeningVideo)
  self.ui.UI_Common_Btn_Back3:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Skip, function()
    self:_OnClickClose()
  end)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:_OnClickClose()
  end))
  self:_InitUIElements(binder)
  self:_CreateVideoPlayers()
  self:_CreateStateMachine(binder)
  self:_CreateShareBtnCom()
  ShortCutKeyManager.Instance:Register("ESC", System.fn(self, self._OnClickClose))
  if self.skipOpeningVideo then
    local haveFirstSSR = false
    if SummonUiUtils.isQuickSummon then
      for _, resultData in ipairs(self.result.itemList) do
        if SummonUiUtils.IsShowQuickSummonItem(resultData) then
          haveFirstSSR = true
          break
        end
      end
    end
    if not haveFirstSSR then
      self:_OnClickClose()
    else
      self.ui.Btn_Skip:SetActive(true)
    end
  end
end

function SummonResultPanel:_InitUIElements(binder)
  self.ui.Mainbg:SetActive(false)
  if self.ui.BlackBg then
    self.ui.BlackBg:SetActive(true)
  end
  self.ui.VideoMask_Black:SetActive(false)
  self.ui.VideoMask_Mainbg:SetActive(false)
  self.ui.WhiteScreen_R:SetActive(false)
  self.ui.WhiteScreen_SR:SetActive(false)
  self.ui.WhiteScreen_SSR:SetActive(false)
  self.ui.Logo_R:SetActive(false)
  self.ui.Logo_SR:SetActive(false)
  self.ui.Logo_SSR:SetActive(false)
  self.ui.Item_R:SetActive(false)
  self.ui.Item_SR:SetActive(false)
  self.ui.Item_SSR:SetActive(false)
  self.uiElementDict = {
    [CommonQuality.Blue] = {
      whiteScreen = self.ui.WhiteScreen_R,
      whiteScreenAnimName = "UI_Summon_Popup_Show_WhiteScreen_R",
      logo = binder:BindComponent(SummonResultItemQualityR(self.ui.Logo_R)),
      item = binder:BindComponent(SummonResultItemDetailR(self.ui.Item_R))
    },
    [CommonQuality.Purple] = {
      whiteScreen = self.ui.WhiteScreen_SR,
      whiteScreenAnimName = "UI_Summon_Popup_Show_WhiteScreen_SR",
      logo = binder:BindComponent(SummonResultItemQualitySR(self.ui.Logo_SR)),
      item = binder:BindComponent(SummonResultItemDetailSR(self.ui.Item_SR))
    },
    [CommonQuality.Orange] = {
      whiteScreen = self.ui.WhiteScreen_SSR,
      whiteScreenAnimName = "UI_Summon_Popup_Show_WhiteScreen_SSR",
      logo = binder:BindComponent(SummonResultItemQualitySSR(self.ui.Logo_SSR)),
      item = binder:BindComponent(SummonResultItemDetailSSR(self.ui.Item_SSR))
    }
  }
end

function SummonResultPanel:_CreateVideoPlayers()
  self.ui.Summon_R:SetActive(false)
  self.ui.Summon_R_Bak:SetActive(false)
  self.ui.Summon_Front_R:SetActive(false)
  self.ui.Summon_Front_R_Bak:SetActive(false)
  self.openingVideoPlayer = self:_CreateVideoPlayer(self.ui.Summon_R, self.ui.Summon_R_Bak)
  self.qualityVideoPlayer = self:_CreateVideoPlayer(self.ui.Summon_Front_R, self.ui.Summon_Front_R_Bak)
end

function SummonResultPanel:_CreateStateMachine(binder)
  if 1 == #self.result.itemList then
    self:_CreateStateSingleOpeningVideo(binder, self.result, self:_CreateStateDisplaySingleItem(binder, self.result)).Enter()
  else
    self:_CreateStateOpeningVideo(binder, self.result, self:_CreateStateDisplayItems(binder, self.result)).Enter()
  end
end

function SummonResultPanel:_CreateStateSingleOpeningVideo(_, result, nextState)
  local state = {}
  
  function state.Enter()
    self.currState = state
    local summonItem = result.itemList[1]
    local itemCfg = DT.Item[summonItem.tid]
    self.ui.VideoMask_Black:SetActive(true)
    local openingVideoURL = OpeningVideoDict[result.highestQuality]
    self.openingVideoPlayer.OpenMedia(openingVideoURL)
    self.singleOpeningVideoAwaiter = Awaiter.Get()
    self.openingVideoPlayer.Play(function()
      self:_ShowMaskForOneFrame(self.ui.VideoMask_Black)
      local soundID = CommonDefine.SummonSoundID.OpeningVideo[result.highestQuality]
      if soundID then
        AudioManager.Instance:PostSoundEvent(soundID)
      end
      local qualityVideoURL = QualityVideoDict[itemCfg.Quality]
      self.qualityVideoPlayer.OpenMedia(qualityVideoURL)
    end, function()
      self.openingVideoPlayer.CloseMedia()
      self.openingVideoPlayer.Hide()
      self.singleOpeningVideoAwaiter:SetCompleted()
    end)
    self.singleOpeningVideoAwaiter:OnCompleted(function()
      local uiElement = self.uiElementDict[itemCfg.Quality]
      self.ui.Mainbg:SetActive(true)
      self:_ShowWhiteScreen(result, function()
        self:_HideWhiteScreen()
      end)
      self.qualityVideoPlayer.Play(function()
        self:_ShowMaskForOneFrame(self.ui.VideoMask_Mainbg)
        self.singleItemLogo = uiElement.logo
        self.singleItemLogo.ui.uiNode:SetActive(true)
        self.singleItemLogo:Display(summonItem.tid, function()
          self.singleItemLogo.ui.uiNode:SetActive(false)
          self.singleItemLogo = nil
          state.Exit()
        end)
        local soundID = CommonDefine.SummonSoundID.ShowQuality[itemCfg.Quality]
        if soundID then
          AudioManager.Instance:PostSoundEvent(soundID)
        end
      end, function()
        self.qualityVideoPlayer.CloseMedia()
        self.qualityVideoPlayer.Hide()
      end)
    end)
  end
  
  function state.Exit(clickClose)
    self.openingVideoPlayer.CloseMedia()
    self.openingVideoPlayer.Hide()
    self.qualityVideoPlayer.CloseMedia()
    self.qualityVideoPlayer.Hide()
    self:_HideWhiteScreen()
    if self.singleOpeningVideoAwaiter then
      self.singleOpeningVideoAwaiter:Recycle()
      self.singleOpeningVideoAwaiter = nil
    end
    if self.singleItemLogo then
      self.singleItemLogo:StopDisplay()
      self.singleItemLogo.ui.uiNode:SetActive(false)
      self.singleItemLogo = nil
    end
    if clickClose then
      local soundID = CommonDefine.SummonSoundID.SkipOpeningVideo
      AudioManager.Instance:PostSoundEvent(soundID)
    end
    nextState.Enter()
  end
  
  return state
end

function SummonResultPanel:_CreateStateDisplaySingleItem(_, result)
  local state = {}
  
  function state.Enter()
    self.currState = state
    self.ui.Btn_Skip:SetActive(false)
    self.ui.UI_Common_Btn_Back3:SetActive(true)
    local summonItem = result.itemList[1]
    local itemCfg = DT.Item[summonItem.tid]
    local uiElement = self.uiElementDict[itemCfg.Quality]
    local item = uiElement.item
    item.ui.uiNode:SetActive(true)
    item:Display(summonItem, result.awakerFragmentCount_1, function()
      self:_OnClickClose()
    end)
    local soundID = CommonDefine.SummonSoundID.ShowItemDetail[itemCfg.Quality]
    if soundID then
      AudioManager.Instance:PostSoundEvent(soundID)
    end
    self:CheckShareBtn(itemCfg.Quality)
    self:SetCurShowItemId(summonItem.tid)
  end
  
  function state.Exit()
    self:SetShareBtnStates(false)
    self:Close()
    AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_AWAKING")
  end
  
  return state
end

function SummonResultPanel:_CreateStateOpeningVideo(_, result, nextState)
  local state = {}
  
  function state.Enter()
    self.currState = state
    local summonItem = result.itemList[1]
    local itemCfg = DT.Item[summonItem.tid]
    self.ui.VideoMask_Black:SetActive(true)
    local openingVideoURL = OpeningVideoDict[result.highestQuality]
    self.openingVideoPlayer.OpenMedia(openingVideoURL)
    self.openingVideoPlayer.Play(function()
      self:_ShowMaskForOneFrame(self.ui.VideoMask_Black)
      local soundID = CommonDefine.SummonSoundID.OpeningVideo[result.highestQuality]
      if soundID then
        AudioManager.Instance:PostSoundEvent(soundID)
      end
      if not self.skipOpeningVideo then
        local qualityVideoURL = QualityVideoDict[itemCfg.Quality]
        self.qualityVideoPlayer.OpenMedia(qualityVideoURL)
      end
    end, function()
      self.ui.Mainbg:SetActive(true)
      state.Exit()
    end)
  end
  
  function state.Exit(clickClose)
    self.openingVideoPlayer.CloseMedia()
    self.openingVideoPlayer.Hide()
    if clickClose then
      local soundID = CommonDefine.SummonSoundID.SkipOpeningVideo
      AudioManager.Instance:PostSoundEvent(soundID)
      if #result.itemList > 1 then
        UIManager.Instance:Reopen(Urls.SummonedAwakerPanel, result, self.poolId, self.summonModel)
      end
      self:Close()
    else
      nextState.Enter()
    end
  end
  
  return state
end

function SummonResultPanel:_CreateStateDisplayItems(binder, result)
  local state = {}
  
  function state.Enter()
    self.currState = state
    self:_ShowWhiteScreen(result, function()
      self:_HideWhiteScreen()
    end)
    state.cancelToken = {canceled = false}
    self:_DisplayItem(binder, result, 1, state.cancelToken, function()
      if #result.itemList > 1 then
        state.Exit()
      end
    end)
  end
  
  function state.Exit()
    state.cancelToken.canceled = true
    if #result.itemList > 1 then
      UIManager.Instance:Reopen(Urls.SummonedAwakerPanel, result, self.poolId, self.summonModel)
    end
    self:Close()
  end
  
  return state
end

function SummonResultPanel:_CreateVideoPlayer(displayGO, displayGOBak)
  local mediaPlayer = GameVideoPlayer(displayGO, displayGOBak)
  local videoPlayer = {}
  local videoUrl
  
  function videoPlayer.Show()
    displayGO:SetActive(true)
  end
  
  function videoPlayer.Hide()
    displayGO:SetActive(false)
  end
  
  function videoPlayer.OpenMedia(url)
    videoUrl = url
  end
  
  function videoPlayer.CloseMedia()
    mediaPlayer:CloseMedia()
    mediaPlayer:RemoveAllListeners()
  end
  
  function videoPlayer.Play(onBeginPlay, onEndOfVideo)
    mediaPlayer:CloseMedia()
    mediaPlayer:RemoveAllListeners()
    
    function mediaPlayer.preparedCallback()
      onBeginPlay()
      
      function mediaPlayer.finishedCallback()
        mediaPlayer:RemoveAllListeners()
        onEndOfVideo()
      end
      
      mediaPlayer:Rewind(true)
      mediaPlayer:Play()
    end
    
    mediaPlayer:OpenMedia(videoUrl)
  end
  
  function videoPlayer.Dispose()
    mediaPlayer:CloseMedia()
  end
  
  return videoPlayer
end

function SummonResultPanel:_ShowMaskForOneFrame(mask)
  mask:SetActive(true)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      mask:SetActive(false)
    end
  end)
end

function SummonResultPanel:_ShowWhiteScreen(result, onEndOfAnimation)
  local uiElement = self.uiElementDict[result.highestQuality]
  self.onEndOfWhiteScreenAnim = onEndOfAnimation
  self.whiteScreen = uiElement.whiteScreen
  self.whiteScreen:SetActive(true)
  self.whiteScreenAnimCtrl = self.whiteScreen:GetComponent(typeof(UIAnimationController))
  self.whiteScreenAnimCtrl:PlayMultiState(uiElement.whiteScreenAnimName, function()
    if self.onEndOfWhiteScreenAnim then
      self.onEndOfWhiteScreenAnim()
    end
  end, 1, false)
end

function SummonResultPanel:_HideWhiteScreen()
  self.onEndOfWhiteScreenAnim = nil
  if self.whiteScreenAnimCtrl then
    self.whiteScreenAnimCtrl:ClearCompleteCb()
    self.whiteScreenAnimCtrl:StopPlayableGraph()
  end
  if self.whiteScreen then
    self.whiteScreen:SetActive(false)
  end
end

function SummonResultPanel:_DisplayItem(binder, result, index, cancelToken, onEndOfDisplay)
  local summonItem = result.itemList[index]
  if self.skipOpeningVideo and not SummonUiUtils.IsShowQuickSummonItem(summonItem) then
    local nextIndex = index + 1
    while nextIndex < #result.itemList and not SummonUiUtils.IsShowQuickSummonItem(result.itemList[nextIndex]) do
      nextIndex = nextIndex + 1
    end
    if nextIndex <= #result.itemList then
      if self.lastDisplayItem then
        self.logoAnimAwaiter:Recycle()
        self.itemAnimAwaiter:Recycle()
        self.lastDisplayItem.ui.uiNode:SetActive(false)
      end
      self:_DisplayItem(binder, result, nextIndex, cancelToken, onEndOfDisplay)
    else
      onEndOfDisplay()
    end
    return
  end
  local itemCfg = DT.Item[summonItem.tid]
  local uiElement = self.uiElementDict[itemCfg.Quality]
  if self.skipOpeningVideo then
    local qualityVideoURL = QualityVideoDict[itemCfg.Quality]
    self.qualityVideoPlayer.OpenMedia(qualityVideoURL)
  end
  self.ui.VideoMask_Mainbg:SetActive(true)
  self.logoAnimAwaiter = Awaiter.Get()
  self.qualityVideoPlayer.Play(function()
    self:SetShareBtnStates(false)
    self:SetCurShowItemId(summonItem.tid)
    self:_ShowMaskForOneFrame(self.ui.VideoMask_Mainbg)
    local logo = uiElement.logo
    logo.ui.uiNode:SetActive(true)
    logo:Display(summonItem.tid, function()
      self:CheckShareBtn(itemCfg.Quality)
      logo.ui.uiNode:SetActive(false)
      self.logoAnimAwaiter:SetCompleted()
    end)
    local soundID = CommonDefine.SummonSoundID.ShowQuality[itemCfg.Quality]
    if soundID then
      AudioManager.Instance:PostSoundEvent(soundID)
    end
  end, function()
    self.ui.VideoMask_Mainbg:SetActive(true)
  end)
  self.itemAnimAwaiter = Awaiter.Get()
  self.logoAnimAwaiter:OnCompleted(function()
    local item = uiElement.item
    item.ui.uiNode:SetActive(true)
    item:Display(summonItem, result.awakerFragmentCount_1, function()
      self.itemAnimAwaiter:SetCompleted()
    end)
    self.lastDisplayItem = item
    local soundID = CommonDefine.SummonSoundID.ShowItemDetail[itemCfg.Quality]
    if soundID then
      AudioManager.Instance:PostSoundEvent(soundID)
    end
    if not self.skipOpeningVideo and index < #result.itemList then
      local nextSummonItem = result.itemList[index + 1]
      local nextItemCfg = DT.Item[nextSummonItem.tid]
      local qualityVideoURL = QualityVideoDict[nextItemCfg.Quality]
      self.qualityVideoPlayer.OpenMedia(qualityVideoURL)
    end
  end)
  self.itemAnimAwaiter:OnCompleted(function()
    self.logoAnimAwaiter:Recycle()
    self.itemAnimAwaiter:Recycle()
    if not cancelToken.canceled then
      if index < #result.itemList then
        index = index + 1
        self.lastDisplayItem.ui.uiNode:SetActive(false)
        self:_DisplayItem(binder, result, index, cancelToken, onEndOfDisplay)
      else
        onEndOfDisplay()
      end
    end
  end)
end

function SummonResultPanel:_OnClickClose()
  ShortCutKeyManager.Instance:UnRegister("ESC", System.fn(self, self._OnClickClose))
  if self.currState then
    self.currState.Exit(true)
  else
    self:Close()
  end
end

function SummonResultPanel:Close()
  Super.Close(self)
  if self.onClose then
    self.onClose()
  end
  SummonDataUtils.SetSummonGainShowList({})
end

function SummonResultPanel:OnUnbind()
  ShortCutKeyManager.Instance:UnRegister("ESC", System.fn(self, self._OnClickClose))
  self.openingVideoPlayer.Dispose()
  self.qualityVideoPlayer.Dispose()
  self:_ClearTimers()
  self:_RecycleAwaiters()
  Super.OnUnbind(self)
end

function SummonResultPanel:_ClearTimers()
  if self.btnTimer ~= nil then
    TimerManager.Instance:StopTimer(self.btnTimer)
    self.btnTimer = nil
  end
end

function SummonResultPanel:_RecycleAwaiters()
  if self.singleOpeningVideoAwaiter then
    self.singleOpeningVideoAwaiter:Recycle()
    self.singleOpeningVideoAwaiter = nil
  end
  if self.logoAnimAwaiter then
    self.logoAnimAwaiter:Recycle()
    self.logoAnimAwaiter = nil
  end
  if self.itemAnimAwaiter then
    self.itemAnimAwaiter:Recycle()
    self.itemAnimAwaiter = nil
  end
  if self.videoPrepareDoneAwaiter then
    self.videoPrepareDoneAwaiter:Recycle()
    self.videoPrepareDoneAwaiter = nil
  end
end

function SummonResultPanel:SetShareBtnStates(bShow)
  if self.shareCom then
    self.shareCom:SetVisible(bShow and self.poolId ~= nil)
  end
end

function SummonResultPanel:CheckShareBtn(quality)
  local bShow = false
  local list = DT.GetOriginalConstant("ShareBtnStates")
  for _, v in ipairs(list) do
    if v == quality then
      bShow = true
      break
    end
  end
  self:SetShareBtnStates(bShow)
end

function SummonResultPanel:SetVisibleAboutShare(bShow)
  local itemCfg = DT.Item[self.CurDisPlayItemId]
  local uiElement = self.uiElementDict[itemCfg.Quality]
  uiElement.item:SetExtraItemListStates(bShow)
  self.shareCom:SetVisible(bShow)
  self.ui.Btn_Skip:SetActive(bShow and not self.isSingleSummon)
  self.ui.UI_Common_Btn_Back3:SetActive(bShow and self.isSingleSummon)
end

function SummonResultPanel:ShowSharePanel()
  self:SetVisibleAboutShare(false)
  
  local function afterCall()
    self:SetVisibleAboutShare(true)
  end
  
  SdkMgr.Instance:GetShare():OpenShareSummonPanel(self.CurDisPlayItemId, nil, afterCall, self.poolId)
end

function SummonResultPanel:_CreateShareBtnCom()
  if SteamSdk.Instance:IsSteam() or ApplicationUtils.IsWindowsOrEditor() then
    self.ui.Btn_Share:SetActive(false)
    return
  end
  self.shareCom = self.binder:BindComponent(ShareBtnCom(self.ui.Btn_Share, System.fn(self, self.ShowSharePanel), "Image_Bg"))
  if not self.poolId then
    self.ui.Btn_Share:SetActive(false)
  end
end

function SummonResultPanel:SetCurShowItemId(itemId)
  self.CurDisPlayItemId = itemId
end

return SummonResultPanel
