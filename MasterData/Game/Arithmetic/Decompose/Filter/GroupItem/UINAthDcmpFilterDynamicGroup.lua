local UINAthDcmpFilterDynamicGroup = class("UINAthDcmpFilterDynamicGroup", UIBaseNode)
local base = UIBaseNode
local UINAthDcmpFilterItem = require("Game.Arithmetic.Decompose.Filter.GroupItem.UINAthDcmpFilterItem")

function UINAthDcmpFilterDynamicGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.filterItemPool = UIItemPool.New(UINAthDcmpFilterItem, self.ui.item, false)
end

function UINAthDcmpFilterDynamicGroup:SetAthDcmpFilterDynamicGroupFunc(valueChangeFunc)
  self.valueChangeFunc = valueChangeFunc
end

function UINAthDcmpFilterDynamicGroup:InitAthDcmpFilterDynamicGroup(scrollData)
  self.filterItemPool:HideAll()
  local filterType = scrollData.filterType
  for k, filterValue in ipairs(scrollData.filterValueList) do
    local item = self.filterItemPool:GetOne()
    local isSelect = scrollData.isSelectFunc(filterType, filterValue)
    item:InitAthDcmpFilterItem(filterType, filterValue, self.valueChangeFunc, isSelect)
  end
  self.ui.line:SetActive(not scrollData.isLast)
end

function UINAthDcmpFilterDynamicGroup:OnDelete()
  self.filterItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthDcmpFilterDynamicGroup
