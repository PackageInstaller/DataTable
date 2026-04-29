_class("UICN20MatPathItem", UICustomWidget)
UICN20MatPathItem = UICN20MatPathItem

function UICN20MatPathItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20MatPathItem:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.high = self:GetUIComponent("Image", "high")
  self.high.gameObject:SetActive(false)
  self.rootRect = self:GetUIComponent("RectTransform", "Root")
  self.rootObj = self:GetGameObject("Root")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UICN20MatPathItem:SetData(pos, angle, data, width)
  self.pos = pos
  self.angle = angle
  self.data = data
  self.width = width
  self.rootRect.anchoredPosition = pos
  self.rootObj.transform.eulerAngles = Vector3(0, 0, angle)
  local heigh = self.rootRect.sizeDelta.y
  self.rootRect.sizeDelta = Vector2(width, heigh)
  self._anim:Play("uieff_UICN20MatPathItem_dark")
end

function UICN20MatPathItem:GetPathLinkData()
  return self.data
end

function UICN20MatPathItem:SetHigh(high)
  if not self.high.gameObject.activeSelf then
    self._anim:Play("uieff_UICN20MatPathItem_unlock_in")
  end
  self.high.gameObject:SetActive(high)
end

function UICN20MatPathItem:SetItemActive(active)
  self.rootObj:SetActive(active)
end
