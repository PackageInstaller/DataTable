local DormFurnitureEntity = class("DormFurnitureEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_ResLoader = CS.ResLoader
local CS_Collider = CS.UnityEngine.Collider
local EnableTouchAnimatorNameHash = CS.UnityEngine.Animator.StringToHash("EnableTouch")
local DormFntCenterType = {Center = 0, BottomCenter = 1}

function DormFurnitureEntity:ctor()
end

function DormFurnitureEntity:InitFntEntity(fntData, holder)
  self.fntData = fntData
  self.type = self.fntData:GetFntType()
  self._enableTouch = false
  self.rootGo = CS_GameObject(tostring(self.fntData.id))
  self.rootTran = self.rootGo.transform
  self.rootTran:SetParent(holder)
  self:InitFntEntityRoot()
end

function DormFurnitureEntity:InitFntEntityRoot()
  local sizeX, sizeY = self.fntData:GetFntSize()
  if self.fntData:GetFntCenterCfg() == DormFntCenterType.BottomCenter then
    self._tranformLocalPos = DormUtil.FntCoord2Unity(sizeX / 2 - 0.5, sizeY - 0.5, self.type)
    self._tranformLocalCenterPos = DormUtil.FntCoord2Unity(sizeX / 2 - 0.5, sizeY / 2 - 0.5, self.type)
  else
    self._tranformLocalPos = DormUtil.FntCoord2Unity(sizeX / 2 - 0.5, sizeY / 2 - 0.5, self.type)
    self._tranformLocalCenterPos = self._tranformLocalPos
  end
  self:SetFntEntityPos(self.fntData.x, self.fntData.y)
  self:__SetRotation()
  self._isLoadedGo = false
end

function DormFurnitureEntity:_ClearResLoader()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
end

function DormFurnitureEntity:LoadFntEntityGo(path, callback)
  self:_ClearResLoader()
  self.resLoader = CS_ResLoader.Create()
  self._inLoadingModel = true
  UIUtil.AddOneCover(self)
  self.resLoader:LoadABAssetAsync(path, function(prefab)
    self._inLoadingModel = false
    UIUtil.CloseOneCover(self)
    if IsNull(self.rootGo) or IsNull(prefab) then
      return
    end
    local go = prefab:Instantiate()
    self:SetFntEntityGo(go)
    if callback ~= nil then
      callback(self)
    end
    self:TryUpdDmFntWallpaperLayer()
  end)
end

function DormFurnitureEntity:IsDmFntEntityInLoading()
  return self._inLoadingModel
end

function DormFurnitureEntity:SetFntEntityGo(obj)
  self.gameObject = obj
  self.transform = obj.transform
  self.transform:SetParent(self.rootTran, false)
  self.transform.localPosition = self._tranformLocalPos
  self._colliders = self.rootTran:GetComponentsInChildren(typeof(CS_Collider))
  self._visibleHolderTransform = self.transform:Find("VisibleHolder")
  self._isLoadedGo = true
  self:InitFntTouchAnimator()
end

function DormFurnitureEntity:EnableDmFntCollider(enable)
  if self._colliders == nil then
    return
  end
  for i = 0, self._colliders.Length - 1 do
    self._colliders[i].enabled = enable
  end
end

function DormFurnitureEntity:EnableDmFntVisibleHolder(enable)
  if self._visibleHolderTransform == nil then
    return
  end
  self._visibleHolderTransform.gameObject:SetActive(enable)
end

function DormFurnitureEntity:ResetFntEntityByData(parent)
  self.rootTran:SetParent(parent)
  self:SetFntEntityPos(self.fntData.x, self.fntData.y)
  self:__SetRotation()
  if self.type == DormEnum.eDormFntType.Wallpaper then
    self:TryUpdDmFntWallpaperLayer()
  end
end

function DormFurnitureEntity:SetFntEntityPos(x, y, tween)
  local unityPos = DormUtil.FntCoord2Unity(x, y, self.type)
  self.fntData:SetFntPos(x, y)
  self.rootTran:DOKill()
  if tween then
    self.rootTran:DOLocalMove(unityPos, 0.1):SetLink(self.rootGo)
  else
    self.rootTran.localPosition = unityPos
  end
end

function DormFurnitureEntity:GetFntEntityLocalPos()
  return self.rootTran.localPosition
end

function DormFurnitureEntity:GetFntEntityCenterTrasform()
  if self.rootCenterTran == nil then
    self.rootCenterGo = CS_GameObject("Center")
    self.rootCenterTran = self.rootCenterGo.transform
    self.rootCenterTran:SetParent(self.rootTran)
    self.rootCenterTran.localPosition = self._tranformLocalCenterPos
  end
  return self.rootCenterTran
end

function DormFurnitureEntity:SetFntEntityPosFromUnity(unityPos, force)
  local newX, newY = DormUtil.UnityCoord2Fnt(unityPos, self.type)
  local sizeX, sizeY = self.fntData:GetFntSize()
  if self.type == DormEnum.eDormFntType.Door then
    newY = self.fntData:GetFntDoorY(sizeY)
  end
  local oldX = self.fntData.x
  local oldY = self.fntData.y
  local move = newX ~= oldX or newY ~= oldY or force
  if move then
    local outX, outY, newX, newY = DormUtil.FntAreaOutMap(newX, newY, sizeX, sizeY, self.fntData.r, self.type, self.fntData.roomData.roomCfg)
    move = newX ~= oldX or newY ~= oldY or force
    if move then
      self:SetFntEntityPos(newX, newY, true)
    end
  end
  return move, oldX, oldY
end

function DormFurnitureEntity:RotateFntEntity()
  self.fntData:RotateFnt()
  self.rootTran.eulerAngles = Vector3.New(0, self.fntData.r, 0)
  if self.fntData:CheckOutMap() then
    self:SetFntEntityPos(self.fntData.x, self.fntData.y, true)
  end
end

function DormFurnitureEntity:__SetRotation()
  local angle = Vector3.New()
  if DormEnum.IsFntWallType(self.type) then
    angle.z = self.fntData.r
  else
    angle.y = self.fntData.r
  end
  self.rootTran.localEulerAngles = angle
end

function DormFurnitureEntity:GetFntEntityType()
  return self.type
end

function DormFurnitureEntity:GetFntAreaList(x, y)
  if x == nil or y == nil then
    x = self.fntData.x
    y = self.fntData.y
  end
  local sizeX, sizeY = self.fntData:GetFntSize()
  local areaList = DormUtil.GetFntArea(x, y, sizeX, sizeY, self.fntData.r)
  return areaList
end

function DormFurnitureEntity:GetFntDoorAreaList(x, y, wallId)
  if x == nil or y == nil then
    x = self.fntData.x
    y = self.fntData.y
  end
  if wallId == nil then
    wallId = self.fntData:GetFntParam()
  end
  x, y = DormUtil.GetFntDoorPosByWall(wallId, x, self.fntData.roomData:GetRoomGridLengthCount())
  local sizeX, _, sizeY = self.fntData:GetFntSize()
  local rot = DormUtil.GetFntDoorR(wallId)
  local areaList = DormUtil.GetFntArea(x, y, sizeX, sizeY, rot)
  return areaList
end

function DormFurnitureEntity:SetFntOverlap(overlap)
  self.overlap = overlap
  self:ShowFntOverlap()
end

function DormFurnitureEntity:IsOverlap()
  return self.overlap
end

function DormFurnitureEntity:ShowFntOverlap()
  if self.fntBottom ~= nil then
    self.fntBottom:ShowOverlap(self.overlap)
  end
  if self.fntFloorBottom ~= nil then
    self.fntFloorBottom:ShowOverlap(self.overlap)
  end
end

function DormFurnitureEntity:AddFntBottom(bottom)
  local sizeX, sizeY = self.fntData:GetFntSize()
  local unityScale = DormUtil.FntSize2Unity(sizeX, sizeY, self.type)
  bottom:InitFntBottom(unityScale, self.type, self.rootTran, self._tranformLocalCenterPos)
  self.fntBottom = bottom
  self:ShowFntOverlap()
end

function DormFurnitureEntity:RemoveFntBottom()
  local bottom = self.fntBottom
  self.fntBottom = nil
  return bottom
end

function DormFurnitureEntity:ResetFntBottom()
  local sizeX, sizeY, sizeZ = self.fntData:GetFntSize()
  if self.fntBottom ~= nil then
    local unityScale = DormUtil.FntSize2Unity(sizeX, sizeY, self.type)
    self.fntBottom:InitFntBottom(unityScale, self.type, self.rootTran, self._tranformLocalCenterPos)
  end
  if self.fntFloorBottom ~= nil then
    local unityScale = DormUtil.FntSize2Unity(sizeX, sizeZ, DormEnum.eDormFntType.Door)
    local wallUnityScale = DormUtil.FntSize2Unity(sizeX, sizeY, DormEnum.eDormFntType.Door)
    local y = -wallUnityScale.z / 2
    local z = unityScale.z / 2
    local pos = Vector3.New(0, y, z) + self._tranformLocalCenterPos
    self.fntFloorBottom:InitFntBottom(unityScale, DormEnum.eDormFntType.Furniture, self.rootTran, pos)
  end
end

function DormFurnitureEntity:AddFntDoorBottom(bottom)
  local sizeX, sizeY, sizeZ = self.fntData:GetFntSize()
  local unityScale = DormUtil.FntSize2Unity(sizeX, sizeZ, DormEnum.eDormFntType.Door)
  local wallUnityScale = DormUtil.FntSize2Unity(sizeX, sizeY, DormEnum.eDormFntType.Door)
  local y = -wallUnityScale.z / 2
  local z = unityScale.z / 2
  local pos = Vector3.New(0, y, z) + self._tranformLocalCenterPos
  bottom:InitFntBottom(unityScale, DormEnum.eDormFntType.Furniture, self.rootTran, pos)
  self.fntFloorBottom = bottom
  self:ShowFntOverlap()
end

function DormFurnitureEntity:RemoveFntDoorBottom(bottom)
  local bottom = self.fntFloorBottom
  self.fntFloorBottom = nil
  return bottom
end

function DormFurnitureEntity:ChangeDmFntWall(wallHolder, wallIndex)
  local roomData = self.fntData:GetFntRoom()
  local isWallpaper = self.type == DormEnum.eDormFntType.Wallpaper
  if isWallpaper then
    roomData:RemoveDmWallpaper(self.fntData)
  end
  self.fntData:SetFntParam(wallIndex)
  if isWallpaper then
    roomData:AddDmWallpaper(self.fntData)
    self:TryUpdDmFntWallpaperLayer()
  end
  self.rootTran:SetParent(wallHolder)
  self.rootTran.localEulerAngles = Vector3.zero
end

function DormFurnitureEntity:TryUpdDmFntWallpaperLayer()
  if self.type ~= DormEnum.eDormFntType.Wallpaper then
    return
  end
  local layerIdx = self.fntData:GetFntDataLayer()
  self:SetDmFntWallpaperLayer(layerIdx)
end

function DormFurnitureEntity:SetDmFntWallpaperLayer(layerIdx)
  if IsNull(self._wallPaperMat) then
    local renderer = self.transform:FindComponent(eUnityComponentID.Renderer)
    self._wallPaperMat = renderer.material
  end
  local value = layerIdx * -0.3
  self._wallPaperMat:SetFloat("_Factor", value)
  self._wallPaperMat:SetFloat("_Units", value)
  self._wallPaperMat.renderQueue = 3030 + layerIdx
end

function DormFurnitureEntity:InitFntTouchAnimator()
  if self.fntData:HasFntAnimator() then
    self._fntAnimator = self.gameObject:FindComponent(eUnityComponentID.Animator)
    if IsNull(self._fntAnimator) then
      error("dorm furniture not find Animator component,obj name:" .. self.gameObject.name)
      return
    end
  end
  if not self.fntData:IsFntEnableTouch() then
    return
  end
  self._enableTouch = true
  local actList = self.fntData:GetFntTouchActList()
  if #actList == 0 or actList[1] ~= DormEnum.FntInterReadyState then
    self.fntData:SetFntInteractState(false)
  end
end

function DormFurnitureEntity:ResetFntAnimatorState()
  self:StopFntAudio()
  if not self.fntData:HasFntAnimator() then
    return
  end
  if self.fntData:IsFntEnableTouch() then
    if self._touchTimerId ~= nil then
      TimerManager:StopTimer(self._touchTimerId)
      self._touchTimerId = nil
    end
    local actList = self.fntData:GetFntTouchActList()
    if #actList == 0 or actList[1] ~= DormEnum.FntInterReadyState then
      self.fntData:SetFntInteractState(false)
    else
      self.fntData:SetFntInteractState(true)
    end
    self._enableTouch = true
    self._fntAnimator:SetBool(EnableTouchAnimatorNameHash, false)
  end
  self._fntAnimator:SetTrigger("Reset")
end

function DormFurnitureEntity:StartFntTouch()
  if not self._enableTouch or self._touchTimerId ~= nil then
    return
  end
  for _, ipointData in pairs(self.fntData.interpoint) do
    if ipointData:HasBindCharacter() then
      return
    end
  end
  local isAnimatorEnableTouch = self._fntAnimator:GetBool(EnableTouchAnimatorNameHash)
  self._fntAnimator:SetBool(EnableTouchAnimatorNameHash, not isAnimatorEnableTouch)
  self._enableTouch = false
  self.fntData:SetFntInteractState(false)
  self._touchTimerId = TimerManager:StartTimer(0.1, self.FntEntityTouchChecker, self, false, false)
end

function DormFurnitureEntity:FntEntityTouchChecker()
  local isOk = false
  local curAnimInfo = self._fntAnimator:GetCurrentAnimatorStateInfo(0)
  for _, actName in pairs(self.fntData:GetFntTouchActList()) do
    if curAnimInfo:IsName(actName) then
      self._enableTouch = true
      if actName == DormEnum.FntInterReadyState then
        self.fntData:SetFntInteractState(true)
      end
      isOk = true
      break
    end
  end
  if isOk then
    TimerManager:StopTimer(self._touchTimerId)
    self._touchTimerId = nil
  end
end

function DormFurnitureEntity:CallFntCommonAnim()
  self._fntAnimator:SetTrigger("Play")
end

function DormFurnitureEntity:PlayFntAudio(auidoId)
  self:StopFntAudio()
  if auidoId ~= 0 then
    self.audioCallback = AudioManager:PlayAudioById(auidoId, function(audioCallback)
      if self.audioCallback == audioCallback then
        self.audioCallback = nil
      end
    end)
  end
end

function DormFurnitureEntity:StopFntAudio()
  if self.audioCallback ~= nil then
    AudioManager:StopAudioByBack(self.audioCallback)
    self.audioCallback = nil
  end
end

function DormFurnitureEntity:OnDormFntInterExit()
  if self._fntAnimator == nil then
    return
  end
  local hasAnim = false
  local hasBind = false
  for _, point in pairs(self.fntData.interpoint) do
    if point:GetInterAnimType() > 0 then
      hasAnim = true
      if point:HasBindCharacter() then
        hasBind = true
      end
    end
  end
  if hasAnim and not hasBind then
    self._fntAnimator:ResetTrigger("Play")
    self._fntAnimator:SetTrigger("Reset")
  end
  self:StopFntAudio()
end

function DormFurnitureEntity:GetFntBindTrans(path)
  if string.IsNullOrEmpty(path) then
    return self.transform
  end
  return self.transform:Find(path)
end

function DormFurnitureEntity:OnRecycleOriginFnt()
  self._savePos = self.rootTran.position
  self.rootTran.position = DormEnum.DormInvisiblePos
  if self._fntAnimator ~= nil then
    self._fntAnimator.speed = 0
  end
end

function DormFurnitureEntity:OnRecoveryOriginFnt()
  if self._savePos == nil then
    return
  end
  self.rootTran.position = self._savePos
  if self._fntAnimator ~= nil then
    self._fntAnimator.speed = 1
  end
end

function DormFurnitureEntity:DestroyDmFntEntityGo()
  DestroyUnityObject(self.gameObject, true)
  self.gameObject = nil
  self.transform = nil
  self._colliders = nil
  self._visibleHolderTransform = nil
end

function DormFurnitureEntity:OnDelete()
  self._fntAnimator = nil
  TimerManager:StopTimer(self._touchTimerId)
  DestroyUnityObject(self.rootGo)
  self:StopFntAudio()
  self:_ClearResLoader()
end

return DormFurnitureEntity
