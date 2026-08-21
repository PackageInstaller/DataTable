_class("BoardColliderComponent", Object)
BoardColliderComponent = BoardColliderComponent

function BoardColliderComponent:Constructor()
  self._boardColliderRequest = nil
  self._boardColliderPlaneRes = "Plane.prefab"
  self:_LoadColliderPlane()
end

function BoardColliderComponent:_LoadColliderPlane()
  self._boardColliderRequest = UnityResourceService:GetInstance():LoadGameObject(self._boardColliderPlaneRes)
  local go = self._boardColliderRequest.Obj
  go.transform.localScale = Vector3(10, 1, 10)
end

function BoardColliderComponent:Dispose()
  if self._boardColliderRequest ~= nil then
    self._boardColliderRequest:Dispose()
  end
  self._boardColliderRequest = nil
end

function Entity:BoardCollider()
  return self:GetComponent(self.WEComponentsEnum.BoardCollider)
end

function Entity:HasBoardCollider()
  return self:HasComponent(self.WEComponentsEnum.BoardCollider)
end

function Entity:AddBoardCollider()
  local index = self.WEComponentsEnum.BoardCollider
  local component = BoardColliderComponent:New()
  self:AddComponent(index, component)
end
