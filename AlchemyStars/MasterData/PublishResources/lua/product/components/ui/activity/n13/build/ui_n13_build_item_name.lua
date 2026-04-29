_class("UIN13BuildItemName", UICustomWidget)
UIN13BuildItemName = UIN13BuildItemName

function UIN13BuildItemName:OnShow()
  self._go = self:GetGameObject("Go")
  self._maskPanel = self:GetUIComponent("RectTransform", "Mask")
  self._txtDebug = self:GetUIComponent("UILocalizationText", "_txtDebug")
end

function UIN13BuildItemName:SetData(buildManager, buildItemId, btnCallback, ReviewType)
  self._buildManager = buildManager
  self._buildItemId = buildItemId
  self._btnCallback = btnCallback
  if ReviewType then
    self._reviewType = ReviewType
  else
    self._reviewType = nil
  end
  local show = self:CanShowBtn()
  self._go:SetActive(show)
  if not show then
    return
  end
  self:_SetPos(buildItemId)
  self:_SetBtn(buildItemId)
  self:_SetScore(buildItemId)
end

function UIN13BuildItemName:CanShowBtn()
  return self._buildManager:IsShow(self._buildItemId) and self:_CanBuild()
end

function UIN13BuildItemName:_CanBuild()
  return not self._buildManager:IsAllStatusComplete(self._buildItemId) and self._buildManager:IsNextStatusUnlock(self._buildItemId)
end

function UIN13BuildItemName:_SetPos(buildItemId)
  self._go.transform.anchoredPosition = self._buildManager:GetWidgetPos(buildItemId)
  self._maskPanel.anchoredPosition = self._buildManager:GetWidgetDesPos(buildItemId)
end

function UIN13BuildItemName:_SetBtn(buildItemId)
  local status = self._buildManager:GetBuildCurStatus(buildItemId)
  local str = UIActivityN13Helper.GetStrByStatus_Operator(status, self._buildManager:GetName(buildItemId))
  local show = self:_CanBuild() and not string.isnullorempty(str)
  self._go:SetActive(show)
  if not string.isnullorempty(str) then
    self._txtDebug:SetText(str)
  end
end

function UIN13BuildItemName:_SetScore(buildItemId)
  local url = UIActivityN13Helper.GetCoinItemIconName(self._reviewType)
  local count = self._buildManager:GetCostCount(buildItemId) or 0
  self:_SetRawImage("_icon", url)
  self:_SetText("_cost", count)
  self:_SetText("_cost2", count)
  local itemCount = UIActivityN13Helper.GetCoinItemCount(self._reviewType)
  local idx = count <= itemCount and 1 or 2
  local tb = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_cost"},
    {"_cost2"}
  })
  UIWidgetHelper.SetObjGroupShow(tb, idx)
end

function UIN13BuildItemName:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIN13BuildItemName:_SetText(widgetName, txt)
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(txt)
end

function UIN13BuildItemName:BtnOnClick()
  if not self:_CanBuild() then
    return
  end
  if self._btnCallback then
    self._btnCallback()
  end
end
