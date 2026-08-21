_class("UIN13BuildPlotListItemReview", UICustomWidget)
UIN13BuildPlotListItemReview = UIN13BuildPlotListItemReview

function UIN13BuildPlotListItemReview:_GetComponents()
  self._selectBg = self:GetGameObject("state_Select_bg")
  self._lockBg = self:GetGameObject("state_Lock_bg")
  self._desc = self:GetUIComponent("UILocalizationText", "descTex")
  self._conditionTex = self:GetUIComponent("UILocalizationText", "condition")
  self._rollingText = self:GetUIComponent("RollingText", "condition")
  self._tips = self:GetGameObject("tips")
end

function UIN13BuildPlotListItemReview:OnShow(uiParams)
  self:_GetComponents()
end

function UIN13BuildPlotListItemReview:OnHide(stamp)
end

function UIN13BuildPlotListItemReview:SetData(idx, select, lock, title, condition, callback)
  self._idx = idx
  self._callback = callback
  self._selectBg:SetActive(select)
  self._lockBg:SetActive(lock)
  self._desc:SetText(title)
  if condition == "none" then
    self._tips:SetActive(false)
  else
    self._conditionTex:SetText(condition)
    if not string.isnullorempty(condition) then
      self._rollingText:RefreshText(nil)
    end
  end
end

function UIN13BuildPlotListItemReview:DragOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
