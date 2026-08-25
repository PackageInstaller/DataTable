local MapTerrainManager, Super = System.NewClass("MapTerrainManager", Manager)

function MapTerrainManager:ctor()
  Super.ctor(self)
  self.terrainObjs = {}
  self.clickTips = {}
  self.lastClickTime = 0
  self.lastClickPos = nil
  self.clickDebounceTime = 0.15
end

function MapTerrainManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot/terrain")
  self.rootTransform = self.rootNode.transform
  binder:BindEvent(EventMgr.Instance.GridLongPress, System.fn(self, self.OnGridLongPress))
  binder:BindEvent(EventMgr.Instance.GridClick, System.fn(self, self.OnGridClick))
end

function MapTerrainManager:OnInit()
  self:CreateTerrains()
end

function MapTerrainManager:CanCreateTerrains()
  return true
end

function MapTerrainManager:Create(x, y, wallTable, hideTerrain, is_has)
  local idx = self.parent:GetIdxByPos(x, y)
  if is_has and self:GetTerrainByIdx(idx) then
    return
  end
  wallTable = wallTable or {}
  hideTerrain = hideTerrain or {}
  if wallTable[idx] or not self:CanCreateTerrains(x, y) then
    return
  end
  if self:CheckBloodPoolFinish(x, y) then
    return
  end
  local prefabPath = self.parent:GetUnitGridPath(x, y)
  local obj = self:CreateTerrain(x, y, prefabPath)
  obj:SetVisible(false)
  self.terrainObjs[idx] = obj
end

function MapTerrainManager:CheckBloodPoolFinish(x, y)
  if MapModel.Instance:IsBloodPoolFinished(x, y) then
    self:SetTerrainToDefault(x, y)
    return true
  end
end

function MapTerrainManager:CreateTerrain(x, y, prefabPath)
  local childBinder = self.binder:createChild()
  local obj = MapItemTerrain(self, x, y, childBinder)
  obj:LoadPrefab(prefabPath)
  obj:SetParent(self.rootTransform)
  local worldPosX, worldPosY = self.parent:GetWorldPosByGridPos(x, y)
  obj:SetPosition(worldPosX, worldPosY)
  obj:SetGridPos(x, y)
  return obj
end

function MapTerrainManager:SetTerrainToDefault(x, y)
  local idx = self.parent:GetIdxByPos(x, y)
  local preTerrain = self.terrainObjs[idx]
  local level = preTerrain and preTerrain:GetLevel()
  if preTerrain then
    preTerrain:Dispose()
    self.terrainObjs[idx] = nil
  end
  local rolePos = self.parent:GetRolePos()
  local terrain = self:CreateTerrain(x, y, self.parent:GetUnitGridDefaultPath())
  if level then
    terrain:OpenMist(level, true)
  end
  if rolePos.x == x and rolePos.y == y then
    terrain:DOMaterialProperty(1, true)
    terrain:PlayUpAndNoOutline()
  end
  self.terrainObjs[idx] = terrain
end

function MapTerrainManager:CreateTerrains()
  local width = self.parent:GetMapWidth()
  local height = self.parent:GetMapHeight()
  local data = MapModel.Instance:GetGearData()
  local wallTable = {}
  local hideTerrain = {}
  for _, v in ipairs(data) do
    local idx = self.parent:GetIdxByPos(v.x, v.y)
    if v.type == CommonDefine.GearItemType.Wall then
      wallTable[idx] = true
    elseif v.type == CommonDefine.GearItemType.HiddenChannel then
      hideTerrain[idx] = true
    end
  end
  for y = 1, height do
    for x = 1, width do
      self:Create(x, y, wallTable, hideTerrain)
    end
  end
end

function MapTerrainManager:UpdateGearsRendering()
  local mistMgr = self:GetComponent(MapMistManager)
  for k, v in pairs(self.terrainObjs) do
    if not v.isVisible and not mistMgr:IsAdjacentNodesAllInMist(v:GetGridPos()) then
      v:SetVisible(true)
    end
  end
end

