_class("HomelandMovieClosingManager", Object)
HomelandMovieClosingManager = HomelandMovieClosingManager

function HomelandMovieClosingManager:Constructor()
  self._operateBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  self._pathRoot = self._operateBuilding:Transform():Find("EndingPath")
  self._animWaitTime = 4
  self._animBeginWaitTime = 1.2
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  local bound = 1.7
  local homelandClient = self._uiModule:GetClient()
  self._globalCamera = homelandClient:CameraManager():GlobalCameraController():CameraCmp()
  self._orgCameraFov = self._globalCamera.fieldOfView
  local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
  local offset = bound - aspect
  local scale = offset < 0 and 0 or offset
  self._globalCamera.fieldOfView = self._orgCameraFov + scale * 20
  self._petReqList = {}
  self._petAnimReqList = {}
  self._animList = {}
  self._faceIDList = {}
  self._faceList = {}
end

function HomelandMovieClosingManager:ShowPetClosing(isRecord, closingItem)
  self._closingItem = closingItem
  if isRecord then
    self:_ShowPetRecordClosingStatus()
  else
    self:_ShowPetClosingStatus()
  end
end

function HomelandMovieClosingManager:StopAnim()
  self._globalCamera.fieldOfView = self._orgCameraFov
  if self._AnimTimer then
    GameGlobal.Timer():CancelEvent(self._AnimTimer)
  end
  if self._FaceTimer then
    GameGlobal.Timer():CancelEvent(self._FaceTimer)
  end
  self._petReqList = nil
  self._petAnimReqList = nil
  self._animList = nil
  self._faceIDList = nil
  self._faceList = nil
end

function HomelandMovieClosingManager:_ShowPetClosingStatus()
  local endList = HomelandMoviePrepareManager:GetInstance():GetSelectedData(MoviePrepareType.PT_Actor)
  local actorCnt = #endList
  local endingPosList = self._pathRoot:Find("EndingPath0" .. actorCnt)
  local idx = 0
  for _, itemData in pairs(endList) do
    local id = itemData:GetItemId()
    local obj, petAnim = self:_CreateActorAndGetAnim(id)
    local face_name = obj.name .. "_face"
    local face = GameObjectHelper.FindChild(obj.transform, face_name)
    if face then
      local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
      if not render then
        Log.error("###[HomeStoryEntityModel] 面部表情节点上找不到SkinnedMeshRenderer：", face_name)
      else
        table.insert(self._faceList, render.material)
      end
    else
      Log.error("###[HomeStoryEntityModel] 找不到面部表情节点：", face_name)
    end
    obj.transform.parent = endingPosList:GetChild(idx)
    obj.transform.localPosition = Vector3.zero
    obj.transform.localRotation = Quaternion.identity
    obj:SetActive(true)
    petAnim:Play(HomelandPetAnimName.Stand)
    table.insert(self._animList, petAnim)
    local petFaceCfg
    local cfg = Cfg.cfg_homeland_movie_pet_face({ID = id})
    if not cfg then
      petFaceCfg = Cfg.cfg_homeland_movie_pet_face({ID = -1})[1]
    else
      petFaceCfg = cfg[1]
    end
    table.insert(self._faceIDList, petFaceCfg)
    idx = idx + 1
  end
  self:PlayClosingAnimTimer()
end

function HomelandMovieClosingManager:PlayClosingAnimTimer()
  self._AnimTimer = GameGlobal.Timer():AddEvent(self._animBeginWaitTime * 1000, function()
    self:PlayClosingAnim()
    self._AnimTimer = GameGlobal.Timer():AddEventTimes(self._animWaitTime * 1000, TimerTriggerCount.Infinite, function()
      self:PlayClosingAnim()
    end)
  end)
end

function HomelandMovieClosingManager:PlayClosingAnim()
  for i = 1, #self._animList do
    if self._animList == nil or tolua.isnull(self._animList[i]) then
      return
    end
    self._animList[i]:Play(self._closingItem.Anim)
    self._faceList[i]:SetInt("_Frame", self._faceIDList[i][self._closingItem.Face])
    local state = self._animList[i]:get_Item(self._closingItem.Anim)
    if state then
      self._FaceTimer = GameGlobal.Timer():AddEvent(state.clip.length * 1000, function()
        if self._animList == nil or tolua.isnull(self._animList[i]) then
          return
        end
        self._animList[i]:Play(HomelandPetAnimName.Stand)
        self._faceList[i]:SetInt("_Frame", self._faceIDList[i].Default)
      end)
    else
      Log.fatal("无法找到该角色的结算动画", self._animList[i])
    end
  end
