local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINMonsterLevelPreviewItem = class("UINMonsterLevelPreviewItem", base)

function UINMonsterLevelPreviewItem:OnInit()
  base.OnInit(self)
end

function UINMonsterLevelPreviewItem:InitMonsterLevelPreviewRowItem(level, isCurLevel, logicList)
  self.attrPool:HideAll()
  for k, v in ipairs(logicList) do
    local attrItem = self.attrPool:GetOne()
    attrItem:InitAttrItem(v, isCurLevel)
  end
end

function UINMonsterLevelPreviewItem:OnDelete()
  base.OnDelete(self)
end

return UINMonsterLevelPreviewItem
