local this = class("cellScienceTreeGroup", G_UIModuleBase)

function this.bind()
  return {
    listScienceItem = {
      moduleName = "pages/home/homeScience/cellScienceTreeItem"
    },
    listScienceLines = {
      moduleName = "pages/home/homeScience/cellScienceTreeLine"
    }
  }
end

function this.methods()
  return {
    listScienceItem = {
      selectItem = function(self, techTreeId)
        self:emit("selectItem", techTreeId)
      end
    }
  }
end

function this:open()
end

local _startX = 234.7
local _startY = -115
local _spaceX = 467.1
local _spaceY = 135.4

function this:setItemData(itemData)
  self:_setData(self.bind.listScienceItem, itemData)
end

function this:refreshItemData(itemData)
  for i, item in ipairs(self.bind.listScienceItem:getItemCls()) do
    local data = itemData[i]
    item.bind.pendingLevel = nil
    item.bind.shouldLock = nil
    for k, value in pairs(data) do
      item.bind[k] = value
    end
    local localGridX = data.gridX - self.bind.gridX
    item.bind.anchoredPosition = C_Vector2(_startX + localGridX * _spaceX, _startY - (data.gridY - 1) * _spaceY)
    item:refresh()
  end
end

function this:setLineData(lineData)
  self:_setData(self.bind.listScienceLines, lineData)
end

function this:_setData(list, Data)
  list:clear()
  if not Data then
    return
  end
  for i, v in ipairs(Data) do
    local localGridX = v.gridX - self.bind.gridX
    v.anchoredPosition = C_Vector2(_startX + localGridX * _spaceX, _startY - (v.gridY - 1) * _spaceY)
  end
  list:insert_array(Data)
end

function this:selectByParent(techTreeId)
  for _, v in ipairs(self.bind.listScienceItem:getItemCls()) do
    v:onSelect(techTreeId)
  end
end

return this
