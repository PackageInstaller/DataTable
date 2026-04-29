_class("UIN26HardLevelBtn", UICustomWidget)
UIN26HardLevelBtn = UIN26HardLevelBtn

function UIN26HardLevelBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN26HardLevelBtn:InitWidget()
  self.select = self:GetUIComponent("Image", "select")
  self.unSelect = self:GetUIComponent("Image", "unSelect")
  self.locker = self:GetUIComponent("Image", "locker")
  self.logName = self:GetUIComponent("UILocalizationText", "logName")
  self.rootRt = self:GetUIComponent("RectTransform", "rootRt")
  self.levelBtn = self:GetUIComponent("Button", "rootRt")
end

function UIN26HardLevelBtn:SetData(atlas, logName, clickCallback)
  self.atlas = atlas
  self.clickCallback = clickCallback
  local btnSpriteName, maskSpriteName, lockSpriteName, multiLangaugeName
  if logName == 1 then
    btnSpriteName = "n26_kng_btn01"
    maskSpriteName = "n26_kng_mask01"
    lockSpriteName = "n26_kng_lock01"
    multiLangaugeName = "str_n26_hard_level_btn01"
  else
    btnSpriteName = "n26_kng_btn02"
    maskSpriteName = "n26_kng_mask02"
    lockSpriteName = "n26_kng_lock02"
    multiLangaugeName = "str_n26_hard_level_btn02"
  end
  self.select.sprite = atlas:GetSprite(btnSpriteName)
  self.unSelect.sprite = atlas:GetSprite(maskSpriteName)
  self.locker.sprite = atlas:GetSprite(lockSpriteName)
  self.logName:SetText(StringTable.Get(multiLangaugeName))
  self:SetLockVisible(false)
end

function UIN26HardLevelBtn:SetLockVisible(bVisible)
  if self.locker then
    self.locker.gameObject:SetActive(bVisible)
  end
  self.isLock = bVisible
end

function UIN26HardLevelBtn:SetSelect(bSelect, localPosition)
  self.unSelect.gameObject:SetActive(not bSelect)
  if localPosition then
    self.rootRt.localPosition = localPosition
  end
  self.levelBtn.interactable = not bSelect
end

function UIN26HardLevelBtn:LevelBtnOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
end
