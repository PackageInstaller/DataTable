local base = UIBaseNode
local UINWarChessChipBagItem = class("UINWarChessChipBagItem", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINWarChessChipBagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._chipItem = UINChipItem.New()
  self._chipItem:Init(self.ui.uINChipItem)
  self._onChipBagItemClick = BindCallback(self, self.OnChipBagItemClick)
end

function UINWarChessChipBagItem:InitWCChipBagItem(chipData, onClickEvent)
  self._onClickEvent = onClickEvent
  self._chipItem:InitChipItem(chipData, true, self._onChipBagItemClick)
  local name = chipData:GetName()
  self.ui.tex_ChipName.text = name
end

function UINWarChessChipBagItem:OnChipBagItemClick()
  if self._onClickEvent ~= nil then
    self._onClickEvent(self, self._chipItem.chipData)
  end
end

function UINWarChessChipBagItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessChipBagItem
