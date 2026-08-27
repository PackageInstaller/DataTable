local UINEpChipSuitItem = class("UINEpChipSuitItem", UIBaseNode)
local SuitGridSize = 16

function UINEpChipSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnBtnSuitSelect)
end

function UINEpChipSuitItem:InitEpChipSuitItem(chipsuit, clickEvent)
  self.__chipSuit = chipsuit
  self.__clickEvent = clickEvent
  self.ui.img_Icon.sprite = chipsuit:GetChipSuitIconSprite()
  self.ui.tex_Count:SetIndex(0, tostring(chipsuit:GetChipSuitCount()), tostring(chipsuit:GetChipSuitMaxCount()))
  local sizeDelta = self.ui.img_MaxCount.sizeDelta
  sizeDelta.x = chipsuit:GetChipSuitMaxCount() * SuitGridSize
  self.ui.img_MaxCount.sizeDelta = sizeDelta
  sizeDelta = self.ui.img_Count.sizeDelta
  sizeDelta.x = chipsuit:GetChipSuitCount() * SuitGridSize
  self.ui.img_Count.sizeDelta = sizeDelta
end

function UINEpChipSuitItem:GetDynChipSuit()
  return self.__chipSuit
end

function UINEpChipSuitItem:OnBtnSuitSelect()
  if self.__clickEvent ~= nil then
    self.__clickEvent(self)
  end
end

return UINEpChipSuitItem
