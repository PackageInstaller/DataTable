local base = UIBaseNode
local UINShareChannelBtn = class("UINShareChannelBtn", base)

function UINShareChannelBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINShareChannelBtn:InitShareChannelBtn(shareChannelId, clickFunc)
  self._shareChannelId = shareChannelId
  self._clickFunc = clickFunc
  self.ui.img_Icon:SetIndex(shareChannelId)
end

function UINShareChannelBtn:_OnClickRoot()
  if self._clickFunc ~= nil then
    self._clickFunc(self._shareChannelId)
  end
end

function UINShareChannelBtn:OnDelete()
  base.OnDelete(self)
end

return UINShareChannelBtn
