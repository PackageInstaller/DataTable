local module = class("guidePointItem", G_UIModuleBase)
local _unitTpl = L_GameTpl:getUnitTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()

local function getMapStore()
  return C_MapManager:GetMapStore()
end

function module.bind()
  return {
    imgIcon = "UI/Atlas/MapNode/tex_icon_mapnode_zhuxian.png",
    imgIconBg = "",
    guidePoint = false,
    targetDirection = false,
    distance_label = "",
    longPressAmount = 0
  }
end

function module.methods()
  return {}
end

function module:created(...)
  self.super.created(self, ...)
end

function module:open()
  self.showEffect = false
  self.totalTime = 0
  self.rotateTime = 0
  self.longPressFlag = false
  self.rotateCam = false
  self.revertFov = false
  self.rotateTarget = nil
  self.longPressEntity = 0
  self.rot_time = L_GameTpl:getGameConstTpl():getData("TASK_ZOOMLENS_ROTATETIME", L_Const.GameTplType.float)
  self.revert_time = L_GameTpl:getGameConstTpl():getData("TASK_ZOOMLENS_REVERTTIME", L_Const.GameTplType.float)
  L_UI:addListener("startPathGuide", self.showPointEffect, self)
  self.bindComponents.guidePoint:Init()
end

function module:hide()
  self.showEffect = false
  self.bindComponents.effect:Stop()
end

function module:close()
  self.totalTime = 0
  self.rotateCam = false
  if self.rotateTarget ~= nil then
    L_CameraManager:getCameraTactics():SetCameraFov(self.rotateTarget.origin_fov)
    self.rotateTarget = nil
  end
  L_UI:removeListener("startPathGuide", self.showPointEffect)
end

function module:longPressTraced(flag, entity)
  self.longPressFlag = flag
  self.longPressEntity = entity
end

function module:refreshTargetPoint(limitCanvas, guidePointViewPort)
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local taskEntityPos, res = self.bind.getTargetPosFunc()
  if not (player ~= nil and taskEntityPos) or not res then
    if self.bind.guidePoint then
      self.bind.guidePoint = false
    end
    self.showEffect = false
    return
  end
  self:commonLogicProcess(taskEntityPos, limitCanvas, guidePointViewPort)
  if self.showEffect == false then
    self.bindComponents.effect:Play()
    self.showEffect = true
  end
  if self:isHidden() then
    self.bind.guidePoint = false
  end
end

function module:isHidden()
  if L_CommonUtil.isValid(self.bind.modelControl) then
    local skinObj = self.bind.modelControl:GetComponentByType(typeof(C_SkinnedMeshRenderer))
    if L_CommonUtil.isValid(skinObj) then
      return skinObj.gameObject.layer == L_Const.layer.hidden
    end
  end
  return false
end

function module:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  self.bindComponents.guidePoint:RefreshTargetPos(entityPos.x, entityPos.y, entityPos.z, guidePointViewPort, self.bind.triggerRange or 0)
end

function module:showPointEffect()
  if self.bind.guidePoint ~= false then
    self.bindComponents.effect:Play()
  end
end

function module:refreshTargetPoint_mapMark(limitCanvas, guidePointViewPort)
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  if not areaId then
    return
  end
  local mapStore = getMapStore()
  local info = mapStore and mapStore:getMarkBymapInfo(areaId, self.bind.guid)
  if not info then
    return
  end
  if not info.isSetPosY then
    return
  end
  if not mapStore:getTracing(self.bind.guid) then
    return
  end
  if not self.bInit then
    local mapNodeTpl = _mapNodeTpl:getTplById(info.markId)
    local icon = _mapNodeTpl:getIcon(mapNodeTpl)
    self.bindComponents.imgSelf:LoadSprite(icon)
    self.bindComponents.imgSelf:SetNativeSize()
    self.bInit = true
  end
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if player == nil then
    self.bind.guidePoint = false
    return
  end
  self.bind.guidePoint = true
  local entityPos = C_Vector3(info.posX, info.posY, info.posZ)
  self:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  local playerPos = L_PlayerManager:getMainControlEntityPos()
  local distance = math.floor(L_Vector3.distance(playerPos, entityPos))
  if distance <= 10 then
    mapStore:req_worldMapMarkTraceDel(self.bind.guid)
    L_FlyMsgManager:showNormalMsgByKey("notice_mapGuideNodeItem")
  end
end

function module:refreshTargetPoint_nodeTarget(limitCanvas, guidePointViewPort)
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  if not areaId then
    return
  end
  local info = self.bind.nodeInfo
  if info == nil or info.sceneId == 0 then
    return
  end
  local isSameScene = AzurWorldInstance.CurWorldId == info.sceneId
  if not isSameScene then
    self.bind.guidePoint = false
    return
  end
  self.bindComponents.imgSelf:LoadSprite(info.icon)
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if player == nil then
    self.bind.guidePoint = false
    return
  end
  self.bind.guidePoint = true
  local entityPos = C_Vector3(info.pos.x, info.pos.y, info.pos.z)
  self:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  local playerPos = L_PlayerManager:getMainControlEntityPos()
  local distance = math.floor(L_Vector3.distance(playerPos, entityPos))
  if distance <= 10 then
    local mapStore = getMapStore()
    if mapStore then
      mapStore:disposeNodeTarget()
    end
    L_FlyMsgManager:showNormalMsgByKey("notice_mapGuideNodeItem")
  end
end

return module
