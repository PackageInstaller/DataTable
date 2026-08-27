local UINChristmasTaskPageItem = class("UINChristmasTaskPageItem", UIBaseNode)
local base = UIBaseNode

function UINChristmasTaskPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.pageItem, self, self.OnClickSelect)
  self._color = self.ui.img_root.color
end

function UINChristmasTaskPageItem:InitChristmasTaskPageItem(titleType, callback)
  self._titleType = titleType
  self._callback = callback
  self.ui.tex_TaskName:SetIndex(titleType - 1)
  self.ui.img_Note:SetIndex(titleType - 1)
  self.ui.tex_Task:SetIndex(titleType - 1)
end

function UINChristmasTaskPageItem:SetChristmasTaskPageSelect(titleType)
  self:SetChristmasTaskPageSelectFlag(self._titleType == titleType)
end

function UINChristmasTaskPageItem:SetChristmasTaskPageSelectFlag(flag)
  self.ui.canvasGroup_root.alpha = flag and 1 or 0.5
end

function UINChristmasTaskPageItem:SetChristmasTaskPageRed(flag)
  self.ui.redDot:SetActive(flag)
end

function UINChristmasTaskPageItem:ShowChristmasTaskPageLine(flag)
  if not IsNull(self.ui.line) then
    self.ui.line:SetActive(flag)
  end
end

function UINChristmasTaskPageItem:OnClickSelect()
  if self._callback ~= nil then
    self._callback(self._titleType, self)
  end
end

return UINChristmasTaskPageItem
