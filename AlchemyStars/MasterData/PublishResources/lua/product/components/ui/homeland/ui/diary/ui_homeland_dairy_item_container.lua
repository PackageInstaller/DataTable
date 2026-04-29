_class("UIHomeLandDiaryItemContainer", UICustomWidget)
UIHomeLandDiaryItemContainer = UIHomeLandDiaryItemContainer

function UIHomeLandDiaryItemContainer:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomeLandDiaryItemContainer:_InitWidget()
end

function UIHomeLandDiaryItemContainer:OnShow(uiParams)
end

function UIHomeLandDiaryItemContainer:OnHide()
end

function UIHomeLandDiaryItemContainer:InitData(data)
  self._data = data
  self._itemCount = #data
  self._itemStaticCount = 3
  self:Refresh()
end

function UIHomeLandDiaryItemContainer:Refresh()
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", "layout")
  cellPool:SpawnObjects("UIHomeLandDiaryItemContainer", self._itemStaticCount)
  local rowList = cellPool:GetAllSpawnList()
  local index = 0
  for i = 1, self._itemStaticCount do
    local itemWidget = #rowList
    if itemWidget then
      local itemIndex = index + 1
      itemWidget:InitData(self._data[itemIndex])
      if itemIndex > self._itemCount then
        itemWidget:GetGameObject():SetActive(false)
      end
    end
  end
end

function UIHomeLandDiaryItemContainer:_SpawnObject(className, widgetName)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIHomeLandDiaryItemContainer:_AttachEvents()
end

function UIHomeLandDiaryItemContainer:_DetachEvents()
end
