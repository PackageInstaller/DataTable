_class("UISeasonOnceMissionControllerLink", UICustomWidget)
UISeasonOnceMissionControllerLink = UISeasonOnceMissionControllerLink

function UISeasonOnceMissionControllerLink:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonOnceMissionControllerLink:InitWidget()
  self._t_b_lineGo = self:GetGameObject("t_b_line")
  self._b_t_lineGo = self:GetGameObject("b_t_line")
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UISeasonOnceMissionControllerLink:SetData(from, to)
  self._rect.anchoredPosition = from
  local top2Bottom = from.y > to.y
  self._t_b_lineGo:SetActive(top2Bottom)
  self._b_t_lineGo:SetActive(not top2Bottom)
end
