local module = class("mapGuideNodeItem", G_UIModuleBase)
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()
local _unitTpl = L_GameTpl:getUnitTpl()

local function getMapStore()
  return C_MapManager:GetMapStore()
end

local function hasNodeTarget(info)
  return info ~= nil and info.sceneId ~= 0
end

local NPCENTITYNODE = {
  [L_MapConst.mapSievingType.kiboDuel] = 1,
  [L_MapConst.mapSievingType.npc] = 1,
  [L_MapConst.mapSievingType.entrustTaskNpc] = 1
}

function module.bind()
  return {
    simple = false,
    go_simplebg = false,
    simpleIcon = "",
    complex = false,
    go_bossbg = false,
    complexIconBossBg = "",
    go_normalbg = false,
    complexIconBg = "",
    complexIcon = "",
    complexIcon_noMask = "",
    maskIcon = false,
    noMaskIcon = false,
    guidePoint = false,
    targetDirection = false,
    distance_label = ""
  }
end

function module.methods()
  return {}
end

function module:created(...)
  self.super.created(self, ...)
  self.mainCamera = nil
  self.rectTrans = nil
  self.limitCanvas = nil
  self._screenPosToUI = nil
  self.showWidth = nil
  self.showHeight = nil
  self.middlePoint = nil
end

function module:open()
  self.mainCamera = C_CameraManager.mainCamera
  self.rectTrans = self.bindComponents.guidePointTransfrom
  self._screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
  local size = math.min(Unity.Screen.width / 1920, Unity.Screen.height / 1080)
  self.screenHeight = Unity.Screen.height / size
  self.screenWidth = Unity.Screen.width / size
  self.showWidth = self.screenWidth * 0.65 / 2
  self.showHeight = self.screenHeight * 0.8 / 2
  self.judgeWidth = Unity.Screen.width * 0.65 / 2
  self.judgeHeight = Unity.Screen.height * 0.8 / 2
  self.middlePoint = L_Vector3.new(Unity.Screen.width / 2, Unity.Screen.height / 2)
  self.vector_up = L_Vector3.up
  self.vector_up_v2 = L_Vector3.new(0, 1)
  self.showEffect = false
  self.complexType = {
    [L_MapConst.mapSievingType.boss] = 1,
    [L_MapConst.mapSievingType.dungeonBoss] = 1,
    [L_MapConst.mapSievingType.dungeon] = 1,
    [L_MapConst.mapSievingType.dynamicDungeon] = 1,
    [L_MapConst.mapSievingType.collection] = 1
  }
  local info = self.bind.nodeInfo
  if hasNodeTarget(info) then
    if self.complexType[info.nodeType] == 1 then
      self.bind.simple = false
      self.bind.complex = true
      self.bind.go_bossbg = info.nodeType == L_MapConst.mapSievingType.boss or info.nodeType == L_MapConst.mapSievingType.dungeonBoss
      self.bind.complexIconBg = info.iconBg
      if info.nodeType == L_MapConst.mapSievingType.boss or info.nodeType == L_MapConst.mapSievingType.dungeonBoss or info.nodeType == L_MapConst.mapSievingType.collection then
        self.bind.complexIcon = info.icon
        self.bind.maskIcon = true
        self.bind.noMaskIcon = false
      else
        self.bind.complexIcon_noMask = info.icon
        self.bind.maskIcon = false
        self.bind.noMaskIcon = true
      end
    else
      self.bind.simple = true
      self.bind.complex = false
      self.bind.simpleIcon = info.icon
    end
    if NPCENTITYNODE[info.nodeType] then
      local tpl = _worldMapTpl:getTplById(info.sceneId, info.id)
      if tpl then
        local spawnerId = _worldMapTpl:getSpawnerId(tpl)
        local baseType = _worldSpawnerTpl:getBasicType(_worldSpawnerTpl:getTplById(spawnerId))
        if baseType == 1 then
          local unitId = _worldSpawnerTpl:getResourceId(_worldSpawnerTpl:getTplById(spawnerId))
          self.bloodBarNode = _unitTpl:getBloodBarNode(_unitTpl:getTplById(unitId))
        elseif baseType == 2 then
          self.bloodBarNode = nil
        end
      end
    end
  end
