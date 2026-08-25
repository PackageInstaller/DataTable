local PopIconMsgPanel, Super = System.NewClass("PopIconMsgPanel", UIBasePanel)
PopIconMsgPanel.uiResCls = Func_Tips_HorizontalFull_IconResource

function PopIconMsgPanel:ctor(str, icon, durtion, callback)
  Super.ctor(self)
  self.durtion = durtion
  self.callback = callback
  self.text = str
  self.iconPath = icon
end

function PopIconMsgPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindToText(self.ui.Text_Tips, function()
    return self.text
  end)
  if self.iconPath then
    binder:BindToImage(self.ui.Image_Pattern, function()
      return self.iconPath
    end)
  end
  local showTime = self.durtion and self.durtion or 2
  binder:BindTimer(showTime, 0, nil, function()
    if self.callback ~= nil then
      self.callback()
    end
    self:Close()
  end)
end

return PopIconMsgPanel
