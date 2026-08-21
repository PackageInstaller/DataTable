require("asset_detail")
_class("NativeUnityPrefabAsset", IAssetDetail)
NativeUnityPrefabAsset = NativeUnityPrefabAsset

function NativeUnityPrefabAsset:Constructor(path, isShow)
  self.AssetType = "NativeUnityPrefab"
  self.isShow = isShow == nil and true or isShow
end

function NativeUnityPrefabAsset:GenerateView(resource_service, finish_callback, ...)
  local orignal_args = {
    ...
  }
  local orignal_arg_num = select("#", ...)
  local viewOwnerEntity = orignal_args[2]
  local resRequest = resource_service:LoadGameObject(self._ResPath)
  local view
  if resRequest then
    local buffCmpt = viewOwnerEntity:BuffView()
    if self:_IsPet(viewOwnerEntity) or buffCmpt and buffCmpt:GetBuffValue("ChangeModelWithPetIndex") then
      local ancName = HelperProxy:GetInstance():GetPetAnimatorControllerName(self._ResPath, PetAnimatorControllerType.Battle)
      local ancRes = resource_service:LoadGameObject(ancName)
      view = UnityPetViewWrapper:New(resource_service, resRequest, ancRes)
    elseif viewOwnerEntity:HasPiece() or viewOwnerEntity:HasPieceFake() then
      view = GridViewWrapper:New(resource_service, resRequest, viewOwnerEntity)
    else
      view = UnityViewWrapper:New(resource_service, resRequest)
    end
  end
  orignal_args[orignal_arg_num + 1] = view
  finish_callback(table.unpack(orignal_args, 1, table.maxn(orignal_args)))
  if viewOwnerEntity:HasLocation() then
    local cLocation = viewOwnerEntity:Location()
    cLocation:SyncLocation(viewOwnerEntity)
  end
  if view then
    view:SetVisible(self.isShow)
  end
end

function NativeUnityPrefabAsset:_IsPet(entity)
  if entity:HasPetPstID() then
    return true
  elseif entity:HasCutscenePlayer() then
    return true
  else
    local ghost = entity:Ghost()
    if ghost then
      local world = entity:GetOwnerWorld()
      local owner = world:GetEntityByID(ghost:GetOwnerID())
      if owner and owner:HasPetPstID() then
        return true
      end
    end
    local guideGhost = entity:GuideGhost()
    if guideGhost then
      local world = entity:GetOwnerWorld()
      local owner = world:GetEntityByID(guideGhost:GetOwnerID())
      if owner and owner:HasPetPstID() then
        return true
      end
    end
  end
  return false
end
