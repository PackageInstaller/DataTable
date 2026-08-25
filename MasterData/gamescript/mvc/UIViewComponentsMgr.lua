local UIViewComponentsMgr = NewClass("UIViewComponentsMgr")

function UIViewComponentsMgr:ctor(view)
  self.view = view
end

function UIViewComponentsMgr:Dispose()
  if self.viewComponents then
    for _, v in pairs(self.viewComponents) do
      v:OnExitComponent()
    end
    self.viewComponents = nil
  end
  self.viewComponentsMap = nil
end

function UIViewComponentsMgr:AddViewComponent(gameObject, viewComponentCls, ...)
  self.viewComponents = self.viewComponents or {}
  local comp = viewComponentCls(gameObject, self.view, ...)
  table.insert(self.viewComponents, comp)
  self.viewComponentsMap = self.viewComponentsMap or {}
  self.viewComponentsMap[gameObject] = self.viewComponentsMap[gameObject] or {}
  table.insert(self.viewComponentsMap[gameObject], comp)
  Trycall(comp.UpdateLocalizedTextAndResouce, comp)
  Trycall(comp.OnBuildComponent, comp)
  Trycall(comp.RegisterNotifications, comp)
  Trycall(comp.RegisterEvents, comp)
  Trycall(comp.OnEnterComponent, comp)
  return comp
end

function UIViewComponentsMgr:AddViewComponentOnce(gameObject, viewComponentCls, ...)
  self:RemoveViewComponentOnce(gameObject, viewComponentCls)
  do return self.AddViewComponent, self, gameObject, viewComponentCls, ... end
  return self.AddViewComponent, self, gameObject, viewComponentCls, ...
end

function UIViewComponentsMgr:RemoveViewComponentOnce(gameObject, viewComponentCls)
  if not self.viewComponentsMap or not self.viewComponentsMap[gameObject] then
    return
  end
  local viewComponents = self.viewComponentsMap[gameObject]
  if viewComponents then
    for i = 1, #viewComponents do
      local comp = viewComponents[i]
      if comp.__name == viewComponentCls.__name then
        table.remove(viewComponents, i)
        table.removeByValue(self.viewComponents, comp)
        comp:OnExitComponent()
        return comp
      end
    end
  end
end

function UIViewComponentsMgr:GetViewComponent(gameObject, viewComponentCls)
  if not self.viewComponentsMap or not self.viewComponentsMap[gameObject] then
    return
  end
  local viewComponents = self.viewComponentsMap[gameObject]
  if viewComponents then
    for i = 1, #viewComponents do
      local comp = viewComponents[i]
      if comp.__name == viewComponentCls.__name then
        return comp
      end
    end
  end
end

return UIViewComponentsMgr
