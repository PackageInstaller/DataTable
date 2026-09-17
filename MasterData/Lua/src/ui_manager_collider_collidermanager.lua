local colliderManager = class("colliderManager")
local _EColliderType = CS.Lens.Gameplay.Managers.WorldScene.EColliderType

function colliderManager:ctor()
  self._goMap = {}
end

function colliderManager:dispose()
  self._goMap = {}
end

function colliderManager:refreshCollider(transKey, bShow, transColliderParent)
  if not self._goMap[transKey] then
    self._goMap[transKey] = {
      mesh = {},
      box = {},
      sphere = {}
    }
  end
  local tb = self._goMap[transKey]
  for k, v in pairs(tb) do
    for kk, vv in pairs(v) do
      vv.gameObject:ActiveTrans(false)
    end
  end
  if bShow then
    local customColliders = transKey:GetComponentsInChildren(typeof(CS.Lens.Gameplay.Managers.WorldScene.CustomCollider), true)
    local meshNum, boxNum, sphereNum = 0, 0, 0
    for i = 0, customColliders.Length - 1 do
      local customCollider = customColliders[i]
      if customCollider.colliderType == _EColliderType.Mesh then
        local lodMeshes = 0 < customCollider.lodMeshes.Count and customCollider.lodMeshes[0]
        if lodMeshes then
          local meshFilters = lodMeshes.meshes
          for j = 0, meshFilters.Count - 1 do
            local meshFilter = meshFilters[j]
            if L_CommonUtil.isValid(meshFilter) then
              meshNum = meshNum + 1
              local mesh = meshFilter.sharedMesh
              local collider = tb.mesh[meshNum]
              if not L_CommonUtil.isValid(collider) then
                local trans = (transColliderParent or transKey):ForceFind("mesh-collider-" .. meshNum)
                collider = trans.gameObject:PickComponent(typeof(Unity.MeshCollider))
                tb.mesh[meshNum] = collider
              end
              collider.gameObject:ActiveTrans(true)
              collider.sharedMesh = mesh
              collider.convex = customCollider.convex
              collider.isTrigger = customCollider.convex and customCollider.isTrigger
              collider.transform.position = meshFilter.transform.position
              collider.transform.localScale = meshFilter.transform.lossyScale
              collider.transform.eulerAngles = meshFilter.transform.eulerAngles
            end
          end
        end
      else
        local collider
        if customCollider.colliderType == _EColliderType.Box then
          boxNum = boxNum + 1
          collider = tb.box[boxNum]
          if not L_CommonUtil.isValid(collider) then
            local trans = (transColliderParent or transKey):ForceFind("box-collider-" .. boxNum)
            collider = trans.gameObject:PickComponent(typeof(Unity.BoxCollider))
            tb.box[boxNum] = collider
            collider.center = customCollider.center
            collider.size = customCollider.size
          end
        else
          sphereNum = sphereNum + 1
          collider = tb.sphere[sphereNum]
          if not L_CommonUtil.isValid(collider) then
            local trans = (transColliderParent or transKey):ForceFind("sphere-collider-" .. sphereNum)
            collider = trans.gameObject:PickComponent(typeof(Unity.SphereCollider))
            tb.sphere[sphereNum] = collider
            collider.center = customCollider.center
            collider.radius = customCollider.radius
          end
        end
        collider.gameObject:ActiveTrans(true)
        collider.transform.position = customCollider.transform.position
        collider.transform.localScale = customCollider.transform.lossyScale
        collider.transform.eulerAngles = customCollider.transform.eulerAngles
      end
    end
  end
end

return colliderManager
