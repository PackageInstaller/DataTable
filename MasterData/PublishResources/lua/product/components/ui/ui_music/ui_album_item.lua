_class("UIAlbumItem", UICustomWidget)
UIAlbumItem = UIAlbumItem

function UIAlbumItem:OnShow(uiParams)
  self:InitWidget()
  self._color = {}
  self._color.valid = Color(1, 1, 1)
  self._color.inValid = Color(0.25098039215686274, 0.25098039215686274, 0.25098039215686274)
end

function UIAlbumItem:InitWidget()
  self.select = self:GetGameObject("select")
  self.play = self:GetGameObject("play")
  self.nameText = self:GetUIComponent("RollingText", "nameText")
  self.authorText = self:GetUIComponent("RollingText", "authorText")
  self.lock = self:GetGameObject("lock")
  self.duration = self:GetUIComponent("UILocalizationText", "duration")
  self.playing = self:GetUIComponent("Animation", "playing")
  self._playingState = self.playing:get_Item("uieff_Album_Playing")
  self._nameText = self:GetUIComponent("Text", "nameText")
  self._authorText = self:GetUIComponent("Text", "authorText")
end

function UIAlbumItem:SetData(cfg, index, isLock, onClick, select, playing, isPause)
  self._cfg = cfg
  self._index = index
  self._isLock = isLock
  self._onClick = onClick
  self._cfgId = cfg.ID
  self.nameText:RefreshText(StringTable.Get(cfg.Name))
  self.authorText:RefreshText(StringTable.Get(cfg.Author))
  self.duration:SetText(UIBgmHelper.FormatTime(cfg.Duration))
  self.select:SetActive(select)
  if playing then
    self.duration.gameObject:SetActive(false)
    self.playing.gameObject:SetActive(true)
    self.play:SetActive(false)
    if isPause then
      self.playing:Stop()
      self._playingState.enabled = true
      self._playingState.normalizedTime = 0
      self.playing:Sample()
      self._playingState.enabled = false
    else
      self.playing:Play()
    end
  else
    self.playing.gameObject:SetActive(false)
    if select then
      self.play:SetActive(true)
      self.duration.gameObject:SetActive(false)
    else
      self.play:SetActive(false)
      self.duration.gameObject:SetActive(true)
    end
  end
  self.lock:SetActive(isLock)
  if isLock then
    self._nameText.color = self._color.valid
    self._authorText.color = self._color.inValid
  else
    self._nameText.color = self._color.valid
    self._authorText.color = self._color.valid
  end
end

function UIAlbumItem:itemOnClick(go)
  if self._isLock then
    ToastManager.ShowToast(StringTable.Get(self._cfg.UnLockDes))
  else
    self._onClick(self._index)
  end
end
