local base = UIBaseNode
local UINRfCdDetailChipItem = class("UINRfCdDetailChipItem", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINRfCdDetailChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self._chipItem = UINChipItem.New()
  self._chipItem:Init(self.ui.uINChipItem)
  self._BgColorDefault = self.ui.img_Bg.color
end

function UINRfCdDetailChipItem:InitRfCdDetailChipItem(chipData, clickFunc)
  self._chipData = chipData
  self._clickFunc = clickFunc
  self._chipItem:InitChipItem(chipData, nil, nil, true)
  self.ui.tex_ChipName.text = chipData:GetName()
end

function UINRfCdDetailChipItem:SetRfCdDetailChipItemLock(isLock, unlockStar)
  self.ui.obj_Lock:SetActive(isLock)
  self.ui.tex_Lock:SetIndex(0, tostring(unlockStar))
end

function UINRfCdDetailChipItem:SetSelectedRfCdDetailChipItem(isSelected)
  self.ui.obj_arrow:SetActive(isSelected)
  self.ui.img_Bg.color = isSelected and self.ui.selectedColor or self._BgColorDefault
end

function UINRfCdDetailChipItem:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self._chipData)
  end
end

function UINRfCdDetailChipItem:OnDelete()
  self._chipItem:Delete()
  base.OnDelete(self)
end

return UINRfCdDetailChipItem
