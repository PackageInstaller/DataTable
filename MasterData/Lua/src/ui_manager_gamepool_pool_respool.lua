local this = class("resPool")
local _instantiate = Unity.GameObject.Instantiate

function this:ctor(count)
  self.cache = L_Struct.getLruCache()
  self.cache:setMaxCount(count)
  self.cache:setRemoveCall(L_CommonUtil.handle(self.onTrigger_garbage, self))
  self.gcCount = 1
  self.gcBase = count or 100
  self.gcMax = self.gcBase
  self.pathToInsGroup = {}
end

function this:asyncGameObject(path, callBack, priority)
  if priority == nil then
    priority = C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page)
  end
  return C_UIMgr.uiLoader:SpawnAsync(path, callBack, nil, true, C_EAssetOperationModule.Lua, priority)
end

function this:syncGameObject(path, parent)
  return C_UIMgr.uiLoader:Spawn(path, parent)
end

function this:destroyGo(go)
  return C_PrefabManager:RecycleByLoader(go)
end

function this:getInsGroup(path, isCreate)
  local group = self.pathToInsGroup[path]
  if group == nil and isCreate then
    group = {}
    self.pathToInsGroup[path] = group
  end
  return group
end

function this:onTrigger_garbage(path, res)
  local needGarbage = self:garbageGroup(path)
  if needGarbage then
    C_LuaUtility.DestroyObject(res.handle)
  end
  return needGarbage
end

function this:garbageGroup(path)
  local group = self:getInsGroup(path)
  local needGarbage = true
  local isTrigger = false
  if group then
    local count = #group
    for i = count, 1, -1 do
      local ins = group[i]
      if ins:IsNull() then
        table.remove(group, i)
        isTrigger = true
      end
    end
    needGarbage = #group <= 0
    if needGarbage then
      self.pathToInsGroup[path] = nil
    end
  end
  return needGarbage, isTrigger
end

function this:forceGarbage()
  for path, v in pairs(self.pathToInsGroup) do
    if self:garbageGroup(path) then
      local node = self.cache:remove(path)
      if node then
        local res = node.value
        C_LuaUtility.DestroyObject(res.handle)
      end
    end
  end
end

function this:destroyAllGo()
  for _, v in pairs(self.pathToInsGroup) do
    for _, go in pairs(v) do
      if not go:IsNull() then
        C_BoundGameObject.Destroy(go)
      end
    end
  end
  self:dispose()
end

function this:dispose()
  self.pathToInsGroup = {}
  self.cache:dispose()
end

return this
