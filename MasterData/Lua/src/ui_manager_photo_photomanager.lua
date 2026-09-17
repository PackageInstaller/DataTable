local this = class("photoManager", G_EventManagerBase)
table.merge(this, require("ui.manager.photo.photoManager_logic"))
table.merge(this, require("ui.manager.photo.photoManager_temp"))
table.merge(this, require("ui.manager.photo.photoManager_mediator"))
local _res4kSize = {x = 3840, y = 2160}
local _defaultTexturePaths = {
  head1 = "UI/Texture/Mod/default_%shead1.png",
  head2 = "UI/Texture/Mod/default_%shead2.png",
  head3 = "UI/Texture/Mod/default_%shead3.png",
  head4 = "UI/Texture/Mod/default_%shead4.png",
  head5 = "UI/Texture/Mod/default_%shead5.png",
  head6 = "UI/Texture/Mod/default_%shead6.png",
  head7 = "UI/Texture/Mod/default_%shead7.png"
}
this.event = {
  photoCaptureFinish = "photoCaptureFinish",
  beforeRemovePhotoPetEntity = "beforeRemovePhotoPetEntity",
  removePhotoPetEntity = "removePhotoPetEntity",
  addPhotoPetEntity = "addPhotoPetEntity",
  clearAllPhotoPetEntity = "clearAllPhotoPetEntity",
  photoMenuStateChange = "photoMenuStateChange",
  photoMenuForceRefresh = "photoMenuForceRefresh",
  selectPhotoHeroChange = "selectPhotoHeroChange",
  photoSettingChange = "photoSettingChange",
  photoTemplateChange = "photoSettingChange",
  photoSwitchHero = "photoSwitchHero",
  photoEditSave = "photoEditSave",
  pagePhotoOpen = "pagePhotoOpen",
  exitSingleAction = "exitSingleAction",
  changeStartAlpha = "changeStartAlpha",
  changeEndAlpha = "changeEndAlpha",
  hideGroup = "hideGroup",
  isActiveBg = "isActiveBg",
  isActiveBgFalse = "isActiveBgFalse",
  pagePhotoWhiteCut = "pagePhotoWhiteCut"
}

function this:ctor()
  this.super.ctor(self)
  self._obj2Entity = {}
  self._bind2PhotoEntity = {}
  self:initPhotoPetEntityInfo()
  self:initTemplateData()
  self.moduleGroupHero = nil
  if not self.util then
    self.util = require("ui.manager.photo.photoUtil")
  end
  self.actionCollectCache = {}
  self.faceCollectCache = {}
  self.onCutWorldEndHandler = handler(self, self.onCutWorldEnd)
  self.onBackWorldEndHandler = handler(self, self.onBackWorldEnd)
  self.onEvent_FullReconnected = self.onEvent_FullReconnected or handler(self, self.onReconnected)
  self.sceneId = nil
  self._pendingCaptureRTs = {}
end

function this:newCaptureRT(width, height)
  return C_RenderTexture(math.ceil(width), math.ceil(height), 0)
end

function this:releaseCaptureRT(rt)
  if not rt then
    return
  end
  self:unmarkPendingCaptureRT(rt)
  if not L_CommonUtil.isValid(rt) then
    return
  end
  rt:Release()
  C_UnityObject.Destroy(rt)
end

function this:markPendingCaptureRT(rt)
  if not rt then
    return rt
  end
  self._pendingCaptureRTs = self._pendingCaptureRTs or {}
  self._pendingCaptureRTs[rt] = true
  return rt
end

function this:unmarkPendingCaptureRT(rt)
  if rt and self._pendingCaptureRTs then
    self._pendingCaptureRTs[rt] = nil
  end
end

function this:releasePendingCaptureRTs()
  local pending = self._pendingCaptureRTs
  if not pending then
    return
  end
  self._pendingCaptureRTs = {}
  for rt in pairs(pending) do
    if rt and L_CommonUtil.isValid(rt) then
      rt:Release()
      C_UnityObject.Destroy(rt)
    end
  end
end

function this:capture(callback, width, height, isPhotoMain, onFail)
  if L_PhotoManager.useHighResolution and isPhotoMain and not C_AppConfigManager.IsMobilePlatformForUI then
    local scaleW = _res4kSize.x / C_Screen.width
    local scaleH = _res4kSize.y / C_Screen.height
    local scale = math.min(scaleW, scaleH)
    if 1 < scale then
      width = C_Screen.width * scale
      height = C_Screen.height * scale
    end
  end
  local uiCamera = C_CameraManager.uiCamera
  local souMask = uiCamera.cullingMask
  uiCamera.cullingMask = 0
  uiCamera:SingleLayerTrans(L_Const.layer.photo)
  width = width or C_Screen.width
  height = height or C_Screen.height
  width = math.ceil(width)
  height = math.ceil(height)
  local rt = self:markPendingCaptureRT(self:newCaptureRT(width, height))
  C_CameraManager.uiCamera:Capture(rt, false, true, function()
    uiCamera.cullingMask = souMask
    if not L_CommonUtil.isValid(rt) then
      self:unmarkPendingCaptureRT(rt)
      if onFail then
        onFail()
      end
      self:sendEvent(this.event.photoCaptureFinish)
      return
    end
    if callback then
      self:unmarkPendingCaptureRT(rt)
      callback(rt)
    else
      self:releaseCaptureRT(rt)
    end
    self:sendEvent(this.event.photoCaptureFinish)
  end)
