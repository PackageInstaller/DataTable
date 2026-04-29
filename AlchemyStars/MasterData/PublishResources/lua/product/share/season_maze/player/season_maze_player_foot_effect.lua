_class("SeasonMazePlayerFootEffect", Object)
SeasonMazePlayerFootEffect = SeasonMazePlayerFootEffect

function SeasonMazePlayerFootEffect:Constructor(rootTransform)
  self._rootTransform = rootTransform
  self:_LoadEffect()
end

function SeasonMazePlayerFootEffect:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
end

function SeasonMazePlayerFootEffect:_LoadEffect()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset("eff_Scene_yd_rootpoint.prefab", LoadType.GameObject)
  if not self._resRequest then
    Log.error("加载不到赛季秘境主角特效")
    return
  end
  self._effectGO = self._resRequest.Obj
  self._effectGO.transform:SetParent(self._rootTransform)
  self._effectGO.transform.localPosition = Vector3.zero
  self._effectGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
  self._effectGO:SetActive(true)
end

function SeasonMazePlayerFootEffect:Stop()
  if self._effectGO then
    self._effectGO:SetActive(false)
  end
end

function SeasonMazePlayerFootEffect:Play()
  if self._effectGO then
    self._effectGO:SetActive(true)
  end
end
