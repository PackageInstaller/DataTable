_class("UIPetSkinsSelectCell", UICustomWidget)
UIPetSkinsSelectCell = UIPetSkinsSelectCell

function UIPetSkinsSelectCell:Constructor()
  self._data = nil
  self._lastOnTop = true
  self._lastOrderLayer = 0
end

function UIPetSkinsSelectCell:OnShow(uiParams)
  self:InitWidget()
end

function UIPetSkinsSelectCell:SetData(skinCfg, idx, callbcak, begindrag, drag, enddrag)
  self._skinCfg = skinCfg
  self._idx = idx
  self._callback = callbcak
  self._beginDrag = begindrag
  self._drag = drag
  self._endDrag = enddrag
  if self._skinCfg then
    self._petId = self._skinCfg.PetId
    self._petCfg = Cfg.cfg_pet[self._petId]
  end
  if self._lockCoverGo then
    self._lockCoverGo:SetActive(false)
  end
  if self._skinCfg then
    self._clothImg:LoadImage(self._skinCfg.TeamBody)
  end
  if self._flagGo and self._skinCfg then
    self._flagGo:SetActive(self._skinCfg.SkinType == PetSkinFlag.PSF_COLLECTION)
  end
  if self._specialGo and self._skinCfg then
    self._specialGo:SetActive(self._skinCfg.SkinType == 3)
  end
  if self._memoryObj and self._skinCfg then
    self._memoryObj:SetActive(self._skinCfg.SkinType == PetSkinFlag.PSF_MEMORY)
  end
  if self._specialEffGo and self._skinCfg then
    self._specialEffGo:SetActive(self._skinCfg.SkinType == 3)
  end
  if self._wishGo and self._skinCfg then
    self._wishGo:SetActive(self._skinCfg.SkinType == PetSkinFlag.PSF_WISH)
  end
  if self._logoImg and self._petCfg then
    self._logoImg:LoadImage(self._petCfg.Logo)
  end
  self:SetIsOnTop(true)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bgGo), UIEvent.BeginDrag, self._beginDrag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bgGo), UIEvent.Drag, self._drag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bgGo), UIEvent.EndDrag, self._endDrag)
end

function UIPetSkinsSelectCell:InitWidget()
  self._clothImg = self:GetUIComponent("RawImageLoader", "ClothImg")
  self._logoImg = self:GetUIComponent("RawImageLoader", "LogoImg")
  self._lockCover = self:GetUIComponent("Image", "LockCover")
  self._lockCoverGo = self:GetGameObject("LockCover")
  self._blackCoverGo = self:GetGameObject("BlackCoverImg")
  self._grayCoverGo = self:GetGameObject("GrayCoverImg")
  self._funcLayerGo = self:GetGameObject("FuncLayer")
  self._lockLayerGo = self:GetGameObject("LockLayer")
  self._frameImgGo = self:GetGameObject("FrameImg")
  self._curIconGo = self:GetGameObject("CurIcon")
  self._redPoint = self:GetGameObject("redPoint")
  self._flagGo = self:GetGameObject("Flag")
  self._specialGo = self:GetGameObject("Special")
  self._memoryObj = self:GetGameObject("memory")
  self._specialEffGo = self:GetGameObject("SpecialEff")
  self._bgGo = self:GetGameObject("BottomBg")
  self._wishGo = self:GetGameObject("wish")
end

function UIPetSkinsSelectCell:BottomBgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UIPetSkinsSelectCell:RefreshData(uiData)
  self._data = uiData
  self:_RefreshStateUi()
end

function UIPetSkinsSelectCell:_RefreshStateUi()
  if self._data then
    local isShop = self._data:IsShopDetail()
    local isObtained = self._data:IsObtained()
    local cfg = self._data.cfg
    if self._data:IsShopDetail() then
      self._lockCoverGo:SetActive(not isObtained)
    end
    local isShowLock = not isShop and not isObtained
    if self._lockCoverGo then
      self._lockCoverGo:SetActive(isShowLock)
    end
    if self._curIconGo then
      self._curIconGo:SetActive(self._data:IsCurrentSkin())
    end
    if isObtained and cfg.StoryId then
      if self._data:IsUnlockCg() then
        self._redPoint:SetActive(false)
      else
        self._redPoint:SetActive(true)
      end
    else
      self._redPoint:SetActive(false)
    end
  end
end

function UIPetSkinsSelectCell:SetIsOnTop(isOnTop)
  if self._lastOnTop ~= isOnTop then
    self._lastOnTop = isOnTop
  else
    return
  end
  self._lockLayerGo:SetActive(isOnTop)
  self._blackCoverGo:SetActive(isOnTop)
  self._grayCoverGo:SetActive(not isOnTop)
  self._funcLayerGo:SetActive(isOnTop)
  self._frameImgGo:SetActive(isOnTop)
end

function UIPetSkinsSelectCell:SetOrderLayer(orderLayer)
  if self._lastOrderLayer ~= orderLayer then
    self._lastOrderLayer = orderLayer
  else
    return
  end
  local scaleParam = 1 - 0.05 * orderLayer
  self:GetGameObject().transform:DOScale(Vector3(scaleParam, scaleParam, 1), 0.2)
end

function UIPetSkinsSelectCell:RefreshLogo(logoImg)
  self._logoImg:LoadImage(logoImg)
end
