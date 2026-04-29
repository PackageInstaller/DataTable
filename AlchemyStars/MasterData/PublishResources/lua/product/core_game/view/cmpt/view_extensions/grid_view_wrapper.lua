require("view_wrapper")
_class("GridViewWrapper", IViewWrapper)
GridViewWrapper = GridViewWrapper

function GridViewWrapper:Constructor(resource_service, resRequest)
  self.ViewType = "GridView"
  self.ResRequest = resRequest
  self.GameObject = resRequest.Obj
  self.Transform = resRequest.Obj.transform
  self._ResService = resource_service
end

function GridViewWrapper:SyncTransform(pos, dir, scale, id, onOtherBoard)
  local tf = self.Transform
  if dir ~= Vector3(0, 0, 0) then
    tf.forward = dir
  end
  if onOtherBoard then
    tf.localEulerAngles = Vector3(0, 0, 0)
    tf.localPosition = pos
  else
    tf.position = pos
  end
  tf.localScale = scale
end

function GridViewWrapper:SetVisible(active)
  local curPos = self.GameObject.transform.position
  if active then
    self.GameObject.transform.position = Vector3(curPos.x, 0, curPos.z)
  else
    self.GameObject.transform.position = Vector3(curPos.x, BattleConst.CacheHeight, curPos.z)
  end
end

function GridViewWrapper:ViewDispose()
  self._ResService:DestroyView(self)
end
