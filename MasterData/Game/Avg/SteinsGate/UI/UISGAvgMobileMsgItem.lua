local base = UIBaseNode
local UISGAvgMobileMsgItem = class("UISGAvgMobileMsgItem", base)

function UISGAvgMobileMsgItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UISGAvgMobileMsgItem:InitSGAvgMobileMsgItem(testStr, imgIdx)
  self.ui.tex_Info.text = testStr
  self.ui.img_Icon:SetIndex(imgIdx)
end

function UISGAvgMobileMsgItem:OnDelete()
  base.OnDelete(self)
end

return UISGAvgMobileMsgItem
