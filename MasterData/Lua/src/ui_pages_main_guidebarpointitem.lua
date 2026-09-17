local module = class("guideBarPointItem", G_UIModuleBase)
local _gameClientTpl = L_GameTpl:getGameClientTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()

local function getMapStore()
  return C_MapManager:GetMapStore()
end

function module.bind()
  return {
    guidePoint = false,
    guideType = L_Const.guidePointType.task
  }
end

function module.methods()
  return {}
end

function module:created(...)
  module.super.created(self, ...)
  self.target = nil
  self.minLimit = nil
  self.maxLimit = nil
end

function module:open()
  self.minLimit = _gameClientTpl:getData("NAVIGATION_MIN_VALUE", L_Const.GameTplType.list_float)
  self.maxLimit = _gameClientTpl:getData("NAVIGATION_MAX_VALUE", L_Const.GameTplType.list_float)
  self.target = C_CameraManager.mainCamera.transform
  self.up = L_Vector3.up
end

function module:fresh()
  if self.isBind then
    if self.bind.guideType == L_Const.guidePointType.task then
      self:setTaskTracedTarget()
    else
      self:setMapNodeTracedTarget()
    end
  end
end

function module:hideGuidePoint()
  self.bind.guidePoint = false
end

function module:setTaskTracedTarget()
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local taskEntityId = self.bind.taskEntityId
  if player == nil or inScene == false then
    self.bind.guidePoint = false
    return
  end
  local playerPos = L_PlayerManager:getMainControlEntityPos()
  local taskEntityPos = pos
  local distance = math.floor(L_Vector3.distance(playerPos, taskEntityPos))
  if distance <= self.minLimit[1] then
    self.bindComponents.guideBarTransform.transform.localScale = L_Vector3.new(self.minLimit[2], self.minLimit[2], self.minLimit[2])
    self.bindComponents.guidePoint.color = CS.UnityEngine.Color(1, 1, 1, self.minLimit[3])
  else
    local scalePercent = math.clamp(self.minLimit[1] / distance, self.maxLimit[2], self.minLimit[2])
    local AlphaPercent = math.clamp(self.minLimit[1] / distance, self.maxLimit[3], self.minLimit[3])
    self.bindComponents.guideBarTransform.transform.localScale = L_Vector3.new(scalePercent, scalePercent, scalePercent)
    self.bindComponents.guidePoint.color = CS.UnityEngine.Color(1, 1, 1, AlphaPercent)
  end
  local viewAngle = L_Vector3.getLocalRot(self.target)
  local cos = 0
  local cameraViewDir
  local taskDir = L_Vector3.new(taskEntityPos.x - playerPos.x, taskEntityPos.y - playerPos.y, taskEntityPos.z - playerPos.z)
  local Dir = L_Vector3.projectOnPlane(taskDir, self.up).normalized
  if viewAngle.x > 89 and viewAngle.x <= 90 then
    cameraViewDir = L_Vector3.projectOnPlane(self.target.up, self.up).normalized
    cos = math.clamp(L_Vector3.dot(Dir, cameraViewDir), -1, 1)
  else
    cameraViewDir = L_Vector3.projectOnPlane(self.target.forward, self.up).normalized
    cos = math.clamp(L_Vector3.dot(Dir, cameraViewDir), -1, 1)
  end
  if cos <= -0.5 then
    self.bind.guidePoint = false
  else
    self.bind.guidePoint = true
    local radians = math.acos(cos)
    local angle = radians * (180 / math.pi)
    local cross
    if viewAngle.x == 90 then
      cross = L_Vector3.cross(Dir, self.target.up)
    else
      cross = L_Vector3.cross(Dir, cameraViewDir)
    end
    if 0 > cross.y then
      self.bindComponents.guideBarTransform.transform.localPosition = L_Vector3.new(angle / 120 * 400, -2, 0)
    else
      self.bindComponents.guideBarTransform.transform.localPosition = L_Vector3.new(-(angle / 120) * 400, -2, 0)
    end
  end
end

function module:setMapNodeTracedTarget()
  local areaId = AzurWorld.areaManager:GetAreaId()
  if not areaId or areaId < 0 then
    return
  end
  local mapStore = getMapStore()
  local info = mapStore and mapStore:getMarkBymapInfo(areaId, self.bind.guid)
  if not info then
    return
  end
  if info.posX == nil or info.posZ == nil then
    return
  end
  if not mapStore:getTracing(self.bind.guid) then
    return
  end
  if not self.bInit then
    local mapNodeTpl = _mapNodeTpl:getTplById(info.markId)
    local icon = _mapNodeTpl:getIcon(mapNodeTpl)
    self.bindComponents.guidePoint:LoadSprite(icon)
    self.bInit = true
  end
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not player then
    return
  end
  local pos = C_Vector3(info.posX, 0, info.posZ) + C_LuaUtility.GetRootNode().position
  local playerPos = L_PlayerManager:getMainControlEntityPos()
  local taskEntityPos = pos
  local distance = math.floor(L_Vector3.distance(playerPos, taskEntityPos))
  if distance <= self.minLimit[1] then
    self.bindComponents.guideBarTransform.transform.localScale = L_Vector3.new(self.minLimit[2], self.minLimit[2], self.minLimit[2])
    self.bindComponents.guidePoint.color = CS.UnityEngine.Color(1, 1, 1, self.minLimit[3])
  else
    local scalePercent = math.clamp(self.minLimit[1] / distance, self.maxLimit[2], self.minLimit[2])
    local AlphaPercent = math.clamp(self.minLimit[1] / distance, self.maxLimit[3], self.minLimit[3])
    self.bindComponents.guideBarTransform.transform.localScale = L_Vector3.new(scalePercent, scalePercent, scalePercent)
    self.bindComponents.guidePoint.color = CS.UnityEngine.Color(1, 1, 1, AlphaPercent)
  end
  local viewAngle = L_Vector3.getLocalRot(self.target)
  local cos = 0
  local cameraViewDir
  local taskDir = L_Vector3.new(taskEntityPos.x - playerPos.x, taskEntityPos.y - playerPos.y, taskEntityPos.z - playerPos.z)
  local Dir = L_Vector3.projectOnPlane(taskDir, self.up).normalized
  if viewAngle.x > 89 and viewAngle.x <= 90 then
    cameraViewDir = L_Vector3.projectOnPlane(self.target.up, self.up).normalized
    cos = math.clamp(L_Vector3.dot(Dir, cameraViewDir), -1, 1)
  else
    cameraViewDir = L_Vector3.projectOnPlane(self.target.forward, self.up).normalized
    cos = math.clamp(L_Vector3.dot(Dir, cameraViewDir), -1, 1)
  end
  if cos <= -0.5 then
    self.bind.guidePoint = false
  else
    self.bind.guidePoint = true
    local radians = math.acos(cos)
    local angle = radians * (180 / math.pi)
    local cross
    if viewAngle.x == 90 then
      cross = L_Vector3.cross(Dir, self.target.up)
    else
      cross = L_Vector3.cross(Dir, cameraViewDir)
    end
    if 0 > cross.y then
      self.bindComponents.guideBarTransform.transform.localPosition = L_Vector3.new(angle / 120 * 400, -2, 0)
    else
      self.bindComponents.guideBarTransform.transform.localPosition = L_Vector3.new(-(angle / 120) * 400, -2, 0)
    end
  end
end

return module
