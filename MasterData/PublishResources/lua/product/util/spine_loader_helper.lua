_class("SpineLoaderHelper", Object)
SpineLoaderHelper = SpineLoaderHelper

function SpineLoaderHelper:Constructor()
  self._spines = ArrayList:New()
  self._root = nil
  self.isOpen = true
end

function SpineLoaderHelper:Init(root, count)
  self._maxCount = count
  self._root = root
end

function SpineLoaderHelper:LoadSpine(spineName, isAsync)
  self:_LoadSpine(spineName, isAsync)
end

function SpineLoaderHelper:_LoadSpine(spineName, isAsync)
  if self:_ContainKey(spineName) then
    return
  end
  if isAsync then
    self:_LoadSpineAsync(spineName)
  else
    self:_LoadSpineSync(spineName)
  end
end

function SpineLoaderHelper:_LoadSpineSync(spineName)
  local tempTab = {}
  tempTab.spineName = spineName
  tempTab.spine = ResourceManager:GetInstance():SyncLoadAsset(spineName .. ".prefab", LoadType.GameObject)
  if tempTab.spine then
    tempTab.spine.Obj.transform:SetParent(self._root)
    tempTab.spine.Obj.transform.localPosition = Vector3(0, 0, 0)
    tempTab.spine.Obj.transform.localScale = Vector3(1, 1, 1)
    tempTab.spine.Obj:SetActive(false)
    self._spines:PushBack(tempTab)
    self:_Delete()
  end
end

function SpineLoaderHelper:_LoadSpineAsync(spineName, cb)
  GameGlobal.TaskManager():StartTask(self._OnLoadSpineAsync, self, spineName, cb)
end

function SpineLoaderHelper:_OnLoadSpineAsync(TT, spineName, cb)
  local _tempTab = {}
  _tempTab.spine = ResourceManager:GetInstance():AsyncLoadAsset(TT, spineName .. ".prefab", LoadType.GameObject)
  if self.isOpen == false then
    return
  end
  if not self:_ContainKey(spineName) then
    _tempTab.spineName = spineName
    _tempTab.spine.Obj.transform:SetParent(self._root)
    _tempTab.spine.Obj.transform.localPosition = Vector3(0, 0, 0)
    _tempTab.spine.Obj.transform.localScale = Vector3(1, 1, 1)
    _tempTab.spine.Obj.transform.localRotation = Quaternion(0, 0, 0, 0)
    _tempTab.spine.Obj:SetActive(false)
    self._spines:PushBack(_tempTab)
    self:_Delete()
  end
  if cb then
    cb()
  end
end

function SpineLoaderHelper:_ContainKey(spineName)
  if self._spines and self._spines.elements then
    for i = 1, table.count(self._spines.elements) do
      local n = self._spines.elements[i].spineName
      if n and n == spineName then
        return true
      end
    end
  end
  return false
end

function SpineLoaderHelper:GetSpine(spineName)
  for i = 1, table.count(self._spines.elements) do
    local n = self._spines.elements[i].spineName
    if n == spineName then
      return self._spines.elements[i].spine
    end
  end
  self:_LoadSpineAsync(spineName, function()
    for i = 1, table.count(self._spines.elements) do
      local n = self._spines.elements[i].spineName
      if n == spineName then
        return self._spines.elements[i].spine
      end
    end
  end)
  local tempTab = {}
  tempTab.spineName = spineName
  tempTab.spine = ResourceManager:GetInstance():SyncLoadAsset(spineName .. ".prefab", LoadType.GameObject)
  if tempTab.spine then
    tempTab.spine.Obj.transform:SetParent(self._root)
    tempTab.spine.Obj.transform.localPosition = Vector3(0, 0, 0)
    tempTab.spine.Obj.transform.localScale = Vector3(1, 1, 1)
    tempTab.spine.Obj:SetActive(false)
    self._spines:PushBack(tempTab)
    self:_Delete()
    return tempTab.spine
  end
  return nil
end

function SpineLoaderHelper:_Delete()
  if self._spines:Size() > self._maxCount then
    self._spines:RemoveByIndex(1)
  end
end

function SpineLoaderHelper:Dispose()
  for i = 1, table.count(self._spines.elements) do
    local res = self._spines.elements[i].spine
    res:Dispose()
  end
  self._root = nil
  self._spines:Clear()
  self._spines = nil
  self.isOpen = false
  self._maxCount = 0
end
