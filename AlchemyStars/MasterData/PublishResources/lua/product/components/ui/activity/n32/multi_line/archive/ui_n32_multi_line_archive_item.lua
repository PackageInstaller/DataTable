_class("UIN32MultiLineArchiveItem", UICustomWidget)
UIN32MultiLineArchiveItem = UIN32MultiLineArchiveItem

function UIN32MultiLineArchiveItem:OnShow(uiParams)
  self:InitComponent()
end

function UIN32MultiLineArchiveItem:InitComponent()
  self._spreadContent = false
  self._state = 1
  self._text = self:GetUIComponent("UILocalizationText", "text")
  self._locktext = self:GetUIComponent("UILocalizationText", "locktext")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._atlas = self:GetAsset("UIN32Multiline.spriteatlas", LoadType.SpriteAtlas)
  self._lockGo = self:GetGameObject("icon_lock")
  self._btn = self:GetGameObject("btn")
  self._drag = self:GetGameObject("drag")
  self._contentGo = self:GetGameObject("content")
  self._contentText = self:GetUIComponent("UILocalizationText", "archiveText")
  local etl = UICustomUIEventListener.Get(self._drag)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self:LockOnClick(go)
  end)
end

function UIN32MultiLineArchiveItem:InitUI()
  self._btnImg.sprite = self._atlas:GetSprite("n32_dzm_rwda_di01")
  local titleText = ""
  if self._hadGot then
    titleText = self._info.DocTitle
  end
  self._text:SetText(StringTable.Get(titleText))
  if self._hadPassed then
    titleText = self._info.UnPassTitle
  else
    titleText = "str_n32_multiline_doc_lock"
  end
  if self._hadGot then
    titleText = self._info.DocDesc
  end
  self._contentText:SetText(StringTable.Get(titleText))
  self._lockGo:SetActive(not self._hadGot)
  self._locktext:SetText(StringTable.Get("str_n32_multiline_lock_pet_title"))
  self._btn:SetActive(false)
  self._contentGo:SetActive(true)
end

function UIN32MultiLineArchiveItem:Refresh(index, hadGot, hadPassed, selectIndex)
  if selectIndex ~= self._index then
    self._spreadContent = false
  end
  local img = self._spreadContent and "n32_dzm_rwda_di02" or "n32_dzm_rwda_di01"
  self._btnImg.sprite = self._atlas:GetSprite(img)
  self._hadGot = hadGot
  self._hadPassed = hadPassed
  local titleText = ""
  if self._hadGot then
    titleText = self._info.DocTitle
  end
  self._text:SetText(StringTable.Get(titleText))
  if self._hadPassed then
    titleText = self._info.UnPassTitle
  else
    titleText = "str_n32_multiline_doc_lock"
  end
  if self._hadGot then
    titleText = self._info.DocDesc
  end
  self._contentText:SetText(StringTable.Get(titleText))
  self._locktext:SetText(StringTable.Get("str_n32_multiline_lock_pet_title"))
  self._lockGo:SetActive(not self._hadGot)
  self._btn:SetActive(self._hadPassed)
  self._contentGo:SetActive(true)
end

function UIN32MultiLineArchiveItem:SetData(index, fileId, info, hadGot, hadPassed, callBack)
  self._index = index
  self._fileId = fileId
  self._info = info[1]
  self._hadGot = hadGot
  self._hadPassed = hadPassed
  self._callBack = callBack
  self:InitUI()
end

function UIN32MultiLineArchiveItem:BtnOnClick(go)
  self._spreadContent = not self._spreadContent
  if self._callBack then
    self._callBack(self._index, self._fileId, self._spreadContent)
  end
end

function UIN32MultiLineArchiveItem:LockOnClick(go)
  if self._hadPassed and self._hadGot then
    return
  end
  if self._hadPassed then
    ToastManager.ShowToast(StringTable.Get("str_n32_multiline_lock_tips2"))
    return
  end
  if not self._hadGot then
    ToastManager.ShowToast(StringTable.Get("str_n32_multiline_lock_tips1"))
  end
end
