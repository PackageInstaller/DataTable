_class("UISeasonTalentLineMissionLine", UICustomWidget)
UISeasonTalentLineMissionLine = UISeasonTalentLineMissionLine

function UISeasonTalentLineMissionLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UISeasonTalentLineMissionLine:Flush(from, to)
  self:GetGameObject():SetActive(from ~= nil)
  if from == nil then
    return
  end
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
