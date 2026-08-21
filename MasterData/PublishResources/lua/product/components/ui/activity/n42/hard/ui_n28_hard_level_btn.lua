_class("UIN28HardLevelBtn", UICustomWidget)
UIN28HardLevelBtn = UIN28HardLevelBtn

function UIN28HardLevelBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN28HardLevelBtn:InitWidget()
  self._bg = self:GetUIComponent("Image", "bg")
  self.select = self:GetUIComponent("Image", "select")
  self.unSelect = self:GetUIComponent("Image", "unSelect")
  self.locker = self:GetUIComponent("Image", "locker")
  self.logName = self:GetUIComponent("UILocalizationText", "logName")
  self.outline = self:GetUIComponent("H3D.UGUI.CircleOutline", "logName")
  self.rootRt = self:GetUIComponent("RectTransform", "rootRt")
  self.levelBtn = self:GetUIComponent("Button", "rootRt")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.timeGo = self:GetGameObject("time")
end

function UIN28HardLevelBtn:SetData(atlas, logName, clickCallback)
  self.atlas = atlas
  self.clickCallback = clickCallback
  local bgSpriteName, btnSpriteName, maskSpriteName, lockSpriteName, multiLangaugeName, text, outline
  if logName == 1 then
    bgSpriteName = "n28_kng_btn02"
    btnSpriteName = "n28_kng_btn04"
    maskSpriteName = "n28_kng_mask02"
    lockSpriteName = "n28_kng_lock01"
    multiLangaugeName = "str_n28_hard_level_btn01"
    text = string.format("<color=#474749>%s</color>", StringTable.Get(multiLangaugeName))
    outline = Color(0.8313725490196079, 0.8352941176470589, 0.796078431372549, 1)
  else
    bgSpriteName = "n28_kng_btn03"
    btnSpriteName = "n28_kng_btn05"
    maskSpriteName = "n28_kng_mask02"
    lockSpriteName = "n28_kng_lock01"
    multiLangaugeName = "str_n28_hard_level_btn02"
    text = string.format("<color=#ffffff>%s</color>", StringTable.Get(multiLangaugeName))
    outline = Color(0.2784313725490196, 0.27450980392156865, 0.25882352941176473, 1)
  end
  self._bg.sprite = atlas:GetSprite(bgSpriteName)
  self.select.sprite = atlas:GetSprite(btnSpriteName)
  self.unSelect.sprite = atlas:GetSprite(maskSpriteName)
  self.locker.sprite = atlas:GetSprite(lockSpriteName)
  self.logName:SetText(text)
  self.outline.effectColor = outline
  self:SetLockVisible(false)
end

function UIN28HardLevelBtn:SetTime(state, str)
  self.timeGo:SetActive(state)
  self.time:SetText(str)
end

function UIN28HardLevelBtn:SetLockVisible(bVisible)
  if self.locker then
    self.locker.gameObject:SetActive(bVisible)
  end
  self.isLock = bVisible
end

function UIN28HardLevelBtn:SetSelect(bSelect, localPosition)
  self.unSelect.gameObject:SetActive(not bSelect)
  if localPosition then
    self.rootRt.localPosition = localPosition
  end
  self.levelBtn.interactable = not bSelect
end

function UIN28HardLevelBtn:LevelBtnOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
end
