local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINEpRSLevelRowItem = class("UINEpRSLevelRowItem", base)

function UINEpRSLevelRowItem:OnInit()
  base.OnInit(self)
end

function UINEpRSLevelRowItem:InitEpRSLevelRowItem(level, isCurLevel, logicList)
  self.attrPool:HideAll()
  for k, v in ipairs(logicList) do
    local attrItem = self.attrPool:GetOne()
    attrItem:InitAttrItem(v, isCurLevel)
  end
end

function UINEpRSLevelRowItem:OnDelete()
  base.OnDelete(self)
end

return UINEpRSLevelRowItem
