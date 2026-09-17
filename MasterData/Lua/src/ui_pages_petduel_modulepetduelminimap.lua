local this = class("modulePetDuelMiniMap", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local kiBoDuelSceneMgr, cameraUtility, quaternionIdentity
local iconMap = {
  playerPet = 0,
  enemyPet = 1,
  player = 2,
  enemy = 3,
  playerTower = 4,
  enemyTower = 5,
  playerDefenceTower = 6,
  enemyDefenceTower = 7
}

function this.bind()
  return {
    markList = {
      moduleName = "pages/petDuel/cellMiniPos"
    },
    mapImg = "",
    panelActive = true,
    activeCamView = false
  }
end

function this.methods()
  return {
    onPointerDown = function(self)
      self:onPointerDown()
    end,
    onPointerUp = function(self)
      self:onPointerUp()
    end,
    onPointerMove = function(self, pos)
      self:dragCameraViewRect(pos)
    end,
    onEndDrag = function(self)
      self:onEndDrag()
    end
  }
end

function this:open()
  kiBoDuelSceneMgr = AzurWorld.KiBoDuelSceneMgr
  cameraUtility = C_CameraUtility
  quaternionIdentity = C_Quaternion.identity
  self.entityMarks = {}
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "movement.modulePetDuelMiniMap.update")
  local bluePos = kiBoDuelSceneMgr:GetBluePos()
  self.planeY = bluePos.y
  self.plane = Unity.Plane(C_Vector3.up, C_Vector3(0, self.planeY, 0))
  self.onEntityChangedHandler = handler(self, self.onEntityChanged)
  C_EntityManager.entityBirthHandler:Add(self.onEntityChangedHandler)
  C_EntityManager.entityOnRemoveHandler:Add(self.onEntityChangedHandler)
end

function this:initMap(duelId)
  local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
  local tpl = kiBoDuelTpl:getTplById(duelId)
  local mapId = kiBoDuelTpl:getMapId(tpl)
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    mapId = C_KiboDuelSimulatorManager.instance.kiboDuelTeam.sceneId
  end
  local kiBoDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()
  local mapTpl = kiBoDuelMapTpl:getTplById(mapId)
  local worldAreaId = kiBoDuelMapTpl:getWorldAreaId(mapTpl)
  self.bind.panelActive = not math.isEmpty(worldAreaId)
  if not self.bind.panelActive then
    return
  end
  local worldAreaTpl = L_GameTpl:getWorldAreaTpl()
  local areaTpl = worldAreaTpl:getTplById(worldAreaId)
  self.bind.mapImg = worldAreaTpl:getAreaMap(areaTpl)
  local rect = self.bindComponents.root.rect
  local size = {
    [1] = rect.size.x,
    [2] = rect.size.y
  }
  self.mapData = C_MapManager:CreateMapData(worldAreaId, true, size)
  return mapTpl
end

function this:close()
  local kiBoDuelSceneMgr, cameraUtility, quaternionIdentity
  if self.onEntityChangedHandler then
    C_EntityManager.entityBirthHandler:Remove(self.onEntityChangedHandler)
    C_EntityManager.entityOnRemoveHandler:Remove(self.onEntityChangedHandler)
    self.onEntityChangedHandler = nil
  end
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
end

function this:onEntityChanged()
  self.needGetEntity = true
end

local lastFrame = 0

function this:update()
  lastFrame = lastFrame + 1
  if lastFrame < 10 then
    return
  end
  lastFrame = 0
  if not self.bind.panelActive then
    return
  end
  if not self.mapData then
    return
  end
  if self.needGetEntity then
    self.needGetEntity = false
    self:parseData()
    local markList = self.bind.markList
    local entityMarks = self.entityMarks
    if #entityMarks == #markList then
      for i = 1, #markList do
        markList:change(i, entityMarks[i])
      end
    else
      markList:clear()
      markList:insert_array(entityMarks)
    end
  else
    local markListModule = self.modules.markList
    for i, item in pairs(markListModule) do
      item:refresh()
    end
  end
  if self.isBirdView and (self.isDrag or kiBoDuelSceneMgr.m_birdViewTactic.isUnderControl) and not C_KiboDuelSystemMgr.isDraggingCard then
    self:updateCameraView()
    self.bind.activeCamView = true
  else
    self.bind.activeCamView = false
  end
end

function this:parseData()
  self.entityMarks = {}
  local entities = C_KiBoDuelLuaWrapper.GetAllEntityData()
  for _, entity in pairs(entities) do
    self:dealIconId(entity)
  end
  if self.mapData then
    table.insert(self.entityMarks, {
      mapData = self.mapData,
      selectTabId = iconMap.player
    })
  end
