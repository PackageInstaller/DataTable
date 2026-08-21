_class("UISailingSelectorItem", UICustomWidget)
UISailingSelectorItem = UISailingSelectorItem

function UISailingSelectorItem:Constructor()
  self._luaIndex = 1
  self._cfg = nil
  self._cfgState = {
    [0] = {
      bkImage = "n22_dhh_zjm_M0",
      shadowGray = "",
      stateLock = "n22_dhh_zjm_M1_lock"
    },
    [1] = {
      bkImage = "n22_dhh_zjm_M1",
      shadowGray = "n22_dhh_zjm_M1_shad",
      stateLock = "n22_dhh_zjm_M1_lock"
    },
    [2] = {
      bkImage = "n22_dhh_zjm_M2",
      shadowGray = "n22_dhh_zjm_M2_shad",
      stateLock = "n22_dhh_zjm_M2_lock"
    }
  }
end

function UISailingSelectorItem:OnShow()
  self._bkImage = self:GetUIComponent("Image", "bkImage")
  self._redChapter = self:View():GetUIComponent("UISelectObjectPath", "redChapter")
  self._txtChapterValue = UISailingImageNumber:New(self, "n22_dhh_num1_%d")
  self._txtChapterValue:AddDigitImage(self:GetUIComponent("Image", "txtChapterValue0"))
  self._txtChapterValue:AddDigitImage(self:GetUIComponent("Image", "txtChapterValue1"))
  self._txtChapterValue:AddDigitImage(self:GetUIComponent("Image", "txtChapterValue2"))
  self._txtChapterValue:AddDigitImage(self:GetUIComponent("Image", "txtChapterValue3"))
  self._shadowGray = self:GetUIComponent("Image", "shadowGray")
  self._stateLock = self:GetUIComponent("Image", "stateLock")
end

function UISailingSelectorItem:OnHide()
end

function UISailingSelectorItem:Init(luaIndex, cfg)
  self._luaIndex = luaIndex
  self._cfg = cfg
  self._txtChapterValue:SetValue(self._luaIndex)
  self:SetBackGround(0)
  self:SetLocked(false, 0)
end

function UISailingSelectorItem:GetChapterCfg()
  return self._cfg
end

function UISailingSelectorItem:SetBackGround(cfgIndex)
  local atlasProperty = self:RootUIOwner():GetAtlasSailing()
  self._bkImage.sprite = atlasProperty:GetSprite(self._cfgState[cfgIndex].bkImage)
end

function UISailingSelectorItem:SetShadow(isShadow, cfgIndex)
  if self._shadowGray.gameObject.activeSelf ~= isShadow then
    self._shadowGray.gameObject:SetActive(isShadow)
  end
  if isShadow then
    local atlasProperty = self:RootUIOwner():GetAtlasSailing()
    self._shadowGray.sprite = atlasProperty:GetSprite(self._cfgState[cfgIndex].shadowGray)
  end
end

function UISailingSelectorItem:SetLocked(isLocked, cfgIndex)
  if self._stateLock.gameObject.activeSelf ~= isLocked then
    self._stateLock.gameObject:SetActive(isLocked)
  end
  if isLocked then
    local atlasProperty = self:RootUIOwner():GetAtlasSailing()
    self._stateLock.sprite = atlasProperty:GetSprite(self._cfgState[cfgIndex].stateLock)
  end
end

function UISailingSelectorItem:SetRedDot(showRedDot)
  if self._redChapter.gameObject.activeSelf ~= showRedDot then
    self._redChapter.gameObject:SetActive(showRedDot)
  end
  if showRedDot then
    self._redChapter:SpawnOneObject("ManualLoad0")
  end
end
