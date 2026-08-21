_class("UISeasonMusicCollectionCell", UICustomWidget)
UISeasonMusicCollectionCell = UISeasonMusicCollectionCell

function UISeasonMusicCollectionCell:Constructor()
end

function UISeasonMusicCollectionCell:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMusicCollectionCell:InitWidget()
  self.new = self:GetGameObject("new")
  self.txtLock = self:GetUIComponent("UILocalizationText", "txtLock")
  self.lock = self:GetGameObject("lock")
  self.unlock = self:GetGameObject("unlock")
  self.imgMusic = self:GetUIComponent("RawImageLoader", "imgMusic")
  self.txtMusicName = self:GetUIComponent("UILocalizationText", "txtMusicName")
  self.txtAuthorName = self:GetUIComponent("UILocalizationText", "txtAuthorName")
  self.playingObj = self:GetGameObject("playingObj")
  self.pauseObj = self:GetGameObject("pauseObj")
end

function UISeasonMusicCollectionCell:SetData(cfg, index, playingIndex, pauseIndex, clickCb)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self.idx = index
  self.clickCb = clickCb
  self._cfg = cfg
  self._isPlaying = playingIndex == index
  self._isPause = pauseIndex == index
  self.isUnlock = not self._roleModule:UI_CheckMusicLock(cfg)
  self.lock:SetActive(not self.isUnlock)
  self.unlock:SetActive(self.isUnlock)
  self.txtMusicName:SetText(StringTable.Get(cfg.Name))
  self.txtAuthorName:SetText(StringTable.Get(cfg.Author))
  self.imgMusic:LoadImage(cfg.Icon)
  if not self.unlock then
    self.txtLock:SetText(StringTable.Get(cfg.UnLockDes))
    self.new:SetActive(false)
  else
    self:_RefreshNew()
  end
  self:RefreshPlayUI()
end

function UISeasonMusicCollectionCell:ItemBtnOnClick(go)
  if self.unlock then
    UISeasonExploreHelper.SetMusicAsClicked(self._cfg.ID)
    self:_RefreshNew()
  end
  if self.clickCb then
    self.clickCb(self.idx, self.isUnlock)
  end
end

function UISeasonMusicCollectionCell:RefreshPlayUI()
  self.playingObj:SetActive(self._isPlaying)
  self.pauseObj:SetActive(self._isPause)
end

function UISeasonMusicCollectionCell:_RefreshNew()
  local isNew = not UISeasonExploreHelper.IsMusicHasClicked(self._cfg.ID)
  self.new:SetActive(isNew)
end
