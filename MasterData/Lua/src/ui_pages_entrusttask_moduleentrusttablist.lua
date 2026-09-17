local module = class("moduleEntrustTabList", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/entrustTask/cellEntrustTabItem"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        self._callback(id)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:setData(idList, callback, selectId)
  self.bind.list_tab:clear()
  self._callback = callback
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, id in ipairs(idList) do
    table.insert(dataList, {id = id})
  end
  self.bind.list_tab:insert_array(dataList)
  self.bind.selectTab = idList[selectId or 1]
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

return module
