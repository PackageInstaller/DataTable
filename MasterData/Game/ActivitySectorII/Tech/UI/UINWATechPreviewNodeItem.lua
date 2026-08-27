local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINWATechPreviewNodeItem = class("UINWATechPreviewNodeItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function UINWATechPreviewNodeItem:OnInit()
  base.OnInit(self)
end

function UINWATechPreviewNodeItem:InitShopItemPriveInterval(isCurLevel, techData, level, maxLevelCount)
  self.attrPool:HideAll()
  local attrItem = self.attrPool:GetOne()
  attrItem:InitAttrItem(tostring(level), isCurLevel)
  local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(level)
  for index, logic in ipairs(logicArray) do
    local para1 = para1Array[index]
    local para2 = para2Array[index]
    local para3 = para3Array[index]
    local _, _, value = CommonLogicUtil.GetDesString(logic, para1, para2, para3, eLogicDesType.ActWinter)
    local attrItem = self.attrPool:GetOne()
    attrItem:InitAttrItem(value, isCurLevel)
  end
  for i = #logicArray + 1, maxLevelCount do
    local attrItem = self.attrPool:GetOne()
    attrItem:InitAttrItem("", isCurLevel)
  end
end

function UINWATechPreviewNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINWATechPreviewNodeItem
