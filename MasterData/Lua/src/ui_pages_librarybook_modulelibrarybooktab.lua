local this = class("moduleLibraryBookTab", G_UIModuleBase)

function this.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/libraryBook/cellLibraryTabItem"
    }
  }
end

function this.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        self._callback(id)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function this:setData(idList, callback, selectId)
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
      isFirst = i == 1,
      callback = function(cell)
        self:onCellClick(cell)
      end
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self.bind.selectTab = idList[selectId or 1]
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function this:onCellClick(cell)
  if cell.bind.id == nil then
    return
  end
  if self._callback then
    self._callback(cell)
  end
end

function this:setSelected(id)
  for i, v in pairs(self.modules.list_tab) do
    local cell = v
    cell:setSelected(id == v.bind.id)
  end
end

return this
