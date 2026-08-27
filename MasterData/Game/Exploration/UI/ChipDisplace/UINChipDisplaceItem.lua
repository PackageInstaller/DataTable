local UINChipDisplaceItem = class("UINChipDisplaceItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UINChipDisplaceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_chipItem, self, self.OnClickItem)
end

function UINChipDisplaceItem:InitItem(idx, chipData, onClickEvent)
  self.idx = idx
  self.chipData = chipData
  self.onClickEvent = onClickEvent
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self.ui.tex_ChipLevel:SetIndex(0, tostring(self.chipData:GetCount()))
  self.ui.img_ChipTypeIcon.sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
end

function UINChipDisplaceItem:OnClickItem()
  if self.onClickEvent ~= nil then
    self.onClickEvent(self.idx)
  end
end

function UINChipDisplaceItem:SetItemSelectState(isAllDisplace, isSelect)
  local active = isAllDisplace and true or false
  self.ui.img_OnSelect:SetActive(active)
  local alpha = (isAllDisplace or isSelect) and 1 or 0.5
  self.ui.fade.alpha = alpha
end

function UINChipDisplaceItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
  end
  base.OnDelete(self)
end

return UINChipDisplaceItem
