_class("HomelandMedal", Object)
HomelandMedal = HomelandMedal

function HomelandMedal:Constructor(rootTran, boardMedal)
  self._id = boardMedal.itemId
  self._req = ResourceManager:GetInstance():SyncLoadAsset(boardMedal.model, LoadType.GameObject)
  if not self._req then
    BuildError("找不到勋章模型:" .. boardMedal.model)
    return
  end
  self._go = self._req.Obj
  self._go.layer = HomeBuildLayer.MedalWall
  self._go:SetActive(true)
  self._transform = self._req.Obj.transform
  self._transform:SetParent(rootTran)
  local offsetZ = (boardMedal.index - 1) * MedalWallConfig.MedalOffset
  self._transform.localPosition = Vector3(-boardMedal.pos.x, boardMedal.pos.y, offsetZ)
  self._transform.localRotation = Quaternion(boardMedal.quat.x, boardMedal.quat.y, boardMedal.quat.z, -boardMedal.quat.w)
end

function HomelandMedal:Destroy()
  self._go = nil
  self._transform = nil
  if self._req then
    self._req:Dispose()
  end
  self._req = nil
end
