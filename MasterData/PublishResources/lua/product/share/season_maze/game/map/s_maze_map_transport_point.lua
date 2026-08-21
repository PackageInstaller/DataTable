_class("SMazeMapTransportPoint", Object)
SMazeMapTransportPoint = SMazeMapTransportPoint

function SMazeMapTransportPoint:Constructor(node)
  self._id = node:ID()
  self._req = ResourceManager:GetInstance():SyncLoadAsset("pfb_Scene_Waypoint08.prefab", LoadType.GameObject)
  local transportObj = self._req.Obj
  if EDITOR then
    transportObj.name = self._id
  end
  transportObj:SetActive(true)
  self._gameObject = transportObj
  transportObj.layer = SMazeSceneLayer.Room
  local tr = transportObj.transform
  tr.position = node:Position()
  tr.rotation = Quaternion.identity
  tr.localScale = Vector3.one
  self._animation = transportObj:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._animName = {
    OpenLoop = "pfb_ludian_open_blueloop",
    OpenOut = "pfb_ludian_open_blueout",
    CloseLoop = "pfb_ludian_close_blueloop"
  }
end

function SMazeMapTransportPoint:Dispose()
  self._req:Dispose()
  self._req = nil
  self._gameObject = nil
  self._animation = nil
end

function SMazeMapTransportPoint:Anim_Reachable(reachable, onInit)
  if onInit then
    if reachable then
      self._animation:Play(self._animName.OpenLoop)
    else
      self._animation:Play(self._animName.CloseLoop)
    end
  elseif not reachable then
    self._animation:Play(self._animName.OpenOut)
    self._animation:PlayQueued(self._animName.CloseLoop)
  end
end

function SMazeMapTransportPoint:GameObject()
  return self._gameObject
end
