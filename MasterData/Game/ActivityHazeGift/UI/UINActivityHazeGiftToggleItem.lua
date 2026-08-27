local UINActivityHazeGiftToggleItem = class("UINActivityHazeGiftToggleItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINActivityHazeGiftToggleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickToggleItem)
end

function UINActivityHazeGiftToggleItem:InitHazeGiftToggleItem(day, des, clickFunc)
  self._dayIndex = day
  self._des = LanguageUtil.GetLocaleText(des)
  self._clickFunc = clickFunc
end

function UINActivityHazeGiftToggleItem:SetToggleItemIsUnlock(isUnlock)
  self._isUnlock = isUnlock
end

function UINActivityHazeGiftToggleItem:SetToggleItemIsSelected(selected)
  self._selected = selected
  self.ui.go_selected:SetActive(selected)
  self.ui.go_notSelected:SetActive(not selected)
  local textIndex = selected and 1 or 0
  self.ui.text_stage:SetIndex(textIndex, self._des)
end

function UINActivityHazeGiftToggleItem:UpdateToggleItemBlueDot(isHave)
  self.ui.BlueDot:SetActive(isHave)
end

function UINActivityHazeGiftToggleItem:UpdateToggleItemRedDot(isHave)
  self.ui.RedDot:SetActive(isHave)
end

function UINActivityHazeGiftToggleItem:OnClickToggleItem()
  if not self._isUnlock then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7914))
    return
  end
  if self._clickFunc ~= nil then
    self._clickFunc(self._dayIndex)
  end
  self:SetToggleItemIsSelected(true)
end

function UINActivityHazeGiftToggleItem:GetItemDayIndex()
  return self._dayIndex
end

function UINActivityHazeGiftToggleItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityHazeGiftToggleItem
