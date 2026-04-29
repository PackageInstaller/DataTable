_class("PetObtainAnimBase", Object)
PetObtainAnimBase = PetObtainAnimBase
local Type2Suffix = {
  [LoadType.GameObject] = ".prefab",
  [LoadType.Mat] = ".mat"
}
local ObtainAnimState = {
  Wait = 1,
  Prepare = 2,
  Ready = 3,
  Playing = 4,
  Finished = 5,
  Closed = 6,
  NONE = 999
}
_enum("ObtainAnimState", ObtainAnimState)

function PetObtainAnimBase:Constructor()
  self._reqs = {}
  self._assets = {}
  self._state = ObtainAnimState.Wait
end

function PetObtainAnimBase:SetAsFirst()
  self._isFirst = true
end

function PetObtainAnimBase:Prepare()
  self._state = ObtainAnimState.Prepare
end

function PetObtainAnimBase:Start()
end

function PetObtainAnimBase:Update(dtMS)
end

function PetObtainAnimBase:Dispose()
end

function PetObtainAnimBase:IsOver()
end

function PetObtainAnimBase:LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name .. Type2Suffix[type], type)
  if req == nil or req.Obj == nil then
    AirError("找不到资源:", name)
    return
  end
  self._assets[name] = req.Obj
  table.insert(self._reqs, req)
end

function PetObtainAnimBase:LoadAssetAsync(TT, name, type)
  local req = ResourceManager:GetInstance():AsyncLoadAsset(TT, name .. Type2Suffix[type], type)
  if self:CheckClosed() then
    req:Dispose()
    return
  end
  if req == nil or req.Obj == nil then
    AirError("找不到资源:", name)
    return
  end
  self._assets[name] = req.Obj
  table.insert(self._reqs, req)
end

function PetObtainAnimBase:ReleaseAsset()
  for _, req in pairs(self._reqs) do
    req:Dispose()
  end
  self._reqs = {}
end

function PetObtainAnimBase:GetAsset(name)
  local asset = self._assets[name]
  if not asset then
    Log.exception("加载卡牌资源失败:", name)
  end
  return asset
end

function PetObtainAnimBase:CheckClosed()
  return self._state == ObtainAnimState.Closed
end

function PetObtainAnimBase:PetID()
  return self._petID
end

function PetObtainAnimBase:OnUIDepthChanged(depth)
end

_class("AssetAsyncRequest", Object)
AssetAsyncRequest = AssetAsyncRequest

function AssetAsyncRequest:Constructor(name, loadType)
  self._name = name .. Type2Suffix[loadType]
  self._loadType = loadType
end

function AssetAsyncRequest:Load(TT)
  AirLog("开始异步加载资源:", self._name)
  self._req = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._name, self._loadType)
  self._object = self._req.Obj
end

function AssetAsyncRequest:Obj()
  if self._object == nil then
    AirError("资源还未加载:", self._name)
  end
  return self._object
end

function AssetAsyncRequest:Name()
  return self._name
end

function AssetAsyncRequest:Dispose()
  if self._req then
    self._req:Dispose()
    self._req = nil
    self._object = nil
  end
end
