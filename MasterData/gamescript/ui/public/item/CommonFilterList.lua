local CommonFilterList, Super = System.NewComponent("CommonFilterList")

function CommonFilterList:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Filter_ListResource(uiNode)
  self.sortTypeList = data.sortTypeList
  self.selectedFunc = data.selectedFunc
  self.callback = data.callback
end

function CommonFilterList:OnBind(binder)
  self.binder = binder
  binder:BindToCircularListView(self.ui.ScrollView_List, function()
    return self.sortTypeList
  end, function(itemBinder, obj, index)
    local sortTypeData = self.sortTypeList[index]
    local sortType = sortTypeData.type
    local sortTypeName = sortTypeData.name
    local itemData = {
      tid = sortType or index,
      name = sortTypeName,
      selectedFunc = self.selectedFunc,
      callback = self.callback
    }
    itemBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
end

return CommonFilterList
