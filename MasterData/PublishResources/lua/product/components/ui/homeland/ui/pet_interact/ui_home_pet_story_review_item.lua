_class("UIHomePetStoryReviewItem", UICustomWidget)
UIHomePetStoryReviewItem = UIHomePetStoryReviewItem

function UIHomePetStoryReviewItem:OnShow(uiParams)
  self._pet = self:GetGameObject("pet")
  self._player = self:GetGameObject("player")
  self._name1 = self:GetUIComponent("UILocalizationText", "name1")
  self._content1 = self:GetUIComponent("UIRichText", "content1")
  self._icon1 = self:GetUIComponent("RawImageLoader", "icon1")
  self._iconGo1 = self:GetGameObject("iconGo1")
  self._name2 = self:GetUIComponent("UILocalizationText", "name2")
  self._content2 = self:GetUIComponent("UIRichText", "content2")
  self._icon2 = self:GetUIComponent("RawImageLoader", "icon2")
  self._iconGo2 = self:GetGameObject("iconGo2")
  self._xian = self:GetGameObject("xian")
  self._go = self:GetGameObject()
  self._layout = self:GetUIComponent("RectTransform", "UIHomePetStoryReviewItem")
end

function UIHomePetStoryReviewItem:SetData(data, showLine, callback)
  self._data = data
  self._callback = callback
  local name = self._data[1]
  local content = self._data[2]
  local icon = self._data[4]
  local isPlayer = self._data[3]
  self._pet:SetActive(false)
  self._player:SetActive(false)
  local nameTex, contentTex, iconImg, iconGo
  if not isPlayer then
    nameTex = self._name1
    contentTex = self._content1
    iconImg = self._icon1
    iconGo = self._iconGo1
    self._pet:SetActive(true)
  else
    nameTex = self._name2
    contentTex = self._content2
    iconImg = self._icon2
    iconGo = self._iconGo2
    self._player:SetActive(true)
  end
  nameTex:SetText(name)
  contentTex:SetText(content)
  if icon then
    iconGo:SetActive(true)
    iconImg:LoadImage(icon)
  else
    iconGo:SetActive(false)
  end
  local show = true
  if not showLine then
    show = false
  end
  self._xian:SetActive(show)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._layout)
end

function UIHomePetStoryReviewItem:Active(active)
  self._go:SetActive(active)
end

function UIHomePetStoryReviewItem:BgOnClick(go)
  if self._callback then
    self._callback()
  end
end
