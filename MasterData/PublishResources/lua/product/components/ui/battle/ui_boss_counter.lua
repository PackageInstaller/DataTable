_class("UIBossCounter", UIController)
UIBossCounter = UIBossCounter

function UIBossCounter:OnShow(arg)
  local uiParams = arg[1]
  if not self:SenityCheck(uiParams) then
    return
  end
  self:SyncLoadAllAsset(uiParams)
  self._monsterCG = self:GetUIComponent("RawImage", "role")
  self:Refresh(uiParams)
end

function UIBossCounter:Dispose()
  if self._cgMatReq then
    self._cgMatReq:Dispose()
    self._cgMatReq = nil
  end
  self._monsterCG = nil
  UIBossCounter.super.Dispose(self)
end

function UIBossCounter:SenityCheck(uiParams)
  local resmgr = ResourceManager:GetInstance()
  if not resmgr:HasResource(uiParams.monsterCGMat) then
    Log.fatal(self._className, "invalid petCG: ", tostring(uiParams.monsterCGMat))
    return false
  end
  return true
end

function UIBossCounter:SyncLoadAllAsset(uiParams)
  local resmgr = ResourceManager:GetInstance()
  self._cgMatReq = resmgr:SyncLoadAsset(uiParams.monsterCGMat, LoadType.Mat)
end

function UIBossCounter:Refresh(uiParams)
  if self._monsterCG and self._cgMatReq and self._cgMatReq.Obj then
    self._monsterCG.material = self._cgMatReq.Obj
    self._monsterCG.transform.localPosition = Vector3(uiParams.offsetPos.x, uiParams.offsetPos.y, 0)
    self._monsterCG.transform.localScale = Vector3(uiParams.offsetScale, uiParams.offsetScale, 1)
  end
end
