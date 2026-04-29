_class("UISeasonS2MusicTab", UICustomWidget)
UISeasonS2MusicTab = UISeasonS2MusicTab

function UISeasonS2MusicTab:OnShow(uiParams)
  self:InitWidget()
  self._lastBGMAudioID = AudioHelperController.GetCurrentBgm()
  Log.info("正在播放的bgm:", self._lastBGMAudioID)
  self._timerHolder = UITimerHolder:New()
  self._pause = true
end

function UISeasonS2MusicTab:OnHide()
  if self._curIdx and self._curIdx > 0 then
    local audioID = self._collageData:GetMusicByIndex(self._curIdx):AudioID()
    if audioID ~= self._lastBGMAudioID or self._pause then
      AudioHelperController.PlayBGM(self._lastBGMAudioID)
      Log.info("恢复正在播放的bgm:", self._lastBGMAudioID)
    end
  end
  if self._tweener and self._tweener:IsPlaying() then
    self._tweener:Kill()
  end
  if self._timerHolder then
    self._timerHolder:Dispose()
    self._timerHolder = nil
  end
end

function UISeasonS2MusicTab:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.musicName = self:GetUIComponent("UILocalizationText", "musicName")
  self.author = self:GetUIComponent("UILocalizationText", "author")
  self.play = self:GetUIComponent("Button", "Play")
  self.pause = self:GetUIComponent("Button", "Pause")
  self.next = self:GetUIComponent("Button", "Next")
  self.last = self:GetUIComponent("Button", "Last")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.progress = self:GetUIComponent("Image", "progress")
  local contentLayout = self:GetUIComponent("HorizontalLayoutGroup", "Content")
  self._paddingLeft = contentLayout.padding.left
  self._cellSizeX = 472
  self._cellSpaceX = contentLayout.spacing
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._viewPortWidth = self:GetUIComponent("RectTransform", "Viewport").rect.width
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS2MusicTab:SetData(data)
  self._collageData = data
  self._musicCount = self._collageData:GetMusicCount()
  self._items = self.content:SpawnObjects("UISeasonS2CollageMusicItem", self._musicCount)
  
  local function onSelect(data)
    self:_OnSelect(data)
  end
  
  local defaultData
  for i = 1, self._musicCount do
    local data = self._collageData:GetMusicByIndex(i)
    self._items[i]:SetData(data, onSelect)
    if data:IsUnlock() and self._lastBGMAudioID == data:AudioID() then
      defaultData = data
    end
  end
  if defaultData then
    Log.info("选中默认bgm:", defaultData:ID())
    self:_OnSelect(defaultData, true)
  else
    self:_RefreshPlayBar()
  end
  self._unlockCount, self._totalCount = self._collageData:GetMusicProgress()
end

function UISeasonS2MusicTab:SetShow(show)
  self:GetGameObject():SetActive(show)
  if show then
    self._timerHolder:StartTimerInfinite("PlayingTick", 1000, function()
      self:_PlayingTick()
    end)
    self:_PlayingTick()
  else
    self._timerHolder:StopTimer("PlayingTick")
  end
end

function UISeasonS2MusicTab:_OnSelect(data, isInit)
  if not data:IsValid() then
    return
  end
  if not data:IsUnlock() then
    return
  end
  if self._curIdx == data:Index() then
    return
  end
  if data:IsNew() then
    self._collageData:MusicCancelNew(data)
    self._items[data:Index()]:SetNew(false)
    self:DispatchEvent(GameEventType.UISeasonS1OnSelectCollageItem)
  end
  if self._curIdx then
    self._items[self._curIdx]:Deselect()
  end
  self._curIdx = data:Index()
  self._items[self._curIdx]:Select()
  if not isInit then
    AudioHelperController.PlayBGM(data:AudioID())
  else
  end
  self._pause = false
  self:_RefreshPlayBar()
  self:_ResetProgress()
end

function UISeasonS2MusicTab:PlayOnClick(go)
  if not self._curIdx then
    return
  end
  if not self._pause then
    Log.info("当前bgm正在播放")
    return
  end
  self._pause = false
  self:_RefreshPlayBar()
  self._items[self._curIdx]:PlayEft()
  AudioHelperController:UnpauseBGM()
end

