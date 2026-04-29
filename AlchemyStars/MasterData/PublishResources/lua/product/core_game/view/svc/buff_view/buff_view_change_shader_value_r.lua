_class("BuffViewChangeShaderValue", BuffViewBase)
BuffViewChangeShaderValue = BuffViewChangeShaderValue

function BuffViewChangeShaderValue:PlayView(TT)
  local buffResult = self._buffResult
  local entity = self._entity
  if not entity:HasView() then
    return
  end
  local root = GameObjectHelper.FindChild(entity:View().ViewWrapper.GameObject.transform, buffResult:GetRoot())
  if not root then
    return
  end
  local renderer = root:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  if not renderer then
    return
  end
  local material = renderer.sharedMaterial
  if not material then
    return
  end
  material:SetFloat(buffResult:GetParam(), buffResult:GetBlood() / 100)
end