end

function module:hide()
  self.showEffect = false
  self.bindComponents.effect:Stop()
end

function module:close()
  self.mainCamera = nil
  self.rectTrans = nil
  self.limitCanvas = nil
  self._screenPosToUI = nil
  self.showWidth = nil
  self.showHeight = nil
  self.middlePoint = nil
end

function module:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  local playerPos = L_PlayerManager:getMainControlEntityPos()
  local distance = math.floor(L_Vector3.distance(playerPos, entityPos))
  local cameraPos = L_Vector3.getPos(self.mainCamera.transform)
  local taskDir = L_Vector3.new(entityPos.x - cameraPos.x, entityPos.y - cameraPos.y, entityPos.z - cameraPos.z)
  local Dir = L_Vector3.projectOnPlane(taskDir, self.vector_up).normalized
  local cameraViewDir = L_Vector3.projectOnPlane(self.mainCamera.transform.forward, self.vector_up).normalized
  local cos = math.clamp(L_Vector3.dot(Dir, cameraViewDir), -1, 1)
  local viewAngle = self.mainCamera.transform.eulerAngles
  local cross
  if viewAngle.x > 89 and viewAngle.x <= 90 then
    local self_forward = L_Vector3.projectOnPlane(self.mainCamera.transform.up, self.vector_up).normalized
    cross = L_Vector3.cross(Dir, self_forward)
  else
    cross = L_Vector3.cross(Dir, cameraViewDir)
  end
  local screenPoint = self.mainCamera:WorldToScreenPoint(entityPos)
  if not self:judgeIsOutScreen(screenPoint) and 0 < cos then
    local pos = self:getClampPos(screenPoint, self:calRectByCanvas(limitCanvas, self.rectTrans.sizeDelta))
    local v2pos = L_Vector3.new(pos.x, pos.y)
    local _, uiPos = self._screenPosToUI(guidePointViewPort, v2pos, C_CameraManager.uiCamera)
    self.rectTrans.localPosition = L_Vector3.new(uiPos.x, uiPos.y, 0)
    self.bind.targetDirection = false
  else
    self:setScreenPosOutScreen(entityPos, cameraPos, cross, guidePointViewPort)
  end
  self.bind.distance_label = string.format("%d<size=16><color=#e1e1e1>%s</color></size>", distance, "M")
end

function module:showPointEffect()
  if self.bind.guidePoint ~= false then
    self.bindComponents.effect:Play()
  end
end

function module:judgeIsOutScreen(screenPoint)
  if screenPoint.x > Unity.Screen.width or screenPoint.x < 0 or screenPoint.y > Unity.Screen.height or 0 > screenPoint.y then
    return true
  end
  local dir = L_Vector3.new(screenPoint.x - self.middlePoint.x, screenPoint.y - self.middlePoint.y).normalized
  local upVector = self.vector_up_v2
  local cos_v2 = math.clamp(L_Vector3.dot(dir, upVector), -1, 1)
  local deg = math.acos(cos_v2) * (180 / math.pi)
  local k = math.tan(deg * (math.pi / 180))
  k = math.abs(k)
  local y = screenPoint.y - self.middlePoint.y
  local x = y * k
  local result = x * x / (self.judgeWidth * self.judgeWidth) + y * y / (self.judgeHeight * self.judgeHeight)
  if 1 < result then
    return true
  else
    return false
  end
end

