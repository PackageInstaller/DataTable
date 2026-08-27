local UIDormSortKindItem = class("UIDormSortKindItem", UIBaseNode)
local base = UIBaseNode
local eSortKindType, eSortKindTypeMax = table.unpack(require("Game.Dorm.UI.SortList.DormSortKindHelper"))

function UIDormSortKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.kind_Item, self, self.OnBtnKindClicked)
  self.ui.kind_Item:SetActive(false)
end

function UIDormSortKindItem:InitDormSortKindItem(type, index, onClickAction)
  self.index = index
  self.type = type
  self.onClickAction = onClickAction
  self:OnItemSelect(false)
  self.ui.tex_Condition:SetIndex(type + index - 1)
  if type == eSortKindType.Star then
    self.ui.img_Pic.sprite = CRH:GetSprite("star_" .. tostring(index), CommonAtlasType.CareerCamp)
  else
    self.ui.img_Pic.gameObject:SetActive(false)
  end
end

function UIDormSortKindItem:OnBtnKindClicked()
  self:OnItemSelect(not self.isSelect)
  if self.onClickAction ~= nil then
    self.onClickAction(self)
  end
end

function UIDormSortKindItem:OnItemSelect(active)
  self.isSelect = active
  self.ui.img_Kind.color = active and self.ui.kind_highlight or Color.white
end

function UIDormSortKindItem:OnDelete()
  base.OnDelete(self)
end

return UIDormSortKindItem
