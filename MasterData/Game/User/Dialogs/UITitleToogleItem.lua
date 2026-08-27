local uiToggleItem = require("Game.User.Dialogs.UIToogleItem")
local base = uiToggleItem
local UITitleToogleItem = class("UITitleToogleItem", base)

function UITitleToogleItem:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UITitleToogleItem:OnSwitchValueChange(flag)
  if flag then
    self.ui.tog_smallIcon.color = self.ui.color_Txtselected
  else
    self.ui.tog_smallIcon.color = self.ui.color_TxtUnselect
  end
  base.OnSwitchValueChange(self, flag)
end

function UITitleToogleItem:OnDelete()
  base.OnDelete(self)
end

return UITitleToogleItem
