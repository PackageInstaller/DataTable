_class("SeasonPlayer", Object)
SeasonPlayer = SeasonPlayer

function SeasonPlayer:Constructor()
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonID = self._seasonModule.uiModule:GetSeasonID()
  self._cfgs = Cfg.cfg_season_map_player({SeasonID = seasonID})
  if not self._cfgs then
    Log.fatal("SeasonPlayer not cfg!")
  end
  self._navTransEndPoint = nil
  self._navTransTargetPosition = nil
  self._curWalkNavName = nil
  self._curNavAreaModelName = nil
  local curObj = self._seasonModule:GetCurSeasonObj()
  self._componentInfo = curObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._clientInfo = self._componentInfo.m_client_info
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._seasonMapManager = self._seasonManager:SeasonMapManager()
  self._coverManager = self._seasonManager:SeasonCoverManager()
  self._coverByNavManager = self._seasonManager:SeasonCoverByNavManager()
  self._showByNavManager = self._seasonManager:SeasonShowByNavManager()
  self._showByNavMnager = self._seasonManager:SeasonShowByNavManager()
  self._zoneFlagLayer = self._seasonManager:SeasonSceneManager():GetLayer(SeasonSceneLayer.ZoneFlag)
  self._navManager = self._seasonManager:NavManager()
  self._navManager:SetPlayer(self)
  self._navManager:InitOffMeshLinkData()
  self._cameraManager = self._seasonManager:SeasonCameraManager()
  self._mapMaterialLayer = self._seasonManager:SeasonSceneManager():GetLayer(SeasonSceneLayer.SoundMaterial)
  self:_CreatePlayer()
  self._crossFadeTime = 0.2
  self._curModel = nil
  self._models = {}
  self:_CreateModels()
  self._line = SeasonPlayerLine:New(self._playerRoot, self._navMeshAgent)
  self._fixedLine = SeasonPlayerFixedLine:New(self._playerRoot)
  self._curMapMaterial = SeasonMapMaterial.Default
  self._syncPosTimer = 0
  self._syncPosDuration = 10000
  self._curZone = SeasonZone.One
  self._express = SeasonPlayerExpress:New(self, self._seasonManager)
  self:_SetDefaultModel()
  self:_CheckPosition(0)
  self:CheckCover()
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.OnEventPointProgressChange, self, self._OnCheckSwitchModel)
  self._playerEffect = SeasonPlayerEffect:New()
  self._playerEffect:Init(self._playerRoot)
  self._isDisposed = nil
end

function SeasonPlayer:_CreatePlayer()
  self._playerRoot = GameObjectHelper.CreateEmpty("Player", nil)
  self._agent = GameObjectHelper.CreateEmpty("Agent", nil)
  self._agentTransform = self._agent.transform
  self._agentTransform:SetParent(self._playerRoot.transform)
  self._agentTransform.position = Vector3.zero
  self._navMeshAgent = self._agent:AddComponent(typeof(UnityEngine.AI.NavMeshAgent))
  self._navMeshAgent.agentTypeID = HelperProxy:GetInstance():GetNavAgentID(AircraftNavAgent.Normal)
  self._navMeshAgent.angularSpeed = 0
  self._navMeshAgent.acceleration = 0
  self._navMeshAgent.speed = 0
  self._navMeshAgent.stoppingDistance = 0.1
  self._navMeshAgent.autoBraking = false
  self._navMeshAgent.enabled = false
  self._navMeshAgent.autoTraverseOffMeshLink = false
  self._navMeshAgent.radius = 0.15
  self:SetNavAreaMask(1)
  self._helpAgent = UnityEngine.GameObject.Instantiate(self._agent, self._agent.transform.parent)
  self._navMeshHelpAgent = self._helpAgent:GetComponent(typeof(UnityEngine.AI.NavMeshAgent))
  self._navMeshHelpAgent.enabled = false
end

function SeasonPlayer:SetNavAreaMask(mask)
  self._navAreaMask = mask
  self._navMeshAgent.areaMask = mask
end

function SeasonPlayer:_CreateModels()
  for _, cfg in ipairs(self._cfgs) do
    table.insert(self._models, SeasonPlayerModel:New(self, cfg, self._clientInfo))
  end
end

function SeasonPlayer:_SetDefaultModel()
  local key = tonumber(self._seasonModule:GetCurSeasonID() .. SeasonKey.Mode)
  local curMode = self._clientInfo.ext[key]
  if curMode then
    self:SwitchModel(curMode)
  else
    local cfg = Cfg.cfg_season_map[self._seasonModule:GetCurSeasonID()]
    if cfg then
      self:SwitchModel(cfg.Mode)
    end
  end
end

function SeasonPlayer:SwitchModel(mapMode)
  self:_OnSwitchModel(mapMode)
end

function SeasonPlayer:Dispose(isExit)
  self._isDisposed = true
  if isExit then
    self:SyncPosition(true)
  end
  self._playerEffect:Dispose()
  for _, model in pairs(self._models) do
    model:Dispose()
  end
  table.clear(self._models)
  self._curModel = nil
  self._line:Dispose()
  self._fixedLine:Dispose()
  UnityEngine.Object.Destroy(self._playerRoot)
  self._agent = nil
  self._navMeshAgent = nil
  self._coverManager = nil
  self._line = nil
  self._fixedLine = nil
  self._express = nil
  self._autoBinder:UnBindAllEvents()
end

function SeasonPlayer:Update(deltaTime)
  if self._isDisposed then
    return
  end
  if self._navTransEffPlaying then
    return
  end
  if tolua.isnull(self._navMeshAgent) or not self._navMeshAgent then
    return
  end
  if not tolua.isnull(self._navMeshHelpAgent) and self._navMeshHelpAgent and self._navMeshHelpAgent.enabled then
    local length = self._navMeshHelpAgent.path.corners.Length
    if 2 <= length then
      local index = length - 1
      local targetOnNav = Vector3(self._navMeshHelpAgent.path.corners[index].x, self._navMeshHelpAgent.path.corners[index].y, self._navMeshHelpAgent.path.corners[index].z)
      self._navTransTargetPosition = targetOnNav
      self._navMeshHelpAgent.enabled = false
      self:NavToOtherIsland()
    end
    return
  end
  if self._navMeshAgent.enabled and self.findDestinationOnNav then
    local length = self._navMeshAgent.path.corners.Length
    if 2 <= length then
      local index = length - 1
      local targetOnNav = Vector3(self._navMeshAgent.path.corners[index].x, self._navMeshAgent.path.corners[index].y, self._navMeshAgent.path.corners[index].z)
      self:SetDestinationOnNav(targetOnNav)
    end
    return
  end
  if self._navMeshAgent.enabled and not self.findDestinationOnNav then
    if Vector3.Distance(self._navMeshAgent.destination, self._agentTransform.position) <= self._navMeshAgent.stoppingDistance then
      if self._navTransEndPoint then
        self._navTransEffPlaying = true
        local endPos = self._navTransEndPoint:GetNavPosition()
        self._agentTransform.position = endPos
        self._curModel:StopFootEffect()
        self._curModel:SetPosition(self._agentTransform.position.x, 0, self._agentTransform.position.z)
        self._navMeshAgent.enabled = false
        self._fixedLine:ClearLineRender()
        self:_SetAgentTransDestination(self._navTransTargetPosition)
        self._navTransStartPoint:PlayTransAni()
        self._navTransEndPoint:PlayTransAni()
        self._playerEffect:PlayEffectWithParent("TransEndPoint", self._curModel:GameObject().transform)
        self._curModel:PlayFootEffect()
        self._navTransEffPlaying = nil
        self._navTransEndPoint = nil
        self:_CheckPosition(deltaTime)
      else
        self:Stop(true)
        self:_CheckPosition(deltaTime)
      end
    else
      self:_CheckPosition(deltaTime)
      if self._navMeshAgent.isOnOffMeshLink then
        local linkName = self._navMeshAgent.navMeshOwner.name
        local cfg = self._navManager:GetOffMeshLinkData(linkName)
        if not cfg then
          Log.fatal("can't find cfg_season_map_nav_link by name ", linkName)
        else
          local endCfg = cfg.End
          local pos = Vector3(endCfg[1], endCfg[2], endCfg[3])
          local startPos = Vector3(self._agentTransform.position.x, 1, self._agentTransform.position.z)
          self._playerEffect:PlayEffect("TransStartPoint", startPos)
          self._agentTransform.position = pos
          self._curModel:SetPosition(self._agentTransform.position.x, 0, self._agentTransform.position.z)
          self._navMeshAgent:CompleteOffMeshLink()
          local endPos = Vector3(self._agentTransform.position.x, 1, self._agentTransform.position.z)
          self._playerEffect:PlayEffect("TransEndPoint", endPos)
        end
      end
      local length = self._navMeshAgent.path.corners.Length
      if 2 <= length then
        local nextPosition = Vector3(self._navMeshAgent.path.corners[1].x, self._agentTransform.position.y, self._navMeshAgent.path.corners[1].z)
        local direction = nextPosition - self._agentTransform.position
        self._agentTransform:Translate(direction.normalized * UnityEngine.Time.deltaTime * self._navMeshAgent.speed, UnityEngine.Space.World)
        local angle = Vector3.Angle(self._agentTransform.forward, direction)
        local cross = Vector3.Cross(self._agentTransform.forward, direction)
        if cross.y < 0 then
          angle = -angle
        end
        self._agentTransform:Rotate(self._agentTransform.up, angle * UnityEngine.Time.deltaTime * 10, UnityEngine.Space.Self)
        self._curModel:Rotate(self._agentTransform.up, angle * UnityEngine.Time.deltaTime * 10, UnityEngine.Space.Self)
      end
      self._curModel:SetPosition(self._agentTransform.position.x, 0, self._agentTransform.position.z)
    end
    self._line:Update(deltaTime)
    self._curModel:Update(deltaTime)
    self:CheckCover(deltaTime)
    self:_CheckSyncPosition(deltaTime)
  end
  self:_CheckExpress(deltaTime)
  self._express:Update(deltaTime)
