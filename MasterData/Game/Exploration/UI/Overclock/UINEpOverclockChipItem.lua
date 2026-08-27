local UINEpOverclockChipItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UINEpOverclockChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_chipItem, self, self.OnChipItemClick)
end

function UINEpOverclockChipItem:InitOverclockChipItem(index, chipData, clickCallback)
  self.index = index
  self.chipData = chipData
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self.clickCallback = clickCallback
  self:SetUnlockUI(true)
  self:SetSelectUI(false)
  self:Show()
end

function UINEpOverclockChipItem:OnChipItemClick()
  if not self.unlock then
    return
  end
  if self.clickCallback ~= nil then
    self.clickCallback(self)
  end
end

function UINEpOverclockChipItem:SetSelectUI(isSelect)
  self.isSelect = isSelect
  self.ui.obj_OnSelect:SetActive(isSelect)
end

function UINEpOverclockChipItem:SetUnlockUI(isUnlock)
  self.unlock = isUnlock
  self.ui.obj_Lock:SetActive(not isUnlock)
end

function UINEpOverclockChipItem:SetHasUI(isHas)
  self.ui.obj_Has:SetActive(isHas)
end

function UINEpOverclockChipItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
  end
  base.OnDelete(self)
end

return UINEpOverclockChipItem
