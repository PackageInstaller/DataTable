local UINSignInMiniGameAwardItem = class("UINSignInMiniGameDayItem", UIBaseNode)
local base = UIBaseNode

function UINSignInMiniGameAwardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSignInMiniGameAwardItem:InitItem(index, minAwardNum, maxAwardNum)
  self.ui.tex_Number.color = self.ui.color_Numbers[index]
  self.ui.tex_Number.text = "0" .. tostring(4 - index)
  self.ui.tex_TagName:SetIndex(index - 1)
  self.ui.img_Tag:SetIndex(index - 1)
  self.ui.img_frame.color = self.ui.color_Numbers[index]
  self.ui.tex_Range.text = tostring(minAwardNum) .. "-" .. tostring(maxAwardNum)
end

function UINSignInMiniGameAwardItem:OnDelete()
  base.OnDelete(self)
end

return UINSignInMiniGameAwardItem
