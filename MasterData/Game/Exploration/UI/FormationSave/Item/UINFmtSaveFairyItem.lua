local base = UIBaseNode
local UINFmtSaveFairyItem = class("UINFmtSaveFairyItem", base)
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")

function UINFmtSaveFairyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.fairyHeadItem)
end

function UINFmtSaveFairyItem:InitFmtSaveFairyItem(dynFairyData, resloader)
  if dynFairyData then
    self.fairyHead:InitFairyHeadItem(dynFairyData, resloader)
    self.fairyHead:Show()
  else
    self.fairyHead:Hide()
  end
end

function UINFmtSaveFairyItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtSaveFairyItem
