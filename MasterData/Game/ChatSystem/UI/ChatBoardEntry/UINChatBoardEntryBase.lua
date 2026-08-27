local UINChatBoardEntryBase = class("UINChatBoardEntryBase", UIBaseNode)
local base = UIBaseNode

function UINChatBoardEntryBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Entry, self, self.OnClickEntry)
  UIUtil.AddButtonListener(self.ui.btn_EntryImage, self, self.OnClickEntryImage)
end

function UINChatBoardEntryBase:SetRecycleCallback(callback)
  self.recycleCallback = callback
end

function UINChatBoardEntryBase:OnClickEntry()
end

function UINChatBoardEntryBase:OnClickEntryImage()
end

function UINChatBoardEntryBase:OnRecycleEntryItem()
  if self.recycleCallback ~= nil then
    self.recycleCallback(self)
  end
end

function UINChatBoardEntryBase:RefreshChatEntryRedDot()
end

return UINChatBoardEntryBase
