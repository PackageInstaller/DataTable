local base = UIBaseNode
local UINMlstSheetBandList = class("UINMlstSheetBandList", base)
local UINmlstShetBandListItem = require("Game.MileStone.UI.Sheet.BandList.ListItem.UINMlstShetBandListItem")

function UINMlstSheetBandList:ctor(sheetRoot)
  self._sheetRoot = sheetRoot
end

function UINMlstSheetBandList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._bandItemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._showStageRewardFunc = BindCallback(self, self._ShowStageReward)
  self._OnClickPickAllFunc = BindCallback(self, self._OnClickPickAll)
  self._OnPickTaskFunc = BindCallback(self, self._OnPickTask)
  self.ui.layoutGroup.childControlHeight = true
  self._OnTaskUpdateFunc = BindCallback(self, self._OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  self._OnTaskRemoveFunc = BindCallback(self, self._OnTaskRemove)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
end

function UINMlstSheetBandList:InitMlstSheetBandList(msData)
  self:Show()
  self.msData = msData
  self._bandHideTaskDic = {}
  self:_UpdList(true)
  self:_PlayInitTween()
end

function UINMlstSheetBandList:_UpdList(refill)
  self:_UpdData()
  self:_RefillScrollRect(refill)
  self._updTimer = nil
end

function UINMlstSheetBandList:_UpdData()
  self._bandDataList = {}
  local bandDataDic = self.msData:GetMilestoneBandDataDic()
  for k, v in pairs(bandDataDic) do
    table.insert(self._bandDataList, v)
  end
  self:_SortBandList()
end

function UINMlstSheetBandList:_SortBandList()
  self._bandDataTaskStateDic = {}
  table.sort(self._bandDataList, function(a, b)
    local canPickStageRewardA = a:CanPickMlstBandStageReward()
    local canPickStageRewardB = b:CanPickMlstBandStageReward()
    if canPickStageRewardA ~= canPickStageRewardB then
      return canPickStageRewardA
    end
    local canPickRewardA, completeAllA = self:_GetBandDataTaskState(a)
    local canPickRewardB, completeAllB = self:_GetBandDataTaskState(b)
    if canPickRewardA ~= canPickRewardB then
      return canPickRewardA
    end
    if completeAllA ~= completeAllB then
      return completeAllB
    end
    return a:GetMlstBandId() < b:GetMlstBandId()
  end)
  self._bandDataTaskStateDic = nil
end

function UINMlstSheetBandList:_GetBandDataTaskState(bandData)
  local state = self._bandDataTaskStateDic[bandData]
  if state == nil then
    local canPickRewardNum, completeAll = bandData:GetMlstBandCurTaskStateNum()
    state = {
      canPickReward = 0 < canPickRewardNum,
      completeAll = completeAll
    }
    self._bandDataTaskStateDic[bandData] = state
  end
  return state.canPickReward, state.completeAll
end

function UINMlstSheetBandList:_RefillScrollRect(refill)
  self.ui.scrollRect.totalCount = #self._bandDataList
  if refill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINMlstSheetBandList:__OnNewItem(go)
  local item = UINmlstShetBandListItem.New()
  item:Init(go)
  item:SetMlstShetBandListItemHideTaskDic(self._bandHideTaskDic)
  item:SetMlstShetBandListItemFunc(self._showStageRewardFunc, self._OnClickPickAllFunc, self._OnPickTaskFunc)
  self._bandItemDic[go] = item
end

function UINMlstSheetBandList:__OnChangeItem(go, index)
  local item = self._bandItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local bandData = self._bandDataList[index + 1]
  if bandData == nil then
    error("Can't find bandData by index, index = " .. tonumber(index))
  end
  item:InitNmlstShetBandListItem(bandData)
end

function UINMlstSheetBandList:_OnTaskUpdate(taskData, isNewTask)
  self:_LateUpdList()
end

function UINMlstSheetBandList:_OnTaskRemove(taskId)
  self:_LateUpdList()
end

function UINMlstSheetBandList:OnMsBandDataUpdate()
  self:_LateUpdList()
end

function UINMlstSheetBandList:_PlayInitTween()
  for index, _ in ipairs(self._bandDataList) do
    local obj = self.ui.scrollRect:GetCellByIndex(index - 1)
    local banItem = self._bandItemDic[obj]
    if banItem == nil then
      return
    end
    banItem:PlayInitTween(index - 1)
  end
end

function UINMlstSheetBandList:_LateUpdList()
  if not self.active then
    return
  end
  if self._updTimer == nil then
    self._updTimer = TimerManager:StartTimer(1, self._UpdList, self, true, true)
  end
end

function UINMlstSheetBandList:_ShowStageReward(bandData)
  self._sheetRoot:ShowMilstBandStageReward(bandData)
end

function UINMlstSheetBandList:_OnClickPickAll(taskIdDic)
  self._sheetRoot:PickMlstTaskDicReward(taskIdDic)
end

function UINMlstSheetBandList:_OnPickTask(taskData)
  self._sheetRoot:PickMlstTaskReward(taskData)
end

function UINMlstSheetBandList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
  for k, v in pairs(self._bandItemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINMlstSheetBandList
