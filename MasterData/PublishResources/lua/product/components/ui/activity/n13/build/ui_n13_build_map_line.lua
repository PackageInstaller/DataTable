_class("UIN13BuildMapLine", UICustomWidget)
UIN13BuildMapLine = UIN13BuildMapLine

function UIN13BuildMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN13BuildMapLine:OnHide()
end

function UIN13BuildMapLine:SetData(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end

function UIN13BuildMapLine:SetDebugText(txt)
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
  local obj = self:GetUIComponent("UILocalizationText", "_debug")
  obj:SetText(txt)
end
