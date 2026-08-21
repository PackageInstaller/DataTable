_class("UIN13BuildGotoBtn", UICustomWidget)
UIN13BuildGotoBtn = UIN13BuildGotoBtn

function UIN13BuildGotoBtn:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN13BuildGotoBtn:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIN13BuildGotoBtn:_SetText(widgetName, txt)
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(txt)
end

function UIN13BuildGotoBtn:OnShow()
end

function UIN13BuildGotoBtn:SetData(type, manager, id, btnCallback, reviewType)
  self.reviewType = reviewType
  self._btnCallback = btnCallback
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"Name"},
    {"Pet"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  if type == 1 then
    self:_SetScore(manager, id)
  end
end

function UIN13BuildGotoBtn:_SetScore(buildManager, buildItemId)
  local url = UIActivityN13Helper.GetCoinItemIconName(self.reviewType)
  local count = buildManager:GetCostCount(buildItemId) or 0
  self:_SetRawImage("_icon", url)
  self:_SetText("_cost", count)
  self:_SetText("_cost2", count)
  local itemCount = UIActivityN13Helper.GetCoinItemCount(self.reviewType)
  local idx = count <= itemCount and 1 or 2
  local tb = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_cost"},
    {"_cost2"}
  })
  UIWidgetHelper.SetObjGroupShow(tb, idx)
end

function UIN13BuildGotoBtn:NameBtnOnClick()
  if self._btnCallback then
    self._btnCallback()
  end
end

function UIN13BuildGotoBtn:PetBtnOnClick()
  if self._btnCallback then
    self._btnCallback()
  end
end
