_class("SeasonShapeRect", SeasonShapeBase)
SeasonShapeRect = SeasonShapeRect

function SeasonShapeRect:Constructor(root, id, position, rotation, param)
  self._root = root
  self._width = param[1]
  self._height = param[2]
  self._gameObject = nil
  if EDITOR then
    self._gameObject = UnityEngine.GameObject.CreatePrimitive(UnityEngine.PrimitiveType.Cube)
    self._gameObject.name = tostring(id)
    self._gameObject.transform.parent = self._root
    SeasonTool:GetInstance():DisenableMeshRender(self._gameObject)
  else
    self._gameObject = GameObjectHelper.CreateEmpty(tostring(id), self._root)
  end
  self._transform = self._gameObject.transform
  self._transform.position = position
  self._transform.rotation = Quaternion.Euler(0, rotation, 0)
  self._transform.localScale = Vector3(self._width, 0, self._height)
  self._gameObject:SetActive(true)
end

function SeasonShapeRect:Dispose()
  self._root = nil
  UnityEngine.Object.Destroy(self._gameObject)
end

function SeasonShapeRect:OnCheck(position)
  local targetPosition = Vector3(position.x, self._transform.position.y, position.z)
  local p = self._transform:InverseTransformPoint(targetPosition)
  p.x = p.x * self._width
  p.z = p.z * self._height
  local half_width = self._width / 2
  local half_height = self._height / 2
  local r1 = half_width >= p.x
  local r2 = p.x >= -half_width
  local r3 = half_height >= p.z
  local r4 = p.z >= -half_height
  if r1 and r2 and r3 and r4 then
    if EDITOR then
      UnityEngine.Debug.DrawLine(self._transform.position, targetPosition, Color.green)
    end
    return true
  else
    return false
  end
end
