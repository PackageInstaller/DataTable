local AlertConfirm3Panel, Super = System.NewClass("AlertConfirm3Panel", AlertConfirm2Panel)

function AlertConfirm3Panel:ctor(data, callback, params, playAnim)
  Super.ctor(self, data, callback, playAnim)
  self.params = params
end

function AlertConfirm3Panel:PushBackCommand()
  if self.params and self.params.forbidBack then
    return
  end
  UIBackCommandStack.Push({
    uiPanel = self,
    Execute = function()
      self:BaseClose()
    end
  })
end

return AlertConfirm3Panel
