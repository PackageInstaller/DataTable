_class("SeasonMazePlayer", Object)
SeasonMazePlayer = SeasonMazePlayer

function SeasonMazePlayer:Constructor(mn)
  self._seasonMazeManager = mn
  self._crossFadeTime = 0.2
  self._curModel = nil
  self._curMapMaterial = SeasonMapMaterial.Default
  self._isDisposed = nil
  self._y = 1
end

function SeasonMazePlayer:OnInit(mazeID)
  self:_CreatePlayer()
  self:_CreateModels(mazeID)
  self._headSlot = GameObjectHelper.FindChild(self._playerRoot.transform, "Bip001 HeadNub")
  self._coverManager = self._seasonMazeManager:SeasonMazeCoverManager()
  self._zoneFlagLayer = self._seasonMazeManager:SeasonMazeSceneManager():GetLayer(SeasonSceneLayer.ZoneFlag)
  self._mapMaterialLayer = self._seasonMazeManager:SeasonMazeSceneManager():GetLayer(SeasonSceneLayer.SoundMaterial)
  local cfg = Cfg.cfg_season_maze_client[mazeID]
  self._interactDuration = cfg.PlayerIdleTime
  self._interactTimer = self._interactDuration
  self._playerEffect = SeasonMazePlayerEffect:New()
  self._playerEffect:Init(self._playerRoot)
end

function SeasonMazePlayer:PlayEffect(key, position)
  if self._playerEffect then
    self._playerEffect:PlayEffect(key, position)
  end
end

function SeasonMazePlayer:PlayEffectWithParent(key, parent)
  if self._playerEffect then
    self._playerEffect:PlayEffectWithParent(key, parent)
  end
end

function SeasonMazePlayer:_CreatePlayer()
  self._playerRoot = GameObjectHelper.CreateEmpty("Player", nil)
  self._agent = GameObjectHelper.CreateEmpty("Agent", nil)
  self._agentTransform = self._agent.transform
  self._agentTransform:SetParent(self._playerRoot.transform)
  self._agentTransform.position = Vector3.zero
end

function SeasonMazePlayer:_CreateModels(mazeID)
  self._curModel = SeasonMazePlayerModel:New(self, mazeID)
  self._follower = SeasonMazePlayerFollower:New(self, mazeID)
end

function SeasonMazePlayer:Dispose(isExit)
  self._isDisposed = true
  self._playerEffect:Dispose()
  self._curModel:Dispose()
  self._curModel = nil
  UnityEngine.Object.Destroy(self._playerRoot)
  self._coverManager = nil
  self._follower:Dispose()
end

function SeasonMazePlayer:Update(deltaTime)
  if self._isDisposed then
    return
  end
  self._curModel:Update(deltaTime)
  self._follower:Update(deltaTime)
  self:_CheckPosition(0)
  self:_CheckCover()
  self._interactTimer = self._interactTimer - deltaTime
  if 0 >= self._interactTimer and not self._onBattleRoom then
    self:ResetRotation()
    self:PlayAnimation(SeasonMazePlayerAnimation.Click)
    self:PlayAnimationQueued(SeasonMazePlayerAnimation.Stand, 0.3)
    self._interactTimer = self._interactDuration
  end
end

function SeasonMazePlayer:IsPlayer(gameObject)
  return gameObject and gameObject == self._curModel:GameObject()
end

function SeasonMazePlayer:PlayerRoot()
  return self._playerRoot
end

function SeasonMazePlayer:PlayerTansform()
  return self._playerRoot.transform
end

function SeasonMazePlayer:AgentTansform()
  return self._agentTransform
end

function SeasonMazePlayer:Position()
  return self._agentTransform.position
end

function SeasonMazePlayer:HeadPosition()
  return self._agentTransform.position + self._curModel:RootTransform().up * 0.81
end

function SeasonMazePlayer:Rotation()
  return self._agentTransform.rotation
end

function SeasonMazePlayer:PlayAnimation(name, fadeTime)
  local animation = self._curModel:Animation()
  if not animation or not name then
    return
  end
  fadeTime = fadeTime or self._crossFadeTime
  animation:CrossFade(name, fadeTime)
  local fanim = self._follower:Animation()
  if fanim and name then
    fanim:CrossFade(name, fadeTime)
  end
end

