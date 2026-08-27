local UINSelectChipSuitItem = class("UINSelectChipSuitItem", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitItem")

function UINSelectChipSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.suitItemBase = UINEpChipSuitItem.New()
  self.suitItemBase:Init(self.ui.uINChipSuitItem)
  self._onSelectChipItemClick = BindCallback(self, self._OnSelectChipItemClick)
end

function UINSelectChipSuitItem:InitSelectChipSuitItem(dynChipSuitData, clickCallback)
  self._ClickCallback = clickCallback
  if dynChipSuitData == nil then
    self.suitItemBase:Hide()
    self.ui.obj_Empty:SetActive(true)
  else
    self.ui.obj_Empty:SetActive(false)
    self.suitItemBase:InitEpChipSuitItem(dynChipSuitData, self._onSelectChipItemClick)
    self.suitItemBase:Show()
  end
end

function UINSelectChipSuitItem:GetEmptyTransform()
  return self.ui.obj_Empty.transform
end

function UINSelectChipSuitItem:GetSelectChipSuitIcon()
  return self.suitItemBase.ui.img_Icon
end

function UINSelectChipSuitItem:_OnSelectChipItemClick()
  if self._ClickCallback ~= nil then
    self._ClickCallback(self.suitItemBase:GetDynChipSuit())
  end
end

function UINSelectChipSuitItem:OnDelete()
  self.suitItemBase:Delete()
  base.OnDelete(self)
end

return UINSelectChipSuitItem
