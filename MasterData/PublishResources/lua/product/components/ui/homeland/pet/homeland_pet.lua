_class("HomelandPet", Object)
HomelandPet = HomelandPet
local Enum_Fade = {
  Enum_Fade_Invalid = 0,
  Enum_Fade_Doing = 1,
  Enum_Fade_End = 3
}

function HomelandPet:Constructor(petData, homelandClient)
  self._alive = true
  self._visible = false
  self._finalVisible = false
  self._invited = false
  self._resLoaded = false
  self.walkSpeed = 1.1
  self.runSpeed = 5
  self._data = petData
  self._homelandClient = homelandClient
  self._tmpID = self._data:TmpID()
  self._prefabName = self._data:Prefab()
  local skinID = string.gsub(self._prefabName, ".prefab", "")
  self._skinID = tonumber(skinID)
  self._clothSkinID = self._data:SkinID()
  local speedCfg = Cfg.cfg_pet_move_speed[self._skinID]
  if speedCfg then
    if speedCfg.HomeWalk then
      self.walkSpeed = speedCfg.HomeWalk
      Log.info("家园星灵使用配置行走速度:", self._skinID, ",", self.walkSpeed)
    end
    if speedCfg.HomeRun then
      self.runSpeed = speedCfg.HomeRun
      Log.info("家园星灵使用配置奔跑速度:", self._skinID, ",", self.runSpeed)
    end
  end
  self._petAgent = GameObjectHelper.CreateEmpty(self._skinID .. "_Agent", nil)
  self._petAgentTransform = self._petAgent.transform
  self._petAgentTransform:SetParent(self._homelandClient:SceneManager():RuntimeRootTrans())
  self._petName = StringTable.Get(Cfg.cfg_pet[self._tmpID].Name)
  self._homelandPetManager = self._homelandClient:PetManager()
  self._interactingBuilding = nil
  self._bornBehaviorType = nil
  self:_InitNavMeshInfo()
  self._behavior = HomelandPetBehavior:New(self)
  self._beforeTalkBehaviorType = nil
  self._greetCfg = Cfg.cfg_homeland_pet_behavior_lib({
    TemplateID = self._tmpID,
    BehaviorType = HomelandPetBehaviorType.GreetPlayer
  })
  if not self._greetCfg then
    self._greetCfg = Cfg.cfg_homeland_pet_behavior_lib({
      TemplateID = 0,
      BehaviorType = HomelandPetBehaviorType.GreetPlayer
    })
  end
  self._greetCheckInterval = 0
  self._occupiedType = HomelandPetOccupiedType.None
  self._occupiedParam = nil
  self._behaviorChangeCallbackList = {}
  self._miniMapVisible = false
  self._motionType = HomelandPetMotionType.None
end

function HomelandPet:_InitNavMeshInfo()
  self._navMeshAgent = self._petAgent:AddComponent(typeof(UnityEngine.AI.NavMeshAgent))
  self._navMeshAgent.agentTypeID = HelperProxy:GetInstance():GetNavAgentID(AircraftNavAgent.Normal)
  self._navMeshAgent.angularSpeed = 1000
  self._navMeshAgent.speed = self.walkSpeed
  self._navMeshAgent.stoppingDistance = 0.1
  self._navMeshAgent.autoBraking = false
  self._navMeshAgent.enabled = false
  self._navMeshAgent.areaMask = 1
  self._navMeshObstacle = self._petAgent:AddComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  self._navMeshObstacle.shape = UnityEngine.AI.NavMeshObstacleShape.Capsule
  self._navMeshObstacle.carving = true
  self._navMeshObstacle.enabled = true
end

function HomelandPet:GetPetBehavior()
  return self._behavior
end

function HomelandPet:GetHomelandClient()
  return self._homelandClient
end

function HomelandPet:GetPetManager()
  return self._homelandPetManager
end

