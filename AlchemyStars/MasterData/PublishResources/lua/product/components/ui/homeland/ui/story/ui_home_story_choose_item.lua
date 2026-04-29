_class("UIHomeStoryChooseItem", UICustomWidget)
UIHomeStoryChooseItem = UIHomeStoryChooseItem

function UIHomeStoryChooseItem:OnShow(uiParams)
  self._text = self:GetUIComponent("UILocalizationText", "text")
  self._contentSizeFitter = self:GetUIComponent("ContentSizeFitter", "layout")
  self._layoutRt = self:GetUIComponent("RectTransform", "layout")
  self._typeGo = self:GetGameObject("typeGo")
  self._go = self:GetGameObject()
  self._new = self:GetGameObject("New")
  self._layoutHorz = self:GetUIComponent("HorizontalLayoutGroup", "layout")
  self._chatIcon = self:GetUIComponent("RawImageLoader", "chatIcon")
  self._chatIconImg = self:GetUIComponent("RawImage", "chatIcon")
  self:ShowChatIcon(false, nil)
end

function UIHomeStoryChooseItem:Active(active)
  self._go:SetActive(active)
end

function UIHomeStoryChooseItem:SetData(idx, txt, callback, type, leftCount, rightCount, PetFishClue)
  self._idx = idx
  self._leftCount = leftCount
  self._rightCount = rightCount
  self._PetFishClue = PetFishClue
  self._callback = callback
  self._text:SetText(txt)
  local showType = false
  if type then
    showType = true
  end
  self._typeGo:SetActive(showType)
  if self._text.preferredWidth > 322 then
    self._contentSizeFitter.enabled = false
    self._layoutRt.sizeDelta = Vector2(322, 100)
    self._text.resizeTextForBestFit = true
    self._text.verticalOverflow = UnityEngine.VerticalWrapMode.Truncate
  else
    self._contentSizeFitter.enabled = true
    self._text.resizeTextForBestFit = false
    self._text.verticalOverflow = UnityEngine.VerticalWrapMode.Overflow
  end
end

function UIHomeStoryChooseItem:SetNewStatus(status)
  self._new:SetActive(status)
end

function UIHomeStoryChooseItem:bgOnClick(go)
  if self._callback then
    self._callback(self._idx, self._leftCount, self._rightCount, self._PetFishClue)
  end
end

function UIHomeStoryChooseItem:ShowChatIcon(inShow, iconName)
  local paddingLeft = 0
  if inShow then
    self._chatIcon:LoadImage(iconName)
    paddingLeft = 0
  else
    paddingLeft = 0
  end
  local padding = self._layoutHorz.padding
  padding.left = paddingLeft
  self._layoutHorz.padding = padding
  self._chatIconImg.gameObject:SetActive(inShow)
end
