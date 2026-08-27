local UINHeroAttributeNode = class("UINHeroAttributeNode", UIBaseNode)
local base = UIBaseNode
local UINHeroAttrItem = require("Game.Formation.UI.Common.UINHeroAttrItem")

function UINHeroAttributeNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.attriItem:SetActive(false)
  self.attrPool = UIItemPool.New(UINHeroAttrItem, self.ui.attriItem)
end

function UINHeroAttributeNode:InitHeroAttrNode(attrDataList, overriodColor)
  self.attrPool:HideAll()
  for k, v in ipairs(attrDataList) do
    local attrItem = self.attrPool:GetOne()
    attrItem:InitHeroAttrItem(v.attrId, v.attrValue, overriodColor)
  end
end

function UINHeroAttributeNode:OnDelete()
  base.OnDelete(self)
end

return UINHeroAttributeNode