function HomelandPet:Dispose()
  self._alive = false
  self._visible = false
  self._finalVisible = false
  if self._behavior:GetCurBehavior() then
    self._behavior:GetCurBehavior():Exit()
  end
  self._behavior:Dispose()
  if self._resLoaded then
    self._assetReq:Dispose()
    self._assetReq = nil
    self._resLoaded = false
  end
  if self._extraAnimReq then
    self._extraAnimReq:Dispose()
  end
  if self.clickEffReq then
    self.clickEffReq:Dispose()
    self.clickEffReq = nil
  end
  self:RemoveInteractPoint()
  self._faceMat = nil
  UnityEngine.Object.Destroy(self._petAgent)
  self._fadeCpt = nil
  self._meshRenderers = nil
  if self._miniMapVisible then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.Pet, self._data:TmpID())
  end
  if self._materialAnimationContainer then
    self._materialAnimationContainer:Dispose()
    self._materialAnimationContainer = nil
  end
  self:_RemoveEvent()
end

function HomelandPet:GetFaceMat()
  return self._faceMat
end

function HomelandPet:IsAlive()
  return self._alive
end

function HomelandPet:IsLoaded()
  return self._resLoaded
end

function HomelandPet:SetOccupied(occupiedType, param)
  self._occupiedType = occupiedType
  self._occupiedParam = param
end

function HomelandPet:IsOccupied()
  return self._occupiedType ~= HomelandPetOccupiedType.None, self._occupiedParam
end

function HomelandPet:GetOccupiedType()
  return self._occupiedType
end

function HomelandPet:Update(deltaTimeMS)
  if not self._alive then
    return
  end
  self:RefreshFade(deltaTimeMS)
  if not self._finalVisible then
    return
  end
  self:_CheckGreetPlayer(deltaTimeMS)
  self._behavior:Update(deltaTimeMS)
  if self._swimPool then
    local collider = self._swimPool:GetPoolAreaCollider()
    local closestPoint = collider:ClosestPoint(self:GetPosition())
    local dir = Vector3.Distance(closestPoint, self:GetPosition())
    local inRange = false
    if dir <= 0 then
      inRange = true
    end
    if not inRange then
      self:_ChangeSwimCloth()
      local behavior = self:GetPetBehavior()
      local type = behavior:GetCurBehaviorType()
      if type == HomelandPetBehaviorType.Roam then
        behavior:RandomBehavior()
      elseif type == HomelandPetBehaviorType.Following then
        behavior:ChangeBehavior(HomelandPetBehaviorType.Following)
      end
      self._swimPool = nil
      self._oldSkin = nil
      self._oldClothSkin = nil
    end
  end
end

function HomelandPet:PetName()
  return self._petName
end

function HomelandPet:PstID()
  return self._data:PstID()
end

function HomelandPet:TemplateID()
  return self._tmpID
end

function HomelandPet:SkinID()
  return self._skinID
end

function HomelandPet:ClothSkinID()
  return self._clothSkinID
end

function HomelandPet:AwakeLevel()
  return self._data:Awake()
end

function HomelandPet:SetGiftFlag(flag)
  self._hasPreset = flag
end

function HomelandPet:IsGiftPet()
  return self._hasPreset
end

function HomelandPet:NaviRadius()
  return self._naviRadius
end

function HomelandPet:PrefabName()
  return self._prefabName
end

function HomelandPet:SetPrefabName(prefabName)
  self._prefabName = prefabName
end

function HomelandPet:SetSkinID(skinID)
  self._skinID = skinID
end

function HomelandPet:SetClothSkinID(clothSkinID)
  self._clothSkinID = clothSkinID
end

function HomelandPet:Show(req, clickAnimClip, reLoad)
  self._resLoaded = true
  self._assetReq = req
  self._petGO = req:PetGameObject()
  self._petTransform = self._petGO.transform
  GameObjectHelper.SetGameObjectLayer(self._petGO, AircraftLayer.Pet)
  GameObjectHelper.AddVolumeComponent(self._petGO)
  self._animation = self._petTransform:Find("Root"):GetComponent(typeof(UnityEngine.Animation))
  local clickAnim = self._animation:get_Item(HomelandPetAnimName.Click)
  if clickAnim == nil then
    Log.error("Homeland Pet Click Animation Not Found:", self._tmpID)
  end
  self._headSlot = GameObjectHelper.FindChild(self._petTransform, "Bip001 Head")
  if not self._headSlot then
    Log.error("Homeland Pet Bip001 Head Not Found.", self._tmpID)
  end
  local bip = GameObjectHelper.FindChild(self._petGO.transform, "Bip001")
  if bip == nil then
    Log.error("Homeland Pet Bip001 Not Found.", self._tmpID)
  end
  local collider = bip.gameObject:AddComponent(typeof(UnityEngine.BoxCollider))
  local cfg = Cfg.cfg_homeland_pet[self._tmpID]
  if not cfg then
    Log.error("cfg_homeland_pet Not Exist:", self._tmpID)
  end
  local size = Vector3(cfg.BoxSize[1], cfg.BoxSize[3], cfg.BoxSize[2])
  collider.size = size
  collider.center = Vector3(0, 0, 0)
  self._collider = collider
  local bipObstacle = bip.gameObject:GetComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  bipObstacle = bipObstacle or bip.gameObject:AddComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  bipObstacle.size = size
  bipObstacle.carving = true
  bipObstacle.enabled = false
  self._bipObstacle = bipObstacle
  self.clickEffCfg = Cfg.cfg_aircraft_click_eff[self._skinID]
  if self.clickEffCfg and self.clickEffCfg.EffName then
    self.clickEffReq = ResourceManager:GetInstance():SyncLoadAsset(self.clickEffCfg.EffName .. ".prefab", LoadType.GameObject)
    self.clickEff = self.clickEffReq.Obj
    self.clickEff.transform.localScale = Vector3.one
    local cfgPos = self.clickEffCfg.PosOffset
    self.clickEffOffset = Vector3(cfgPos[1], cfgPos[2], cfgPos[3])
  end
  local face_name = self._skinID .. "_face"
  local face = GameObjectHelper.FindChild(self._petGO.transform, face_name)
  if face then
    local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
    if not render then
      Log.error("面部表情节点上找不到SkinnedMeshRenderer：", face_name)
    else
      self._faceMat = render.material
    end
  else
    Log.error("找不到面部表情节点：", face_name)
  end
  self._petTransform:SetParent(self._petAgentTransform)
  local petScale = Cfg.cfg_aircraft_camera.petScale.Value
  self._petTransform.localScale = Vector3(petScale, petScale, petScale)
  self._petTransform.localPosition = Vector3.zero
  self._petTransform.localRotation = Quaternion.identity
  local root = self._petTransform:Find("Root")
  for i = 0, root.childCount - 1 do
    local child = root:GetChild(i)
    if string.find(child.name, "weapon") then
      child.gameObject:SetActive(false)
    end
  end
  self._selectAnim = self._petGO:GetComponent(typeof(UnityEngine.Animation))
  if not self._selectAnim then
    self._selectAnim = self._petGO:AddComponent(typeof(UnityEngine.Animation))
    self._selectAnim.playAutomatically = false
    self._selectAnim:AddClip(req:ClickAnimClip(), "aircraft_select")
  end
  self._outLine = root.gameObject:GetComponent(typeof(OutlineComponent))
  if not self._outLine then
    self._outLine = root.gameObject:AddComponent(typeof(OutlineComponent))
    self._outLine.blurNum = 3
    self._outLine.intensity = 2.5
    self._outLine.outlineSize = 1
    self._outLine.blendType = OutlineComponent.BlendType.Blend
    self._outLine.enabled = false
  end
  self._shadow = self._petGO:GetComponent(typeof(ShadowmapCheckPoint))
  if not self._shadow then
    self._shadow = self._petGO:AddComponent(typeof(ShadowmapCheckPoint))
  end
  self._fadeCpt = self._petGO:AddComponent(typeof(FadeComponent))
  self._fadeCpt.Alpha = 1
  self._fadState = Enum_Fade.Enum_Fade_Invalid
  self._materialAnimation = self._petGO:GetComponent(typeof(MaterialAnimation))
  if not self._materialAnimation then
    self._materialAnimation = self._petGO:AddComponent(typeof(MaterialAnimation))
  end
  self._materialAnimationContainer = ResourceManager:GetInstance():SyncLoadAsset("HomelandShaderEffects.asset", LoadType.Asset)
  self._materialAnimation:AddClips(self._materialAnimationContainer.Obj)
  self._petGO:SetActive(true)
  self:_InitSkinnedMeshRender()
  if not self:IsOccupied() and not reLoad then
    self:_RandomBornPosition()
    self._behavior:StartBehavior(self._bornBehaviorType)
  end
  self:_AddEvent()
  self:SetVisible(true)
end

function HomelandPet:_InitSkinnedMeshRender()
  local meshRenderers = self._petGO:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  local tempMeshRenders = meshRenderers:ToTable()
  self._meshRenderers = {}
  for _, meshRenderer in pairs(tempMeshRenders) do
    if meshRenderer.enabled then
      table.insert(self._meshRenderers, meshRenderer)
    end
  end
end

function HomelandPet:_SetPetVisible(visible)
  self:_EnableSkinnedMeshRender(visible)
  local behaviorBase = self._behavior:GetCurBehavior()
  if behaviorBase then
    local component = behaviorBase:GetComponent(HomelandPetComponentType.InteractionAnimation)
    if component then
      component:SetInteractVisible(visible)
    end
  end
end

function HomelandPet:_EnableSkinnedMeshRender(enabled)
  if self._meshRenderers then
    for _, meshRenderer in pairs(self._meshRenderers) do
      meshRenderer.enabled = enabled
    end
  end
end

function HomelandPet:_RandomBornPosition()
  local center = Vector3(2, 0, 20)
  local bornPosition = HomelandNavmeshTool:GetInstance():GetRandomPositionCircle(BuildConfig.MaxCircle.Radius, center)
  self:SetPosition(bornPosition)
end

function HomelandPet:_AddEvent()
  self._OnSaveBuildingCallBack = GameHelper:GetInstance():CreateCallback(self._OnSaveBuilding, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._OnSaveBuildingCallBack)
end

function HomelandPet:_RemoveEvent()
  if self._OnSaveBuildingCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._OnSaveBuildingCallBack)
  end
end

function HomelandPet:HeadPos()
  if self._headSlot then
    return self._headSlot.position
  else
    return self._petAgentTransform.position + Vector3(0, 1.5, 0)
  end
end

function HomelandPet:AgentGameObject()
  return self._petAgent
end

function HomelandPet:AgentTransform()
  return self._petAgentTransform
end

function HomelandPet:FollowBuilding(trBuilding)
  if trBuilding == nil then
    self._petTransform:SetParent(self._petAgentTransform, false)
    local petScale = Cfg.cfg_aircraft_camera.petScale.Value
    self._petTransform.localScale = Vector3(petScale, petScale, petScale)
    self._petTransform.localPosition = Vector3.zero
    self._petTransform.localRotation = Quaternion.identity
  else
    self._petTransform:SetParent(trBuilding, true)
  end
end

function HomelandPet:Collider()
  return self._collider
end

function HomelandPet:SetBornBehavior(behaviorType)
  self._bornBehaviorType = behaviorType
end

function HomelandPet:GetBoneNode(name)
  local boneTransform = GameObjectHelper.FindChild(self._petTransform, name)
  if boneTransform then
    return boneTransform
  end
  return self._petTransform
end

function HomelandPet:GetPosition()
  return self._petAgentTransform.position
end

function HomelandPet:SetPosition(pos)
  if pos then
    self._petAgentTransform.position = pos
  else
    Log.error("Homeland Pet SetPosition Error !")
  end
end

function HomelandPet:GetRotation()
  return self._petAgentTransform.rotation
end

function HomelandPet:SetRotation(rotation)
  if rotation then
    self._petAgentTransform.rotation = rotation
  end
end

function HomelandPet:SetLocalTrans(pos, rotation)
  if pos then
    self._petAgentTransform.localPosition = pos
  end
  if rotation then
    self._petAgentTransform.localRotation = rotation
  end
end

function HomelandPet:SetEuler(v3)
  self._petAgentTransform.eulerAngles = v3
