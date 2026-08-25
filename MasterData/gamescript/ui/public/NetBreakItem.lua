local NetBreakItem, Super = System.NewComponent("NetBreakItem")

function NetBreakItem:ctor(res)
  Super.ctor(self)
  self.ui = Com_BreakResource(res)
end

function NetBreakItem:OnBind(binder)
end

return NetBreakItem
