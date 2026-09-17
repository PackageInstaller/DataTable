local module = class("moduleCommonTabListHorizontalWithWords", G_UIModuleBase)

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "modulePages/tabList/cellCommonTabItemHor"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        self._callback(id)
      end
    end
  }
end

function module:setData(idList, callback, selectId, redKeys)
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
      show = i ~= #idList
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  self.bind.selectTab = idList[selectId or 1]
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
end

function module:refreshRedPoint(bRedPoint)
  for key, value in pairs(self.modules.list_tab) do
    if key == 2 then
      value:refreshRedPoint(bRedPoint)
    end
  end
end

function module:open()
end

function module:close()
  self._callback = nil
end

return module
