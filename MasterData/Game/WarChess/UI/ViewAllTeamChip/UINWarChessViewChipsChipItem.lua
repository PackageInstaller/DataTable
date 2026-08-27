local UINWarChessViewChipsChipItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UINWarChessViewChipsChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_chipItem, self, self.__OnClickItem)
end

function UINWarChessViewChipsChipItem:InitWCViewChipChipItem(chipData, onClickFunc)
  self.chipData = chipData
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(self.chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self.onClickFunc = onClickFunc
  self:SetSelectUI(false)
  self:Show()
end

function UINWarChessViewChipsChipItem:__OnClickItem()
  if self.onClickFunc ~= nil then
    self.onClickFunc(self.chipData)
  end
  self:SetSelectUI(true)
end

function UINWarChessViewChipsChipItem:SetSelectUI(isSelect)
  self.isSelect = isSelect
  self.ui.obj_OnSelect:SetActive(isSelect)
end

function UINWarChessViewChipsChipItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
    self.baseEpChipItem = nil
  end
  base.OnDelete(self)
end

return UINWarChessViewChipsChipItem
