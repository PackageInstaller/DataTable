require("view_wrapper")
_class("AnimationViewWrapper", IViewWrapper)
AnimationViewWrapper = AnimationViewWrapper

function AnimationViewWrapper:Constructor(resource_service, resRequest)
  self.ViewType = "AnimationView"
  self.ResRequest = resRequest
  self.GameObject = resRequest.Obj
  self.Transform = resRequest.Obj.transform
  self._ResService = resource_service
end

function AnimationViewWrapper:SyncTransform(pos, dir, scale, id)
  local tf = self.Transform
  tf.position = pos
  if dir ~= Vector3(0, 0, 0) then
    tf.forward = dir
  end
  tf.localScale = scale
end

function AnimationViewWrapper:SetVisible(active)
  local curPos = self.GameObject.transform.position
  if active then
    self.GameObject.transform.position = Vector3(curPos.x, 0, curPos.z)
  else
    self.GameObject.transform.position = Vector3(curPos.x, BattleConst.CacheHeight, curPos.z)
  end
end

function AnimationViewWrapper:ViewDispose()
  self._ResService:DestroyView(self)
end
