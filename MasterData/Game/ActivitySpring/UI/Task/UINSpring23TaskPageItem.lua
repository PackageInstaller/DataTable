local base = require("Game.ActivityChristmas.UI.Task.UINChristmasTaskPageItem")
local UINSpring23TaskPageItem = class("UINSpring23TaskPageItem", base)

function UINSpring23TaskPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.pageItem, self, self.OnClickSelect)
end

function UINSpring23TaskPageItem:InitChristmasTaskPageItem(titleType, callback)
  self._titleType = titleType
  self._callback = callback
  self.ui.tex_Task:SetIndex(titleType - 1)
  self.ui.img_Title:SetIndex(titleType - 1)
end

function UINSpring23TaskPageItem:InitChristmasTaskPageItemParam2(titleType, imgType, callback)
  self._titleType = titleType
  self._callback = callback
  self.ui.tex_Task:SetIndex(titleType - 1)
  self.ui.img_Title:SetIndex(imgType - 1)
end

function UINSpring23TaskPageItem:SetChristmasTaskPageSelectFlag(flag)
  local textColor = self.ui.color_texSelected ~= nil and self.ui.color_texSelected or Color.New(1, 1, 1, 1)
  self.ui.tex_Task.text.color = flag and textColor or self.ui.color_texUnSelected
  self.ui.img_Title.image.color = flag and textColor or self.ui.color_texUnSelected
  self.ui.img_root.color = flag and self.ui.color_selected or self.ui.color_unselected
  self.ui.img_pageItem:SetIndex(flag and 0 or 1)
end

return UINSpring23TaskPageItem