function module:setScreenPosOutScreen(taskEntityPos, playerPos, cross, guidePointViewPort)
  local taskDir = L_Vector3.new(taskEntityPos.x - playerPos.x, taskEntityPos.y - playerPos.y, taskEntityPos.z - playerPos.z)
  local targetVec = L_Vector3.projectOnPlane(taskDir - self.mainCamera.transform.forward, self.mainCamera.transform.forward).normalized
  local cos_p = math.clamp(L_Vector3.dot(self.mainCamera.transform.up, targetVec), -1, 1)
  local deg = math.acos(cos_p) * (180 / math.pi)
  self:calculatePos(deg, cross, guidePointViewPort)
end

function module:calculatePos(deg, cross, guidePointViewPort)
  local result = L_Vector3.new(0, 0, 0)
  local k = math.tan(deg * (math.pi / 180))
  k = math.abs(k)
  result.y = self.judgeWidth * self.judgeHeight * math.sqrt(1 / (self.judgeWidth * self.judgeWidth + self.judgeHeight * self.judgeHeight * k * k))
  result.x = result.y * k
  if deg == 0 then
    result.y = self.showHeight
  end
  if 90 < deg then
    result.y = -result.y
  end
  if 0 < cross.y then
    result.x = -result.x
    self.bindComponents.targetDirection.eulerAngles = L_Vector3.new(180, 0, -deg * 1)
  else
    self.bindComponents.targetDirection.eulerAngles = L_Vector3.new(180, 0, deg * 1)
  end
  result.x = self.middlePoint.x + result.x
  result.y = self.middlePoint.y + result.y
  local v2pos = L_Vector3.new(result.x, result.y)
  local _, uiPos = self._screenPosToUI(guidePointViewPort, v2pos, C_CameraManager.uiCamera)
  self.rectTrans.localPosition = L_Vector3.new(uiPos.x, uiPos.y, 0)
  self.bind.targetDirection = true
end

function module:getClampPos(pos, area)
  local safePos = L_Vector3.new(0, 0)
  safePos.x = math.clamp(pos.x, area.xMin, area.xMax)
  safePos.y = math.clamp(pos.y, area.yMin, area.yMax)
  return safePos
end

function module:calRectByCanvas(canvas, uiSize)
  local rect = C_Rect(0, 0, 0, 0)
  local width = Unity.Screen.width
  local height = Unity.Screen.height
  rect.xMax = width - uiSize.x / 2
  rect.yMax = height - uiSize.y / 2
  rect.xMin = uiSize.x / 2
  rect.yMin = uiSize.y / 2
  return rect
end

function module:refreshTargetPoint_nodeTarget(limitCanvas, guidePointViewPort)
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  if not areaId then
    return
  end
  local info = self.bind.nodeInfo
  if not hasNodeTarget(info) then
    return
  end
  local isSameScene = AzurWorldInstance.CurWorldId == info.sceneId
  if not isSameScene then
    self.bind.guidePoint = false
    return
  end
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if player == nil then
    self.bind.guidePoint = false
    return
  end
  self.bind.guidePoint = true
  local entityPos = L_Vector3.new(info.pos.x, info.pos.y, info.pos.z)
  if NPCENTITYNODE[info.nodeType] then
    local npcEntity = AzurWorld.WorldMapMgr:TryGetEntity(info.id)
    if npcEntity ~= nil then
      self.targetPos = entityPos
      if self.bloodBarNode ~= nil then
        local node = L_GameUtil.findTranByName(npcEntity.transform.gameObject, self.bloodBarNode)
        if node then
          self.targetPos = L_Vector3.getPos(node)
          self.targetPos = self:_getRealPos(self.targetPos)
          self.targetPos.y = self.targetPos.y + 0.7
        end
      else
        self.targetPos.y = self.targetPos.y + 1.7
      end
      entityPos = L_Vector3.new(self.targetPos.x, self.targetPos.y, self.targetPos.z)
    end
  end
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

function module:_getRealPos(targetPos)
  local x, y, z = C_LuaUtility.GetRootTransformPoint(targetPos.x, targetPos.y, targetPos.z)
  local pos = L_Vector3.new(x, y, z)
  return pos
end

return module