end

function HomelandPet:GetInteractingBuilding()
  return self._interactingBuilding
end

function HomelandPet:SetInteractingBuilding(building)
  self._interactingBuilding = building
end

function HomelandPet:StopAnimation()
  if self._animation then
    self._animation:Stop()
  end
end

function HomelandPet:PlayClickAnimation()
  if self.clickEff then
    self.clickEff.transform.rotation = self._petTransform.rotation
    self.clickEff.transform.position = self._petTransform.position + self.clickEffOffset
    self.clickEff:SetActive(false)
    self.clickEff:SetActive(true)
  end
end

function HomelandPet:WorldPosition()
  return self._petAgentTransform.position
end

function HomelandPet:GetAnimation()
  return self._animation
end

function HomelandPet:GetNavMeshAgent()
  return self._navMeshAgent
end

function HomelandPet:SetNavMeshAgentEnabled(enable)
  self._navMeshAgent.enabled = enable
end

function HomelandPet:GetNavMeshObstacle()
  return self._navMeshObstacle
end

function HomelandPet:SetNavMeshObstacleEnabled(enabled)
  self._navMeshObstacle.enabled = enabled
end

function HomelandPet:SetBipObstacleEnabled(enabled)
  self._bipObstacle.enabled = enabled
end

function HomelandPet:PlaySelectAnim()
  if self._selectAnim then
    self._selectAnim:Play("aircraft_select")
  end
end

function HomelandPet:SetFadeValue()
  if not self._fadeCpt then
    return
  end
  self._fadState = Enum_Fade.Enum_Fade_Doing
  self._fabAddtime = 0
  self._fabTotaltime = 400
  self._fabAptime = 1 / self._fabTotaltime
  if self._finalVisible then
    self._fadeCpt.Alpha = 1
    self:SetVisibleBubble(false)
  else
    if self._homelandClient:CurrentMode() == HomelandMode.Build or self._homelandClient:CurrentMode() == HomelandMode.Story then
      self:_SetPetVisible(self._finalVisible)
    else
      self:_SetPetVisible(true)
    end
    self._fadeCpt.Alpha = 0
  end
end

function HomelandPet:RefreshFade(deltaTimeMS)
  if self._homelandClient:IsVisit() then
    return
  end
  if self._fadState ~= Enum_Fade.Enum_Fade_Doing or self._fadeCpt == nil then
    return
  end
  local taskManager = self._homelandClient:GetHomelandTaskManager()
  local show = not taskManager:IsPetOccupiedAsNpc(self._tmpID)
  local vv = self._visible and show
  self._fabAddtime = self._fabAddtime + deltaTimeMS
  if vv then
    self._fadeCpt.Alpha = self._fabAptime * self._fabAddtime
  else
    self._fadeCpt.Alpha = 1 - self._fabAptime * self._fabAddtime
  end
  if self._fabAddtime >= self._fabTotaltime then
    self._fadState = Enum_Fade.Enum_Fade_End
    if vv then
      self._fadeCpt.Alpha = 1
    else
      self._fadeCpt.Alpha = 0
    end
    self:SetVisibleBubble(vv)
    self:RefreshVisible()
  end
end

function HomelandPet:RefreshVisible()
  if self._homelandClient:IsVisit() then
    return
  end
  local taskManager = self._homelandClient:GetHomelandTaskManager()
  local show = not taskManager:IsPetOccupiedAsNpc(self._tmpID)
  self._finalVisible = self._visible and show
  self:_SetPetVisible(self._finalVisible)
  if self._behavior and self._behavior:GetCurBehavior() then
    local com = self._behavior:GetCurBehavior():GetComponent(HomelandPetComponentType.Bubble)
    if com ~= nil and not show then
      com:_Stop()
    end
    if com then
      com:SetCanShowBubble(self._finalVisible)
    end
  end
  if self._finalVisible then
    self:AddInteractPoint()
  else
    self:RemoveInteractPoint()
  end
  if self._fadeCpt then
    if self._finalVisible then
      self._fadeCpt.Alpha = 1
    else
      self._fadeCpt.Alpha = 0
    end
  end
  if self._miniMapVisible ~= self._finalVisible then
    self._miniMapVisible = self._finalVisible
    if self._miniMapVisible then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.Pet, self._data:TmpID(), self._petAgentTransform, self)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.Pet, self._data:TmpID())
    end
  end
end

function HomelandPet:SetVisible(visible)
  if self._visible == visible then
    return
  end
  self._visible = visible
  local show = true
  if not self._homelandClient:IsVisit() then
    local taskManager = self._homelandClient:GetHomelandTaskManager()
    show = not taskManager:IsPetOccupiedAsNpc(self._tmpID)
  end
  self._finalVisible = visible and show
  self:SetFadeValue()
  if self._finalVisible then
    self:AddInteractPoint()
  else
    self._behavior:GetCurBehavior():HideBubble()
  end
end

function HomelandPet:AddInteractPoint()
  if not self._interactPoint then
    self._interactPoint = self._homelandClient:InteractPointManager():AddBuildInteractPoint(self, 1, 3)
  end
end

function HomelandPet:RemoveInteractPoint()
  if self._interactPoint then
    self._homelandClient:InteractPointManager():RemoveBuildInteractPoint(self._interactPoint)
    self._interactPoint = nil
  end
end

function HomelandPet:GetInteractPosition(index)
  local tb = {
    [HomelandPetBehaviorType.Following] = true,
    [HomelandPetBehaviorType.FishingMatch] = true
  }
  local behaviorType = self._behavior:GetCurBehaviorType()
  if tb[behaviorType] then
    return nil
  end
  if self._petTransform then
    return self._petTransform.position
  end
  return nil
end

function HomelandPet:GetInteractAreaPosition()
  return nil
end

function HomelandPet:Interact(pointType, index)
  if pointType == InteractPointType.PetCommunication then
    local currentType = self._behavior:GetCurBehaviorType()
    local eventMgr = self._homelandClient:HomeEventManager()
    eventMgr:ReplyPetBe(self:PstID(), currentType)
    if self._invited then
      local inviteMgr = self._homelandClient:GetHomelandPetInviteManager()
      inviteMgr:SetUIHomelandPetInteract(self)
    end
    self._beforeTalkBehaviorType = self._behavior:GetCurBehaviorType()
    self._behavior:ChangeBehavior(HomelandPetBehaviorType.InteractingPlayer)
    self._homelandClient:OpenPetInteract(self)
  end
end

function HomelandPet:_CheckGreetPlayer(deltaTimeMS)
  if self._greetCheckInterval > 0 then
    self._greetCheckInterval = self._greetCheckInterval - deltaTimeMS
    return
  end
  self._greetCheckInterval = 200
  if not self:_GreetCondition() then
    return
  end
  if self._behavior:InCooling(HomelandPetBehaviorType.GreetPlayer) then
    return
  end
  if not (self._greetCfg and self._greetCfg[1].Range and self._greetCfg[1].Angle) or not self._greetCfg[1].Prob then
    return
  end
  local playerTransform = self._homelandClient:CharacterManager():GetCharacterTransform()
  if Vector3.Distance(playerTransform.position, self._petAgentTransform.position) > self._greetCfg[1].Range then
    return
  end
  local dir = playerTransform.position - self._petAgentTransform.position
  if Vector3.Angle(self._petAgentTransform.forward, dir) > self._greetCfg[1].Angle then
    return
  end
  if not self:_CheckInCameraField() then
    return
  end
  local random = math.random(1, 100)
  if random > self._greetCfg[1].Prob then
    self._greetCheckInterval = self._greetCheckInterval + self._greetCfg[1].CD * 1000
    return
  end
  if self._invited then
    return
  end
  self._behavior:ChangeBehavior(HomelandPetBehaviorType.GreetPlayer)
end

function HomelandPet:_GreetCondition()
  local behaviorType = self._behavior:GetCurBehaviorType()
  if behaviorType == HomelandPetBehaviorType.Free then
    return true
  end
  if behaviorType == HomelandPetBehaviorType.Roam then
    return true
  end
  if behaviorType == HomelandPetBehaviorType.InteractingFurniture then
    local moveComponent = self._behavior:GetCurBehavior():GetComponent(HomelandPetComponentType.Move)
    return moveComponent.state == HomelandPetComponentState.Running
  end
  return false
