local UINTaskList = class("UINTaskList", UIBaseNode)
local base = UIBaseNode
local UINTaskListItem = require("Game.Task.NewUI.UINTaskListItem")

function UINTaskList:OnInit()
  self.slotItemDic = {}
  self.dataList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.taskListNode.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.taskListNode.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UINTaskList:RefreshTaskItems(TaskDataList, needSort, typeId)
  self.dataList = {}
  self.typeId = typeId
  for index, value in ipairs(TaskDataList) do
    table.insert(self.dataList, value)
  end
  if needSort then
    table.sort(self.dataList, function(a, b)
      local aComplete = a:CheckComplete()
      local bComplete = b:CheckComplete()
      if aComplete ~= bComplete then
        return aComplete
      end
      local aIsPicked = a.isPicked or false
      local bIsPicked = b.isPicked or false
      if aIsPicked ~= bIsPicked then
        return not aIsPicked
      end
      if a.stcData.order ~= b.stcData.order then
        return a.stcData.order < b.stcData.order
      end
      return a.id < b.id
    end)
  end
  local num = #self.dataList
  self.ui.taskListNode.totalCount = num
  self.ui.taskListNode:RefillCells()
end

function UINTaskList:__OnNewItem(go)
  local taskItem = UINTaskListItem.New()
  taskItem:Init(go)
  self.slotItemDic[go] = taskItem
end

function UINTaskList:__OnChangeItem(go, index)
  local taskItem = self.slotItemDic[go]
  if taskItem == nil then
    error("Can't find taskItem by gameObject")
    return
  end
  local taskData = self.dataList[index + 1]
  if taskData == nil then
    error("Can't find taskData by index, index = " .. tonumber(index))
  end
  taskItem.gameObject.name = "taskItem" .. tostring(index)
  taskItem:InitTaskItem(taskData, self.typeId)
end

function UINTaskList:OnDelete()
  base.OnDelete(self)
end

return UINTaskList
