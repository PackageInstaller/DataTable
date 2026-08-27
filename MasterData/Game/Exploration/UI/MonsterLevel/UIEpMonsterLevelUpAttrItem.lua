local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UIEpMonsterLevelUpAttrItem = class("UIEpMonsterLevelUpAttrItem", base)

function UIEpMonsterLevelUpAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpMonsterLevelUpAttrItem:InitMonsterLevelPreviewRowItem(index, curValue, nextValue)
  local sign = "+"
  self.ui.tex_Name:SetIndex(index)
  self.ui.tex_LastNum.text = sign .. GetPreciseDecimalStr(curValue / 10, 1) .. "%"
  self.ui.tex_CurNum.text = sign .. GetPreciseDecimalStr(nextValue / 10, 1) .. "%"
end

return UIEpMonsterLevelUpAttrItem
