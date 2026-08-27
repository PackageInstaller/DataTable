local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINBuildLogicLvRowItem = class("UINBuildLogicLvRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase

function UINBuildLogicLvRowItem:OnInit()
  base.OnInit(self)
end

function UINBuildLogicLvRowItem:InitBuildLogicLvRowItem(level, logicList, customLogicList, isCurLevel)
  self.attrPool:HideAll()
  local attrItem = self.attrPool:GetOne()
  attrItem:InitAttrItem(tostring(level), isCurLevel)
  for k, v in ipairs(logicList) do
    local attrItem = self.attrPool:GetOne()
    local curValue = v.curValue
    if v.logicId == eLogicType.BuildingCustomInfo then
      curValue = v.currentInfo
    end
    attrItem:InitAttrItem(curValue, isCurLevel)
  end
  for k, v in ipairs(customLogicList) do
    local attrItem = self.attrPool:GetOne()
    attrItem:InitAttrItem(v, isCurLevel)
  end
end

function UINBuildLogicLvRowItem:OnDelete()
  base.OnDelete(self)
end

return UINBuildLogicLvRowItem