function UISeasonS2MusicTab:PauseOnClick(go)
  if not self._curIdx then
    return
  end
  if self._pause then
    Log.info("当前bgm已暂停")
    return
  end
  self._pause = true
  self:_RefreshPlayBar()
  self._items[self._curIdx]:PauseEft()
  AudioHelperController.PauseBGM()
end

function UISeasonS2MusicTab:LastOnClick(go)
  if not self._curIdx then
    return
  end
  if self._unlockCount == 1 then
    Log.info("只有一首，别切了")
    return
  end
  local target
  if self._curIdx <= 1 then
    Log.info("当前bgm是第一首")
    target = self._unlockCount
  else
    target = self._curIdx - 1
  end
  local data = self._collageData:GetMusicByIndex(target)
  self:_OnSelect(data)
end

function UISeasonS2MusicTab:NextOnClick(go)
  if not self._curIdx then
    return
  end
  if self._unlockCount == 1 then
    Log.info("只有一首，别切了")
    return
  end
  local target
  if self._curIdx >= self._unlockCount then
    Log.info("当前bgm是最后一首")
    target = 1
  else
    target = self._curIdx + 1
  end
  local data = self._collageData:GetMusicByIndex(target)
  self:_OnSelect(data)
end

function UISeasonS2MusicTab:_RefreshPlayBar()
  if self._curIdx then
    local data = self._collageData:GetMusicByIndex(self._curIdx)
    local cfg = Cfg.cfg_role_music[data:ID()]
    self.musicName:SetText(StringTable.Get(cfg.Name))
    self.author:SetText(StringTable.Get(cfg.Author))
    if self._pause then
      self.play.gameObject:SetActive(true)
      self.play.interactable = true
      self.pause.gameObject:SetActive(false)
    else
      self.play.gameObject:SetActive(false)
      self.pause.gameObject:SetActive(true)
      self.pause.interactable = true
    end
    self.last.interactable = true
    self.next.interactable = true
  else
    self.musicName:SetText("")
    self.author:SetText("")
    self.play.gameObject:SetActive(true)
    self.play.interactable = false
    self.next.interactable = false
    self.last.interactable = false
    self.pause.gameObject:SetActive(false)
    self:_ResetProgress()
  end
end

function UISeasonS2MusicTab:_ResetProgress()
  self.progress.fillAmount = 0
  self.time:SetText("")
end

function UISeasonS2MusicTab:_PlayingTick()
  if self._pause then
    return
  end
  local data = self._collageData:GetMusicByIndex(self._curIdx)
  if data:AudioID() ~= AudioHelperController.GetCurrentBgm() then
    return
  end
  if AudioHelperController.BGMPlayerIsPlaying() then
    local time = AudioHelperController.GetPlayingBGMTimeSyncedWithAudio()
    if time < 0 then
      time = 0
    end
    local duration = data:Duration()
    if self._development then
      local realDua = AudioHelperController.GetPlayingBGMTotalTimeMs()
      if 0 < realDua and math.abs(realDua / 1000 - duration) > 0.5 then
        ToastManager.ShowToast("音乐配置时长错误！ID:" .. self._curPlaying .. "，真实时长:" .. realDua / 1000)
      end
    end
    time = math.floor(time / 1000 % duration)
    self.time:SetText(UIBgmHelper.FormatTime(time) .. "/" .. UIBgmHelper.FormatTime(duration))
    self.progress.fillAmount = time / duration
  end
end

function UISeasonS2MusicTab:_SnapTo(index, animate)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)
  local width = self._contentRect.rect.width
  local x = self._paddingLeft + (self._cellSizeX + self._cellSpaceX) * (index - 1) + self._cellSizeX / 2 - self._viewPortWidth / 2
  x = -Mathf.Clamp(x, 0, width - self._viewPortWidth)
  if animate then
    if self._tweener and self._tweener:IsPlaying() then
      self._tweener:Kill()
    end
    self._tweener = self._contentRect:DOAnchorPosX(x, 0.7):SetEase(DG.Tweening.Ease.OutCubic)
  else
    self._contentRect.anchoredPosition = Vector2(x, 0)
  end
end

function UISeasonS2MusicTab:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1MusicTab_out")
  for i = 1, self._musicCount do
    self._items[i]:PlayExitAnim()
  end
end