end

function this:screenHeadShot(rect, cameraList, imgType, callback)
  local width = math.ceil(rect.width)
  local height = math.ceil(rect.height)
  local tex = CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:NewTexture2D("photoMgr-FeiQi", width, height)
  for _, v in ipairs(cameraList) do
    C_CameraCaptureUtil.CaptureFrameToTexture2D2(v, tex, rect)
  end
  tex = C_CameraCaptureUtil.HorizontalFlipTexture(tex)
  local uploadKey = {
    L_PhotoStore.path.imgCDNPath,
    L_PlayerStore:getPlayerId(),
    "_",
    imgType,
    "_",
    tostring(C_HttpManager.ConvertDataTime())
  }
  
  local function _onSuccess(key)
    local strArr = string.split(key, "/")
    key = strArr[#strArr]
    local path = self:getHeadTexFilePath(key)
    C_PhotoManager.SaveTexture2DByPath(path, tex, false)
    if callback then
      callback(true, key)
    end
  end
  
  local function _onFail(message)
    if callback then
      if CS.UnityEngine.Application.isEditor then
        _onSuccess(uploadKey)
        return
      end
      callback(false, message)
    end
  end
  
  local texData = Unity.ImageConversion.EncodeToPNG(tex)
  uploadKey = table.concat(uploadKey)
  C_CDNManager.TransferUploadBytes(texData, uploadKey, _onSuccess, _onFail)
  return tex
end

function this:shotByRectTrans(rectTrans, camera)
  local pos = L_Vector3.getAnchored(rectTrans)
  local rect = C_Rect(pos.x, pos.y, rectTrans.rect.width, rectTrans.rect.height)
  local width = math.ceil(rect.width)
  local height = math.ceil(rect.height)
  local tex = CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:NewTexture2D("photoMgr-shotByRect", width, height)
  C_CameraCaptureUtil.CaptureFrameToTexture2D2(camera, tex, rect)
  tex = C_CameraCaptureUtil.HorizontalFlipTexture(tex)
  return tex
end

function this:downloadHeadTexure(name, callback, cdnPath, savePath)
  if _defaultTexturePaths[name] then
    errorf(string.format("Trying to download default texture identifier: %s", name))
    if callback then
      callback(nil)
    end
    return
  end
  local loadNum = 1
  
  local function getCallback(flag, tex, errorKey)
    if flag then
      if not string.isEmpty(savePath) then
        C_PhotoManager.SaveTexture2DByPath(savePath, tex)
      end
    elseif loadNum <= 3 then
      loadNum = loadNum + 1
      self:getScreenShotHead(name, getCallback, cdnPath)
    else
      errorf(string.format("%s download fail: %s", name, tostring(errorKey)))
    end
    if callback then
      callback(tex)
    elseif flag and tex ~= nil then
      C_PhotoManager.ReleaseTexture(tex)
    end
  end
  
  self:getScreenShotHead(name, getCallback, cdnPath)
end

function this:getScreenShotHead(url, callback, cdnPath)
  cdnPath = cdnPath or L_PhotoStore.path.imgCDNPath
  url = url or ""
  if not string.find(url, cdnPath, 1, true) then
    url = cdnPath .. url
  end
  
  local function successCall(self, tex)
    L_PhotoStore:call(L_PhotoStore.event.photoFinishGet, {url = url, tex = tex})
    if callback then
      callback(true, tex)
    end
  end
  
  local function failCall(self, key)
    if callback then
      callback(false, nil, key)
    end
  end
  
  C_CDNManager.DownloadToTex(url, handler(self, successCall), handler(self, failCall))
end

function this:getHeadTexFilePath(name, customPath)
  local path = ""
  local strArr = string.split(name, "_")
  if not string.isEmpty(strArr[2]) then
    customPath = customPath or L_PhotoStore.path.imgSavePath
    path = customPath .. strArr[2]
  end
  return string.format("%s/%s.png", path, name)
end

function this:getDefaultHeadTexFilePath(name, sexStr)
  local strArr = string.split(name, "_")
  local folderName = string.gsub(string.split(strArr[2], ".")[1], sexStr, "")
  local path = L_PhotoStore.path.imgSavePath .. folderName
  return string.format("%s/default_%s", path, strArr[2])
end

function this:getDefaultHeadPath(name, sexType)
  local defaultTexturePath = _defaultTexturePaths[name]
  if defaultTexturePath then
    local sexStr = sexType == L_Const.sexType.male and "male" or "female"
    return string.format(defaultTexturePath, sexStr)
  end
  return nil
end

function this:getHeadPath(name)
  local strArr = string.split(name, "_")
  return string.isEmpty(strArr[2]) and string.format("/%s.png", name) or string.format("%s%s/%s.png", L_PhotoStore.path.imgSavePath, strArr[2], name)
end

function this:loadHeadTex(name, callback, customPath, cdnPath, playerBaseInfo)
  if string.isEmpty(name) then
    callback()
    return
  end
  if _defaultTexturePaths[name] then
    self:loadDefaultTextureByType(name, callback, playerBaseInfo)
    return
  end
  local imgFilePath = self:getHeadTexFilePath(name, customPath)
  if C_File.Exists(imgFilePath) then
    C_PhotoManager.GetTexture2DByPath(imgFilePath, callback)
  else
    self:downloadHeadTexure(name, callback, cdnPath, imgFilePath)
  end
end

function this:loadDefaultTextureByType(typeIdentifier, callback, playerBaseInfo)
  if callback then
    local defaultTexturePath = _defaultTexturePaths[typeIdentifier]
    if defaultTexturePath then
      local pSex = L_PlayerStore:getSex()
      if playerBaseInfo and playerBaseInfo.sex then
        pSex = playerBaseInfo.sex
      end
      local sexStr = pSex == L_Const.sexType.male and "male" or "female"
      defaultTexturePath = string.format(defaultTexturePath, sexStr)
      local imgFilePath = self:getDefaultHeadTexFilePath(defaultTexturePath, sexStr)
      C_PhotoManager.GetTexutre2DFromRes(defaultTexturePath, callback)
      return
    end
    errorf("默认图片不存在 " .. typeIdentifier)
    callback(nil)
  end
end

function this:loadCdnTex(name, localPath, cdnPath, callback)
  if string.isEmpty(name) then
    callback(nil)
    return
  end
  if _defaultTexturePaths[name] then
    self:loadDefaultTextureByType(name, callback)
    return
  end
  local imgFilePath = localPath .. name .. ".png"
  if C_File.Exists(imgFilePath) then
    C_PhotoManager.GetTexture2DByPath(imgFilePath, callback)
  else
    local function successCall(self, tex)
      if tex then
        C_PhotoManager.SaveTexture2DByPath(imgFilePath, tex)
      end
      if callback then
        callback(tex)
      end
    end
    
    local function failCall(self, key)
      if callback then
        callback(nil)
      end
    end
    
    local url = cdnPath .. name
    C_CDNManager.DownloadToTex(url, handler(self, successCall), handler(self, failCall))
  end
end

function this:checkHeadTex()
  local path = L_PlayerStore:getAvatarTexturePath(L_Const.avatarTextureIndex.painting)
  if _defaultTexturePaths[path] then
    return
  end
  if path ~= L_CommonUtil.getLocalValue("CheckHeadTex") then
    L_CommonUtil.setLocalValue("CheckHeadTex", path)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.painting)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.half_formation)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.head)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.head_circle)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.head_talk)
    self:predownloadHeadTex(L_Const.avatarTextureIndex.body)
  end
end

function this:predownloadHeadTex(avatarTextureIndex)
  local name = L_PlayerStore:getAvatarTexturePath(avatarTextureIndex)
  if _defaultTexturePaths[name] then
    return
  end
  local imgFilePath = self:getHeadTexFilePath(name)
  if not C_File.Exists(imgFilePath) then
    self:downloadHeadTexure(name, nil, nil, imgFilePath)
  end
end

function this:newOrBindPhotoEntity(obj, go, url)
  if string.isEmpty(url) then
    return
  end
  self._obj2Entity[obj] = self._obj2Entity[obj] or require("ui.manager.photo.photoEntity").new()
  self._obj2Entity[obj]:bindGameObject(go)
  self._obj2Entity[obj]:setImgName(url)
end

function this:clearPhotoEntity(obj)
  if self._obj2Entity[obj] then
    self._obj2Entity[obj]:dispose()
    self._obj2Entity[obj] = nil
  end
end

function this:bindPhotoEntity(go, url, cbk)
  local photoEntity = require("ui.manager.photo.photoEntity").new()
  photoEntity:bindGameObject(go)
  photoEntity:setImgName(url, cbk)
  return photoEntity
end

function this:fillMainHead(bind, img_icon, playerId, index, cbk)
  if index == nil then
    index = L_Const.avatarTextureIndex.head
  end
  local modName = L_PlayerStore:getAvatarTexturePath(index)
  if not string.isEmpty(modName) then
    local photoEntity = self._bind2PhotoEntity[bind]
    if photoEntity == nil then
      photoEntity = self:bindPhotoEntity(img_icon, modName, cbk)
      self._bind2PhotoEntity[bind] = photoEntity
    else
      photoEntity:bindGameObject(img_icon)
      photoEntity:setImgName(modName, cbk)
    end
  else
    local photoEntity = self._bind2PhotoEntity[bind]
    if photoEntity then
      photoEntity:dispose()
      self._bind2PhotoEntity[bind] = nil
    end
  end
