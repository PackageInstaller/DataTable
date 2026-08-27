local UINChatemojiNode = class("UINChatemojiNode", UIBaseNode)
local base = UIBaseNode

function UINChatemojiNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChatemojiNode:OnDelete()
  base.OnDelete(self)
end

return UINChatemojiNode
