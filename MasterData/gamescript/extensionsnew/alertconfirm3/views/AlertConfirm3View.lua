local AlertConfirm3View, Super = NewClass("AlertConfirm3View", AlertConfirm2View)

function AlertConfirm3View:ctor(data, callback, params, playAnim)
  Super.ctor(self, data, callback, playAnim)
  self.params = params
end

function AlertConfirm3View:PushBackCommand()
  if self.params and self.params.forbidBack then
    return
  end
  UIBackCommandStack.Push({
    uiPanel = self,
    Execute = function()
      self:_BaseClose()
    end
  })
end

return AlertConfirm3View
