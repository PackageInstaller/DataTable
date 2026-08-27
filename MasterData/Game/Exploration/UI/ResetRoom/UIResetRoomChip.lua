local UIResetRoomChip = class("UIResetRoomChip", UIBaseNode)
local base = UIBaseNode
local UINChipItemWithName = require("Game.CommonUI.Item.UINChipItemWithName")

function UIResetRoomChip:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnButtonClick)
  self.ChipItem = UINChipItemWithName.New()
  self.ChipItem:Init(self.ui.chipItem)
  self.ui.onSelect:SetActive(false)
end

function UIResetRoomChip:InitChipItem(chipData, chipCount, clickAction)
  self.chipData = chipData
  self.dataId = chipData.dataId
  self.count = chipData:GetCount()
  self.clickAction = clickAction
  self.selectCount = 0
  self.ChipItem:InitChipItem(chipData, chipCount, nil)
  self.ChipItem:UpdateChipItem()
  self.ui.onSelect.transform:SetAsLastSibling()
  self.ui.btn_Item.enabled = true
  self:UpdateCountUI(0)
end

function UIResetRoomChip:UpdateCountUI(selectCount)
  if 0 < selectCount then
    self:OnSelectUI(true)
    self.ui.tex_ChipCount.gameObject:SetActive(true)
    self.ui.tex_ChipCount.text = tostring(selectCount)
    self.selectCount = selectCount + 1
  else
    self:OnSelectUI(false)
  end
end

function UIResetRoomChip:OnSelectUI(active)
  self.ui.onSelect:SetActive(active)
  self.ui.tex_ChipCount.gameObject:SetActive(not active)
end

function UIResetRoomChip:CanSelect()
  return self.selectCount <= self.count
end

function UIResetRoomChip:OnButtonClick()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UIResetRoomChip:OnDelete()
  base.OnDelete(self)
end

return UIResetRoomChip
