_class("IViewWrapper", Object)
IViewWrapper = IViewWrapper

function IViewWrapper:Constructor()
  self.ViewType = "invalid"
end

function IViewWrapper:FindChild(name)
  return nil
end
