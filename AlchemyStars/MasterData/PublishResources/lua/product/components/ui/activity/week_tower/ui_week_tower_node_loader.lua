_class("UIWeekTowerNodeLoader", UICustomWidget)
UIWeekTowerNodeLoader = UIWeekTowerNodeLoader

function UIWeekTowerNodeLoader:OnShow(uiParams)
end

function UIWeekTowerNodeLoader:SetData(index, missionCount, data, callback, width, open)
  self:DisposeCustomWidgets()
  local pool = self:GetUIComponent("UISelectObjectPath", "pool")
  pool.dynamicInfoOfEngine:SetObjectName(data:GetWidgetName() .. ".prefab")
  self._widget = pool:SpawnObject("UIWeekTowerNodeItem")
  self._widget:SetData(index, missionCount, data, callback, width, open)
end

function UIWeekTowerNodeLoader:Active(active)
  self:GetGameObject():SetActive(active)
end

function UIWeekTowerNodeLoader:Open()
  self._widget:Open()
end
