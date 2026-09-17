local module = class("moduleAchieveTabList", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "pages/activityTask/cellPageActivityTaskToggleItem"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self.firstInit == true then
        self.firstInit = false
        return
      end
      if self._callback then
        self._callback(id)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:setData(idList, callback, selectId)
  self.firstInit = true
  self.bind.list_tab:clear()
  self._callback = callback
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, value in ipairs(idList) do
    table.insert(dataList, {
      id = value.index,
      comTabID = value.comTabID,
      txt_eng = value.txt_eng
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self.bind.selectTab = selectId
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

return module
