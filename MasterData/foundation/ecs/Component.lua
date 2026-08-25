local Component = System.NewClass("Component", IDestroyable)

function Component:ctor()
end

function Component:GetComponent(T)
  do return self.parent.GetComponent1, self.parent end
  return self.parent.GetComponent1, self.parent, T
end

function Component:GetComponent1(T)
  do return self.parent.GetComponent1, self.parent end
  return self.parent.GetComponent1, self.parent, T
end

function Component:GetOrAddComponent(T, ...)
  do return self.parent.GetOrAddComponent, self.parent, T, ... end
  return self.parent.GetOrAddComponent, self.parent, T, ...
end

function Component:AddComponent(T, ...)
  do return self.parent.AddComponent, self.parent, T, ... end
  return self.parent.AddComponent, self.parent, T, ...
end

function Component:Destroy()
  self.parent:DestroyComponent(self)
end

function Component:Awake()
end

function Component:Update()
end

function Component:Start()
end

function Component:OnDestroy()
end

function Component:isDestroyed()
  return self.destroyed
end

return Component
