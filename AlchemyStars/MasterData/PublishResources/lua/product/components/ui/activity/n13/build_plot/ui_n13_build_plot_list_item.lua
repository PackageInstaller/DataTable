_class("UIN13BuildPlotListItem", UICustomWidget)
UIN13BuildPlotListItem = UIN13BuildPlotListItem

function UIN13BuildPlotListItem:_GetComponents()
  self._selectBg = self:GetGameObject("state_Select_bg")
  self._lockBg = self:GetGameObject("state_Lock_bg")
  self._desc = self:GetUIComponent("UILocalizationText", "descTex")
  self._conditionTex = self:GetUIComponent("UILocalizationText", "condition")
  self._rollingText = self:GetUIComponent("RollingText", "condition")
end

function UIN13BuildPlotListItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN13BuildPlotListItem:OnHide(stamp)
end

function UIN13BuildPlotListItem:SetData(idx, select, lock, title, condition, callback)
  self._idx = idx
  self._callback = callback
  self._selectBg:SetActive(select)
  self._lockBg:SetActive(lock)
  self._desc:SetText(title)
  self._conditionTex:SetText(condition)
  if not string.isnullorempty(condition) then
    self._rollingText:RefreshText(nil)
  end
end

function UIN13BuildPlotListItem:dragOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
