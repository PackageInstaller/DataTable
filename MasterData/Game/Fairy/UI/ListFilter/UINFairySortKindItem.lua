local UINFairySortKindItem = class("UINFairySortKindItem", UIBaseNode)
local base = UIBaseNode
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")

function UINFairySortKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

function UINFairySortKindItem:InitFairySortKindItem(kindType, index, onSelectFunc)
  self.kindType = kindType
  self.index = index
  self.onSelectFunc = onSelectFunc
  self.isStarType = false
  if self.kindType == FairyFilterEnum.eKindType.Rank then
    self.isStarType = true
    self.ui.tex_KindName.text = tostring(index)
  elseif self.kindType == FairyFilterEnum.eKindType.Quality then
    self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(ConfigData.fairy_skill_weight[index].name)
  elseif self.kindType == FairyFilterEnum.eKindType.Type then
    self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(ConfigData.fairy_data[index].name)
  end
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
end

function UINFairySortKindItem:__OnKindItemClick()
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    self.onSelectFunc(self.kindType, self.index, self.select)
  end
end

function UINFairySortKindItem:SetSelectUIActive()
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
  self.ui.img_sortKindItem.color = self.select and self.ui.col_selected or self.ui.col_noSelect
end

function UINFairySortKindItem:SetSelectState(flag)
  self.select = flag
  self:SetSelectUIActive()
end

function UINFairySortKindItem:OnDelete()
  base.OnDelete(self)
end

return UINFairySortKindItem
