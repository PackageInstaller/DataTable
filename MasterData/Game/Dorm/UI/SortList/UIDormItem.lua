local UIDormItem = class("UIDormItem", UIBaseNode)

function UIDormItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btnItem, self, self.OnItemClick)
end

function UIDormItem:InitDormItem(dormItemData, onClickActon)
  self.dormItemData = dormItemData
  self.__onClickActon = onClickActon
  self:__InitUI(dormItemData)
end

function UIDormItem:__InitUI(dormItemData)
end

function UIDormItem:OnItemClick()
  if self.__onClickActon ~= nil then
    self.__onClickActon(self.dormItemData)
  end
end

function UIDormItem:OnDelete()
end

return UIDormItem
