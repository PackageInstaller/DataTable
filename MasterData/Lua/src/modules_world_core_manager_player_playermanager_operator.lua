local this = {}

function this:transferPoint(pointId, callback)
  if pointId == nil then
    return
  end
  local pointTpl = L_GameTpl:getWorldBorthposTpl()
  local tpl = pointTpl:getTplById(pointId)
  local pos = pointTpl:getPosition(tpl)
  local rot = pointTpl:getRotation(tpl)
  AzurWorld.transferMgr:ClientTransferStartFlow(pos, rot, callback)
end

function this:setTransferPoint(lookPos, lookRot)
  if self.transBindPoint == nil then
    self.transBindPoint = C_GameObject("virtualPoint(transfer)").transform
    self.transBindPoint:SetParent(C_LuaUtility.GetRootNode())
    self.transBindPoint.gameObject:TryGetComponent(typeof(C_ColliderProbe))
  end
  self.transBindPoint.gameObject:ActiveTrans(true)
  local pos = lookPos or L_Vector3.getTemp()
  self.transBindPoint.localPosition = C_Vector3(pos.x, pos.y, pos.z)
  local rot = lookRot or L_Vector3.getTemp()
  self.transBindPoint.localEulerAngles = C_Vector3(rot.x, rot.y, rot.z)
end

function this:clearTransferPoint()
  if self.transBindPoint then
    self.transBindPoint.gameObject:ActiveTrans(false)
  end
  C_WorldSceneManager.SetTraceTransform(C_CameraManager.GetFollowNode().transform)
end

return this
