local UIViewChipsItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UIViewChipsItem:OnInit()
  self.OnClickEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_chipItem, self, self.__OnBtnClick)
  self.ui.obj_Lock.transform:SetAsLastSibling()
end

function UIViewChipsItem:InitLevelChipItem(selIdx, chipData, unlock)
  self.selIdx = selIdx
  self.chipData = chipData
  self.id = chipData.dataId
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self:UpdateUnlock(unlock)
  self:Show()
end

function UIViewChipsItem:SetClickEvent(clickEvent)
  self.OnClickEvent = clickEvent
end

function UIViewChipsItem:UpdateUnlock(unlock)
  self.unlock = unlock
  self.ui.obj_Lock:SetActive(not unlock)
end

function UIViewChipsItem:IsUnlock()
  return self.unlock
end

function UIViewChipsItem:GetIndex()
  return self.selIdx
end

function UIViewChipsItem:SetLevelChipItemSelect(selected)
  self.ui.obj_OnSelect:SetActive(selected)
end

function UIViewChipsItem:__OnBtnClick()
  if self.OnClickEvent ~= nil then
    self.OnClickEvent(self)
  end
end

function UIViewChipsItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
    self.baseEpChipItem = nil
  end
  base.OnDelete(self)
end

return UIViewChipsItem
