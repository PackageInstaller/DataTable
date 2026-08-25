local UIBaseWidget, Super = System.NewClass("UIBaseWidget", MvvmComponent)

function UIBaseWidget:ctor()
  Super.ctor(self)
end

function UIBaseWidget:Setup(binder)
  self.binder = binder
  Super.Setup(self, binder)
end

function UIBaseWidget:OnBind(binder)
end

function UIBaseWidget:OnUnbind()
end

return UIBaseWidget
