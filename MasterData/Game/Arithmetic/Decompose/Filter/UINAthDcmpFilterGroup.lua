local UINAthDcmpFilterGroup = class("UINAthDcmpFilterGroup", UIBaseNode)
local base = UIBaseNode
local AthDcmpFilterUtil = require("Game.Arithmetic.Decompose.Filter.AthDcmpFilterUtil")

function UINAthDcmpFilterGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

local updItemFuncDic = {
  [AthDcmpFilterUtil.FilterGroupType.Basic] = function(self, item, scrollData)
  end,
  [AthDcmpFilterUtil.FilterGroupType.Title] = function(self, item, scrollData)
    local isSelectBasic = self.isSelectBasicFunc()
    item:InitAthDcmpFilterDynamicTitleGroup(scrollData, isSelectBasic)
  end,
  [AthDcmpFilterUtil.FilterGroupType.Dynamic] = function(self, item, scrollData)
    item:InitAthDcmpFilterDynamicGroup(scrollData)
  end
}

function UINAthDcmpFilterGroup:SetAthDcmpFilterGroupFunc(getItemFunc, recycleItemFunc, isSelectBasicFunc)
  self.getItemFunc = getItemFunc
  self.recycleItemFunc = recycleItemFunc
  self.isSelectBasicFunc = isSelectBasicFunc
end

function UINAthDcmpFilterGroup:InitAthDcmpFilterGroup(scrollData)
  if self.scrollData == nil or self.scrollData.groupType ~= scrollData.groupType then
    if self.scrollData ~= nil and self.groupItem ~= nil then
      self:RecycleAthDcmpFilterGroup()
    end
    self.groupItem = self.getItemFunc(scrollData)
  end
  local updItemFunc = updItemFuncDic[scrollData.groupType]
  if updItemFunc == nil then
    error("Cant get updItemFunc, groupType = " .. tostring(scrollData.groupType))
  else
    updItemFunc(self, self.groupItem, scrollData)
  end
  self.scrollData = scrollData
  self.groupItem.transform:SetParent(self.transform)
  self.groupItem.transform.anchoredPosition = Vector2.zero
  self.ui.layoutElement.minHeight = self.groupItem.transform.rect.height
end

function UINAthDcmpFilterGroup:RecycleAthDcmpFilterGroup()
  if self.scrollData == nil or self.groupItem == nil or self.groupItem.transform.parent ~= self.transform then
    return
  end
  self.recycleItemFunc(self.scrollData, self.groupItem)
  self.scrollData = nil
  self.groupItem = nil
end

function UINAthDcmpFilterGroup:OnDelete()
  base.OnDelete(self)
end

return UINAthDcmpFilterGroup
