local OSTMusicCom, Super = NewViewComponent("OSTMusicCom", CGItem)
local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local Ease = CS.DG.Tweening.Ease

function OSTMusicCom:ctor(uiNode, view, musicIndex, musicId, ostIndex)
  Super.ctor(self, uiNode, view, musicId, UI_Collection_Item_Music_ToggleResource(uiNode))
  self.musicIndex = musicIndex
  self.musicId = musicId
  self.musicCfg = ArtCollectionModel.Instance:GetCfg(self.musicId)
  self.isSelected = nil
end

function OSTMusicCom:OnBuildComponent()
  self:RefreshView()
  self:OnOSTMusic()
end

function OSTMusicCom:OnExitComponent()
  Super.OnExitComponent(self)
  self:ClearTimer()
  self:StopTween()
end

function OSTMusicCom:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.uiNode, System.fn(self, self.OnClickUiNode))
end

function OSTMusicCom:OnClickUiNode()
  self:OnClickMusic()
end

function OSTMusicCom:OnClickMusic(withoutAlert)
  self:ReqClearRed()
  local isUnlock = self:_CheckIsUnlock()
  local isItemUnlock = self:_CheckIsItemUnlock()
  if not isUnlock then
    if not withoutAlert then
      Alert.ShowStr(LT.Text(self.musicCfg.LockTip))
    end
    return
  end
  if not isItemUnlock then
    if not withoutAlert then
      self:_OpenItemUnlockConfirmView()
    end
    return
  end
  local curPlayingMusic = ArtCollectionModel.Instance:GetPlayingMusic()
  if curPlayingMusic == self.musicId then
    local isPause = ArtCollectionModel.Instance:IsMusicPause()
    ArtCollectionModel.Instance:SetMusicPause(not isPause)
    if not isPause then
      self:_OnMusicPause()
    else
      self:_OnMusicResume()
    end
  else
    self:_PostMusic()
  end
end

function OSTMusicCom:RegisterNotifications()
  self:RegisterNotify(NotifyId.OSTMusicChange, System.fn(self, self.OnOSTMusic))
  self:RegisterNotify(NotifyId.CollectionItemUnlocked, self.OnCollectionItemUnlocked, self)
  self:RegisterNotify(NotifyId.OSTMusicSet, System.fn(self, self._OnOSTMusicSet))
end

function OSTMusicCom:OnOSTMusic()
  local curPlayingMusic = ArtCollectionModel.Instance:GetPlayingMusic()
  self:SetSelected(curPlayingMusic == self.musicId)
  self:UpdateMusicProgress()
  local eventName, dura = self:GetSoundEvent()
  if not eventName or not dura then
    return
  end
  local realPlayingTime = ArtCollectionModel.Instance:GetCurPlayingTime()
  local leftMusicTime = math.ceil(dura - realPlayingTime)
  self.countDownTime = leftMusicTime
  self:_RefreshDurationTime()
  if self.isSelected then
    self.timer = self:BindTimer(1, leftMusicTime, System.fn(self, self._RefreshDurationTime), System.fn(self, self.ClearTimer))
  end
end

function OSTMusicCom:_OnOSTMusicSet()
  self:SetActive(self.ui.Image_BgMusicIcon, self:IsBgMusic(self.musicId))
end

function OSTMusicCom:OnCollectionItemUnlocked()
  self:RefreshView()
end

function OSTMusicCom:RefreshView()
  self:RefreshBaseInfo()
  self:RefreshState()
  self:UpdateRedComp()
end

function OSTMusicCom:_OnMusicPause()
  self:ClearTimer()
  self:SetActive(self.ui.UI_Vx_Glow, false)
  self:SetActive(self.ui.PlayEffect, false)
end

function OSTMusicCom:_OnMusicResume()
end

function OSTMusicCom:_RefreshDurationTime()
  if self.isSelected then
    self.countDownTime = self.countDownTime - 1
    self:SetText(self.ui.Text_Time, TimeUtils.format(self.countDownTime, CommonDefine.TimeParseType.ms))
  end
end

function OSTMusicCom:RefreshBaseInfo()
  local isUnlock = self:_CheckIsUnlock()
  local isItemUnlock = self:_CheckIsItemUnlock()
  local isAllUnlock = self:_CheckIsAllUnlock()
  self:SetActive(self.ui.Text_Number, isAllUnlock)
  if isAllUnlock then
    self:SetText(self.ui.Text_Number, self.musicIndex < 10 and "0" .. self.musicIndex or self.musicIndex)
  end
  local showName = self.musicCfg and LT.Text(self.musicCfg.Title) or ""
  if not isUnlock then
    local colorHexCode = ColorUtils.GetColorHexCode("OstLockConfuseTextColor", CommonDefine.ColorType.Dark)
    local colorHex = string.format("color=%s", colorHexCode)
    showName = StrUtils.Fix2ConfuseText(showName, colorHex)
  end
  self:SetText(self.ui.Text_Name, showName)
  self:SetActive(self.ui.Text_Time, isAllUnlock)
  if isAllUnlock then
    local _, duration = self:GetSoundEvent()
    self:SetText(self.ui.Text_Time, TimeUtils.format(duration or 0, CommonDefine.TimeParseType.ms))
  end
  self:SetActive(self.ui.Image_BgMusicIcon, self:IsBgMusic(self.musicId))
  if isUnlock and not isItemUnlock then
    local costItemTid = self:GetUnlockItemTid()
    local costItemNum = self:GetUnlockItemNum()
    self:SetImage(self.ui.Image_CostIcon, costItemTid and ItemDataUtils.GetItemIcon(costItemTid))
    self:SetText(self.ui.Text_CostNum, costItemNum and ItemNumUtils.GetStr(costItemNum) or "")
  end
end

function OSTMusicCom:RefreshState()
  local isUnlock = self:_CheckIsUnlock()
  local isItemUnlock = self:_CheckIsItemUnlock()
  local isAllUnlock = self:_CheckIsAllUnlock()
  self:SetActive(self.ui.Group_Disable, not isUnlock)
  self:SetActive(self.ui.Group_Cost, isUnlock and not isItemUnlock)
  self:SetActive(self.ui.Group_Selected, isAllUnlock and self.isSelected)
  self:SetActive(self.ui.Group_Normal, isUnlock and isItemUnlock and not self.isSelected)
  self:SetActive(self.ui.PlayEffect, isAllUnlock and self.isSelected)
  self:SetActive(self.ui.UI_Vx_Glow, isAllUnlock and self.isSelected)
  self:SetTextColorType(self.ui.Text_Name, self.isSelected and cd.ColorType.Light or cd.ColorType.Dark)
end

function OSTMusicCom:_OpenItemUnlockConfirmView()
  local costItemTid, costItemNum = self:GetUnlockItemTid(), self:GetUnlockItemNum()
  local tipsTid = 20137
  local tipsCfg = DT.TipsType[tipsTid]
  local itemName = ItemDataUtils.GetItemName(costItemTid)
  local desc = LT.Textf(tipsCfg.Desc, itemName, costItemNum)
  Alert.Show(tipsTid, nil, System.fn(self, self._OnItemUnlock), nil, desc)
end

function OSTMusicCom:_OnItemUnlock()
  ArtCollectionController.Instance:OnItemUnlock(self.musicId)
end

function OSTMusicCom:GetSoundEvent()
  local soundEvent = self.musicCfg and self.musicCfg.Video
  local defaultDura = 10
  local dura = self.musicCfg.Duration or defaultDura
  return soundEvent, dura
end

function OSTMusicCom:GetUnlockItemTid()
  return self.musicCfg.UnlockConsume and self.musicCfg.UnlockConsume[1]
end

function OSTMusicCom:GetUnlockItemNum()
  return self.musicCfg.UnlockConsume and self.musicCfg.UnlockConsume[2]
end

function OSTMusicCom:SetSelected(isSelected)
  self:ClearTimer()
  if isSelected == self.isSelected and self.isSelected == false then
    return
  end
  self.isSelected = isSelected
  self:RefreshBaseInfo()
  self:RefreshState()
end

function OSTMusicCom:_CheckIsUnlock()
  do return ArtCollectionModel.Instance.IsUnlock, ArtCollectionModel.Instance end
  return ArtCollectionModel.Instance.IsUnlock, ArtCollectionModel.Instance, self.musicId
end

function OSTMusicCom:_CheckIsItemUnlock()
  do return ArtCollectionModel.Instance.IsItemUnlocked, ArtCollectionModel.Instance end
  return ArtCollectionModel.Instance.IsItemUnlocked, ArtCollectionModel.Instance, self.musicId
end

function OSTMusicCom:_CheckIsAllUnlock()
  return self:_CheckIsUnlock() and self:_CheckIsItemUnlock()
end

function OSTMusicCom:UpdateMusicProgress()
  if not self.isSelected then
    self:SetSliderValue(self.ui.Progress_Music, 0)
    return
  end
  local eventName, dura = self:GetSoundEvent()
  if not eventName or not dura then
    return
  end
  local recordPlayingTime = ArtCollectionModel.Instance:GetCurPlayingTime()
  local realPlayingTime = recordPlayingTime
  local leftMusicTime = dura - realPlayingTime
  local progress = realPlayingTime / dura
  self:StopTween()
  self:SetSliderValue(self.ui.Progress_Music, progress)
  if ArtCollectionModel.Instance:IsMusicPause() then
    return
  end
  local slider = self.ui.Progress_Music:GetComponent(TYPEOF_Slider)
  self.tw = slider:DOValue(1, leftMusicTime):SetEase(Ease.Linear):OnComplete(function()
    self.tw = nil
    self:ReplayMusic()
  end)
end

function OSTMusicCom:StopTween()
  if self.tw then
    self.tw:Kill()
    self.tw = nil
  end
end

function OSTMusicCom:ReplayMusic()
  if not self.isSelected then
    return
  end
  self:_PostMusic()
end

function OSTMusicCom:_PostMusic()
  ArtCollectionModel.Instance:SetPlayingMusic(self.musicId)
  local soundEvent, _ = self:GetSoundEvent()
  if not soundEvent then
    return
  end
  AudioManager.Instance:PostSoundEvent(soundEvent)
  AudioManager.Instance:PostSoundEvent("Resume_Mus")
end

function OSTMusicCom:IsBgMusic(musicId)
  if not musicId then
    return false
  end
  return ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", ConstantCfgUtils.GetDefaultBgMusicId()) == musicId
end

function OSTMusicCom:ClearTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

return OSTMusicCom