end

function HomelandPet:_CheckInCameraField()
  local camera = self._homelandClient:CameraManager():GetCamera()
  local viewPoint = camera:WorldToViewportPoint(self._petAgentTransform.position)
  local dir = (self._petAgentTransform.position - camera.gameObject.transform.position).normalized
  local dot = Vector3.Dot(camera.gameObject.transform.forward, dir)
  return 0 < dot and 0 <= viewPoint.x and viewPoint.x <= 1 and 0 <= viewPoint.y and 1 >= viewPoint.y
end

function HomelandPet:GetInteractRedStatus(pointType, index)
  return false
end

function HomelandPet:EnterInteractArea()
end

function HomelandPet:LeaveInteractArea()
end

function HomelandPet:RefreshFollow()
  if self._behavior:GetCurBehaviorType() == HomelandPetBehaviorType.Following then
    self._behavior:GetCurBehavior():Enter()
  end
end

function HomelandPet:SetSpeed(speed)
  self._navMeshAgent.speed = speed
end

function HomelandPet:GetSpeed()
  return self._navMeshAgent.speed
end

function HomelandPet:GetBeforeTalkBahaviorType()
  return self._beforeTalkBehaviorType
end

function HomelandPet:LoadExtraAnimation()
  if self._extraAnimReq then
    return
  end
  self._extraAnimReq = ResourceManager:GetInstance():SyncLoadAsset(self._skinID .. "_homeland_extra.prefab", LoadType.GameObject)
  if not self._extraAnimReq then
    Log.error("Homeland Pet Load Extra Animation Fail.", self._skinID)
    return
  end
  local animation = self._extraAnimReq.Obj:GetComponent(typeof(UnityEngine.Animation))
  HelperProxy:GetInstance():AddAnimTo(animation, self._animation)
end

function HomelandPet:GetExtraAnimation()
  self:LoadExtraAnimation()
  return self._extraAnimReq and self._extraAnimReq.Obj:GetComponent(typeof(UnityEngine.Animation))
end

function HomelandPet:SetStoryID(id)
  self._storyid = id
end

function HomelandPet:GetStoryID()
  return self._storyid
end

function HomelandPet:SetMatchChatID(chatID)
  self._matchChatID = chatID
end

function HomelandPet:GetMatchChatID()
  return self._matchChatID
end

function HomelandPet:BreakUpMatch()
  self._matchChatID = nil
end

function HomelandPet:PlayAnimAndReturnTime(animName)
  local time = 0
  local clip = self._animation:GetClip(animName)
  if clip then
    time = clip.length
  end
  self._animation:CrossFade(animName, 0.2)
  return time
end

function HomelandPet:PlayBubble(bubble)
  local be = self._behavior:GetCurBehavior()
  local time = be:ShowBubble(bubble)
  return time
end

function HomelandPet:SetVisibleBubble(value)
  local com = self._behavior:GetCurBehavior():GetComponent(HomelandPetComponentType.Bubble)
  if com == nil then
    return
  end
  com:Setvisible(value)
end

function HomelandPet:OnBehaviorChanged()
  for i = 1, #self._behaviorChangeCallbackList do
    self._behaviorChangeCallbackList[i](self._behavior:GetCurBehaviorType())
  end
end

function HomelandPet:RegisterBehaviorChangeCallback(callback)
  table.insert(self._behaviorChangeCallbackList, callback)
end

function HomelandPet:UnRegisterBehaviorChangeCallback(callback)
  table.removev(self._behaviorChangeCallbackList, callback)
end

function HomelandPet:_OnSaveBuilding(updateBuildings, deleteBuildings)
  if not self._interactingBuilding then
    return
  end
  if #updateBuildings <= 0 and #deleteBuildings <= 0 then
    return
  end
  local pstid = self._interactingBuilding:GetBuildPstId()
  for _, building in pairs(updateBuildings) do
    if pstid == building:GetBuildPstId() then
      self._behavior:RandomBehavior()
      return
    end
  end
  for _, building in pairs(deleteBuildings) do
    if pstid == building:GetBuildPstId() then
      self._behavior:RandomBehavior()
      return
    end
  end
