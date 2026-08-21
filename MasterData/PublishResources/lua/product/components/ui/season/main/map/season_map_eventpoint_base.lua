_class("SeasonMapEventPointBase", Object)
SeasonMapEventPointBase = SeasonMapEventPointBase

function SeasonMapEventPointBase:Constructor(owner, cfgMission, cfgEventPoint)
  self._owner = owner
  self._cfgMission = cfgMission
  self._groupID = self._cfgMission.GroupID
  self._diff = self._cfgMission.OrderID
  self._cfgEventPoint = cfgEventPoint
  self._id = self._cfgEventPoint.ID
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._component = self._seasonModule:GetCurSeasonObj():GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._componentInfo = self._component:GetComponentInfo()
  self._seasonManger = self._uiSeasonModule:SeasonManager()
  self._modelRes = self._cfgEventPoint.ModelRes
  self._interactionRange = self._cfgEventPoint.InteractionRange
  self._interactionRange = self._cfgEventPoint.Scale * self._interactionRange
  self._eventPointType = self._cfgEventPoint.EventPointType
  self._position = Vector3.zero
  self._rotation = Quaternion.Euler(0, 0, 0)
  self._conditions = {}
  self._progressExpress = {}
  self._animationEffect = {}
  self._assetReq = nil
  self._isUnlock = false
  self._show = false
  self._expressShow = false
  self._rangeShow = true
  self._obstacleOpen = true
  self._curProgress = SeasonEventPointProgress.SEPP_Begin
  self._modleResRealProgess = self._curProgress
  self._curProgressExpress = nil
  self._endCallBack = nil
  self._bTrackPermanen = self._cfgMission.BackTrackPermanent
  self:_InitPR()
  self:_CreateConditions()
  self:_CreateExpresses()
  self:_AnimationEffect()
  self:_CheckUnlock()
  self:_CalcCurProgressExpress()
  self:_CalcFirstModel()
end

function SeasonMapEventPointBase:OnAfterInit()
  local checkTriggerId = self._cfgEventPoint.CheckTrigger
  if not checkTriggerId or checkTriggerId < 1 then
    return
  end
  local trigger = self._seasonManger:SeasonTriggerManager():FindTrigger(checkTriggerId)
  if not trigger then
    return
  end
  local overlap = trigger:CheckOverlapWithPlayer()
  local progress
  if overlap then
    progress = self._cfgEventPoint.InTriggerProgress
  else
    progress = self._cfgEventPoint.OutTriggerProgress
  end
  if progress and 0 < progress then
    self:PlayExpress(progress, SeasonExpressTriggerType.Trigger)
  end
end

function SeasonMapEventPointBase:BTrackPermanen()
  return self._bTrackPermanen
end

function SeasonMapEventPointBase:_CalcCurProgressExpress()
  if not self._isUnlock then
    self:ExpressShow(false)
    return
  end
  local map
  if self._uiSeasonModule:IsBackTrack() then
    map = self._uiSeasonModule:GetTrackEventpointStatus()
  else
    map = GameGlobal.GetModule(SeasonTaskModule):GetConditionMap(self._componentInfo.m_stage_info)
  end
  if map and map[self._id] then
    self._curProgress = map[self._id]
  else
  end
  if not self:BTrackPermanen() then
    for progress, _condition in pairs(self._conditions) do
      if _condition and _condition:OnCheck(map) and progress > self._curProgress and self._progressExpress[progress] then
        self._curProgress = progress
      end
    end
  end
  self._curProgressExpress = self._progressExpress[self._curProgress]
  if self._curProgressExpress then
    local result, content = self._curProgressExpress:ContainExpress(SeasonExpressType.Show)
    if result and content ~= nil and (not content.id or content.id == self._id) then
      self._expressShow = content.show
    end
  end
  self:ExpressShow(self._expressShow)
end

function SeasonMapEventPointBase:_CalcFirstModel()
  if not self._modelRes then
    return
  end
  local modelRes = self._modelRes[self._curProgress]
  if modelRes then
    self:_SetCurModelRes(modelRes, self._curProgress)
    return
  end
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    modelRes = self._modelRes[progress]
    if modelRes then
      self:_SetCurModelRes(modelRes, progress)
      return
    end
  end
end

function SeasonMapEventPointBase:_SetCurModelRes(modleRes, progress)
  self._modleResRealProgess = progress
  self._curModelRes = modleRes
end

function SeasonMapEventPointBase:GetID()
  return self._id
end

function SeasonMapEventPointBase:DiffAble()
  if self._uiSeasonModule:GetSeasonID() > 8004 then
    return true
  end
  if self._diff and self._diff > 0 then
    return self._diff == self._uiSeasonModule:GetCurrentSeasonLevelDiff()
  end
  return true
end

function SeasonMapEventPointBase:ModeAble()
  if self._uiSeasonModule:IsBackTrack() then
    return true
  elseif self._cfgMission.Mode then
    return table.icontains(self._cfgMission.Mode, self._seasonManger:SeasonMapManager():Mode())
  else
    return true
  end
end

function SeasonMapEventPointBase:Diff()
  return self._diff
end

function SeasonMapEventPointBase:GetResName()
  return self._curModelRes
end

function SeasonMapEventPointBase:InteractionRange()
  return self._interactionRange
end

function SeasonMapEventPointBase:EventPointType()
  return self._eventPointType
end

function SeasonMapEventPointBase:Position()
  return self._position
end

function SeasonMapEventPointBase:ObstacleRadius()
  if self._navMeshObstacle then
    return self._navMeshObstacle.radius
  end
  return 0
end

function SeasonMapEventPointBase:GroupID()
  return self._groupID
end

function SeasonMapEventPointBase:EventMapIcon()
  return self._cfgEventPoint.MapEventIcon
end

function SeasonMapEventPointBase:IsUnlock()
  return self._isUnlock
end

function SeasonMapEventPointBase:IsLevel()
  return self._isLevel
end

function SeasonMapEventPointBase:RangeShow()
  return self._cfgEventPoint.RangeShow
end

function SeasonMapEventPointBase:Dispose()
  if self._assetReq then
    self._assetReq:Dispose()
    self._assetReq = nil
  end
  if self._shadowResRequestShadow then
    self._shadowResRequestShadow:Dispose()
    self._shadowResRequestShadow = nil
  end
  if self._effectReq then
    self._effectReq:Dispose()
    self._effectReq = nil
    self._effectReqName = nil
  end
  for _, express in pairs(self._progressExpress) do
    express:Dispose()
  end
  table.clear(self._progressExpress)
  table.clear(self._conditions)
  table.clear(self._animationEffect)
  UnityEngine.Object.Destroy(self._gameObject)
  self._materialPropertyBlock = nil
  self._renderers = nil
end

function SeasonMapEventPointBase:_InitPR()
  if self._cfgEventPoint.Position then
    self._position = Vector3(self._cfgEventPoint.Position[1], self._cfgEventPoint.Position[2], self._cfgEventPoint.Position[3])
  end
  if self._cfgEventPoint.Rotation then
    self._rotation = Quaternion.Euler(self._cfgEventPoint.Rotation[1], self._cfgEventPoint.Rotation[2], self._cfgEventPoint.Rotation[3])
  end
end

function SeasonMapEventPointBase:OnShow(req)
  self._assetReq = req
  self:_OnLoadFinish(req:GameObject())
  self:_PlayCurProgressExpress()
end

function SeasonMapEventPointBase:_OnLoadFinish(gameObject)
  self._gameObject = gameObject
  self._gameObject.layer = SeasonLayerMask.Stage
  self._gameObject.name = tostring(self._id)
  self._transform = self._gameObject.transform
  self._transform:SetParent(self._seasonManger:SeasonSceneManager():GetEventPointRootTransform())
  if self:_NeedShadow() then
    self._rootTransform = self._transform:Find("Root")
    if self._rootTransform then
      self:_AddShadow()
      self._animation = self._rootTransform.gameObject:GetComponent(typeof(UnityEngine.Animation))
    else
      Log.fatal("event point need shadow,bug no Root ", self._id)
    end
  else
    self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
    if not self._animation then
      self._animation = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
    end
  end
  self._transform.position = Vector3(self._position.x, self._position.y, self._position.z)
  self._transform.rotation = self._rotation
  self._transform.localScale = Vector3(self._cfgEventPoint.Scale, self._cfgEventPoint.Scale, self._cfgEventPoint.Scale)
  self:_AddNavMeshObstacle()
  self._capsuleCollider = self._gameObject:AddComponent(typeof(UnityEngine.CapsuleCollider))
  self._capsuleCollider.center = Vector3(0, 0.5, 0)
  self._capsuleCollider.radius = self._interactionRange
  self:_OnModelCreated()
  self:_CreateCover()
  self:_Show(self:_RealShow())
end

function SeasonMapEventPointBase:_AddNavMeshObstacle()
  if self._navMeshObstacle then
    return
  end
  local obstacletrans = UnityEngine.GameObject:New("meshObstacle").transform
  obstacletrans:SetParent(self._gameObject.transform)
  obstacletrans.localScale = Vector3.one
  obstacletrans.localPosition = Vector3.zero
  obstacletrans.rotation = Quaternion.Euler(0, 0, 0)
  self._navMeshObstacle = obstacletrans.gameObject:AddComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  self._navMeshObstacle.shape = UnityEngine.AI.NavMeshObstacleShape.Capsule
  self._navMeshObstacle.radius = self._cfgEventPoint.ObstacleRadius
  self._navMeshObstacle.height = 0.6
  self._navMeshObstacle.carving = true
  self._navMeshObstacle.enabled = true
end

function SeasonMapEventPointBase:_OnModelCreated()
  if self._gameObject and self._cfgEventPoint.ModelParam then
    local cfg = self._cfgEventPoint.ModelParam[self._curProgress]
    cfg = cfg or self._cfgEventPoint.ModelParam[self._modleResRealProgess]
    if cfg then
      local modelType = cfg.type
      if modelType == SeasonEventPointModelType.UI then
        if cfg.image then
          local view = self._gameObject:GetComponentInChildren(typeof(UIView))
          local canvas = view:GetUIComponent("Canvas", "Canvas")
          canvas.worldCamera = self._seasonManger:SeasonCameraManager():Camera()
          local rawImageLoader = view:GetUIComponent("RawImageLoader", "Head")
          rawImageLoader:LoadImage(cfg.image)
        end
      elseif modelType == SeasonEventPointModelType.Spine and cfg.spine then
        local view = self._gameObject:GetComponentInChildren(typeof(UIView))
        local spineLoader = view:GetUIComponent("SpineLoader", "Spine")
        spineLoader:LoadSpine(cfg.spine)
      end
    end
  end
end

function SeasonMapEventPointBase:_PlayCurProgressExpress()
  if self._curProgressExpress and self._curProgressExpress:TriggerType() == SeasonExpressTriggerType.Passive and self:_CheckRemainingCount(self._curProgressExpress) then
    self:PlayNextExpress()
  end
end

function SeasonMapEventPointBase:_NeedShadow()
  local shadow = self._cfgEventPoint.Shadow[self._curProgress]
  if shadow ~= nil then
    return shadow
  end
  return false
end

function SeasonMapEventPointBase:CreateVirtualPoint()
  self._gameObject = GameObjectHelper.CreateEmpty(tostring(self._id), self._seasonManger:SeasonSceneManager():GetEventPointRootTransform())
  self._gameObject.layer = SeasonLayerMask.Stage
  self._transform = self._gameObject.transform
  self._transform.position = Vector3(self._position.x, 1, self._position.z)
  self:_AddNavMeshObstacle()
  self:_Show(self:_RealShow())
  self:_PlayCurProgressExpress()
end

function SeasonMapEventPointBase:ExpressShow(expressShow)
  self._expressShow = expressShow
  self:_Show(self:_RealShow())
end

function SeasonMapEventPointBase:_Show(show)
  self._show = show
  if self._gameObject then
    self._gameObject:SetActive(show)
  end
  if self._navMeshObstacle then
    self._navMeshObstacle.enabled = show and self._obstacleOpen
  end
  if self._show then
    local needBoneAnimation, boneAnimationName = self:NeedPlayBornAnimation()
    if needBoneAnimation and boneAnimationName then
      self:PlayAnimation(boneAnimationName)
      TaskManager:GetInstance():StartTask(function(TT)
        self:_RecardBorAnimation(TT)
        YIELD(TT, 500)
        self:_SetAnimationEffect()
      end)
    else
      self:_SetAnimationEffect()
    end
  end
end

function SeasonMapEventPointBase:_RealShow()
  return self._expressShow and self:DiffAble() and self:ModeAble() and self._rangeShow and self:_TimeAble() and self:BackTrackAble()
end

