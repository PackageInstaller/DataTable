require("i_resource_service")
_class("UnityResourceService", Singleton)
UnityResourceService = UnityResourceService

function UnityResourceService:Constructor()
end

function UnityResourceService:LoadGameObject(ResPath)
  local request = ResourceManager:GetInstance():SyncLoadAsset(ResPath, LoadType.GameObject)
  if request == nil then
    Log.fatal("LoadGameObject failed", "[" .. ResPath .. "]")
    return
  end
  local u3dGo = request.Obj
  u3dGo:SetActive(true)
  return request
end

function UnityResourceService:DestroyView(view)
  if view.ViewType == "UnitySimple" then
    view.Transform = nil
    view.ResRequest:Dispose()
    view.ResRequest = nil
    view.GameObject = nil
  end
end
