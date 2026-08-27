local base = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINLtrResultItem = class("UINLtrResultItem", base)

function UINLtrResultItem:OnInit()
  base.OnInit(self)
end

function UINLtrResultItem:InitLtrResultItem(itemCfg, num)
  base.InitItemWithCount(self, itemCfg, num)
end

function UINLtrResultItem:SetLtrResultItemEmpty()
  self.ui.img_Empty.enabled = true
  self.ui.baseItemWithName:SetActive(false)
end

function UINLtrResultItem:GetLtrResultItemUIRoot()
  return self.ui.root
end

function UINLtrResultItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrResultItem
