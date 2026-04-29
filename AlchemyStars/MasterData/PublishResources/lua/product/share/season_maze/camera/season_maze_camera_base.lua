_class("SeasonMazeCameraBase", Object)
SeasonMazeCameraBase = SeasonMazeCameraBase

function SeasonMazeCameraBase:Constructor(seasonMazeID)
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self._seasonID = self._uiSeasonMazeModule:GetSeasonID()
  self._cameraSeasonCfg = Cfg.cfg_season_maze_camera[seasonMazeID]
  self._seasonMapCfg = Cfg.cfg_season_map[self._seasonID]
  self._cameraSizeMin = self._cameraSeasonCfg.CameraSizeMin
  self._cameraSizeMax = self._cameraSeasonCfg.CameraSizeMax
  self._mapLeft = self._seasonMapCfg.MapDragRange[1]
  self._mapTop = self._seasonMapCfg.MapDragRange[2]
  self._mapRight = self._seasonMapCfg.MapDragRange[3]
  self._mapBottom = self._seasonMapCfg.MapDragRange[4]
  self._cameraSpeed = 0.005
  self._cameraSizeSpeed = 0.005
  self._dragValue = 50
  self._startPosition = Vector3.zero
  self._endPosition = Vector3.zero
  self._draging = false
  self._inputPhase = SeasonInputPhase.None
  self._touchFingerID = nil
  self._targetPosition = nil
  self._deltaPosition = nil
  self._recordSize = nil
  self._sizeTweenTime = 1
  self._cameraSize = SeasonMazeTool:GetInstance():GetLocalDBFloat("SeasonMazeCameraSize", self._cameraSeasonCfg.DefaultSize)
  self._input = GameGlobal.EngineInput()
  self._mode = SeasonCameraMode.Drag
  self._cameraGO = UnityEngine.GameObject.Find("Main Camera")
  if not self._cameraGO then
    Log.fatal("SeasonMazeCameraBase can not found MainCamera!")
  end
  self._camera = self._cameraGO:GetComponent("Camera")
  self._cameraTransform = self._cameraGO.transform
  self._effectTransform = self._cameraTransform:Find("Effect")
  if self._effectTransform then
    self._effectTransform.localScale = Vector3(self._cameraSize, self._cameraSize, self._cameraSize)
    self._effectTransform.gameObject:SetActive(true)
  end
  self._unlockTweenTime = 1
  self._renderers = {}
  self:_CacheEffectRender()
  self._seasonManager = self._uiSeasonMazeModule:SeasonMazeManager()
  self._player = self._seasonManager:Player()
  self._rtCameraGO = self._cameraTransform:Find("RTCamera")
  self._rtCamera = self._rtCameraGO:GetComponent("Camera")
  local rt = self._rtCamera.targetTexture
  self._cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width * 0.25, UnityEngine.Screen.height * 0.25, 16)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, self._cache_rt)
    self._rtCamera.targetTexture = self._cache_rt
    UnityEngine.Shader.SetGlobalTexture("_RTMask", self._rtCamera.targetTexture)
    UnityEngine.Shader.SetGlobalTexture("_RTMask1", self._rtCamera.targetTexture)
  end)
end

function SeasonMazeCameraBase:DoCameraSizeScaleAni(TT, scale)
  if not self._camera then
    return
  end
  self._cameraAniPlaying = true
  local oldSize = self._camera.orthographicSize
  local targetSize = oldSize * scale
  DoTweenHelper.DoUpdateFloat(-1, 1, 0.9, function(val)
    local t = math.abs(val)
    local size = Mathf.Lerp(targetSize, oldSize, t)
    self._camera.orthographicSize = size
    self._rtCamera.orthographicSize = size
  end)
  YIELD(TT, 1000)
  self._cameraAniPlaying = false
end

function SeasonMazeCameraBase:Update(deltaTime)
  if self._cameraAniPlaying then
    return false
  end
  if self._camera then
    local size = Mathf.Lerp(self._camera.orthographicSize, self._cameraSize, deltaTime * self._cameraSizeSpeed)
    self._camera.orthographicSize = size
    self._rtCamera.orthographicSize = size
  end
  if self._cameraTransform then
    local position = self._cameraTransform.position
    if self._mode == SeasonCameraMode.Follow then
      if self._player then
        position = Vector3(self._player:Position().x, self._cameraTransform.position.y, self._player:Position().z)
        position = Vector3.Lerp(self._cameraTransform.position, position, deltaTime * self._cameraSpeed)
      end
    elseif self._mode == SeasonCameraMode.Drag and self._targetPosition then
      position = Vector3.Lerp(self._cameraTransform.position, self._targetPosition, deltaTime * self._cameraSpeed)
    end
    self._cameraTransform.position = self:ConstraintPosition(position)
  end
end

function SeasonMazeCameraBase:Dispose()
  if not self._recordSize then
    SeasonMazeTool:GetInstance():SetLocalDBFloat("SeasonMazeCameraSize", self._camera.orthographicSize)
  end
  self._input.multiTouchEnabled = false
  self._camera = nil
  self._cameraTransform = nil
  self._player = nil
  self._targetPosition = nil
  self._deltaPosition = nil
  self._recordSize = nil
  if self._tweenTask then
    GameGlobal.TaskManager():KillTask(self._tweenTask)
    self._tweenTask = nil
  end
  table.clear(self._renderers)
end

function SeasonMazeCameraBase:SwitchMode(mode)
  self._mode = mode
end

function SeasonMazeCameraBase:Camera()
  return self._camera
end

function SeasonMazeCameraBase:IsDraging()
  return self._draging
end

function SeasonMazeCameraBase:Focus(position)
  self:SwitchMode(SeasonCameraMode.Drag)
  self:SetPosition(position)
end

function SeasonMazeCameraBase:ChangePos(pos)
  local position = Vector3(pos.x, self._cameraTransform.position.y, pos.z)
  self._cameraTransform.position = self:ConstraintPosition(position)
end

function SeasonMazeCameraBase:Transform()
  return self._cameraTransform
end

function SeasonMazeCameraBase:Position()
  return self._cameraTransform.position
end

function SeasonMazeCameraBase:SetPosition(position)
  self._targetPosition = Vector3(position.x, self._cameraTransform.position.y, position.z)
end

function SeasonMazeCameraBase:SetPositionForce()
  local cfgs = Cfg.cfg_season_map_player({
    SeasonID = self._seasonID
  })
  if cfgs and cfgs[1] then
    local position = Vector3(cfgs[1].Position[1], self._cameraTransform.position.y, cfgs[1].Position[3])
    self._cameraTransform.position = self:ConstraintPosition(position)
  end
end

function SeasonMazeCameraBase:RenderTexture()
  return self._rtCamera.targetTexture
end

function SeasonMazeCameraBase:ConstraintPosition(position)
  local aspect = self._camera.aspect
  local size = self._camera.orthographicSize
  local width = size * aspect
  local height = size
  local topLeft = Vector3(width, 0, -height)
  local bottomRight = Vector3(-width, 0, height)
  local expectTopLeft = topLeft + position
  local expectBottomRight = bottomRight + position
  if expectTopLeft.x >= self._mapLeft then
    position.x = self._mapLeft - width
  end
  if expectTopLeft.z <= self._mapTop then
    position.z = self._mapTop + height
  end
  if expectBottomRight.x <= self._mapRight then
    position.x = self._mapRight + width
  end
  if expectBottomRight.z >= self._mapBottom then
    position.z = self._mapBottom - height
  end
  return position
end

function SeasonMazeCameraBase:Size()
  return self._camera.orthographicSize
end

function SeasonMazeCameraBase:MinSize()
  return self._cameraSizeMin
end

function SeasonMazeCameraBase:MaxSize()
  return self._cameraSizeMax
end

function SeasonMazeCameraBase:SetSize(size)
  self._cameraSize = size
end

function SeasonMazeCameraBase:GetSize()
  return self._cameraSize
end

function SeasonMazeCameraBase:SetRecordSize(size)
  self._recordSize = size
end

function SeasonMazeCameraBase:GetRecordSize()
  return self._recordSize
end

function SeasonMazeCameraBase:TryResumeSize()
  if self._recordSize then
    self:SetSize(self._recordSize)
    self:SetRecordSize(nil)
    self:Focus(Vector3(self._player:Position().x, 0, self._player:Position().z))
  end
end

function SeasonMazeCameraBase:FocusDone()
  local p1 = self:ConstraintPosition(self._targetPosition)
  local p2 = Vector3(self._cameraTransform.position.x, self._targetPosition.y, self._cameraTransform.position.z)
  return Vector3.Distance(p1, p2) <= 0.2
end

function SeasonMazeCameraBase:SizeDone()
  return math.abs(self._camera.orthographicSize - self._cameraSize) <= 0.3
end

function SeasonMazeCameraBase:_CacheEffectRender()
  local effect = self._cameraTransform:Find("Effect1")
  if effect then
    table.clear(self._renderers)
    local renderers = effect.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
    if renderers.Length > 0 then
      for i = 0, renderers.Length - 1 do
        table.insert(self._renderers, renderers[i])
      end
    end
  end
end

function SeasonMazeCameraBase:UnLock(zoneMask, zoneID2Animation)
  local v4 = SeasonMazeTool:GetInstance():GetV4ByZoneMask(zoneMask, zoneID2Animation)
  for _, renderer in pairs(self._renderers) do
    if renderer and renderer.material then
      if renderer.material:HasProperty("_AreaUnlockMask") then
        renderer.material:SetVector("_AreaUnlockMask", v4)
      end
      if renderer.material:HasProperty("_AreaUnlockMask1") then
        renderer.material:SetVector("_AreaUnlockMask1", v4)
      end
    end
  end
  self._zoneMask = zoneMask
  self:TweenV4()
end

function SeasonMazeCameraBase:TweenV4()
  self._tweenTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    local v4 = SeasonMazeTool:GetInstance():GetV4ByZoneMask(self._zoneMask)
    for _, renderer in pairs(self._renderers) do
      if renderer and renderer.material then
        if renderer.material:HasProperty("_AreaUnlockMask") then
          renderer.material:DOVector(v4, "_AreaUnlockMask", self._unlockTweenTime)
        end
        if renderer.material:HasProperty("_AreaUnlockMask1") then
          renderer.material:DOVector(v4, "_AreaUnlockMask1", self._unlockTweenTime)
        end
      end
    end
  end)
end
