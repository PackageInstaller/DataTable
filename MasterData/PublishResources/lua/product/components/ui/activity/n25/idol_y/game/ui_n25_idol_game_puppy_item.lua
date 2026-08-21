_class("UIN25IdolGamePuppyItem", UICustomWidget)
UIN25IdolGamePuppyItem = UIN25IdolGamePuppyItem

function UIN25IdolGamePuppyItem:SetData(idx, icon, txtMain, txtSub, callback)
  self._idx = idx
  self._callback = callback
  self:_SetName()
  self:_SetIcon(icon)
  self:_SetText(txtMain)
  self:_SetSubText(txtSub)
end

function UIN25IdolGamePuppyItem:PlayAnim()
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolGamePuppy_Item_name_in")
end

function UIN25IdolGamePuppyItem:_SetName()
  local txtName = HelperProxy:GetInstance():ReplacePlayerName("PlayerName")
  UIWidgetHelper.SetLocalizationText(self, "_txtName", txtName)
end

function UIN25IdolGamePuppyItem:_SetIcon(icon)
  UIWidgetHelper.SetRawImage(self, "_icon", icon)
end

function UIN25IdolGamePuppyItem:_SetText(txtMain)
  UIWidgetHelper.SetLocalizationText(self, "_txtMain", StringTable.Get(txtMain))
end

function UIN25IdolGamePuppyItem:_SetSubText(txtSub)
  local enable = txtSub == nil
  if not enable then
    UIWidgetHelper.SetLocalizationText(self, "_txtSub", StringTable.Get(txtSub))
  end
  self:GetGameObject("_txtSub"):SetActive(not enable)
  self:GetGameObject("_mask"):SetActive(not enable)
  self:GetGameObject("Btn"):SetActive(enable)
  self:GetGameObject("DisableBtn"):SetActive(not enable)
end

function UIN25IdolGamePuppyItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._idx, self)
  end
end