end

function SeasonPlayer:IsPlayer(gameObject)
  return gameObject and gameObject == self._curModel:GameObject()
end

function SeasonPlayer:PlayerGameObject()
  return self._playerRoot
end

function SeasonPlayer:PlayerTansform()
  return self._playerRoot.transform
end

function SeasonPlayer:Transform()
  return self._agentTransform
end

function SeasonPlayer:Position()
  return self._agentTransform.position
end

function SeasonPlayer:Rotation()
  return self._agentTransform.rotation
end

function SeasonPlayer:RealTransform()
  return self._curModel:Transform()
end

function SeasonPlayer:RealPosition()
  return self._curModel:Position()
end

function SeasonPlayer:Cfg()
  return self._curModel:Cfg()
end

function SeasonPlayer:GetLastCorners()
  if self._navTransTargetPosition and self._navTransEndPoint then
    return self._navTransTargetPosition
  end
  local length = self._navMeshAgent.path.corners.Length
  if 1 <= length then
    return self._navMeshAgent.path.corners[length - 1]
  end
  return nil
end

function SeasonPlayer:CurZone()
  return self._curZone
end

function SeasonPlayer:CurModule()
  return self._curModel
end

function SeasonPlayer:SetDestination(destination, play_move_click_sound, moveDoneCallback)
  self.findDestinationOnNav = false
  self._navMeshAgent.enabled = false
  self._navMeshHelpAgent.enabled = false
  destination.y = 1
  self._moveTimer = 0
  self._isPlayMoveVoice = false
  self._moveDoneCallback = moveDoneCallback
  self._play_move_click_sound = play_move_click_sound
  local modlePos = self._curModel:Position()
  self:PlayAnimation(SeasonPlayerAnimation.Stand)
  self._line:ClearLineRender()
  self._fixedLine:ClearLineRender()
  self._orignDestination = destination
  self._navTransEndPoint = nil
  self._navTransTargetPosition = nil
  if Vector3.Distance(self._navMeshAgent.destination, modlePos) > self._navMeshAgent.stoppingDistance then
    local targetAtOtherIsland
    if self:HasMoreIsland() then
      local clickZoneId = self._seasonManager:SeasonInputManager():GetClickZoneID()
      local modleAtZone = self:CalCurZone()
      Log.debug("seasonplayer island clickAt zone ", clickZoneId, " modleAtZone ", modleAtZone)
      if clickZoneId and modleAtZone and clickZoneId ~= modleAtZone then
        targetAtOtherIsland = true
        self:TryNavToOtherIsland(modleAtZone, clickZoneId, self._orignDestination)
      end
    end
    if not targetAtOtherIsland then
      self.findDestinationOnNav = true
      self._navMeshAgent.enabled = true
      self._navMeshAgent:SetDestination(destination)
    end
  end
end

function SeasonPlayer:CalCurZone()
  local originPos = self._agentTransform.position
  originPos.y = originPos.y + 0.2
  local direction = Vector3(0, -1, 0)
  local results = UnityEngine.Physics.RaycastAll(originPos, direction, 1000, 1 << SeasonLayerMask.Scene)
  if results and 0 < results.Length then
    for i = 0, results.Length - 1 do
      local trans = results[i].transform
      local contain, zoneID = self._zoneFlagLayer:GetZoneID(trans.gameObject)
      if contain then
        return zoneID
      end
    end
  end
end

function SeasonPlayer:HasMoreIsland()
  local seasonId = self._seasonModule.uiModule:GetSeasonID()
  return self._navManager:HasMoreAsland(seasonId)
end

function SeasonPlayer:TryNavToOtherIsland(startZone, endZone, endPos)
  local startTransPoint, endTransPoint = self._navManager:FindOtherIslandPath(startZone, self._agentTransform.position, endZone, endPos, self._navAreaMask)
  if not startTransPoint or not endTransPoint then
    Log.error("SeasonPlayer:TryNavToOtherIsland 未找到传送点 startZone  ", startZone, " endZone ", endZone)
    return
  end
  self._navTransEndPoint = endTransPoint
  self._navTransStartPoint = startTransPoint
  self._navTransTargetPosition = endPos
  self._navMeshHelpAgent.transform.position = self._navTransEndPoint:GetPosition()
  self._navMeshHelpAgent.enabled = true
  self._navMeshHelpAgent:SetDestination(self._navTransTargetPosition)
end

function SeasonPlayer:NavToOtherIsland()
  self:PlayAnimation(SeasonPlayerAnimation.Move)
  self:_SetAgentTransDestination(self._navTransStartPoint:GetNavPosition())
  self._fixedLine:SetLine(self._navTransEndPoint:GetPosition(), self._navTransTargetPosition, self._navAreaMask)
end

function SeasonPlayer:SetDestinationOnNav(destination)
  self.findDestinationOnNav = nil
  self._navTransEndPoint = nil
  self._fixedLine:ClearLineRender()
  self._express:Interrupt(SeasonPlayerExpressType.Moving)
  local targetPos = Vector3(destination.x, destination.y, destination.z)
  local originPos = self._agentTransform.position
  local startTransPoint, endTransPoint = self._navManager:FindTrasnsPath(originPos, targetPos, self._navAreaMask)
  if startTransPoint and endTransPoint then
    self._navTransEndPoint = endTransPoint
    self._navTransStartPoint = startTransPoint
    self._navTransTargetPosition = destination
    self:_SetAgentTransDestination(startTransPoint:GetNavPosition())
    self._fixedLine:SetLine(endTransPoint:GetPosition(), targetPos, self._navAreaMask)
  else
    self:_SetAgentTransDestination(destination)
  end
  self:PlayAnimation(SeasonPlayerAnimation.Move)
  if self.play_move_click_sound then
    self._seasonManager:SeasonAudioManager():GetSeasonAudio():PlaySound(SeasonCriAudio.Destination)
  end
end

function SeasonPlayer:_SetAgentTransDestination(postion)
  self._navMeshAgent.enabled = true
  self._navMeshAgent:SetDestination(postion)
end

function SeasonPlayer:IsMoveing()
  return self._navMeshAgent.enabled and not self.findDestinationOnNav
end

function SeasonPlayer:PlayAnimation(name, fadeTime)
  local animation = self._curModel:Animation()
  if not animation or not name then
    return
  end
  fadeTime = fadeTime or self._crossFadeTime
  local animationState = animation:get_Item(name)
  if animationState then
    animation:CrossFade(animationState.name, fadeTime)
  else
    Log.error("SeasonPlayer PlayAnimation error. not exist animation", name)
  end
  return animationState
