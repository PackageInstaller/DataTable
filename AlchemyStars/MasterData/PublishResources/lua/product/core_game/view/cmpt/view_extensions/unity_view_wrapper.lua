_class("UnityViewWrapper", IViewWrapper)
UnityViewWrapper = UnityViewWrapper

function UnityViewWrapper:Constructor(resource_service, resRequest)
  self.ViewType = "UnitySimple"
  self.ResRequest = resRequest
  self.GameObject = resRequest.Obj
  self.Transform = resRequest.Obj.transform
  self._ResService = resource_service
  self._childTrans = {}
end

function UnityViewWrapper:SyncTransform(pos, dir, scale, id, onOtherBoard)
  local tf = self.Transform
  if dir ~= Vector3(0, 0, 0) and not onOtherBoard then
    tf.forward = dir
  end
  if onOtherBoard then
    tf.localPosition = pos
  else
    tf.position = pos
  end
  tf.localScale = scale
end

function UnityViewWrapper:SetVisible(active)
  self.GameObject:SetActive(active)
end

function UnityViewWrapper:ViewDispose()
  self._ResService:DestroyView(self)
end

function UnityViewWrapper:FindChild(name)
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
