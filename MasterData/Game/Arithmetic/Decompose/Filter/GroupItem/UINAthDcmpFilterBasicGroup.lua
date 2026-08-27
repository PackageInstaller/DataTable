local UINAthDcmpFilterBasicGroup = class("UINAthDcmpFilterBasicGroup", UIBaseNode)
local base = UIBaseNode
local UINAthDcmpFilterItem = require("Game.Arithmetic.Decompose.Filter.GroupItem.UINAthDcmpFilterItem")
local AthDcmpFilterUtil = require("Game.Arithmetic.Decompose.Filter.AthDcmpFilterUtil")

function UINAthDcmpFilterBasicGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.areaItemPool = UIItemPool.New(UINAthDcmpFilterItem, self.ui.areaItem, false)
  self.qualityItemPool = UIItemPool.New(UINAthDcmpFilterItem, self.ui.qualityItem, false)
  self.sizeItemPool = UIItemPool.New(UINAthDcmpFilterItem, self.ui.sizeItem, false)
  self._OnItemValueChangeFunc = BindCallback(self, self._OnItemValueChange)
  for k, v in ipairs(AthDcmpFilterUtil.FilterBaseValue[AthDcmpFilterUtil.FilterType.Area]) do
    self.areaItemPool:GetOne():InitAthDcmpFilterItem(AthDcmpFilterUtil.FilterType.Area, v, self._OnItemValueChangeFunc, false)
  end
  for k, v in ipairs(AthDcmpFilterUtil.FilterBaseValue[AthDcmpFilterUtil.FilterType.Quality]) do
    self.qualityItemPool:GetOne():InitAthDcmpFilterItem(AthDcmpFilterUtil.FilterType.Quality, v, self._OnItemValueChangeFunc, false)
  end
  for k, v in ipairs(AthDcmpFilterUtil.FilterBaseValue[AthDcmpFilterUtil.FilterType.Size]) do
    self.sizeItemPool:GetOne():InitAthDcmpFilterItem(AthDcmpFilterUtil.FilterType.Size, v, self._OnItemValueChangeFunc, false)
  end
end

function UINAthDcmpFilterBasicGroup:ResetAthDcmpFilterBasicGroup()
  for k, v in ipairs(self.areaItemPool.listItem) do
    v:SetAthDcmpFilterItemIsOn(false, true)
  end
  for k, v in ipairs(self.qualityItemPool.listItem) do
    v:SetAthDcmpFilterItemIsOn(false, true)
  end
  for k, v in ipairs(self.sizeItemPool.listItem) do
    v:SetAthDcmpFilterItemIsOn(false, true)
  end
end

function UINAthDcmpFilterBasicGroup:InitAthDcmpFilterBasicGroup(itemValueChangeFunc)
  self.itemValueChangeFunc = itemValueChangeFunc
end

function UINAthDcmpFilterBasicGroup:_OnItemValueChange(filterType, filterValue, isOn)
  if self.itemValueChangeFunc ~= nil then
    self.itemValueChangeFunc(filterType, filterValue, isOn)
  end
end

function UINAthDcmpFilterBasicGroup:OnDelete()
  self.areaItemPool:DeleteAll()
  self.qualityItemPool:DeleteAll()
  self.sizeItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthDcmpFilterBasicGroup
