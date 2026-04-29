_class("SeasonMazePlayerModel", Object)
SeasonMazePlayerModel = SeasonMazePlayerModel

function SeasonMazePlayerModel:Constructor(player, mazeID)
  self._player = player
  self:_LoadModel(mazeID)
end

function SeasonMazePlayerModel:Update(deltaTime)
  if self._shadow then
    self._shadow:Update(deltaTime)
  end
end

function SeasonMazePlayerModel:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._shadow:Dispose()
  self._shadow = nil
end

function SeasonMazePlayerModel:_LoadModel(mazeID)
  local cfg = Cfg.cfg_season_maze_client[mazeID]
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(cfg.PlayerRes, LoadType.GameObject)
  if not self._resRequest then
    Log.error("加载不到赛季秘境主角")
  end
  self._gameObject = self._resRequest.Obj
  self._transform = self._gameObject.transform
  self._transform:SetParent(self._player:PlayerTansform())
  local position = Vector3.zero
  local rotation = Vector3(-43.6, 2.7, -2.4)
  local scale = cfg.PlayerScale
  self._transform.position = position
  self._transform.rotation = Quaternion.Euler(rotation.x, rotation.y, rotation.z)
  self._transform.localScale = Vector3.one * scale
  self._rootTransform = self._transform:Find("Root")
  self._animation = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._capsuleCollider = self._gameObject:AddComponent(typeof(UnityEngine.CapsuleCollider))
  if self._capsuleCollider then
    UnityEngine.Object.Destroy(self._capsuleCollider)
  end
  self._gameObject:SetActive(true)
  self._shadow = SeasonMazePlayerShadow:New(self:RootTransform())
end

function SeasonMazePlayerModel:GameObject()
  return self._gameObject
end

function SeasonMazePlayerModel:Transform()
  return self._transform
end

function SeasonMazePlayerModel:Position()
  return self._transform.position
end

function SeasonMazePlayerModel:Rotation()
  return self._transform.rotation
end

function SeasonMazePlayerModel:RootTransform()
  return self._rootTransform
end

function SeasonMazePlayerModel:SetActive(active)
  self._gameObject:SetActive(active)
  if active then
    self._shadow:UpdateMaterialProperty()
  end
end

function SeasonMazePlayerModel:SetPR(position, rotation)
  self._transform.position = position
  self._transform.rotation = rotation
end

function SeasonMazePlayerModel:Animation()
  return self._animation
end

function SeasonMazePlayerModel:Rotate(up, deltaAngle, space)
  self._transform:Rotate(up, deltaAngle, space)
end

function SeasonMazePlayerModel:SetPosition(pos)
  self._transform.position = pos
end

function SeasonMazePlayerModel:Rotation()
  return self._transform.rotation
end

function SeasonMazePlayerModel:StopFootEffect()
  self._footEffect:Stop()
end

function SeasonMazePlayerModel:PlayFootEffect()
  self._footEffect:Play()
end
