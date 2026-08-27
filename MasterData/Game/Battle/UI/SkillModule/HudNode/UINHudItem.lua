local UINHudItem = class("UINHudItem", UIBaseNode)
local base = UIBaseNode
local UINHudTextItem = require("Game.Battle.UI.SkillModule.HudNode.UINHudTextItem")

function UINHudItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.hUDTextItem:SetActive(false)
  self.textItemPool = UIItemPool.New(UINHudTextItem, self.ui.hUDTextItem)
  for i = 1, self.ui.itemCount do
    local textItem = self.textItemPool:GetOne()
    textItem.transform:SetAsFirstSibling()
  end
end

function UINHudItem:RefreshHudItem(startNum)
  for k, textItem in ipairs(self.textItemPool.listItem) do
    local num = startNum + (k - 1) * 5
    textItem:RefreshHudTextItem(num)
  end
end

function UINHudItem:OnDelete()
  base.OnDelete(self)
  self.textItemPool:DeleteAll()
  self.textItemPool = nil
end

return UINHudItem
