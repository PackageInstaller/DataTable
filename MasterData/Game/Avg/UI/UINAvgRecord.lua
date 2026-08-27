local UINAvgRecord = class("UINAvgRecord", UIBaseNode)
local base = UIBaseNode
local UINAvgRecordItem = require("Game.Avg.UI.UINAvgRecordItem")

function UINAvgRecord:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function UINAvgRecord:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buttom, self, self.OnClickBtnButtom)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.recordItemGoDic = {}
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
  self:Hide()
end

function UINAvgRecord:ShowAcgRecord(recordDataList)
  if recordDataList == nil then
    return
  end
  self:Show()
  self.recordDataList = recordDataList
  self.ui.scrollRect.totalCount = #self.recordDataList
  self.ui.scrollRect:RefreshCells()
  self.ui.scrollRect:RefillCellsFromEnd()
  self.ui.scrollRect:SrollToCell(#self.recordDataList - 1, 1000)
end

function UINAvgRecord:OnClickBtnButtom()
  self.avgSystem:OnAvgRecordClose()
  self:Hide()
end

function UINAvgRecord:__OnNewItem(go)
  local item = UINAvgRecordItem.New()
  item:Init(go)
  self.recordItemGoDic[go] = item
end

function UINAvgRecord:__OnChangeItem(go, index)
  self.scrollRectIndex = index
  local item = self.recordItemGoDic[go]
  if item == nil then
    self.avgCtrl:AvgLogError("Can't find item by gameObject")
    return
  end
  local recordData = self.recordDataList[index + 1]
  if recordData == nil then
    self.avgCtrl:AvgLogError("Can't find recordData by index, index = " .. tonumber(index))
    return
  end
  local isLast = index + 1 == #self.recordDataList
  item:InitAvgRecordItem(self.avgSystem, recordData, isLast)
end

function UINAvgRecord:OnDelete()
  base.OnDelete(self)
end

return UINAvgRecord
