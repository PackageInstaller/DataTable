require("view_wrapper")
_class("UnityPetViewWrapper", IViewWrapper)
UnityPetViewWrapper = UnityPetViewWrapper

function UnityPetViewWrapper:Constructor(resource_service, petRes, ancRes)
  self.ViewType = "UnityPet"
  self.ResRequests = {petRes, ancRes}
  self.GameObject = petRes.Obj
  self.Transform = petRes.Obj.transform
  local animatorController = ancRes.Obj:GetComponent(typeof(UnityEngine.Animator)).runtimeAnimatorController
  if animatorController == nil then
    Log.error("[ani] getAnimatorController Error", petRes.m_Name, ancRes.m_Name)
  end
  local u3dAnimatorCmpt = self.GameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
  if u3dAnimatorCmpt == nil then
    Log.error("[ani] Root has no animator ", petRes.m_Name, ancRes.m_Name)
  end
  u3dAnimatorCmpt.runtimeAnimatorController = animatorController
  ancRes.Obj:SetActive(false)
  self._ResService = resource_service
  self._childTrans = {}
end

function UnityPetViewWrapper:SyncTransform(pos, dir, scale)
  local tf = self.Transform
  tf.position = pos
  if dir ~= Vector3(0, 0, 0) then
    tf.forward = dir
  end
  tf.localScale = scale
end

function UnityPetViewWrapper:SetVisible(active)
  self.GameObject:SetActive(active)
end

function UnityPetViewWrapper:ViewDispose()
  self._ResService:DestroyView(self)
end

function UnityPetViewWrapper:FindChild(name)
  local tran = self.Transform
  if not tran then
    Log.fatal("### no Transform in UnityViewWrapper")
    return nil
  end
  if not self._childTrans[name] then
    local tranChild = GameObjectHelper.FindChild(tran, name)
    self._childTrans[name] = tranChild
  end
  return self._childTrans[name]
end
