local Z1Toggle = CS.Z1Client.Z1Toggle
local typeof = _ENV.typeof
local AwakerVoiceDetailComp, Super = System.NewComponent("AwakerVoiceDetailComp")

function AwakerVoiceDetailComp:ctor(uiNode, awakerModel, storyModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_VoiceResource(uiNode)
  self.awakerModel = awakerModel
  self.storyModel = storyModel
end

function AwakerVoiceDetailComp:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_CV, function()
    local awakerId = self.awakerModel.selectAwakerId
    do return LT.Textf, "VoiceActorTips", LT.Text(DT.AwakerConfig[awakerId].VoiceActor) end
    return LT.Textf, "VoiceActorTips", LT.Text(DT.AwakerConfig[awakerId].VoiceActor)
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text, self.storyModel:GetCurVoiceTitle() end
    return LT.Text, self.storyModel:GetCurVoiceTitle()
  end)
  binder:BindToText(self.ui.Text_Story, function()
    local showContent = self.storyModel:GetCurVoiceContent()
    do return LT.Text end
    return LT.Text, showContent
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Story, function()
    return self.storyModel.voiceShowList
  end, function(itemBinder, item, index)
    local awakerVoiceData = self.storyModel.voiceShowList[index]
    
    local function callBack()
      local isRepeatVoice = awakerVoiceData.soundEventStr == self.storyModel.curPlayingVoiceName
      local curPlayingVoiceName = self.storyModel.curPlayingVoiceName
      if curPlayingVoiceName and awakerVoiceData.unlock ~= CommonDefine.AwakerStoryVoiceState.Lock then
        AwakerFaceManager.Instance:SwitchFace(self.awakerModel.selectAwakerId, nil)
        AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All_Fast")
        self.storyModel:SetCurPlayingVoiceName("")
      end
      self.storyModel:SetCurSelectVoiceId(awakerVoiceData.tid)
      if self.storyModel.voiceSelectTab == CommonDefine.AwakerVoiceTab.Pvp then
        AwakerVoiceController.Instance:ReqMarkPvpOpeningVoiceRead({
          awakerVoiceData.tid
        }, function()
          awakerVoiceData.unlock = CommonDefine.AwakerStoryVoiceState.Read
        end)
      else
        AwakerDataUtils.ReadVoice(self.awakerModel.selectAwakerId, {
          awakerVoiceData.tid
        })
      end
      if awakerVoiceData.unlock ~= CommonDefine.AwakerStoryVoiceState.Lock and not isRepeatVoice then
        if awakerVoiceData.FacialExpressionSwitch then
          AwakerFaceManager.Instance:SwitchFace(self.awakerModel.selectAwakerId, awakerVoiceData.FacialExpressionSwitch)
        end
        if awakerVoiceData.soundEventStr then
          self.storyModel:SetCurPlayingVoiceName(awakerVoiceData.soundEventStr)
          AudioManager.Instance:PostSoundEvent(awakerVoiceData.soundEventStr)
          local duration = AudioManager.Instance:GetEventDuration(awakerVoiceData.soundEventStr)
          if self.timer then
            self.binder:StopTimer(self.timer)
            self.timer = nil
          end
          self.timer = self.binder:BindTimer(duration, 1, nil, function()
            self.storyModel:SetCurPlayingVoiceName("")
            AwakerFaceManager.Instance:SwitchFace(self.awakerModel.selectAwakerId, nil)
          end)
        end
      end
    end
    
    itemBinder:BindComponent(AwakerVoiceItem(item, awakerVoiceData, self.storyModel, callBack))
  end)
  binder:BindToVisible(self.ui.ScrollView_Story_Content, function()
    if self.storyModel.voiceSelectTab == CommonDefine.AwakerVoiceTab.Pvp then
      return true
    end
    if not self.awakerModel.selectAwakerData or not self.awakerModel.selectAwakerData.voices then
      return false
    end
    return self.awakerModel.selectAwakerData.voices[self.storyModel.curSelectVoiceId]
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Story_Lock, function()
    local list = self.storyModel:GetVoiceLockList()
    do return self.storyModel.GetVoiceLockList end
    return self.storyModel.GetVoiceLockList, self.storyModel
  end, function(itemBinder, item, index)
    local list = self.storyModel:GetVoiceLockList()
    local data = list[index]
    itemBinder:BindComponent(AwakerStoryLockItem(item, data))
  end)
  binder:BindToVisible(self.ui.ScrollView_Story_Lock, function()
    if self.storyModel.voiceSelectTab == CommonDefine.AwakerVoiceTab.Pvp then
      return false
    end
    if not self.awakerModel.selectAwakerData or not self.awakerModel.selectAwakerData.voices then
      return false
    end
    return not self.awakerModel.selectAwakerData.voices[self.storyModel.curSelectVoiceId]
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Daily, nil, function(isOn)
    if isOn then
      self:RemoveRedPoints()
      self.storyModel:SetVoiceSelectTab(CommonDefine.AwakerVoiceTab.Daily)
      self:ResetList()
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Battle, nil, function(isOn)
    if isOn then
      self:RemoveRedPoints()
      self.storyModel:SetVoiceSelectTab(CommonDefine.AwakerVoiceTab.Battle)
      self:ResetList()
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Pvp, nil, function(isOn)
    if isOn then
      self:RemoveRedPoints()
      self.storyModel:SetVoiceSelectTab(CommonDefine.AwakerVoiceTab.Pvp)
      self:ResetList()
    end
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Daily, CommonDefine.RedDotType.Dot, nil, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    local curSkin = awakerData and awakerData.curSkin or 0
    local voiceList = self.storyModel.awakerVoiceList
    for k, v in pairs(voiceList or {}) do
      local cfg = DT.Voice[k]
      if cfg and cfg.AwakerVoiceTab == CommonDefine.AwakerVoiceTab.Daily and cfg.ShowInAwakerDate == CommonDefine.IsShowAwakerDate.Yes and v == CommonDefine.AwakerStoryVoiceState.Unlock then
        local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(cfg)
        if not unlockSkinItem then
          return "isNew"
        end
        if unlockSkinItem == curSkin then
          return "isNew"
        end
      end
    end
    return false
  end))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Battle, CommonDefine.RedDotType.Dot, nil, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    local curSkin = awakerData and awakerData.curSkin or 0
    local voiceList = self.storyModel.awakerVoiceList
    for k, v in pairs(voiceList or {}) do
      local cfg = DT.Voice[k]
      if cfg and cfg.AwakerVoiceTab == CommonDefine.AwakerVoiceTab.Battle and cfg.ShowInAwakerDate == CommonDefine.IsShowAwakerDate.Yes and v == CommonDefine.AwakerStoryVoiceState.Unlock then
        local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(cfg)
        if not unlockSkinItem then
          return "isNew"
        end
        if unlockSkinItem == curSkin then
          return "isNew"
        end
      end
    end
    return false
  end))
  binder:BindToRaw(function(_, nVal, _)
    self.ui.Btn_Daily:GetComponent(typeof(Z1Toggle)).interactable = nVal ~= CommonDefine.AwakerVoiceTab.Daily
    self.ui.Btn_Battle:GetComponent(typeof(Z1Toggle)).interactable = nVal ~= CommonDefine.AwakerVoiceTab.Battle
    self.ui.Btn_Pvp:GetComponent(typeof(Z1Toggle)).interactable = nVal ~= CommonDefine.AwakerVoiceTab.Pvp
  end, function()
    return self.storyModel.voiceSelectTab
  end)
  self:_RefreshPvpRedDot()
  binder:BindEvent(EventMgr.Instance.OnAwakerPvpVoiceStateChanged, System.fn(self, self._RefreshPvpRedDot))