end

function SeasonPlayer:CheckCover(deltaTime)
  self._coverManager:OnCoverCheck(self._curModel:Position())
end

function SeasonPlayer:GetBoneNode(name)
  local boneTransform = GameObjectHelper.FindChild(self._curModel:Transform(), name)
  if boneTransform then
    return boneTransform
  end
  return self._curModel:Transform()
end

function SeasonPlayer:RotateToPosition(position, speed)
  local targetPosition = Vector3(position.x, self._agentTransform.position.y, position.z)
  local direction = targetPosition - self._agentTransform.position
  local angle = Vector3.Angle(self._agentTransform.forward, direction)
  local cross = Vector3.Cross(self._agentTransform.forward, direction)
  if cross.y < 0 then
    angle = -angle
  end
  speed = speed or 1
  self._agentTransform:Rotate(self._agentTransform.up, angle * speed, UnityEngine.Space.Self)
  self._curModel:Rotate(self._agentTransform.up, angle * speed, UnityEngine.Space.Self)
end

function SeasonPlayer:OnMoveStop(playExpress)
  self._moveTimer = 0
  self._isPlayMoveVoice = false
  self:_PlayEventPointExpress(playExpress)
  if self._moveDoneCallback then
    self._moveDoneCallback()
    self._moveDoneCallback = nil
  end
end

function SeasonPlayer:_PlayEventPointExpress(playExpress)
  local seasonInput = self._seasonManager:SeasonInputManager():GetInput()
  if seasonInput then
    if playExpress then
      local curEventPoint = seasonInput:GetCurClickEventPoint()
      if curEventPoint and curEventPoint:IsShow() and curEventPoint:CheckInteractionDistance(self:RealPosition()) and curEventPoint:CheckBacktrack() then
        local isPlaying, id = curEventPoint:IsPlaying()
        if isPlaying then
          Log.error("SeasonPlayer curEventPoint is playing.", curEventPoint:GetID())
          return
        end
        if self:_IsTopUI() then
          self._express:Stop()
          self:RotateToPosition(curEventPoint:Position())
          curEventPoint:PlayExpress(curEventPoint:CurProgress(), SeasonExpressTriggerType.Active, {
            curEventPoint:GroupID()
          })
          seasonInput:SetCurClickEventPoint(nil)
        else
          Log.error("SeasonPlayer PlayEventPointExpress is not top ui.")
        end
      end
    else
      seasonInput:SetCurClickEventPoint(nil)
    end
  end
end

function SeasonPlayer:Stop(playExpress)
  self._navMeshAgent.enabled = false
  self:PlayAnimation(SeasonPlayerAnimation.Stand)
  self:OnMoveStop(playExpress)
  self._line:ClearLineRender()
  self._fixedLine:ClearLineRender()
  local seasonInput = self._seasonManager:SeasonInputManager():GetInput()
  if seasonInput then
    seasonInput:GetClickEffect():Stop()
  end
end

function SeasonPlayer:_CheckPosition(deltaTime)
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
    local bChecked = false
    local findSoudMat = false
    for i = 1, #sortResult do
      local trans = sortResult[i].transform
      local contain, zoneID = self._zoneFlagLayer:GetZoneID(trans.gameObject)
      if contain then
        if not bChecked then
          bChecked = true
          local name = trans.name
          if self._curWalkNavName ~= name then
            Log.info("SeasonPlayer Walk NavAreaChange ", name)
            self:_OnNavAgentAreaChanged(name)
          end
        end
        self._curZone = zoneID
        local unlock = self._seasonManager:SeasonMapManager():IsUnLock(zoneID)
        if self._seasonManager:SeasonInputManager():GetInput() then
          local clickUnlock = self._seasonManager:SeasonInputManager():GetClickUnLockZone()
          if not unlock and not clickUnlock then
            self:Stop(false)
          end
        end
      end
      if not findSoudMat then
        mapMaterial, findSoudMat = self._mapMaterialLayer:GetMapMaterial(trans.gameObject)
      end
    end
  end
  if self._curMapMaterial ~= mapMaterial then
    self._curMapMaterial = mapMaterial
  end
  if self._seasonManager:SeasonAudioManager():GetSeasonAudio() then
    self._seasonManager:SeasonAudioManager():GetSeasonAudio():PlayStepSound(self._curMapMaterial, deltaTime)
  end
end

function SeasonPlayer:_OnNavAgentAreaChanged(areaName)
  self._curWalkNavName = areaName
  self:_OnCheckModelByChangeNavArea(areaName)
  self._coverByNavManager:OnCoverCheck(areaName)
  self._showByNavManager:OnShowCheck(areaName)
end

function SeasonPlayer:_CheckSyncPosition(deltaTime)
  self._syncPosTimer = self._syncPosTimer + deltaTime
  if self._syncPosTimer > self._syncPosDuration then
    self._syncPosTimer = 0
    self:SyncPosition()
  end
end

function SeasonPlayer:SyncPosition(isDispose)
  GameGlobal.TaskManager():StartTask(self._StartSyncPosition, self, isDispose)
end

function SeasonPlayer:_StartSyncPosition(TT, isDispose)
  if self._isSyncing then
    Log.error("SeasonPlayer synchronizing position.")
    return
  end
  local pos = self:_FormatPosition()
  pos.y = 0
  if self._lastSyncPos == pos then
    Log.info("SeasonPlayer position no change.", self._lastSyncPos)
    return
  end
  self._isSyncing = true
  if isDispose then
    Log.info("SeasonPlayer sync position on season exit.", pos)
  end
  local uiSeasonModule = self._seasonModule.uiModule
  if not uiSeasonModule:IsBackTrack() then
    local req = self._seasonModule:HandleSeasonClientDataPoint(TT, pos.x, pos.y, pos.z)
    self._isSyncing = false
    self._lastSyncPos = pos
    if req:GetSucc() then
      Log.info("SeasonPlayer sync position succ.", pos)
    end
  end
end

function SeasonPlayer:_FormatPosition()
  local pos = self:Position()
  local x = math.floor(pos.x * 10000) / 10000
  local y = math.floor(pos.y * 10000) / 10000
  local z = math.floor(pos.z * 10000) / 10000
  return Vector3(x, y, z)
end

function SeasonPlayer:ResetExpress()
  local cfg = self._curModel:Cfg()
  self._relaxTime = Mathf.Random(cfg.RelaxWaitTime[1], cfg.RelaxWaitTime[2]) * 1000
  self._curRelaxTime = 0
  self._movingTime = Mathf.Random(cfg.MovingWaitTime[1], cfg.MovingWaitTime[2]) * 1000
  self._curMoveingTime = 0
  self._express:Stop()
end

function SeasonPlayer:_CheckExpress(deltaTime)
  if self._express then
    if self._express:IsPlaying() then
      self:ClearWaitTime()
    elseif self._navMeshAgent.enabled and not self.findDestinationOnNav then
      self._curRelaxTime = 0
      self._curMoveingTime = self._curMoveingTime + deltaTime
      if self._curMoveingTime >= self._movingTime then
        self._curMoveingTime = 0
        self._movingTime = Mathf.Random(self._curModel:Cfg().MovingWaitTime[1], self._curModel:Cfg().MovingWaitTime[2]) * 1000
        self:TryPlayExpress(SeasonPlayerExpressType.Moving)
      end
    else
      self._curMoveingTime = 0
      self._curRelaxTime = self._curRelaxTime + deltaTime
      if self._curRelaxTime >= self._relaxTime then
        self._curRelaxTime = 0
        self._relaxTime = Mathf.Random(self._curModel:Cfg().RelaxWaitTime[1], self._curModel:Cfg().RelaxWaitTime[2]) * 1000
        self:TryPlayExpress(SeasonPlayerExpressType.Relax)
      end
    end
  end
end

function SeasonPlayer:TryPlayExpress(expressType)
  if self._seasonMapManager:EventPointPlaying() then
    return
  end
  if self:_IsTopUI() then
    self._express:Play(expressType)
  end
end

