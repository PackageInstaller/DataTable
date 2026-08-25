local DbgEventEffectBase, Super = System.NewClass("DbgEventEffectBase")

function DbgEventEffectBase:ctor(uiBinder)
  Super.ctor(self)
  self.binder = uiBinder
  uiBinder:onDestroy(function()
    self:Clear()
  end)
  self:CreateResources()
end

function DbgEventEffectBase:StartEffect(data)
  self.paramsData = data
  self:LoadResources()
end

function DbgEventEffectBase:LoadResources()
  if self:IsResourcesReady() then
    self:OnResourcesReady()
    return
  end
  for k, v in pairs(self.resources) do
    v:LoadResource(function()
      if self:IsResourcesReady() then
        self:OnResourcesReady()
        return
      end
    end)
  end
end

function DbgEventEffectBase:Clear()
  if self.resources then
    for k, v in pairs(self.resources) do
      v:UnloadResource()
    end
    self.resources = nil
  end
  self.onCompeleteFunc = nil
  self.paramsData = nil
  self.binder = nil
end

function DbgEventEffectBase:SetEffectCompeleteCallback(onCompeleteFunc)
  self.onCompeleteFunc = onCompeleteFunc
end

function DbgEventEffectBase:CreateResources()
  if self.resources then
    return
  end
  self.resources = {}
  local resources = self:GetResources()
  if not resources or 0 == #resources then
    return
  end
  for i = 1, #resources do
    self.resources[resources[i]] = DbgEventEffResource(resources[i])
  end
end

function DbgEventEffectBase:IsResourcesReady()
  if not self.resources then
    return true
  end
  for k, v in pairs(self.resources) do
    if not v:IsResourceLoaded() then
      return false
    end
  end
  return true
end

function DbgEventEffectBase:GetMainAsset(assetPath)
  if self.resources and self.resources[assetPath] then
    do return self.resources[assetPath].GetMainAsset end
    return self.resources[assetPath].GetMainAsset, self.resources[assetPath]
  end
end

function DbgEventEffectBase:FetchGameObject(assetPath)
  if self.resources and self.resources[assetPath] then
    do return self.resources[assetPath].FetchGameObject end
    return self.resources[assetPath].FetchGameObject, self.resources[assetPath]
  end
end

function DbgEventEffectBase:ReturnGameObject(assetPath, go)
  if self.resources and self.resources[assetPath] then
    do return self.resources[assetPath].ReturnGameObject, self.resources[assetPath] end
    return self.resources[assetPath].ReturnGameObject, self.resources[assetPath], go
  end
end

function DbgEventEffectBase:GetResources()
end

function DbgEventEffectBase:OnResourcesReady()
end

return DbgEventEffectBase