end

function AwakerVoiceDetailComp:ResetList()
  local scrollRect = self.ui.ScrollView_Story:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollRect.normalizedPosition = CS.UnityEngine.Vector2(0, 1)
  if self.storyModel.curPlayingVoiceName then
    AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
    self.storyModel:SetCurPlayingVoiceName("")
  end
  local firstShowItem = self.storyModel.voiceShowList and self.storyModel.voiceShowList[1]
  if firstShowItem then
    self.storyModel:SetCurSelectVoiceId(firstShowItem.tid)
  end
end

function AwakerVoiceDetailComp:_RefreshPvpRedDot()
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Pvp, CommonDefine.RedDotType.TextNew, nil, function()
    do return AwakerVoiceModel.Instance.IsAwakerHaveUnlockPvpVoice, AwakerVoiceModel.Instance end
    return AwakerVoiceModel.Instance.IsAwakerHaveUnlockPvpVoice, AwakerVoiceModel.Instance, self.awakerModel.selectAwakerId
  end))
end

function AwakerVoiceDetailComp:Init()
  self.binder:SetZ1Toggle(self.ui.Btn_Daily, true)
  self.storyModel:SetVoiceSelectTab(CommonDefine.AwakerVoiceTab.Daily)
  self:ResetList()
  self.binder:BindToRaw(function(_, nVal, _)
    self.storyModel:UpdateVoiceLockList()
  end, function()
    return self.storyModel.curSelectVoiceId or self.awakerModel.selectAwakerId
  end)
end

function AwakerVoiceDetailComp:RemoveRedPoints()
  local voiceList = {}
  for _, data in pairs(self.storyModel.voiceShowList) do
    table.insert(voiceList, data.tid)
  end
  if #voiceList <= 0 then
    return
  end
  if self.storyModel.voiceSelectTab == CommonDefine.AwakerVoiceTab.Pvp then
    AwakerVoiceController.Instance:ReqMarkPvpOpeningVoiceRead(voiceList)
  else
    AwakerDataUtils.ReadVoice(self.awakerModel.selectAwakerId, voiceList)
  end
end

return AwakerVoiceDetailComp