function MapTerrainManager:UpdateClickable()
  local roleMgr = self:GetComponent(MapRoleManager)
  local curPosX, curPosY = roleMgr.role:GetGridPos()
  for _, terrainItem in pairs(self.terrainObjs) do
    local isInMoveArea = self:IsInMoveArea(curPosX, curPosY, terrainItem.gridX, terrainItem.gridY)
    terrainItem:EnableClick(isInMoveArea)
  end
end

function MapTerrainManager:OnGridLongPress(gridX, gridY)
  local touchMgr = self:GetComponent(MapTouchManager)
  if touchMgr:GetIsMoving() or touchMgr:GetIsScaled() then
    Logger.Info("正在拖动地图~")
    return
  end
  local gearMgr = self:GetComponent(MapGearManager)
  if self.isLongPress then
    return
  end
  self.isLongPress = true
  local gear = gearMgr:GetGearByPos(gridX, gridY)
  if not gear or gear:GetType() == CommonDefine.GearItemType.HiddenAward or gear:IsRemoved() then
    return
  end
  local mistMgr = self:GetComponent(MapMistManager)
  if mistMgr:IsInMist(gridX, gridY) then
    return
  end
  touchMgr:SetTouchAvailable(true)
  if gearMgr:InTrigger() then
    return
  end
  if gear:GetIsChoas() then
    return
  end
  local terrain = self:GetTerrainByPos(gridX, gridY)
  if not terrain or not terrain.isVisible then
    return
  end
  local nodeTypeCfg = gear:GetNodeTypeConfig()
  local worldPosX, worldPosY = self.parent:GetWorldPosByGridPos(gridX, gridY)
  local worldPos = CS.UnityEngine.Vector3(worldPosX, 0, worldPosY)
  local tipsData = {
    title = nodeTypeCfg.Name,
    desc = nodeTypeCfg.Desc,
    worldPos = worldPos
  }
  self.PopTipPanel = Alert.ShowToolTipsByData(tipsData)
  self.PopTipPanel._ID = self.parent:GetIdxByPos(gridX, gridY)
end

function MapTerrainManager:OnPressUp()
  if self.PopTipPanel then
    self.PopTipPanel:Close()
    self.PopTipPanel = nil
  end
  self.isLongPress = false
end

function MapTerrainManager:OnHide()
  if self.PopTipPanel then
    self.PopTipPanel:Close()
    self.PopTipPanel = nil
  end
  self.isLongPress = false
end

function MapTerrainManager:OnShow()
  for k, v in pairs(self.terrainObjs) do
    local played = v.played
    v.played = {}
    v:SetAnimEndFunc()
    for anim, _ in pairs(played) do
      v:PlayAnim(anim, true)
    end
  end
end

function MapTerrainManager:OnGearRemoved(x, y)
  self:CheckBloodPoolFinish(x, y)
end

function MapTerrainManager:OnGridClick(gridX, gridY)
  MapController.Instance:RequestGridAction(gridX, gridY)
end

function MapTerrainManager:DestroyTerrain(data)
  local gearMgr = self:GetComponent(MapGearManager)
  gearMgr:RemoveGearByUid(data.uid)
  self:RemoveTerrain(data.x, data.y)
end

function MapTerrainManager:RemoveTerrain(x, y)
  local idx = self.parent:GetIdxByPos(x, y)
  if self.PopTipPanel and idx == self.PopTipPanel._ID then
    self.PopTipPanel:Close()
    self.PopTipPanel = nil
    self.isLongPress = false
  end
  local terrain = self:GetTerrainByIdx(idx)
  terrain:SetReadyDestroy()
  self.binder:BindTimer(1, 0, nil, function()
    local _terrain = self:GetTerrainByIdx(idx)
    if _terrain then
      _terrain:SetVisible(false)
    end
  end)
end

function MapTerrainManager:IsInMoveArea(curPosX, curPosY, destPosX, destPosY)
  do return MapModel.Instance.IsInMoveArea, MapModel.Instance, curPosX, curPosY, destPosX end
  return MapModel.Instance.IsInMoveArea, MapModel.Instance, curPosX, curPosY, destPosX, destPosY
end

