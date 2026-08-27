local UINSignInMiniGameDayItem = class("UINSignInMiniGameDayItem", UIBaseNode)
local base = UIBaseNode

function UINSignInMiniGameDayItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSignInMiniGameDayItem:InitVaildItem(day)
  if 9 < day then
    self.ui.tex_Date.text = tostring(day)
  else
    self.ui.tex_Date.text = "0" .. tostring(day)
  end
end

function UINSignInMiniGameDayItem:ChangeSignFlag(signEnum)
  self.ui.obj_signFlag:SetActive(signEnum == 1)
  self.ui.tex_Date.color = self.ui.color_sign[signEnum]
end

function UINSignInMiniGameDayItem:OnDelete()
  base.OnDelete(self)
end

return UINSignInMiniGameDayItem