end

function this:releaseHead(bind)
  local photoEntity = self._bind2PhotoEntity[bind]
  if photoEntity then
    photoEntity:dispose()
    self._bind2PhotoEntity[bind] = nil
  end
end

function this:initPhotoPetEntityInfo()
  self.entitys = {}
  self.insIndex = 0
  self.selectEntityGuid = nil
end

function this:getPhotoPetEntityIndex()
  self.insIndex = self.insIndex + 1
  return self.insIndex
end

function this:getPhotoPetEntityCount()
  local count = 0
  for key, value in pairs(self.entitys) do
    count = count + 1
  end
  return count
end

function this:getAllPhotoPetEntity()
  return self.entitys
end

function this:setPhotoPetEntityInfo(info)
  self.curSelectEntityInfo = info
end

function this:addPhotoPetEntity(guid, endCallback)
  local info = {}
  info.index = self:getPhotoPetEntityIndex()
  info.guid = guid
  info.actionId = L_Const.photoParam.petDefAction
  local petItem = L_PetStore:getPetItem(guid)
  self.entitys[info.index] = info
  info.entityId = L_EntityManager:generatePhotoPetEntity(petItem, function(entity)
    if self.entitys[info.index] then
      local pos = L_PlayerManager:getMainControlEntityPos()
      entity.csEntity.entity:SafeSetPosition(pos)
      info.entity = entity
      info.cachePos = entity.goModel.transform.position
      info.cacheRotation = L_Vector3.getPos(entity:getTransform())
      if endCallback then
        endCallback(info)
      end
      self:sendEvent(this.event.addPhotoPetEntity, info)
      self:sendEvent(this.event.photoMenuForceRefresh)
      entity.csEntity.entity:SetRotation(C_Quaternion.identity)
    else
      L_EntityManager:destroyEntity(entity)
    end
  end, nil, C_EEntityEntranceType.PhotoPet)
end

function this:removePhotoPetEntity(index, callback)
  local info = self.entitys[index]
  self.entitys[index] = nil
  if info then
    self:sendEvent(this.event.beforeRemovePhotoPetEntity, info)
    if info.entity then
      L_PhotoManager:removePhotoCaress(info.entity)
      L_PlayerManager:disposeCsEntityEnd(info.entity.csEntity.entity.data.entityId)
      L_EntityManager:destroyEntity(info.entity)
    else
      L_PlayerManager:disposeCsEntityEnd(info.entityId)
      C_EntityManager.RemoveEntityWithEntityId(info.entityId)
    end
    if callback then
      callback()
    end
    self:sendEvent(this.event.removePhotoPetEntity, info)
    self:sendEvent(this.event.photoMenuForceRefresh)
  end
end

function this:clearAllPhotoPetEntity()
  for _, v in pairs(self.entitys) do
    if v.entity then
      L_PhotoManager:removePhotoCaress(v.entity)
      L_PlayerManager:disposeCsEntityEnd(v.entity.csEntity.entity.data.entityId)
      L_EntityManager:destroyEntity(v.entity)
    else
      L_PlayerManager:disposeCsEntityEnd(v.entityId)
      C_EntityManager.RemoveEntityWithEntityId(v.entityId)
    end
  end
  self:initPhotoPetEntityInfo()
  self:sendEvent(this.event.clearAllPhotoPetEntity)
  self:sendEvent(this.event.photoMenuForceRefresh)
end

function this:checkPhotoCanTouchClick(noShowMsg)
  local canTouch = true
  if self.selectEntityGuid then
    canTouch = false
    if not noShowMsg then
      L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_01")
    end
  end
  return canTouch
end

function this:checkPetCanSet(id)
  local count = 0
  for _, v in pairs(self.entitys) do
    if v.guid == id then
      count = count + 1
    end
  end
  return count <= 0
end

function this:checkCanSwitchHero(guid)
  if self.moduleGroupHero == nil then
    return true
  end
  local putInfo = self.moduleGroupHero.heroPutInfo
  for i, v in pairs(putInfo) do
    if guid == i then
      return false
    end
  end
  return true
end

function this:setCollectAction(id, isCollect)
  local key = string.format("photo_action_collect_%d", id)
  local timeKey = string.format("photo_action_collectTime_%d", id)
  if isCollect then
    L_CommonUtil.setLocalBoolValue(key, true)
    L_CommonUtil.setLocalValue(timeKey, L_TimeUtil.getServerTime())
  else
    L_CommonUtil.clearLocalValue(key)
    L_CommonUtil.clearLocalValue(timeKey)
  end
  self.actionCollectCache[id] = {
    isOn = isCollect,
    time = isCollect and L_TimeUtil.getServerTime() or nil
  }
end

function this:checkCollectAction(id)
  local cache = self.actionCollectCache[id]
  if cache == nil then
    local key = string.format("photo_action_collect_%d", id)
    local timeKey = string.format("photo_action_collectTime_%d", id)
    local data = L_CommonUtil.getLocalBoolValue(key)
    if data == true then
      local time = L_CommonUtil.getLocalValue(timeKey)
      self.actionCollectCache[id] = {
        isOn = true,
        time = tonumber(time)
      }
      return self.actionCollectCache[id]
    else
      self.actionCollectCache[id] = {isOn = false, time = nil}
      return self.actionCollectCache[id]
    end
  else
    return cache
  end
end

function this:setCollectFace(id, isCollect)
  local key = string.format("photo_face_collect_%d", id)
  local timeKey = string.format("photo_face_collectTime_%d", id)
  if isCollect then
    L_CommonUtil.setLocalBoolValue(key, true)
    L_CommonUtil.setLocalValue(timeKey, L_TimeUtil.getServerTime())
  else
    L_CommonUtil.clearLocalBoolValue(key)
    L_CommonUtil.clearLocalValue(timeKey)
  end
  self.faceCollectCache[id] = {
    isOn = isCollect,
    time = isCollect and L_TimeUtil.getServerTime() or nil
  }
end

function this:checkCollectFace(id)
  local cache = self.faceCollectCache[id]
  if cache == nil then
    local key = string.format("photo_face_collect_%d", id)
    local timeKey = string.format("photo_face_collectTime_%d", id)
    local data = L_CommonUtil.getLocalBoolValue(key)
    if data == true then
      local time = L_CommonUtil.getLocalValue(timeKey)
      self.faceCollectCache[id] = {
        isOn = true,
        time = tonumber(time)
      }
      return self.faceCollectCache[id]
    else
      self.faceCollectCache[id] = {isOn = false, time = nil}
      return self.faceCollectCache[id]
    end
  else
    return cache
  end
end

function this:photoSwitchScene(sceneId)
  L_GameUtil.showCommonTip({
    txtContent = L_WordsTpl:getValue("notice_photo_sceneEnter"),
    confirmCallback = function()
      if self.sceneId == nil then
        self.remSceneId = AzurWorldInstance.CurWorldId
        self.remScenePos = L_PlayerManager:getMainControlEntityPos()
      end
      self.remHeroUid = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.UUID
      L_UI:close("pagePhoto", nil, function()
        C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self.onCutWorldEndHandler)
        C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self.onCutWorldEndHandler)
        self.sceneId = sceneId
        AzurWorld.service:RequestEnterScene(sceneId, 0)
      end)
    end
  })
end

function this:backToNormalScene()
  self.sceneId = nil
  L_UI:close("pagePhoto")
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self.onBackWorldEndHandler)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self.onBackWorldEndHandler)
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapReturnLast, nil, function(rspData, errorCode)
  end)
end

function this:onCutWorldEnd()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self.onCutWorldEndHandler)
  local sceneId = AzurWorldInstance.CurWorldId
  if self.sceneId ~= sceneId then
    return
  end
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  self:setHighQuality()
  L_UI:open("pagePhoto", {
    heroUUID = self.remHeroUid
  })
end

function this:onBackWorldEnd()
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self.onBackWorldEndHandler)
  local sceneId = AzurWorldInstance.CurWorldId
  if sceneId ~= self.remSceneId then
    return
  end
  self.remSceneId = nil
  self:revertQuality()
  L_UI:open("pagePhoto", {
    heroUUID = self.remHeroUid,
    targetPos = self.remScenePos,
    isBackToMain = true
  })
end

function this:onReconnected()
  self.sceneId = nil
  self.remSceneId = nil
  L_PhotoManager.isGoScene = false
  self:revertQuality()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self.onBackWorldEndHandler)
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
end

function this:setHighQuality()
  L_SettingStore:setHighestQuality()
end

function this:revertQuality()
  L_SettingStore:revertQuality()
end

