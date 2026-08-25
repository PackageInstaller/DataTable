local TrinketFilterController = NewClass("TrinketFilterController", BaseController)

function TrinketFilterController:OpenTrinkFilterView(filterModel, position, callabck)
  if not UIManager.Instance:GetWindow(Urls.TrinketFilterView) then
    UIManager.Instance:Reopen(Urls.TrinketFilterView, filterModel, position, callabck)
  end
end

function TrinketFilterController:OpenCommonFilterView(position, curType, sortTypeList, selectedFunc)
  if not UIManager.Instance:GetWindow(Urls.BagCommonFilterListView) then
    UIManager.Instance:Reopen(Urls.BagCommonFilterListView, position, curType, sortTypeList, selectedFunc)
  end
end

return TrinketFilterController
