_class("BuildBase", Object)
BuildBase = BuildBase

function BuildBase:Constructor()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homeLandModule:GetClient()
  self._interactPointManager = self._homelandClient:InteractPointManager()
  self._petInteractPointCount = 0
end

function BuildBase:RefreshInteractPoint()
  if self._isLock then
    return
  end
  if not self._transform then
    return
  end
  self._interactParent = self._transform:Find("Interact")
  if not self._interactParent then
    return
  end
  self._interactPoints = {}
  self._interactpos = {}
  for i = 0, self._interactParent.childCount - 1 do
    local interactPoint = self._interactParent:GetChild(i)
    local name = interactPoint.name
    local cfgs = Cfg.cfg_building_interact_point({PointName = name})
    if cfgs and 0 < table.count(cfgs) then
      local cfg = cfgs[1]
      self._interactPoints[#self._interactPoints + 1] = self._interactPointManager:AddBuildInteractPoint(self, i, cfg.ID)
      if cfg.ID == InteractPointType.PetBuilding then
        self._petInteractPointCount = self._petInteractPointCount + 1
      end
    end
  end
end

function BuildBase:GetPetInteractPoint(interactPointindex)
  local interactPoint, index
  if self._interactPoints then
    local petInteractPoint = {}
    for i = 1, #self._interactPoints do
      local ip = self._interactPoints[i]
      if ip:GetPointType() == InteractPointType.PetBuilding then
        petInteractPoint[#petInteractPoint + 1] = ip
      end
    end
    if 0 < #petInteractPoint then
      for _index, _interactPoint in ipairs(petInteractPoint) do
        local curInteractObject = _interactPoint:GetInteractObject()
        if HomelandPet:IsInstanceOfType(curInteractObject) then
          local cfg = Cfg.cfg_homeland_pet_behavior_lib({
            TemplateID = curInteractObject:TemplateID(),
            BehaviorType = HomelandPetBehaviorType.InteractingFurniture
          })
          if cfg and 0 < #cfg and table.icontains(cfg[1].ExclusiveBuildings, curInteractObject:TemplateID()) then
            return nil, nil
          end
        end
        if interactPointindex then
          if _index == interactPointindex and not curInteractObject then
            interactPoint = _interactPoint
            index = _index
            break
          end
        elseif not curInteractObject then
          interactPoint = _interactPoint
          index = _index
          break
        end
      end
    end
  end
  return interactPoint, index
end

function BuildBase:GetAllInteractPointByType(interactPointType)
  local interactPoints = {}
  for i = 1, #self._interactPoints do
    local ip = self._interactPoints[i]
    if ip:GetPointType() == interactPointType then
      interactPoints[#interactPoints + 1] = ip
    end
  end
  return interactPoints
end

function BuildBase:ResetInteractPoint()
  if not self._interactPoints then
    return
  end
  for i = 1, #self._interactPoints do
    self._interactPointManager:RemoveBuildInteractPoint(self._interactPoints[i])
  end
  self._interactPoints = nil
  self._interactpos = {}
end

function BuildBase:GetBuildId()
  return self._cfgID
end

function BuildBase:GetBuildPstId()
  if self._architecture and self._architecture.pstid then
    return self._architecture.pstid
  end
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  return homelandModule:GetBuildPstid(self:GetBuildId())
end

function BuildBase:GetInteractTransform(index)
  if not self._interactParent then
    return
  end
  return self._interactParent:GetChild(index)
end

function BuildBase:GetInteractLeaveNode(index, leaveName)
  local interact = self:GetInteractTransform(index)
  if interact ~= nil then
    return interact:Find(leaveName)
  end
  return nil
end

function BuildBase:AddInteractPoint_UniqueIndex(build, index, interactPointCfgId)
  for _, v in ipairs(self._interactPoints) do
    if v:GetIndex() == index then
      return
    end
  end
  local ip = self._interactPointManager:AddBuildInteractPoint(build, index, interactPointCfgId)
  table.insert(self._interactPoints, ip)
end

function BuildBase:GetInteractPoint(index)
  if self._interactPoints then
    return self._interactPoints[index]
  end
end

function BuildBase:EnableInteractPointByIndex(pointIndex, isEnable)
  local findPointId
  for id, point in ipairs(self._interactPoints) do
    if point:GetIndex() == pointIndex then
      findPointId = id
      break
    end
  end
  if findPointId == nil then
    return
  end
  local findPoint = self._interactPoints[findPointId]
  if isEnable then
    local build = findPoint:GetBuild()
    local index = findPoint:GetIndex()
    local interactPointCfgId = findPoint:GetCfg().ID
    self._interactPoints[findPointId] = self._interactPointManager:AddBuildInteractPoint(build, index, interactPointCfgId)
  else
    self._interactPointManager:RemoveBuildInteractPoint(findPoint)
  end
end

function BuildBase:EnableInteractPointByCfgId(configId, isEnable)
  local findList = {}
  for id, point in ipairs(self._interactPoints) do
    if point:GetCfg().ID == configId then
      table.insert(findList, id)
    end
  end
  for k, v in pairs(findList) do
    local findPoint = self._interactPoints[v]
    if isEnable then
      local build = findPoint:GetBuild()
      local index = findPoint:GetIndex()
      local interactPointCfgId = findPoint:GetCfg().ID
      self._interactPoints[v] = self._interactPointManager:AddBuildInteractPoint(build, index, interactPointCfgId)
    else
      self._interactPointManager:RemoveBuildInteractPoint(findPoint)
    end
  end
end

function BuildBase:GetInteractPosition(index)
  if not self._interactParent then
    return
  end
  if self._interactpos == nil then
    self._interactpos = {}
  end
  if self._interactpos[index] == nil then
    local tran = self._interactParent:GetChild(index)
    self._interactpos[index] = tran.position
  end
  return self._interactpos[index]
end

function BuildBase:GetInteractBoxCollider(index)
  if not self._interactParent then
    return
  end
  if self._interactBoxCollider == nil then
    self._interactBoxCollider = {}
  end
  if self._interactBoxCollider[index] == nil then
    local tran = self._interactParent:GetChild(index)
    self._interactBoxCollider[index] = tran:GetComponent("BoxCollider")
  end
  return self._interactBoxCollider[index]
end

function BuildBase:ResetInteractPos()
  self._interactpos = nil
end

function BuildBase:GetInteractAreaPosition()
  return Vector3(0, 0, 0)
end

function BuildBase:Interact(pointType, index, interactPoint, interactBtn)
  local characterManager = self._homelandClient:CharacterManager()
  local characterController = characterManager:MainCharacterController()
  local playerPos = characterController:Position()
  local targetPos = self._transform.position
  local targetDir = targetPos - playerPos
  targetDir.y = 0
  self:OnInteract(pointType)
  if pointType == InteractPointType.Info then
    self:ShowDialog("UIBuildInfo", self)
    characterController:SetLocation(playerPos, Quaternion.LookRotation(targetDir))
  elseif pointType == InteractPointType.Build then
    self:ShowDialog("UIForge")
  elseif pointType == InteractPointType.Treasure then
  elseif pointType == InteractPointType.TreasureBounding then
    self:ShowDialog("UITreasureBoard")
  elseif pointType == InteractPointType.PetBuilding then
  elseif pointType == InteractPointType.Wishing then
    characterController:SetForbiddenMove(true)
    self:ShowDialog("UIBuildCollectCoin", self)
    characterController:SetLocation(playerPos, Quaternion.LookRotation(targetDir))
  elseif pointType == InteractPointType.Raise then
    characterController:SetForbiddenMove(true)
    local cameraTran = self._transform:Find("FishCamera")
    if cameraTran then
      local cameraMgr = self._homelandClient:CameraManager()
      local followCameraController = cameraMgr:FollowCameraController()
      followCameraController:Focus(cameraTran, nil, function(param)
        characterController:SetLocation(playerPos, Quaternion.LookRotation(targetDir))
        self:ShowDialog("UIBuildRaiseFish", self)
      end)
    end
  elseif pointType == InteractPointType.Shop then
    self:ShowDialog("UIHomelandShopController", self)
  elseif pointType == InteractPointType.Breed then
    Log.info("BuildBase Click Breed InteractPointBtn")
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    homeLandModule:OnBreedInteract(self)
  elseif pointType == InteractPointType.EnterDomitory then
    self:ShowDialog("UIHomeDomitory", self:GetBuildPstId())
  elseif pointType == InteractPointType.Photo then
    self:ShowDialog("UIHomePhotoController")
  elseif pointType == InteractPointType.Storehouse then
    self:ShowDialog("UIHomeStorehouse")
  elseif pointType == InteractPointType.Visit_Build then
    self:ShowDialog("UIHomeVisitSpeedup")
  elseif pointType == InteractPointType.Visit_Water then
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    homeLandModule:Visit_Water(self, self:GetInteractTransform(index), interactBtn)
  elseif pointType == InteractPointType.Visit_GetGift then
    self:ShowDialog("UIHomeVisitGetGift")
  elseif pointType == InteractPointType.FixBuilding then
    self:_TryFixBuilding()
  elseif pointType == InteractPointType.TreeDye then
    self:ShowDialog("UIHomelandTreeDye", self:GetBuildPstId(), self:GetBuildId())
  elseif pointType == InteractPointType.RoleInteract then
    local relatedPetInteractingTarget = interactPoint:GetBuild():GetInteractPoint(interactPoint:GetIndex())
    local curInteractingTarget = relatedPetInteractingTarget:GetInteractObject()
    if curInteractingTarget and HomelandPet:IsInstanceOfType(curInteractingTarget) then
      curInteractingTarget:GetPetBehavior():RandomBehavior()
    end
    self._homelandClient:CharacterManager():MainCharacterController():Interact(self, index, interactPoint)
  elseif pointType == InteractPointType.Album then
    self:ShowDialog("UIHomelandAlbum")
  elseif pointType == InteractPointType.Aquarium then
    characterController:SetForbiddenMove(true)
    local camera1 = GameObjectHelper.FindChild(self._transform, "FishCamera")
    local camera2 = GameObjectHelper.FindChild(self._transform, "FishCamera2")
    local targetPos = self._homelandClient:CharacterManager():MainCharacterController():Position()
    local distance1 = Vector3.Distance(camera1.position, targetPos)
    local distance2 = Vector3.Distance(camera2.position, targetPos)
    local cameraTran = camera1
    if distance1 > distance2 then
      cameraTran = camera2
    end
    if cameraTran then
      local cameraMgr = self._homelandClient:CameraManager()
      local followCameraController = cameraMgr:FollowCameraController()
      followCameraController:FocusUseAngles(cameraTran, nil, function(param)
        characterController:SetLocation(playerPos, Quaternion.LookRotation(targetDir))
        self:ShowDialog("UIHomelandAquarium", self)
      end)
      local targetFieldOfView = 26
      self:_AddCameraFovEvent(followCameraController, targetFieldOfView)
    end
  elseif pointType == InteractPointType.Invite then
    self:ShowDialog("UIHomePetInvite", self, index)
  elseif pointType == InteractPointType.Clean then
    self:Clean(index)
  elseif pointType == InteractPointType.HomelandShop then
    self:_OpenShop()
  elseif pointType == InteractPointType.FlushingRoom then
    self._homelandClient:CharacterManager():MainCharacterController():Interact(self, index, interactPoint)
  elseif pointType == InteractPointType.RoleSwimmingArea then
    Log.fatal("泳池区域")
  elseif pointType == InteractPointType.EditMedalWall then
    characterController:SetForbiddenMove(true)
    self:ShowDialog("UIN22MedalEdit", true, function(param)
      characterController:SetForbiddenMove(false)
    end)
  elseif pointType == InteractPointType.ShowMedalWall then
    self:_ShowMedalWall()
  elseif pointType == InteractPointType.Movie then
    self:ShowDialog("UIHomelandMovieMainController", self)
  else
    Log.warn("### invalid interact point")
  end
end

function BuildBase:OnInteract(interactType)
end

function BuildBase:GetInteractRedStatus(pointType, index)
  if pointType == InteractPointType.Info then
    local homelandModule = GameGlobal.GetModule(HomelandModule)
    return homelandModule:HasSkinRedPoint(self:GetBuildId())
  elseif pointType == InteractPointType.Build then
    local homelandModule = GameGlobal.GetModule(HomelandModule)
    local data = homelandModule:GetForgeData()
    local map = data:GetSequenceStateCountMap()
    if data:HasCanUnlockItem() or map[ForgeSequenceState.Getable] > 0 then
      return true
    end
  elseif pointType == InteractPointType.Photo then
    local itemModule = GameGlobal.GetModule(ItemModule)
    local has = itemModule:UIHomePhotoHasNew()
    return has
  elseif pointType == InteractPointType.Wishing then
    local datas = UIBuildCollectCoinDatas:New()
    if datas:HasCollectCoin() then
      return true
    end
    return false
  end
  return false
end

function BuildBase:EnterInteractArea()
end

function BuildBase:LeaveInteractArea()
end

function BuildBase:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function BuildBase:CloseDialog(name)
  GameGlobal.UIStateManager():CloseDialog(name)
end

function BuildBase:_TryFixBuilding()
  Log.info("Building TryFixBuilding")
  local enough = true
  if self:IsShabby() then
    Log.info("Building TryFixBuilding, Building Shabby")
    local defaultBuildingCfgs = Cfg.cfg_default_architecture({
      ArchitectureId = self._cfgID
    })[1]
    local cost = defaultBuildingCfgs.FixCost
    local str = ""
    local itemModule = GameGlobal.GetModule(ItemModule)
    for i, item in ipairs(cost) do
      local id = item[1]
      local need = item[2]
      local count = itemModule:GetItemCount(id)
      local name = StringTable.Get(Cfg.cfg_item[id].Name)
      if need > count then
        str = str .. StringTable.Get("str_homeland_unlock_not_enough", name, count, need)
        enough = enough and false
      else
        str = str .. StringTable.Get("str_homeland_unlock_enough", name, count, need)
        enough = enough and true
      end
      if i < #cost then
        str = str .. StringTable.Get("str_homeland_unlock_building_tip_spliter")
      end
    end
    self:ShowDialog("UIHomelandMessageBox", nil, StringTable.Get("str_homeland_unlock_building_tip", str, self:GetName()), {
      StringTable.Get("str_common_cancel"),
      function(param)
      end
    }, {
      StringTable.Get("str_common_ok"),
      function(param)
        if enough then
          GameGlobal.TaskManager():StartTask(self._ReqFix, self)
        else
          ToastManager.ShowHomeToast(StringTable.Get("str_homeland_unlock_building_failed"))
        end
      end
    }, true)
  end
end

function BuildBase:_ReqFix(TT)
  local pstid = self:PstID()
  local module = GameGlobal.GetModule(HomelandModule)
  GameGlobal.UIStateManager():Lock("ReqFixBuilding")
  local res = module:HandleHomelandFixShabbyReq(TT, pstid)
  GameGlobal.UIStateManager():UnLock("ReqFixBuilding")
  if not res:GetSucc() then
    Log.fatal("修复建筑失败：", res:GetResult())
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_task_error_" .. res:GetResult()))
    return
  end
  AudioHelperController.RequestAndPlayUIVoiceAutoRelease(CriAudioIDConst.HomelandFixBuild)
  self:ShowDialog("UIHomelandFixBuilding", self._cfgID, pstid)
end

function BuildBase:_OpenShop()
  GameGlobal.UAReportForceGuideEvent("HomelandInteractClick", {
    "Click_ShopController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Shop)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_SHOP)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    ClientShop.OpenShop()
  else
    ClientShop.OpenShop(nil, ShopMainTabType.Homeland)
  end
end

function BuildBase:GetHomelandClient()
  return self._homelandClient
end

function BuildBase:_ShowMedalWall()
  local characterController = self._homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(true)
  local cameraTran = GameObjectHelper.FindChild(self._transform, "MedalCamera")
  if cameraTran then
    local cameraMgr = self._homelandClient:CameraManager()
    local followCameraController = cameraMgr:FollowCameraController()
    followCameraController:FocusUseAngles(cameraTran, nil, function(param)
      self:ShowDialog("UIHomelandMedalWall", cameraTran)
    end)
    local targetFieldOfView = 26
    self:_AddCameraFovEvent(followCameraController, targetFieldOfView)
  end
end

function BuildBase:_AddCameraFovEvent(followCameraController, targetFieldOfView)
  local defaultFocusTime = 0.5
  local startTime = GameGlobal:GetInstance():GetCurrentTime()
  local curFieldOfView = followCameraController._camera.fieldOfView
  self._timerHandler = GameGlobal.Timer():AddEventTimes(defaultFocusTime, TimerTriggerCount.Infinite, function()
    local curTime = GameGlobal:GetInstance():GetCurrentTime()
    local percent = (curTime - startTime) / (defaultFocusTime * 1000)
    if curTime - startTime >= defaultFocusTime then
      percent = 1
      if self._timerHandler then
        GameGlobal.Timer():CancelEvent(self._timerHandler)
        self._timerHandler = nil
      end
    end
    local fov = DG.Tweening.DOVirtual.EasedValue(curFieldOfView, targetFieldOfView, percent, DG.Tweening.Ease.Linear)
    followCameraController._camera.fieldOfView = fov
  end)
end

function BuildBase:GetInteractableCount()
  return self._petInteractPointCount
end