function this:captureUI(rt, uiTrans, callback, onFail)
  if uiTrans == nil then
    if callback then
      callback(rt)
    else
      self:releaseCaptureRT(rt)
    end
    return rt
  end
  local canvas = L_ResPool:syncGameObject("Program/UIScene/pre_UICaptureCanvas.prefab", C_LuaUtility.GetRootNode())
  local cam = canvas.transform:Find("UICaptureCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  local rawImg = canvas.transform:Find("RawImage"):GetComponent(typeof(C_LRawImage))
  rawImg.texture = rt
  rawImg.gameObject:SetActive(true)
  rawImg.transform.sizeDelta = C_Vector2(rt.width, rt.height)
  local copyUI = CS.Lens.Framework.AzurAssets.Instantiate(uiTrans.gameObject, false).Result
  copyUI.transform:SetParent(canvas.transform)
  copyUI.transform.localScale = C_Vector3.one
  copyUI.transform.localPosition = C_Vector3.zero
  local cur = uiTrans.rect.size
  local ratioX = rawImg.transform.sizeDelta.x / cur.x
  copyUI.transform.localScale = C_Vector3(ratioX, ratioX, 1)
  local mat = C_UnityObject.Instantiate(rawImg.material)
  mat:EnableKeyword("FIX_TO_GAMMA")
  rawImg.material = mat
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.RegistCaptureCamera(cam)
  local tempRt = self:markPendingCaptureRT(self:newCaptureRT(rt.width, rt.height))
  cam.targetTexture = tempRt
  FrameScheduler.add(function()
    if not (L_CommonUtil.isValid(tempRt) and L_CommonUtil.isValid(rt)) or not L_CommonUtil.isValid(cam) then
      if L_CommonUtil.isValid(cam) then
        cam.targetTexture = nil
        Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.UnregistCaptureCamera(cam)
      end
      if L_CommonUtil.isValid(canvas) then
        C_GameObject.Destroy(canvas)
      end
      if L_CommonUtil.isValid(mat) then
        C_UnityObject.Destroy(mat)
      end
      self:releaseCaptureRT(rt)
      self:releaseCaptureRT(tempRt)
      if onFail then
        onFail()
      end
      return
    end
    cam:Render()
    cam.targetTexture = nil
    Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.UnregistCaptureCamera(cam)
    C_GameObject.Destroy(canvas)
    if L_CommonUtil.isValid(mat) then
      C_UnityObject.Destroy(mat)
    end
    self:releaseCaptureRT(rt)
    if callback then
      self:unmarkPendingCaptureRT(tempRt)
      callback(tempRt)
    else
      self:releaseCaptureRT(tempRt)
    end
  end, 1)
end

function this:isPetCaressing(entity)
  if entity and entity.csEntity then
    local stateType = entity.csEntity.entity.state.currentFsmStateType
    return stateType == C_EFsmStateType.Caress or stateType == C_EFsmStateType.MoveToPoint
  end
  return false
end

function this:isHeroCaressing(entity)
  if entity and entity.entity and entity.entity.state then
    return entity.entity.state.currentFsmStateType == C_EFsmStateType.Caress
  end
  return false
end

function this:showMsgCaressing()
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_qibo_stroke"))
end

function this:PetCaressBlock(entity)
  if self:isPetCaressing(entity) then
    self:showMsgCaressing()
    return true
  end
  return false
end

function this:HeroCaressBlock(entity)
  if self:isHeroCaressing(entity) then
    self:showMsgCaressing()
    return true
  end
  return false
end

function this:removePhotoCaress(entity)
  if entity and entity.csEntity then
    AzurWorld.InteractMgr:RemoveInteractByConfigId(entity.csEntity, 114)
  end
end

function this:pointLogCapture(captureMode)
  local _photoParamTpl = L_GameTpl:getPhotographParamTpl()
  local eventData = {
    act_type = captureMode,
    hero_param = {},
    pet_param = {},
    hero_id_list = {},
    pet_id_list = {},
    pet_guid_list = {}
  }
  local mount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
  if not mount then
    local heroActionTpls = {}
    local heroFaceTpls = {}
    local petActionTpls = {}
    local petFaceTpls = {}
    for _, v in pairs(_photoParamTpl.data) do
      local groupId = _photoParamTpl:getGroupId(v)
      if groupId == 5 then
        table.insert(heroActionTpls, v)
      elseif groupId == 6 then
        table.insert(heroFaceTpls, v)
      elseif groupId == 12 then
        table.insert(petActionTpls, v)
      elseif groupId == 13 then
        table.insert(petFaceTpls, v)
      end
    end
    local allHero = C_PhotoPlayManager.heroDict
    for i, v in pairs(allHero) do
      local animator = v.entity.data.animator
      local heroConfigId = v.entity.data.heroConfig.id
      table.insert(eventData.hero_id_list, heroConfigId)
      local info = {hero_id = heroConfigId}
      for _, tpl in pairs(heroActionTpls) do
        local stateName = _photoParamTpl:getParam(tpl)
        local state = animator:GetState(stateName)
        if state ~= nil and state.isRunning then
          info.pose = tpl.id
          break
        end
      end
      local faceLayerIdx = animator:GetLayerIndex("singleExpression")
      for _, tpl in pairs(heroFaceTpls) do
        local param = _photoParamTpl:getParam(tpl)
        if not string.isEmpty(param) then
          local stateName = string.split(param, "|")[2]
          local state = animator:GetState(stateName, faceLayerIdx)
          if state ~= nil and state.isRunning then
            info.emoji = tpl.id
            break
          end
        end
      end
      table.insert(eventData.hero_param, info)
    end
    local allPet = self.entitys
    for i, v in pairs(allPet) do
      local entity = v.entity.csEntity
      local petItem = L_PetStore:getPetItem(v.guid)
      local animator = entity.data.animator
      local petConfigId = petItem.petId
      table.insert(eventData.pet_id_list, petConfigId)
      table.insert(eventData.pet_guid_list, v.guid)
      local info = {pet_id = petConfigId}
      for _, tpl in pairs(petActionTpls) do
        local stateName = _photoParamTpl:getParam(tpl)
        local state = animator:GetState(stateName)
        if state ~= nil and state.isRunning then
          info.pose = tpl.id
          break
        end
      end
      local expression = entity.model:GetComponentByType(typeof(CS.KiboExpression))
      local curIndex = expression:GetEyeIndex()
      for _, tpl in pairs(petFaceTpls) do
        local param = _photoParamTpl:getParam(tpl)
        if not string.isEmpty(param) and curIndex == param then
          info.emoji = tpl.id
          break
        end
      end
      table.insert(eventData.pet_param, info)
    end
  else
    local heroConfigId = C_EntityManager.ControllingHeroEntity.data.heroConfig.id
    table.insert(eventData.hero_id_list, heroConfigId)
    local mountGuid = AzurWorld.playerMgr.myPlayerData.mountData.mountGuid
    local mountConfigId = AzurWorld.playerMgr.myPlayerData.mountData.mountConfigId
    table.insert(eventData.pet_id_list, mountConfigId)
    table.insert(eventData.pet_guid_list, mountGuid)
  end
  local curMin = C_GameTime.GetVirMinute()
  local hour = math.floor(curMin / 60)
  local min = math.floor(curMin % 60)
  eventData.time = string.format("%02d:%02d", hour, min)
  local filter = L_PhotoManager:getMediator().photoFilter
  eventData.filter = filter.filterId
  local wind = C_RealWeather.GetWeatherWind()
  if wind then
    local dir = wind:GetDirection()
    local power = wind:GetPower()
    eventData.wind = {
      dir = {
        dir.x,
        dir.y,
        dir.z
      },
      power = power
    }
  end
  
  local function normalizedparam(id, val)
    local tpl = _photoParamTpl:getTplById(id)
    local min = _photoParamTpl:getParamMin(tpl)
    local max = _photoParamTpl:getParamMax(tpl)
    return (val - min) / (max - min) * 100
  end
  
  local color = {
    postExposure = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.postExposure]],
    brightness = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.brightness]],
    hightlights = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.hightlights]],
    shadows = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.shadows]],
    contrast = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.contrast]],
    saturation = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.saturation]],
    temperature = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.temperature]],
    whitebalancetint = filter[L_PhotoManager.IDTOFIELD[L_Const.photoParam.whitebalancetint]]
  }
  color.postExposure = normalizedparam(L_Const.photoParam.postExposure, color.postExposure)
  color.brightness = normalizedparam(L_Const.photoParam.brightness, color.brightness)
  color.hightlights = normalizedparam(L_Const.photoParam.hightlights, color.hightlights)
  color.shadows = normalizedparam(L_Const.photoParam.shadows, color.shadows)
  color.contrast = normalizedparam(L_Const.photoParam.contrast, color.contrast)
  color.saturation = normalizedparam(L_Const.photoParam.saturation, color.saturation)
  color.temperature = normalizedparam(L_Const.photoParam.temperature, color.temperature)
  color.whitebalancetint = normalizedparam(L_Const.photoParam.whitebalancetint, color.whitebalancetint)
  eventData.color = color
  local mediator = L_PhotoManager:getMediator()
  eventData.cameraparam = {
    wideIntensity = mediator:getPhotoParmVal(L_Const.photoParam.wideIntensity),
    dof = mediator:getPhotoParmVal(L_Const.photoParam.dof),
    softlightIntensity = mediator:getPhotoParmVal(L_Const.photoParam.softlightIntensity),
    vignetteIntensity = mediator:getPhotoParmVal(L_Const.photoParam.vignetteIntensity),
    grainIntensity = mediator:getPhotoParmVal(L_Const.photoParam.grainIntensity),
    rotation = mediator:getPhotoParmVal(L_Const.photoParam.rotation),
    rate = mediator:getPhotoParmVal(L_Const.photoParam.rate)
  }
  eventData.cameraparam.wideIntensity = normalizedparam(L_Const.photoParam.wideIntensity, eventData.cameraparam.wideIntensity)
  eventData.cameraparam.dof = normalizedparam(L_Const.photoParam.dof, eventData.cameraparam.dof)
  eventData.cameraparam.softlightIntensity = normalizedparam(L_Const.photoParam.softlightIntensity, eventData.cameraparam.softlightIntensity)
  eventData.cameraparam.vignetteIntensity = normalizedparam(L_Const.photoParam.vignetteIntensity, eventData.cameraparam.vignetteIntensity)
  eventData.cameraparam.grainIntensity = normalizedparam(L_Const.photoParam.grainIntensity, eventData.cameraparam.grainIntensity)
  eventData.cameraparam.rotation = normalizedparam(L_Const.photoParam.rotation, eventData.cameraparam.rotation)
  eventData.cameraparam.rate = normalizedparam(L_Const.photoParam.rate, eventData.cameraparam.rate)
  local temp = 0
  if L_PhotoManager.templateType == L_Const.photoTemplateDataType.config then
    temp = 1
    eventData.temp_id = 1
  elseif L_PhotoManager.templateType == L_Const.photoTemplateDataType.custom then
    temp = 2
  end
  eventData.use_temp = temp
  local options = {
    showSelf = mediator:getSettingOrDefault(L_Const.photoParam.player),
    showNpc = mediator:getSettingOrDefault(L_Const.photoParam.npc),
    showOtherPet = mediator:getSettingOrDefault(L_Const.photoParam.enemy),
    showNpcHud = mediator:getSettingOrDefault(L_Const.photoParam.npcHud),
    showPetHud = mediator:getSettingOrDefault(L_Const.photoParam.petHud)
  }
  eventData.options = options
  local illumination_param = {charLightIntensity = 0, charSkinSpecular = 0}
  if mediator.lightParam then
    illumination_param.charLightIntensity = mediator.lightParam.charLightIntensity
    illumination_param.charSkinSpecular = mediator.lightParam.charSkinSpecular
  end
  illumination_param.charLightIntensity = normalizedparam(L_Const.photoParam.charLightIntensity, illumination_param.charLightIntensity)
  illumination_param.charSkinSpecular = normalizedparam(L_Const.photoParam.charSkinSpecular, illumination_param.charSkinSpecular)
  eventData.illumination_param = illumination_param
  local illumination = {
    color = {
      r = 0,
      g = 0,
      b = 0
    },
    intensity = 0
  }
  if mediator.globalLightData then
    local c = mediator.globalLightData.color
    illumination.color.r = c.r
    illumination.color.g = c.g
    illumination.color.b = c.b
    illumination.intensity = mediator.globalLightData.intensity
  end
  illumination.intensity = normalizedparam(L_Const.photoParam.globalLightIntensity, illumination.intensity)
  eventData.illumination = illumination
  local lightArrangeData = mediator.lightArrangeData
  local light1 = false
  local light2 = false
  local light3 = false
  local light1_param, light2_param, light3_param
  for i, v in pairs(lightArrangeData or {}) do
    local color = {
      r = v.color.r,
      g = v.color.g,
      b = v.color.b
    }
    local intensity = v.intensity
    local range = v.range
    local info = {
      color = color,
      intensity = intensity,
      range = range
    }
    if i == 1 then
      light1 = v.isOn
      light1_param = info
    elseif i == 2 then
      light2 = v.isOn
      light2_param = info
    elseif i == 3 then
      light3 = v.isOn
      light3_param = info
    end
  end
  eventData.lightArrangeData = {
    light1 = light1,
    light2 = light2,
    light3 = light3,
    light1_param = light1_param,
    light2_param = light2_param,
    light3_param = light3_param
  }
  eventData.map_id = AzurWorldInstance.CurWorldId
  local pos = L_PlayerManager:getMainControlEntityPos()
  eventData.coordinate = {
    x = pos.x,
    y = pos.y,
    z = pos.z
  }
  L_GameUtil.logEvent(L_Const.logEventName.camera, eventData)
end

function this:dispose()
  self.remSceneId = nil
  self.sceneId = nil
  for bind, photoEntity in pairs(self._bind2PhotoEntity) do
    if photoEntity then
      photoEntity:dispose()
    end
  end
  if self.onEvent_FullReconnected then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  end
  self._bind2PhotoEntity = {}
end

return this