function SeasonMazePlayer:PlayAnimationQueued(name, fadeTime)
  local animation = self._curModel:Animation()
  if not animation or not name then
    return
  end
  fadeTime = fadeTime or self._crossFadeTime
  animation:CrossFadeQueued(name, fadeTime)
  local fanim = self._follower:Animation()
  if fanim and name then
    fanim:CrossFadeQueued(name, fadeTime)
  end
end

function SeasonMazePlayer:InteractOnRoom(roomType)
  if roomType == SeasonMazeRoomType.SMRT_PVE then
    self:SetBattleRoomState(true)
    self:ResetRotation()
    self:PlayAnimation(SeasonMazePlayerAnimation.BattleIdle)
  elseif roomType == SeasonMazeRoomType.SMRT_Empty then
    self:ResetRotation()
    self:PlayAnimation(SeasonMazePlayerAnimation.Stand)
    self._interactTimer = self._interactDuration
  else
    self:ResetRotation()
    self._interactTimer = self._interactDuration
  end
end

function SeasonMazePlayer:_CheckCover(deltaTime)
  self._coverManager:OnCoverCheck(self._curModel:Position())
end

function SeasonMazePlayer:GetBoneNode(name)
  local boneTransform = GameObjectHelper.FindChild(self._curModel:Transform(), name)
  if boneTransform then
    return boneTransform
  end
  return self._curModel:Transform()
end

function SeasonMazePlayer:RotateToPosition(targetPosition, speed)
  local targetPosition = Vector3(targetPosition.x, self._y, targetPosition.z)
  local direction = targetPosition - self._agentTransform.position
  local angle = Vector3.Angle(self._agentTransform.forward, direction)
  local cross = Vector3.Cross(self._agentTransform.forward, direction)
  if cross.y < 0 then
    angle = -angle
  end
  speed = speed or 1
  local up = self._agentTransform.up
  angle = angle * speed
  local axis = UnityEngine.Space.Self
  self._agentTransform:Rotate(up, angle, axis)
  self._curModel:Rotate(up, angle, axis)
end

function SeasonMazePlayer:_CheckPosition(deltaTime)
  local mapMaterial = SeasonMapMaterial.Default
  local originPos = self._agentTransform.position
  originPos.y = originPos.y + 0.2
  local direction = Vector3(0, -1, 0)
  local results = UnityEngine.Physics.RaycastAll(originPos, direction, 1000, 1 << SeasonLayerMask.Scene)
  if results and 0 < results.Length then
    local sortResult = {}
    for i = 0, results.Length - 1 do
      table.insert(sortResult, results[i])
    end
    table.sort(sortResult, function(a, b)
      return a.point.y > b.point.y
    end)
    local findSoudMat = false
    for i = 1, #sortResult do
      local trans = sortResult[i].transform
      if not findSoudMat then
        mapMaterial, findSoudMat = self._mapMaterialLayer:GetMapMaterial(trans.gameObject)
      end
    end
  end
  if self._curMapMaterial ~= mapMaterial then
    self._curMapMaterial = mapMaterial
  end
end

function SeasonMazePlayer:PlayStepAudio(deltaTime)
  if self._seasonMazeManager:SeasonMazeAudioManager():GetSeasonMazeAudio() then
    self._seasonMazeManager:SeasonMazeAudioManager():GetSeasonMazeAudio():PlayStepSound(self._curMapMaterial, deltaTime)
  end
end

function SeasonMazePlayer:SetPos(pos)
  pos.y = self._y
  self._agentTransform.position = pos
  self._curModel:SetPosition(pos)
  self._interactTimer = self._interactDuration
end

function SeasonMazePlayer:GetModelTransform()
  return self._curModel:Transform()
end

function SeasonMazePlayer:GetModelGameObject()
  return self._curModel:GameObject()
end

function SeasonMazePlayer:GetUp()
  return self._agentTransform.up
end

function SeasonMazePlayer:MoveFollowerImmidiately()
  self._follower:FollowImmidiately()
end

function SeasonMazePlayer:SetBattleRoomState(isBattleRoom)
  self._onBattleRoom = isBattleRoom
end

function SeasonMazePlayer:ResetRotation()
  self:RotateToPosition(self:Position() + Vector3.forward)
end

function SeasonMazePlayer:ModelRotation()
  return self._curModel:Rotation()
end
