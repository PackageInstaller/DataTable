local module = class("moduleNewCommonTabList", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "modulePages/tabList/cellNewCommonTabItem"
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

function module:setData(idList, callback, selectIndex, redKeys, skipFirstCallback, IslimitList)
  self.bind.list_tab:clear()
  self._callback = nil
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, id in ipairs(idList) do
    table.insert(dataList, {
      id = id,
      isLast = i == #idList,
      redKey = redKeys and redKeys[i],
      Islimit = IslimitList[i]
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self._suppressFirstCallback = skipFirstCallback and true or false
  self.bind.selectTab = idList[selectIndex or 1]
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:refreshLimitInfo(IslimitList)
  local index = 1
  for i, limit in ipairs(IslimitList) do
    self.modules.list_tab[index]:refreshLimit(limit)
    index = index + 1
  end
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

function module:open()
end

return module