function MapTerrainManager:IsForbidBack(curPosX, curPosY, destPosX, destPosY)
  local roleMgr = self.parent:GetComponent(MapRoleManager)
  local role = roleMgr and roleMgr:GetRole()
  if not role then
    return
  end
  local prex, prey = role:GetPrevPos()
  do return MapModel.Instance.IsForbidBack, MapModel.Instance, curPosX, curPosY, destPosX, destPosY, prex end
  return MapModel.Instance.IsForbidBack, MapModel.Instance, curPosX, curPosY, destPosX, destPosY, prex, prey
end

function MapTerrainManager:GetTerrainByPos(x, y)
  local idx = self.parent:GetIdxByPos(x, y)
  do return self.GetTerrainByIdx, self end
  return self.GetTerrainByIdx, self, idx
end

function MapTerrainManager:GetAllTerrain()
  return self.terrainObjs
end

function MapTerrainManager:GetTerrainByIdx(idx)
  return self.terrainObjs[idx]
end

function MapTerrainManager:SetMist(posX, posY, level)
  local obj = self:GetTerrainByPos(posX, posY)
  local rolePos = self.parent:GetRolePos()
  local curPosX, curPosY = rolePos.x, rolePos.y
  if obj then
    if self:IsInMoveArea(curPosX, curPosY, posX, posY) or curPosX == posX and curPosY == posY then
      obj:PlayAnim("Up-Y-B", true)
    else
      obj:PlayAnim("Up-Y-A", true)
    end
    obj:OpenMist(level, true)
  end
  for lv = 1, level do
    local field = self.parent:GetFieldOfView(posY, lv)
    for _, v in ipairs(field) do
      local biasX, biasY = v[1], v[2]
      local newX = posX + biasX
      local newY = posY + biasY
      if newX >= 1 and newX <= self.parent:GetMapWidth() and newY >= 1 and newY <= self.parent:GetMapHeight() then
        obj = self:GetTerrainByPos(newX, newY)
        if obj then
          if self:IsInMoveArea(curPosX, curPosY, newX, newY) or curPosX == newX and curPosY == newY then
            obj:PlayAnim("Up-Y-B", true)
          else
            obj:PlayAnim("Up-Y-A", true)
          end
        end
      end
    end
  end
end

function MapTerrainManager:PlayMist(posX, posY, level)
  local obj = self:GetTerrainByPos(posX, posY)
  if obj then
    obj:OpenMist(level, false)
  end
end

function MapTerrainManager:GetFieldTerrain(posX, posY, lv)
  local newField = self.parent:GetFieldOfView(posY, lv)
  local newIdx = {}
  for _, v in pairs(newField) do
    local newPosX = posX + v[1]
    local newPosY = posY + v[2]
    if newPosX >= 1 and newPosX <= self.parent:GetMapWidth() and newPosY >= 1 and newPosY <= self.parent:GetMapHeight() then
      local gridIdx = self.parent:GetIdxByPos(newPosX, newPosY)
      if self:GetTerrainByIdx(gridIdx) then
        table.insert(newIdx, gridIdx)
      end
    end
  end
  return newIdx
end

function MapTerrainManager:GetFieldPos(posX, posY, startLv, endLv)
  local result = {}
  for i = startLv, endLv do
    local field = self.parent:GetFieldOfView(posY, i)
    for _, v in pairs(field) do
      local newPosX = posX + v[1]
      local newPosY = posY + v[2]
      if newPosX >= 1 and newPosX <= self.parent:GetMapWidth() and newPosY >= 1 and newPosY <= self.parent:GetMapHeight() then
        local gridIdx = self.parent:GetIdxByPos(newPosX, newPosY)
        table.insert(result, gridIdx)
      end
    end
  end
  return result
end

