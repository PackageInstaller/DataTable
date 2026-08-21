_class("UISeasonBackpackLine", UICustomWidget)
UISeasonBackpackLine = UISeasonBackpackLine

function UISeasonBackpackLine:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBackpackLine:InitWidget()
  self._line1 = self:GetGameObject("Line1")
  self._line2 = self:GetGameObject("Line2")
end

function UISeasonBackpackLine:SetData(index)
  self._index = index
  local show = self._index % 2 == 1
  self._line1:SetActive(show)
  self._line2:SetActive(not show)
end