function SeasonPlayer:_IsTopUI()
  local ui = UISeasonHelper.CurSeasonSceneUI()
  if ui then
    return GameGlobal.UIStateManager():IsTopUI(ui)
  else
    self._seasonModule:CheckSeasonAndMissionCoseAndJump()
    return false
  end
end

function SeasonPlayer:ClearWaitTime()
  self._curRelaxTime = 0
  self._curMoveingTime = 0
end

function SeasonPlayer:Transmit(position, direction)
  self:Stop()
  self._curModel:SetPosition(position.x, position.y, position.z)
  self._agentTransform.position = Vector3(position.x, self._agentTransform.position.y, position.z)
  if direction then
    self:RotateToPosition(direction)
  end
  self:_CheckPosition(0)
  self:CheckCover()
end

function SeasonPlayer:ResetPosition()
  self._curModel:ResetPosition()
  self._agentTransform.position = Vector3(self._curModel:Position().x, self._agentTransform.position.y, self._curModel:Position().z)
end

function SeasonPlayer:_OnCheckSwitchModel()
  self:_OnSwitchModel(self._seasonMapManager:Mode())
end

function SeasonPlayer:_OnCheckModelByChangeNavArea(areaName)
  for _, model in pairs(self._models) do
    if model:CheckNavAreaModel(areaName) then
      if self._curNavAreaModelName ~= areaName then
        Log.debug("[season][player] _SwitchModel by changeNavArea ", areaName)
        self._curNavAreaModelName = areaName
        self:_SwitchModel(model, true)
      end
      return
    end
  end
  if self._curNavAreaModelName then
    self._curNavAreaModelName = nil
    self:_OnSwitchModel(self._seasonMapManager:Mode(), true)
  end
end

function SeasonPlayer:_OnSwitchModel(mapMode, dontBreakGoing)
  if self._curNavAreaModelName then
    return
  end
  local nextModel, defaultModel
  for _, model in pairs(self._models) do
    if model:IsDefault() then
      defaultModel = model
    end
    local r1 = model:OnCheckCondition(self._seasonModule, self._componentInfo.m_stage_info)
    local r2 = model:MapMode() == 0 or table.icontains(model:MapMode(), mapMode)
    if r1 and r2 then
      nextModel = model
      break
    end
  end
  nextModel = nextModel or defaultModel
  Log.debug("[season][player] _SwitchModel by _OnSwitchModel ")
  self:_SwitchModel(nextModel, dontBreakGoing)
end

function SeasonPlayer:_SwitchModel(nextModel, dontBreakGoing)
  if not nextModel or nextModel == self._curModel then
    return
  end
  local position, rotation
  if self._curModel then
    position = self._curModel:Position()
    rotation = self._curModel:Rotation()
    self._curModel:SetActive(false)
  else
    position = nextModel:Position()
    rotation = nextModel:Rotation()
    self._agentTransform.position = nextModel:Position()
  end
  self._curModel = nextModel
  self._navMeshAgent.speed = self._curModel:Speed()
  self._curModel:SetPR(position, rotation)
  self._curModel:SetActive(true)
  if not dontBreakGoing then
    self:Stop()
  end
  self:ResetExpress()
end

function SeasonPlayer:TransToTarget(position, eventId)
  if self._isDisposed then
    return
  end
  position.y = 1
  local modlePos = self._curModel:Position()
  if Vector3.Distance(position, modlePos) < self._navMeshAgent.stoppingDistance then
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UISeasonTransitionAnimations", "UISeasonTransitionAnimation_Style1", 500, 500, function()
    self._cameraManager:SeasonCamera():Focus(position)
    self:Transmit(position)
    self._playerEffect:PlayEffectWithParent("TransEndPoint", self._curModel:GameObject().transform)
    if eventId then
      local eventPoint = self._seasonMapManager:GetEventPoint(eventId)
      if eventPoint then
        eventPoint:PlayAnimationSeq("effanim_S4_pfb_chuansongzhu_release", "effanim_S4_pfb_chuansongzhu_idle")
      end
    end
  end, function()
  end)
end

function SeasonPlayer:HandleEnter(enterParam)
  if not enterParam then
    return
  end
  local position = enterParam.position
  local style = enterParam.style
  if style == SeaonPlayerEnterStyle.Direct then
    self:Transmit(position)
  end
end
