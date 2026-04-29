_class("UIN28ErrandMapLine", UICustomWidget)
UIN28ErrandMapLine = UIN28ErrandMapLine

function UIN28ErrandMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._go = self:GetGameObject()
  self._go:SetActive(false)
end

function UIN28ErrandMapLine:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
end

function UIN28ErrandMapLine:Flush(from, to, yieldTime)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._go:SetActive(true)
  end)
end