end

function HomelandPet:OnClientModeChange(lastMode, currentMode)
  local behavior = self._behavior:GetCurBehavior()
  if behavior then
    behavior:OnClientModeChange(lastMode, currentMode)
  end
end

function HomelandPet:ResetNavmeshPos()
  local hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(self:GetPosition(), nil, 10, UnityEngine.AI.NavMesh.AllAreas)
  if hit then
    self:SetPosition(navMeshHit.position)
  end
end

function HomelandPet:FinalVisible()
  return self._finalVisible
end

function HomelandPet:ChangeBehavior(behaviorType, args, isInteract, index)
  self._behavior:ChangeBehavior(behaviorType, args, isInteract, index)
end

function HomelandPet:GetMotionType()
  return self._motionType
end

function HomelandPet:SetMotionType(motionType)
  self._motionType = motionType
end

function HomelandPet:ShowSkinModle(req)
  if self._resLoaded then
    self._assetReq:Dispose()
    self._assetReq = nil
    self._resLoaded = false
  end
  if self._extraAnimReq then
    self._extraAnimReq:Dispose()
    self._extraAnimReq = nil
  end
  if self.clickEffReq then
    self.clickEffReq:Dispose()
    self.clickEffReq = nil
  end
  if self._materialAnimationContainer then
    self._materialAnimationContainer:Dispose()
    self._materialAnimationContainer = nil
  end
  UnityEngine.Object.Destroy(self._petGO)
  self:_RemoveEvent()
  local reLoad = true
  self:Show(req, nil, reLoad)
end

function HomelandPet:ReloadBehaviorComponent()
  self._behavior:ReloadBehaviorComponent()
end

function HomelandPet:SetInvited(invited)
  self._invited = invited
end

function HomelandPet:GetInvited()
  return self._invited
end

function HomelandPet:CheckIsInInviteingCDList()
  return self._homelandClient:GetHomelandPetInviteManager():CheckInInviteingCDTime(self)
end

function HomelandPet:PlayMaterialAnim(anim)
  if not self._materialAnimation then
    return
  end
  self._materialAnimation:Play(anim)
end

function HomelandPet:SetPoolAndOldSkin(pool, oldSkin, oldClothSkin)
  self._swimPool = pool
  self._oldSkin = oldSkin
  self._oldClothSkin = oldClothSkin
end

function HomelandPet:_ChangeSwimCloth()
  if self._miniMapVisible then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.Pet, self._data:TmpID())
  end
  local petSkinID = self:SkinID()
  local cfgSwimmingPoolPet = Cfg.cfg_homeland_swimming_pool_pet[petSkinID]
  self._cfgSwimmingPoolPet = cfgSwimmingPoolPet
  if not cfgSwimmingPoolPet then
    return
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(self._cfgSwimmingPoolPet.ChangeSkinEffectName, LoadType.GameObject)
  if req then
    req.Obj:SetActive(true)
    local tran = req.Obj.transform
    tran.position = self:AgentTransform().position
    tran.localRotation = Quaternion.identity
  end
  self._homelandPetManager:ChangePetSkin(self, self._oldSkin, self._oldClothSkin)
  if self._miniMapVisible then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.Pet, self._data:TmpID(), self._petAgentTransform, self)
  end
  self:PlayMaterialAnim("eff_yyc_hz_switch_glow")
  self:ReloadBehaviorComponent()
end

function HomelandPet:BindingSkeleton(isBinding, skeleton)
  if isBinding then
    if skeleton then
      self._petAgentTransform:SetParent(skeleton)
      self._petAgentTransform.localPosition = Vector3.zero
      self._petAgentTransform.localRotation = Quaternion.identity
    end
  else
    self._petAgentTransform:SetParent(self._homelandClient:SceneManager():RuntimeRootTrans(), true)
  end
end