function MapTerrainManager:GetUpAndSinkGrid(oldPosX, oldPosY, newPosX, newPosY)
  if nil == oldPosX or nil == oldPosY or 0 == oldPosX or 0 == oldPosY then
    local result = {}
    result.up = self:GetFieldTerrain(newPosX, newPosY, 1)
    result.curIdx = self.parent:GetIdxByPos(newPosX, newPosY)
    return result
  else
    local oldField = self:GetFieldTerrain(oldPosX, oldPosY, 1)
    local newField = self:GetFieldTerrain(newPosX, newPosY, 1)
    local oldIdxT = {}
    for _, v in pairs(oldField) do
      oldIdxT[v] = true
    end
    local newIdxT = {}
    for _, v in pairs(newField) do
      newIdxT[v] = true
    end
    local result = {
      sink = {},
      up = {},
      curIdx = self.parent:GetIdxByPos(newPosX, newPosY)
    }
    for k, _ in pairs(oldIdxT) do
      if not newIdxT[k] then
        table.insert(result.sink, k)
      end
    end
    for k, _ in pairs(newIdxT) do
      table.insert(result.up, k)
    end
    return result
  end
end

function MapTerrainManager:GetUpHalfGrid(newPosX, newPosY, lv)
  local result = {}
  for i = 2, lv do
    local newIdx = self:GetFieldTerrain(newPosX, newPosY, i)
    local len = #newIdx
    for index = len, 1, -1 do
      local obj = self:GetTerrainByIdx(newIdx[index])
      if obj and (obj.played["Up-Y-A"] or obj.played["Up-Y-B"]) then
        table.remove(newIdx, index)
      end
    end
    result[i] = newIdx
  end
  return result
end

function MapTerrainManager:PlayGridUp(grids)
  for k, v in pairs(grids) do
    local obj = self:GetTerrainByIdx(v)
    if obj then
      obj:DOMaterialProperty(1, true)
    end
  end
end

function MapTerrainManager:PlayGridUpNoOutline(idx)
  assert(type(idx) ~= nil)
  local terrain = self:GetTerrainByIdx(idx)
  if terrain then
    terrain:PlayUpAndNoOutline()
  end
end

function MapTerrainManager:PlayGridSink(grids)
  for k, v in pairs(grids) do
    local obj = self:GetTerrainByIdx(v)
    if obj then
      obj:DOMaterialProperty(0, true)
    end
  end
end

function MapTerrainManager:PlayGridHalfUp(grids)
  for k, v in pairs(grids) do
    local obj = self:GetTerrainByIdx(v)
    if obj then
      obj:PlayAnim("Up-Y-A")
    end
  end
end

function MapTerrainManager:UpdateClickTip(curPosX, curPosY)
  local field = self.parent:GetFieldOfView(curPosY, 1)
  local length = #field
  local gearMgr = self:GetComponent(MapGearManager)
  local roleMgr = self:GetComponent(MapRoleManager)
  local oldIdx = self.curIdx
  self.curIdx = self.parent:GetIdxByPos(curPosX, curPosY)
  local curGear = gearMgr:GetGearByIdx(self.curIdx)
  local isDropTerrain = curGear and curGear:GetType() == CommonDefine.GearItemType.DropTerrain
  local preX, preY = roleMgr:GetRole():GetPrevPos()
  local tips = {}
  for i = 1, length do
    local biasX, biasY = field[i][1], field[i][2]
    local newPosX = curPosX + biasX
    local newPosY = curPosY + biasY
    if newPosX == curPosX and newPosY == curPosY then
    elseif isDropTerrain and newPosX == preX and newPosY == preY then
    elseif newPosX >= 1 and newPosX <= self.parent:GetMapWidth() and newPosY >= 1 and newPosY <= self.parent:GetMapHeight() then
      local idx = self.parent:GetIdxByPos(newPosX, newPosY)
      local gear = gearMgr:GetGearByIdx(idx)
      local terrain = self:GetTerrainByIdx(idx)
      if nil ~= terrain and (not gear or not gear:IsHideMoveTip()) then
        tips[idx] = terrain
      end
    end
  end
  for k, v in pairs(tips) do
    if nil == self.clickTips[k] then
      v:DOMaterialProperty(1, not oldIdx or k ~= oldIdx)
    else
      self.clickTips[k] = nil
    end
  end
  for k, v in pairs(self.clickTips) do
    v:DOMaterialProperty(0, self.curIdx ~= k)
  end
  self.clickTips = tips
end

function MapTerrainManager:OnDestroy()
  Super.OnDestroy(self)
  for _, v in pairs(self.terrainObjs) do
    v:Dispose()
  end
  self.terrainObjs = nil
end

return MapTerrainManager