end

function HomelandMovieClosingManager:_ShowPetRecordClosingStatus()
  local playBackData = MoviePrepareData:GetInstance():GetPlayBackData()
  local actorCnt = table.count(playBackData.chose_pets)
  local endingPosList = self._pathRoot:Find("EndingPath0" .. actorCnt)
  local idx = 0
  for petID, v in pairs(playBackData.chose_pets) do
    local obj, petAnim = self:_CreateActorAndGetAnim(v)
    local face_name = obj.name .. "_face"
    local face = GameObjectHelper.FindChild(obj.transform, face_name)
    if face then
      local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
      if not render then
        Log.error("###[HomeStoryEntityModel] 面部表情节点上找不到SkinnedMeshRenderer：", face_name)
      else
        table.insert(self._faceList, render.material)
      end
    else
      Log.error("###[HomeStoryEntityModel] 找不到面部表情节点：", face_name)
    end
    obj.transform.parent = endingPosList:GetChild(idx)
    obj.transform.localPosition = Vector3.zero
    obj.transform.localRotation = Quaternion.identity
    obj:SetActive(true)
    petAnim:Play(HomelandPetAnimName.Stand)
    table.insert(self._animList, petAnim)
    local petFaceCfg
    local cfg = Cfg.cfg_homeland_movie_pet_face({ID = petID})
    if not cfg then
      petFaceCfg = Cfg.cfg_homeland_movie_pet_face({ID = -1})[1]
    else
      petFaceCfg = cfg[1]
    end
    table.insert(self._faceIDList, petFaceCfg)
    idx = idx + 1
  end
  self:PlayClosingAnimTimer()
end

function HomelandMovieClosingManager:_CreateActorAndGetAnim(petName)
  local petObjReq = ResourceManager:GetInstance():SyncLoadAsset(petName .. ".prefab", LoadType.GameObject)
  table.insert(self._petReqList, petObjReq)
  local obj = petObjReq.Obj
  local rootTrans = obj.transform:Find("Root")
  for i = 0, rootTrans.childCount - 1 do
    local child = rootTrans:GetChild(i)
    if string.find(child.name, "weapon") then
      child.gameObject:SetActive(false)
    end
  end
  local root = rootTrans.gameObject
  local animator = root:GetComponent(typeof(UnityEngine.Animator))
  if animator then
    UnityEngine.Object.Destroy(animator)
  end
  local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
  local petHomePrefab = HelperProxy:GetInstance():GetPetAnimatorControllerName(petName .. ".prefab", PetAnimatorControllerType.Homeland)
  if petHomePrefab then
    local petHomelandAnimReq = ResourceManager:GetInstance():SyncLoadAsset(petHomePrefab, LoadType.GameObject)
    table.insert(self._petAnimReqList, petHomelandAnimReq)
    local homelandAnimation = petHomelandAnimReq.Obj:GetComponent("Animation")
    local clips = HelperProxy:GetInstance():GetAllAnimationClip(homelandAnimation)
    for i = 0, clips.Length - 1 do
      if clips[i] == nil then
        Log.error("Pet animation is null:", self._petID, ", index:", i)
      else
        petAnim:AddClip(clips[i], clips[i].name)
      end
    end
  end
  local petAircraftPrefab = HelperProxy:GetInstance():GetPetAnimatorControllerName(petName .. ".prefab", PetAnimatorControllerType.Aircraft)
  if petAircraftPrefab then
    local petAircraftAnimReq = ResourceManager:GetInstance():SyncLoadAsset(petAircraftPrefab, LoadType.GameObject)
    table.insert(self._petAnimReqList, petAircraftAnimReq)
    local aircraftAnimation = petAircraftAnimReq.Obj:GetComponent("Animation")
    local clips = HelperProxy:GetInstance():GetAllAnimationClip(aircraftAnimation)
    for i = 0, clips.Length - 1 do
      if clips[i] == nil then
        Log.error("Pet animation is null:", self._petID, ", index:", i)
      else
        petAnim:AddClip(clips[i], clips[i].name)
      end
    end
  end
  return obj, petAnim
end
