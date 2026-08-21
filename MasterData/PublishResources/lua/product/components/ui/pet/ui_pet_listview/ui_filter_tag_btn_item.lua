_class("UIFilterTagBtnItem", UICustomWidget)

function UIFilterTagBtnItem:Constructor()
  self._selected = false
  self._tagData = nil
  self._clickCallback = nil
end

function UIFilterTagBtnItem:OnShow(uiParams)
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
end

function UIFilterTagBtnItem:SetData(itemDataInfo, clickCallback)
  self._tagData = itemDataInfo
  self._clickCallback = clickCallback
  self._icon = self:GetUIComponent("Image", "Image")
  self._text = self:GetUIComponent("Text", "Text")
  self._text:SetText(StringTable.Get(itemDataInfo.Name))
  self._chooseImage = self:GetUIComponent("Image", "chooseImage")
  self._chooseImageGo = self:GetGameObject("chooseImage")
  self._uiItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  if self._tagData.tagType == 1 then
    self._selected = self._petModule.uiModule:ContainTagFilterType(itemDataInfo.tagID)
  elseif self._tagData.tagType == 2 then
    self._selected = self._petModule.uiModule:ContainSecondTagFilterType(itemDataInfo.tagID)
  end
  self:RefreshShow()
end

function UIFilterTagBtnItem:RefreshShow()
  if self._selected == true then
    self._chooseImageGo:SetActive(true)
    self._chooseImage.sprite = self._uiItemAtlas:GetSprite("spirit_gou1_icon")
    self._icon.sprite = self._uiItemAtlas:GetSprite("spirit_zhezhao4_frame")
  else
    self._chooseImageGo:SetActive(false)
    self._icon.sprite = self._uiItemAtlas:GetSprite("spirit_zhezhao3_frame")
  end
end

function UIFilterTagBtnItem:itemBtnOnClick(go)
  self._selected = not self._selected
  self:RefreshShow()
  if self._clickCallback then
    self._clickCallback(self._tagData.tagID)
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
end
