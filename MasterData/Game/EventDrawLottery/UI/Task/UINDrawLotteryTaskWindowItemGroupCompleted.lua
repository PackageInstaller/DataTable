local UINDrawLotteryTaskWindowItemGroupCompleted = class("UINDrawLotteryTaskWindowItemGroupCompleted", UIBaseNode)
local UINDrawLotteryTaskWindowItem = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskWindowItem")
local base = UIBaseNode

function UINDrawLotteryTaskWindowItemGroupCompleted:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.taskItemDic = {}
end

function UINDrawLotteryTaskWindowItemGroupCompleted:InitDrawLotteryTaskWindowItemGroupCompleted(actData)
  self.actData = actData
  self.groupNum = self.actData:GetDrawLotteryGroupNum()
  self:RefreshTaskItemIsCompleted()
end

function UINDrawLotteryTaskWindowItemGroupCompleted:RefreshTaskItemIsCompleted()
  self.dataList = {}
  for i = 1, self.groupNum do
    local dataList = self.actData:GetAllCompleteTaskDataList(i)
    for _, data in ipairs(dataList) do
      table.insert(self.dataList, data)
    end
  end
  self.ui.loop_scroll.totalCount = #self.dataList
  self.ui.loop_scroll:RefillCells()
end

function UINDrawLotteryTaskWindowItemGroupCompleted:__OnNewItem(go)
  local taskWindowItem = UINDrawLotteryTaskWindowItem.New()
  taskWindowItem:Init(go)
  self.taskItemDic[go] = taskWindowItem
end

function UINDrawLotteryTaskWindowItemGroupCompleted:__OnChangeItem(go, index)
  local taskItem = self.taskItemDic[go]
  if taskItem == nil then
    error("Can't find taskItem by gameObject")
    return
  end
  local data = self.dataList[index + 1]
  local stageId = self.actData:GetStageIdByTaskData(data)
  taskItem:InitDrawLotteryTaskItem(self.actData, data, stageId)
end

function UINDrawLotteryTaskWindowItemGroupCompleted:OnDelete()
  for i, item in pairs(self.taskItemDic) do
    item:Delete()
  end
  self.taskItemDic = nil
  base.OnDelete(self)
end

return UINDrawLotteryTaskWindowItemGroupCompleted