end

function this:dealIconId(entity)
  if not self.mapData then
    return
  end
  if entity.campType == C_ECampType.Red then
    if entity.entityType == C_EEntityType.BaseTower then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.enemyTower,
        entityTans = entity.entityTrans
      })
    end
    if entity.entityType == C_EEntityType.KiBo then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.enemyPet,
        entityTans = entity.entityTrans
      })
    end
    if entity.entityType == C_EEntityType.DefenseTower then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.enemyDefenceTower,
        entityTans = entity.entityTrans
      })
    end
  end
  if entity.campType == C_ECampType.Blue then
    if entity.entityType == C_EEntityType.BaseTower then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.playerTower,
        entityTans = entity.entityTrans
      })
    end
    if entity.entityType == C_EEntityType.KiBo then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.playerPet,
        entityTans = entity.entityTrans
      })
    end
    if entity.entityType == C_EEntityType.DefenseTower then
      table.insert(self.entityMarks, {
        mapData = self.mapData,
        selectTabId = iconMap.playerDefenceTower,
        entityTans = entity.entityTrans
      })
    end
  end
end

function this:SwitchBirdView(enable)
  self.isBirdView = enable
  if enable then
    self.virCam = kiBoDuelSceneMgr.m_birdViewTactic.cineMachineCamera
  else
    self.isDrag = false
  end
end

function this:updateCameraView()
  if not self.virCam then
    return
  end
  local curPos = self.virCam.transform.position
  if curPos == self.lastCameraPos then
    return
  end
  self.lastCameraPos = self.virCam.transform.position
  local rays = cameraUtility.GetFarFrustumRays(self.virCam)
  self.bindComponents.rect_camView.rotation = quaternionIdentity
  if not rays then
    return
  end
  for i = 0, 1 do
    local ray = rays[i]
    local s, distance = self.plane:Raycast(ray)
    if s then
      local hitPoint = ray:GetPoint(distance)
      if i == 0 then
        self.p1 = self.mapData:worldToLocal(hitPoint)
      end
      if i == 1 then
        self.p2 = self.mapData:worldToLocal(hitPoint)
      end
    end
  end
  if self.p1 and self.p2 then
    self.viewWidth = C_Vector3.Distance(self.p1, self.p2)
  end
  local forwardRay = Unity.Ray(self.virCam.transform.position, self.virCam.transform.forward)
  local s, distance = self.plane:Raycast(forwardRay)
  if s then
    local hitPoint = forwardRay:GetPoint(distance)
    self.center = self.mapData:worldToLocal(hitPoint)
    self.bindComponents.rect_camView.localPosition = C_Vector3(self.center.x, self.center.y, 0)
    if self.p1 and self.p2 then
      local mid = (self.p1 + self.p2) / 2
      self.viewHeight = C_Vector3.Distance(self.center, mid) * 2
      self.bindComponents.rect_camView.sizeDelta = C_Vector2(self.viewWidth or self.viewHeight, self.viewHeight)
    end
  end
end

function this:onPointerDown()
  if not self.isBirdView then
    return
  end
  self.isDrag = true
  kiBoDuelSceneMgr.m_birdViewTactic.isDraggingMap = true
  local screenPos = CS.UnityEngine.Input.mousePosition
  local _, uiPos = _screenPosToUI(self.bindComponents.root, C_Vector2(screenPos.x, screenPos.y), C_CameraManager.uiCamera)
  local wp = self.mapData:localToWorld(uiPos)
  self:setCameraPos(wp)
end

function this:onPointerUp()
  self.isDrag = false
  kiBoDuelSceneMgr.m_birdViewTactic.isDraggingMap = false
end

function this:onEndDrag()
  self.isDrag = false
  kiBoDuelSceneMgr.m_birdViewTactic.isDraggingMap = false
end

function this:dragCameraViewRect(pos)
  if not self.isBirdView then
    return
  end
  if not self.isDrag then
    return
  end
  local _, uiPos = _screenPosToUI(self.bindComponents.root, C_Vector2(pos.x, pos.y), C_CameraManager.uiCamera)
  kiBoDuelSceneMgr.m_birdViewTactic.isDraggingMap = true
  local wp = self.mapData:localToWorld(uiPos)
  self:setCameraPos(wp)
end

function this:setCameraPos(pos)
  pos.y = self.planeY
  kiBoDuelSceneMgr.m_birdViewTactic:SetLookTarget(C_Vector3(pos.x, pos.y, pos.z))
end

return this