function SeasonMapEventPointBase:_TimeAble()
  if self._cfgEventPoint.BeginTime and self._cfgEventPoint.EndTime then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local beginTime = self._loginModule:GetTimeStampByTimeStr(self._cfgEventPoint.BeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = self._loginModule:GetTimeStampByTimeStr(self._cfgEventPoint.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    return curTime < endTime and curTime >= beginTime
  end
  return true
end

function SeasonMapEventPointBase:BackTrackAble()
  return true
end

function SeasonMapEventPointBase:SetRangeShow(rangeShow)
  if self._cfgEventPoint.RangeShow and self._rangeShow ~= rangeShow then
    self._rangeShow = rangeShow
    self:ExpressShow(self._expressShow)
  end
end

function SeasonMapEventPointBase:IsShow()
  return self._show
end

function SeasonMapEventPointBase:OpenObstacle(open)
  self._obstacleOpen = open
  if self._navMeshObstacle then
    self._navMeshObstacle.enabled = self._obstacleOpen
  end
end

function SeasonMapEventPointBase:_AddShadow()
  self._shadowResRequestShadow = ResourceManager:GetInstance():SyncLoadAsset("SCShadowPlane.prefab", LoadType.GameObject)
  if not self._shadowResRequestShadow then
    Log.error("SeasonEventPoint add shadow fail. SCShadowPlane.prefab load fail.")
    return
  end
  local shadowGO = self._shadowResRequestShadow.Obj
  self._shadowPlane = shadowGO.transform
  self._shadowPlane.parent = self._rootTransform
  if APPVER_EXPLORE then
    local planeShadowComponent = self._rootTransform.gameObject:AddComponent(typeof(PlaneShadowComponent))
    planeShadowComponent.shadowPlane = self._shadowPlane
    planeShadowComponent.maxDistanceToMainCamera = 50
  end
  SeasonTool:GetInstance():DisenableMeshRender(shadowGO)
  self._materialPropertyBlock = UnityEngine.MaterialPropertyBlock:New()
  self._renderers = self._rootTransform.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  shadowGO:SetActive(true)
end

function SeasonMapEventPointBase:_UpdateMaterialProperty()
  if not APPVER_EXPLORE and self._shadowPlane and self._renderers and self._materialPropertyBlock then
    SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  end
end

function SeasonMapEventPointBase:_SetAnimationEffect()
  if not self._transform then
    return
  end
  local animationEffect = self._animationEffect[self._curProgress]
  local sameEffect
  if animationEffect and animationEffect.effect and animationEffect.effect == self._effectReqName then
    sameEffect = true
  end
  if self._effectReq and not sameEffect then
    self._effectReq:Dispose()
    self._effectReq = nil
    self._effectReqName = nil
  end
  if animationEffect then
    local anim = animationEffect.anim
    local holder = animationEffect.holder
    local effect = animationEffect.effect
    self:PlayAnimation(anim)
    if effect then
      if not self._effectReq or not sameEffect then
        self._effectReq = ResourceManager:GetInstance():SyncLoadAsset(effect, LoadType.GameObject)
      end
      if self._effectReq then
        self._effectReqName = effect
        local bone = self:GetBoneNode(holder)
        local effectGO = self._effectReq.Obj
        effectGO:SetActive(true)
        effectGO.transform:SetParent(bone)
        effectGO.transform.localPosition = Vector3.zero
        effectGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
      end
    end
  end
end

function SeasonMapEventPointBase:_SetAnimation()
  local animationEffect = self._animationEffect[self._curProgress]
  if animationEffect then
    self:PlayAnimation(animationEffect.anim)
  end
end

function SeasonMapEventPointBase:CurProgress()
  return self._curProgress
end

function SeasonMapEventPointBase:CurProgressExpress()
  return self._curProgressExpress
end

function SeasonMapEventPointBase:_CreateConditions()
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    self:_CreatePerCondition(progress)
  end
end

function SeasonMapEventPointBase:_CreatePerCondition(progress)
  self._conditions[progress] = SeasonMapCondition:New(self._seasonModule, self._id, progress)
end

function SeasonMapEventPointBase:_CreateExpresses()
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    local expressCount = self._cfgEventPoint["ExpressCount" .. progress]
    local triggerType = self._cfgEventPoint["Express" .. progress .. "TriggerType"]
    local expressCfg = self._cfgEventPoint["Express" .. progress]
    self:_CreatePerExpress(progress, expressCount, triggerType, expressCfg)
  end
end

function SeasonMapEventPointBase:_CreatePerExpress(progress, expressCount, triggerType, expressArr)
  if triggerType and expressArr and not self._progressExpress[progress] then
    local express = SeasonMapExpress:New(self, expressCount, triggerType, expressArr)
    self._isLevel = express:IsLevel()
    self._progressExpress[progress] = express
  end
end

function SeasonMapEventPointBase:_AnimationEffect()
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    self._animationEffect[progress] = self._cfgEventPoint["AnimationEffect" .. progress]
  end
end

function SeasonMapEventPointBase:GetCurExpressIndex()
  if self._progressExpress[self._curProgress] then
    return self._progressExpress[self._curProgress]:CurExpressIndex()
  end
  return nil
end

function SeasonMapEventPointBase:PlayExpress(progress, triggerType, param, endCallBack)
  if not self._progressExpress[progress] then
    return
  end
  self._curProgress = progress
  local nextProgressExpress = self._progressExpress[self._curProgress]
  if self._curProgressExpress ~= nextProgressExpress then
    self._curProgressExpress = nextProgressExpress
    self:_CheckUnlock()
    self:_CalcAllLast()
  end
  if self._curProgressExpress and self:_CheckRemainingCount(self._curProgressExpress) then
    if self._curProgressExpress:TriggerType() == triggerType then
      self._endCallBack = endCallBack
      self:_StopAudio(true)
      self._seasonManger:SeasonPlayerManager():GetPlayer():SyncPosition()
      self._curProgressExpress:Reset()
      self:PlayNextExpress(param)
    elseif self._curProgressExpress:TriggerType() == SeasonExpressTriggerType.Active then
      local result, content = self._curProgressExpress:ContainExpress(SeasonExpressType.Show)
      if result and content ~= nil and (not content.id or content.id == self._id) then
        self:ExpressShow(content.show)
        if content.show then
          self:_Born()
        end
      end
    end
  end
end

function SeasonMapEventPointBase:_CalcAllLast()
end

function SeasonMapEventPointBase:_Born()
  local result, content = self._curProgressExpress:ContainExpress(SeasonExpressType.Born)
  if result and content then
    local bornType = content.type
    if bornType == SeasonBornType.Before then
      self:PlayAnimation(content.anim)
    end
  end
end

function SeasonMapEventPointBase:_StopAudio(stop)
  local seasonAudio = self._seasonManger:SeasonAudioManager():GetSeasonAudio()
  if seasonAudio then
    seasonAudio:PlayVoice(stop)
  end
end

function SeasonMapEventPointBase:PlayNextExpress(param)
  if self._curProgressExpress then
    local isEnd = self._curProgressExpress:PlayNext(param)
    if isEnd then
      self:SyncProgress(self._curProgress)
      self:_StopAudio(false)
      self:_OnPlayEnd()
      self._seasonManger:SeasonPlayerManager():GetPlayer():ClearWaitTime()
      self._curProgressExpress:Reset()
      local result, content = self._curProgressExpress:ContainExpress(SeasonExpressType.LockInput)
      if result then
        self._seasonManger:ClearLocks()
      end
    end
  end
end

function SeasonMapEventPointBase:_OnPlayEnd()
end

function SeasonMapEventPointBase:_OnSyncSuccess(progress)
  self._seasonManger:SeasonPlayerManager():GetPlayer():SyncPosition()
  local seasonMapManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager()
  seasonMapManager:OnEventPointProgressChange(self._id, progress)
  self:_CheckModelChange()
end

function SeasonMapEventPointBase:Update(deltaTime)
  if self._curProgressExpress then
    self._curProgressExpress:Update(deltaTime)
  end
  self:_UpdateMaterialProperty(deltaTime)
end

function SeasonMapEventPointBase:PlayAnimation(name)
  if not self._animation or not name then
    return
  end
  local animationState = self._animation:get_Item(name)
  if animationState then
    Log.info("[season]eventPoint animation ", self._id, " aniName = ", name)
    self._animation:Play(animationState.name)
  end
  return animationState
end

function SeasonMapEventPointBase:PlayAnimationSeq(firstName, secondName)
  if not self._animation or not firstName then
    return
  end
  self._animation:Play(firstName)
  if secondName then
    self._animation:PlayQueued(secondName)
  end
end

function SeasonMapEventPointBase:GetBoneNode(name)
  if not name then
    return self._transform
  else
    local boneTransform = GameObjectHelper.FindChild(self._transform, name)
    if boneTransform then
      return boneTransform
    end
    return self._transform
  end
end

function SeasonMapEventPointBase:CheckCondition(map)
  local result = false
  local curProgress = self._curProgress
  for progress, _condition in pairs(self._conditions) do
    if _condition:OnCheck(map) and progress > curProgress and self._progressExpress[progress] then
      result = true
      curProgress = progress
    end
  end
  return result, curProgress
end

function SeasonMapEventPointBase:CheckInteractionDistance(position)
  if self._transform then
    local p1 = Vector2(position.x, position.z)
    local p2 = Vector2(self._transform.position.x, self._transform.position.z)
    return Vector2.Distance(p1, p2) <= self:InteractionRange()
  else
    return false
  end
end

function SeasonMapEventPointBase:CheckBacktrack()
  if self:EventPointType() ~= SeasonEventPointType.Task and self._uiSeasonModule:IsBackTrack() and self._cfgMission.BackTrackInteract == false then
    return false
  end
  return true
end

function SeasonMapEventPointBase:GetMissionCfg()
  return self._cfgMission
end

function SeasonMapEventPointBase:GetEventPointCfg()
  return self._cfgEventPoint
end

function SeasonMapEventPointBase:TryResumeExpress()
  local param = self._seasonManger:SeasonMapManager():GetParams()
  local missionCreateInfo = param[1]
  local isWin = param[2]
  if missionCreateInfo and isWin then
    local info = self._seasonModule:GetLevelExpress()
    if info and info.eventPointID == self._id and self._curProgressExpress then
      local result, content, index = self._curProgressExpress:ContainExpress(info.expressType)
      if result then
        Log.info("SeasonMapEventPointBase TryResumeExpress, ", self._id, index)
        self._curProgressExpress:ResumePlay(index, isWin)
      end
      self._seasonModule:ClearLevelExpress()
    end
  end
end

function SeasonMapEventPointBase:InterruptExpress()
  if self._curProgressExpress then
    self._curProgressExpress:Reset()
  end
  self._seasonManger:ClearLocks()
end

function SeasonMapEventPointBase:_CheckModelChange()
  if not self._modelRes then
    return
  end
  local modelRes = self._modelRes[self._curProgress]
  if modelRes and self._curModelRes ~= modelRes then
    self:_SetCurModelRes(modelRes, self._curProgress)
    self:ReloadModel()
  end
end

function SeasonMapEventPointBase:ReloadModel()
  if self._assetReq then
    self._assetReq:Dispose()
    self._assetReq = nil
  end
  if self._shadowResRequestShadow then
    self._shadowResRequestShadow:Dispose()
    self._shadowResRequestShadow = nil
  end
  if self._effectReq then
    self._effectReq:Dispose()
    self._effectReq = nil
    self._effectReqName = nil
  end
  if self._gameObject then
    UnityEngine.Object.Destroy(self._gameObject)
  end
  self._assetReq = ResourceManager:GetInstance():SyncLoadAsset(self._curModelRes, LoadType.GameObject)
  if not self._assetReq or self._assetReq.Obj then
    Log.error("SeasonPlayer load player modle res fail.", self._curModelRes)
    return
  end
  self._materialPropertyBlock = nil
  self._renderers = nil
  self:_OnLoadFinish(self._assetReq.Obj)
end

function SeasonMapEventPointBase:SwitchDiff(diff)
  if self._isUnlock and self._diff and self._diff > 0 then
    self:_Show(self:_RealShow())
    self:_SetAnimation()
    self:_OnSwitchDiff(diff)
  end
end

function SeasonMapEventPointBase:_OnSwitchDiff(diff)
end

function SeasonMapEventPointBase:SwitchMapMode(mapMode)
  if self._isUnlock and self._cfgMission.Mode ~= nil and self._cfgEventPoint.NoRefresh ~= true then
    self:_Show(self:_RealShow())
    self:_SetAnimation()
    self:_OnSwitchMapMode(mapMode)
  end
end

function SeasonMapEventPointBase:_OnSwitchMapMode(mapMode)
end

function SeasonMapEventPointBase:AutoMoveToMe(callBack)
  local player = self._seasonManger:SeasonPlayerManager():GetPlayer()
  local clickPosition = Vector3(self:Position().x, player:Position().y, self:Position().z)
  local direction = player:Position() - clickPosition
  direction = direction.normalized * self:ObstacleRadius() * 2
  local targetPosition = clickPosition + direction
  local result, navMeshHit = UnityEngine.AI.NavMesh.Raycast(targetPosition, clickPosition, nil, UnityEngine.AI.NavMesh.AllAreas)
  self._seasonManger:SeasonInputManager():SetClickZoneID(nil)
  local dir = Vector3(0, -1, 0)
  local results = UnityEngine.Physics.RaycastAll(clickPosition, dir, 1000, 1 << SeasonLayerMask.Scene)
  if results and 0 < results.Length then
    for i = 0, results.Length - 1 do
      local trans = results[i].transform
      local contain, zoneID = self._seasonManger:SeasonSceneManager():GetLayer(SeasonSceneLayer.ZoneFlag):GetZoneID(trans.gameObject)
      if contain then
        self._seasonManger:SeasonInputManager():SetClickZoneID(zoneID)
        break
      end
    end
  end
  if result then
    player:SetDestination(navMeshHit.position, false, callBack)
  else
    player:SetDestination(clickPosition, false, callBack)
  end
end

function SeasonMapEventPointBase:GuideMove(callback)
  GameGlobal.UIStateManager():Lock("SeasonMapEventPointBase:GuideMove")
  self._seasonManger:Lock("guide")
  self:AutoMoveToMe(function()
    self._seasonManger:UnLock("guide")
    if callback then
      callback()
    end
    GameGlobal.UIStateManager():UnLock("SeasonMapEventPointBase:GuideMove")
  end)
end

function SeasonMapEventPointBase:IsPlaying()
  if self._curProgressExpress then
    return self._curProgressExpress:IsPlaying(), self._id
  end
  return false
end

function SeasonMapEventPointBase:_CreateCover()
  local coverManager = self._seasonManger:SeasonCoverManager()
  local hasCover = false
  if self._transform then
    local childCount = self._transform.childCount
    if 0 < childCount then
      for i = 0, childCount - 1 do
        local child = self._transform:GetChild(i)
        if string.find(string.lower(child.name), coverManager:CoverFlag()) then
          SeasonTool:GetInstance():TryAddCover(self._transform, child)
          hasCover = true
        end
        local grandChildCount = child.childCount
        if 0 < grandChildCount then
          for j = 0, grandChildCount - 1 do
            local grandChild = child:GetChild(j)
            if string.find(string.lower(grandChild.name), coverManager:CoverFlag()) then
              SeasonTool:GetInstance():TryAddCover(child, grandChild)
              hasCover = true
            end
          end
        end
      end
    end
  end
  if hasCover then
    self._seasonManger:SeasonPlayerManager():GetPlayer():CheckCover()
  end
end

function SeasonMapEventPointBase:ReCreatCover()
  local coverManager = self._seasonManger:SeasonCoverManager()
  if self._transform then
    local childCount = self._transform.childCount
    if 0 < childCount then
      for i = 0, childCount - 1 do
        local child = self._transform:GetChild(i)
        if string.find(string.lower(child.name), coverManager:CoverFlag()) then
          SeasonTool:GetInstance():TryClearCover(self._transform, child)
        end
        local grandChildCount = child.childCount
        if 0 < grandChildCount then
          for j = 0, grandChildCount - 1 do
            local grandChild = child:GetChild(j)
            if string.find(string.lower(grandChild.name), coverManager:CoverFlag()) then
              SeasonTool:GetInstance():TryClearCover(child, grandChild)
            end
          end
        end
      end
    end
  end
  self:_CreateCover()
end

function SeasonMapEventPointBase:SyncProgress(progress)
  if self._uiSeasonModule:IsBackTrack() then
    if self:BTrackPermanen() then
      self:_SyncTrackProgress(progress)
    end
    return
  end
  local map = self._componentInfo.m_stage_info
  if map and map[self._id] and map[self._id] == progress then
    if self._curProgressExpress:NeedCount() then
      TaskManager:GetInstance():StartTask(function(TT)
        self:_RecordExpressCount(TT, progress)
      end, self)
    end
    return
  end
  Log.debug("SeasonMapEventPointBase play all expresses end.", self._id, progress)
  GameGlobal.UIStateManager():Lock("SeasonMapEventPointBase:SyncProgress")
  TaskManager:GetInstance():StartTask(function(TT)
    local res = self._seasonModule:HandleSeasonClientStageData(TT, self._id, progress)
    if res:GetSucc() and self._uiSeasonModule:InSeasaonRunning() then
      if self._curProgressExpress:NeedCount() then
        self:_RecordExpressCount(TT, progress)
      end
      self:_OnSyncSuccess(progress)
      self:_TrySyncProgressNormal(progress)
      if self._endCallBack then
        self._endCallBack(self._id, progress)
        self._endCallBack = nil
      end
    else
      Log.error("SeasonMapEventPointBase sync progress fail!", self._id, progress)
    end
    GameGlobal.UIStateManager():UnLock("SeasonMapEventPointBase:SyncProgress")
  end, self)
end

function SeasonMapEventPointBase:_SyncTrackProgress(progress)
  local map = self._uiSeasonModule:GetTrackEventpointStatus()
  if map and map[self._id] and map[self._id] == progress then
    if self._curProgressExpress:NeedCount() then
      TaskManager:GetInstance():StartTask(function(TT)
        self:_RecordTrackExpressCount(TT, progress)
      end, self)
    end
    return
  end
  Log.debug("SeasonMapEventPointBase backtrack play all expresses end.", self._id, progress)
  GameGlobal.UIStateManager():Lock("SeasonMapEventPointPlayEnd")
  TaskManager:GetInstance():StartTask(function(TT)
    local reqInfo = EvenPointInfo:New()
    reqInfo.event_id = self._id
    reqInfo.status = progress
    local res = GameGlobal.GetModule(SeasonTaskModule):ReqSubmitEventPointInfo(TT, reqInfo)
    if res:GetSucc() and self._uiSeasonModule:InSeasaonRunning() then
      if self._curProgressExpress:NeedCount() then
        self:_RecordTrackExpressCount(TT, progress)
      end
      self:_OnSyncSuccess(progress)
      if self._endCallBack then
        self._endCallBack(self._id, progress)
        self._endCallBack = nil
      end
    else
      Log.error("SeasonMapEventPointBase sync progress fail!", self._id, progress)
    end
    GameGlobal.UIStateManager():UnLock("SeasonMapEventPointPlayEnd")
  end, self)
end

function SeasonMapEventPointBase:_TrySyncProgressNormal(progress)
  if self:IsLevel() and self._diff == UISeasonLevelDiff.Hard then
    local normalCfg = Cfg.cfg_season_mission({
      GroupID = self._groupID,
      OrderID = UISeasonLevelDiff.Normal
    })
    if normalCfg then
      local normalEventPoint = self._seasonManger:SeasonMapManager():GetEventPoint(normalCfg[1].ID)
      if normalEventPoint and progress >= normalEventPoint:CurProgress() then
        normalEventPoint:SyncProgress(progress)
        return
      end
    end
  end
end

function SeasonMapEventPointBase:_CheckUnlock()
  self._isUnlock = self._owner:IsUnlock()
end

function SeasonMapEventPointBase:IsLastProgress(targetProgress)
  return SeasonTool:GetInstance():IsLastProgress(self._cfgEventPoint, targetProgress)
end

function SeasonMapEventPointBase:_CheckRemainingCount(express)
  if express then
    if express:Count() == nil or express:Count() <= 0 then
      return true
    else
      local key = tonumber(self._id .. self._curProgress)
      local count
      if self._uiSeasonModule:IsBackTrack() then
        if self:BTrackPermanen() then
          local taskModule = GameGlobal.GetModule(SeasonTaskModule)
          local eventInfo = taskModule:GetTrackPointInfo(key)
          if eventInfo then
            count = eventInfo.status
          end
        end
      else
        count = self._componentInfo.m_client_info.ext[key]
      end
      if count then
        return count < express:Count()
      else
        return true
      end
    end
  end
  return true
end

function SeasonMapEventPointBase:_RecordExpressCount(TT, progress)
  local clientInfo = self._componentInfo.m_client_info
  local key = tonumber(self._id .. progress)
  local count = 1
  if clientInfo.ext[key] then
    count = clientInfo.ext[key] + count
  end
  local info = {}
  info[key] = count
  local req = self._seasonModule:HandleSeasonClientDataExt(TT, info)
  if req:GetSucc() then
    Log.info("SeasonMapEventPointBase sync express count.", self._id, progress)
  end
end

function SeasonMapEventPointBase:_RecordTrackExpressCount(TT, progress)
  local taskModule = GameGlobal.GetModule(SeasonTaskModule)
  local key = tonumber(self._id .. progress)
  local status = 1
  local eventInfo = taskModule:GetTrackPointInfo(key)
  if eventInfo then
    status = eventInfo.status + 1
    eventInfo.status = status
  end
  local reqInfo = EvenPointInfo:New()
  reqInfo.event_id = key
  reqInfo.status = status
  local req = taskModule:ReqSubmitEventPointInfo(TT, reqInfo)
  if req:GetSucc() then
    Log.info("SeasonMapEventPointBase sync backtrack express count.", self._id, progress)
  end
end

function SeasonMapEventPointBase:NeedPlayBornAnimation()
  local missionComponent = self._seasonModule:GetSeasonMissionComponent()
  if not missionComponent then
    return
  end
  if not self._cfgEventPoint.BoneAnimation then
    return
  end
  local missionInfo = missionComponent:GetComponentInfo()
  local key = self:_GetBornAniKey()
  local playTimes = missionInfo.m_client_info.ext[key]
  if playTimes and 0 < playTimes then
    return
  end
  return true, self._cfgEventPoint.BoneAnimation
end

function SeasonMapEventPointBase:_GetBornAniKey()
  local key = "11" .. self._id
  local iKey = tonumber(key)
  return iKey
end

function SeasonMapEventPointBase:_RecardBorAnimation(TT)
  local key = self:_GetBornAniKey()
  local info = {}
  info[key] = 1
  local req = self._seasonModule:HandleSeasonClientDataExt(TT, info)
  if req:GetSucc() then
    Log.info("RecardBorAnimation sync trigger success.", key)
  end
end
