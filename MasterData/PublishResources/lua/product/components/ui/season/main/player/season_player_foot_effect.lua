_class("SeasonPlayerFootEffect", Object)
SeasonPlayerFootEffect = SeasonPlayerFootEffect

function SeasonPlayerFootEffect:Constructor(cfg, rootTransform)
  self._cfg = cfg
  self._rootTransform = rootTransform
  self:_LoadEffect()
end

function SeasonPlayerFootEffect:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
end

function SeasonPlayerFootEffect:_LoadEffect()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.FootEffect, LoadType.GameObject)
  if not self._resRequest then
    Log.error("SeasonPlayerFootEffect load rooteffect fail.", self._cfg.FootEffect)
    return
  end
  self._effectGO = self._resRequest.Obj
  self._effectGO.transform:SetParent(self._rootTransform)
  self._effectGO.transform.localPosition = Vector3.zero
  self._effectGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
  self._effectGO:SetActive(true)
end

function SeasonPlayerFootEffect:Stop()
  if self._effectGO then
    self._effectGO:SetActive(false)
  end
end

function SeasonPlayerFootEffect:Play()
  if self._effectGO then
    self._effectGO:SetActive(true)
  end
end
