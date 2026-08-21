_class("UIActiveTaskAwardItemInfo", UICustomWidget)
UIActiveTaskAwardItemInfo = UIActiveTaskAwardItemInfo

function UIActiveTaskAwardItemInfo:OnShow()
  self:_GetComponent()
end

function UIActiveTaskAwardItemInfo:OnHide()
end

function UIActiveTaskAwardItemInfo:_GetComponent()
  self._info = self:GetUIComponent("UILocalizationText", "ItemInfo")
  self._rect = self:GetUIComponent("RectTransform", "gameObj")
  self._gameObj = self:GetGameObject("gameObj")
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._rect.pivot = Vector2(0.85, 1)
  self._rect.sizeDelta = Vector2(480, 0)
end

function UIActiveTaskAwardItemInfo:SetData(txt, pos)
  self._info:SetText(txt)
  self._gameObj.transform.position = pos
end

function UIActiveTaskAwardItemInfo:SetActive(isActive)
  self._gameObj:SetActive(isActive)
end
