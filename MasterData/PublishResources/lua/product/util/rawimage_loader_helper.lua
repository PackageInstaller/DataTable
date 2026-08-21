_class("RawImageLoaderHelper", Object)
RawImageLoaderHelper = RawImageLoaderHelper

function RawImageLoaderHelper:Constructor()
  self._mats = ArrayList:New()
  self.isOpen = true
end

function RawImageLoaderHelper:Init(count)
  self._maxCount = count
end

function RawImageLoaderHelper:LoadMat(matName, isAsync)
  self:_LoadMat(matName, isAsync)
end

function RawImageLoaderHelper:_LoadMat(matName, isAsync)
  if self:_ContainKey(matName) then
    return
  end
  if isAsync then
    self:_LoadMatAsync(matName)
  else
    self:_LoadMatSync(matName)
  end
end

function RawImageLoaderHelper:_LoadMatSync(matName)
  local tempMat = {}
  tempMat.matName = matName
  tempMat.mat = ResourceManager:GetInstance():SyncLoadAsset(matName .. ".mat", LoadType.Mat)
  if tempMat.mat then
    self._mats:PushBack(tempMat)
    self:_Delete()
  end
end

function RawImageLoaderHelper:_LoadMatAsync(matName, cb)
  GameGlobal.TaskManager():StartTask(self._OnLoadMatAsync, self, matName, cb)
end

function RawImageLoaderHelper:_OnLoadMatAsync(TT, matName, cb)
  local _tempTab = {}
  _tempTab.mat = ResourceManager:GetInstance():AsyncLoadAsset(TT, matName .. ".mat", LoadType.Mat)
  if self.isOpen == false then
    return
  end
  if not self:_ContainKey(matName) then
    _tempTab.matName = matName
    self._mats:PushBack(_tempTab)
    self:_Delete()
  end
  if cb then
    cb()
  end
end

function RawImageLoaderHelper:_ContainKey(matName)
  if self._mats and self._mats.elements then
    for i = 1, table.count(self._mats.elements) do
      local n = self._mats.elements[i].matName
      if n == matName then
        return true
      end
    end
  end
  return false
end

function RawImageLoaderHelper:GetMat(matName)
  for i = 1, table.count(self._mats.elements) do
    local n = self._mats.elements[i].matName
    if n == matName then
      return self._mats.elements[i].mat.Obj
    end
  end
  self:_LoadMatAsync(matName, function()
    for i = 1, table.count(self._mats.elements) do
      local n = self._mats.elements[i].matName
      if n == matName then
        return self._mats.elements[i].mat.Obj
      end
    end
  end)
  local tempTab = {}
  tempTab.matName = matName
  tempTab.mat = ResourceManager:GetInstance():SyncLoadAsset(matName .. ".mat", LoadType.Mat)
  if tempTab.mat then
    self._mats:PushBack(tempTab)
    self:_Delete()
    return tempTab.mat.Obj
  end
  return nil
end

function RawImageLoaderHelper:_Delete()
  if self._mats:Size() > self._maxCount then
    self._mats:RemoveByIndex(1)
  end
end

function RawImageLoaderHelper:Dispose()
  for i = 1, table.count(self._mats.elements) do
    local res = self._mats.elements[i].mat
    res:Dispose()
  end
  self._mats:Clear()
  self._mats = nil
  self._maxCount = 0
  self.isOpen = false
end
