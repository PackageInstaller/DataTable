_class("SeasonPlayerModel", Object)
SeasonPlayerModel = SeasonPlayerModel

function SeasonPlayerModel:Constructor(player, cfg, clientInfo)
  self._player = player
  self._cfg = cfg
  self._clientInfo = clientInfo
  self:_LoadModel()
end

function SeasonPlayerModel:Update(deltaTime)
  if self._shadow then
    self._shadow:Update(deltaTime)
  end
end

function SeasonPlayerModel:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._footEffect:Dispose()
  self._footEffect = nil
  self._shadow:Dispose()
  self._shadow = nil
end

function SeasonPlayerModel:_LoadModel()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.PlayerRes, LoadType.GameObject)
  if not self._resRequest then
    Log.error("SeasonPlayerModel load modle res fail.", self._cfg.PlayerRes)
  end
  self._gameObject = self._resRequest.Obj
  self._transform = self._gameObject.transform
  self._transform:SetParent(self._player:PlayerTansform())
  local position = Vector3(self._cfg.Position[1], self._cfg.Position[2], self._cfg.Position[3])
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  if uiSeasonModule:IsBackTrack() then
    local seasonId = uiSeasonModule:BackTrackID()
    local cfgs = Cfg.cfg_season_map_player({SeasonID = seasonId})
    if cfgs and cfgs[1] then
      position = Vector3(cfgs[1].Position[1], cfgs[1].Position[2], cfgs[1].Position[3])
    end
  elseif self._clientInfo.m_x ~= 0 or self._clientInfo.m_z ~= 0 then
    position.x = self._clientInfo.m_x
    position.z = self._clientInfo.m_z
  end
  self._transform.position = position
  self._transform.rotation = Quaternion.Euler(self._cfg.Rotation[1], self._cfg.Rotation[2], self._cfg.Rotation[3])
  self._transform.localScale = Vector3.one * self._cfg.Scale
  self._rootTransform = self._transform:Find("Root")
  self._animation = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
  self._capsuleCollider = self._gameObject:AddComponent(typeof(UnityEngine.CapsuleCollider))
  self._capsuleCollider.center = Vector3(self._cfg.Center[1], self._cfg.Center[2], self._cfg.Center[3])
  self._capsuleCollider.height = self._cfg.Height
  self._capsuleCollider.radius = self._cfg.Radius
  self._gameObject:SetActive(false)
  self._shadow = SeasonPlayerShadow:New(self)
  self._footEffect = SeasonPlayerFootEffect:New(self._cfg, self._rootTransform)
end

function SeasonPlayerModel:Cfg()
  return self._cfg
end

function SeasonPlayerModel:MapMode()
  return self._cfg.MapMode
end

function SeasonPlayerModel:Speed()
  return self._cfg.Speed
end

function SeasonPlayerModel:IsDefault()
  return self._cfg.Default
end

function SeasonPlayerModel:GameObject()
  return self._gameObject
end

function SeasonPlayerModel:Transform()
  return self._transform
end

function SeasonPlayerModel:Position()
  return self._transform.position
end

function SeasonPlayerModel:Rotation()
  return self._transform.rotation
end

function SeasonPlayerModel:RootTransform()
  return self._rootTransform
end

function SeasonPlayerModel:SetActive(active)
  self._gameObject:SetActive(active)
  if active then
    self._shadow:UpdateMaterialProperty()
  end
end

function SeasonPlayerModel:SetPR(position, rotation)
  self._transform.position = position
  self._transform.rotation = rotation
end

function SeasonPlayerModel:Animation()
  return self._animation
end

function SeasonPlayerModel:Rotate(up, deltaAngle, space)
  self._transform:Rotate(up, deltaAngle, space)
end

function SeasonPlayerModel:SetPosition(x, y, z)
  self._transform.position = Vector3(x, self._transform.position.y, z)
end

function SeasonPlayerModel:ResetPosition()
  self._transform.position = Vector3(self._cfg.Position[1], self._cfg.Position[2], self._cfg.Position[3])
end

function SeasonPlayerModel:OnCheckCondition(model, map)
  if self._cfg.Condition then
    return model:CheckCondition(self._cfg.Condition, map)
  else
    return true
  end
end

function SeasonPlayerModel:CheckNavAreaModel(areaName)
  if not areaName or not self._cfg.NavName then
    return false
  end
  if string.find(areaName, self._cfg.NavName) then
    return true
  end
  return false
end

function SeasonPlayerModel:StopFootEffect()
  self._footEffect:Stop()
end

function SeasonPlayerModel:PlayFootEffect()
  self._footEffect:Play()
end
