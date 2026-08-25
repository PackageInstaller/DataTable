local MvvmComponent = System.NewClass("MvvmComponent")

function MvvmComponent:ctor()
end

function MvvmComponent:Setup(binder)
  binder:onDestroy(function()
    self:OnUnbind()
    if binder.OnDispose then
      binder:OnDispose()
    end
  end)
  self:OnBind(binder)
end

function MvvmComponent:OnBind(binder)
end

function MvvmComponent:OnUnbind()
end

return MvvmComponent
